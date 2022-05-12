
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	2d013103          	ld	sp,720(sp) # 800042d0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	1b8010ef          	jal	ra,800011d4 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <main>:
#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"

int main() {
    80001000:	ff010113          	addi	sp,sp,-16
    80001004:	00113423          	sd	ra,8(sp)
    80001008:	00813023          	sd	s0,0(sp)
    8000100c:	01010413          	addi	s0,sp,16

    int* par = (int*)MemoryAllocator::mem_alloc(2*sizeof(int));
    80001010:	00800513          	li	a0,8
    80001014:	00000097          	auipc	ra,0x0
    80001018:	050080e7          	jalr	80(ra) # 80001064 <_ZN15MemoryAllocator9mem_allocEm>
    *par = 5;
    8000101c:	00500793          	li	a5,5
    80001020:	00f52023          	sw	a5,0(a0) # 1000 <_entry-0x7ffff000>
    *(par + 1) = 3;
    80001024:	00300793          	li	a5,3
    80001028:	00f52223          	sw	a5,4(a0)

    char c = '0' + *par;
    char c2 = '0' + par[1];
    __putc(c);
    8000102c:	03500513          	li	a0,53
    80001030:	00002097          	auipc	ra,0x2
    80001034:	26c080e7          	jalr	620(ra) # 8000329c <__putc>
    __putc('\n');
    80001038:	00a00513          	li	a0,10
    8000103c:	00002097          	auipc	ra,0x2
    80001040:	260080e7          	jalr	608(ra) # 8000329c <__putc>
    __putc(c2);
    80001044:	03300513          	li	a0,51
    80001048:	00002097          	auipc	ra,0x2
    8000104c:	254080e7          	jalr	596(ra) # 8000329c <__putc>

    return 0;
    80001050:	00000513          	li	a0,0
    80001054:	00813083          	ld	ra,8(sp)
    80001058:	00013403          	ld	s0,0(sp)
    8000105c:	01010113          	addi	sp,sp,16
    80001060:	00008067          	ret

0000000080001064 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80001064:	ff010113          	addi	sp,sp,-16
    80001068:	00813423          	sd	s0,8(sp)
    8000106c:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80001070:	00003797          	auipc	a5,0x3
    80001074:	2b07b783          	ld	a5,688(a5) # 80004320 <_ZN15MemoryAllocator4headE>
    80001078:	04078e63          	beqz	a5,800010d4 <_ZN15MemoryAllocator9mem_allocEm+0x70>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 1);
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    8000107c:	00003717          	auipc	a4,0x3
    80001080:	25c73703          	ld	a4,604(a4) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001084:	00073703          	ld	a4,0(a4)
    80001088:	12e78463          	beq	a5,a4,800011b0 <_ZN15MemoryAllocator9mem_allocEm+0x14c>
    static MemoryAllocator* memAllocator;
    MemoryAllocator() {}

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    8000108c:	00655613          	srli	a2,a0,0x6
    80001090:	03f57513          	andi	a0,a0,63
    80001094:	00a036b3          	snez	a3,a0
    80001098:	00d60633          	add	a2,a2,a3
        return nullptr;
    }

    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    8000109c:	00003517          	auipc	a0,0x3
    800010a0:	28453503          	ld	a0,644(a0) # 80004320 <_ZN15MemoryAllocator4headE>
    800010a4:	00000593          	li	a1,0
    while(curr) {
    800010a8:	0a050663          	beqz	a0,80001154 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        size_t freeSegSizeInBlocks = sizeInBlocks(curr->size);
    800010ac:	00853683          	ld	a3,8(a0)
    800010b0:	0066d793          	srli	a5,a3,0x6
    800010b4:	03f6f713          	andi	a4,a3,63
    800010b8:	00e03733          	snez	a4,a4
    800010bc:	00e787b3          	add	a5,a5,a4
        size_t allocatedSize = 0;
        void* startOfAllocatedSpace = curr->baseAddr;
    800010c0:	00053703          	ld	a4,0(a0)
        if(freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    800010c4:	04c7f663          	bgeu	a5,a2,80001110 <_ZN15MemoryAllocator9mem_allocEm+0xac>
            }

            return startOfAllocatedSpace;
        }

        prev = curr;
    800010c8:	00050593          	mv	a1,a0
        curr = curr->next;
    800010cc:	01053503          	ld	a0,16(a0)
    while(curr) {
    800010d0:	fd9ff06f          	j	800010a8 <_ZN15MemoryAllocator9mem_allocEm+0x44>
        head = (FreeSegment*)HEAP_START_ADDR;
    800010d4:	00003697          	auipc	a3,0x3
    800010d8:	1f46b683          	ld	a3,500(a3) # 800042c8 <_GLOBAL_OFFSET_TABLE_+0x8>
    800010dc:	0006b783          	ld	a5,0(a3)
    800010e0:	00003717          	auipc	a4,0x3
    800010e4:	24f73023          	sd	a5,576(a4) # 80004320 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    800010e8:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 1);
    800010ec:	00003717          	auipc	a4,0x3
    800010f0:	1ec73703          	ld	a4,492(a4) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800010f4:	00073703          	ld	a4,0(a4)
    800010f8:	0006b683          	ld	a3,0(a3)
    800010fc:	40d70733          	sub	a4,a4,a3
    80001100:	00170713          	addi	a4,a4,1
    80001104:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80001108:	0007b823          	sd	zero,16(a5)
    8000110c:	f81ff06f          	j	8000108c <_ZN15MemoryAllocator9mem_allocEm+0x28>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001110:	04f60863          	beq	a2,a5,80001160 <_ZN15MemoryAllocator9mem_allocEm+0xfc>
    }

    // Vraca velicinu numOfBlocks blokova u bajtovima
    static inline size_t blocksInSize(size_t numOfBlocks) {
        return numOfBlocks * MEM_BLOCK_SIZE;
    80001114:	00661613          	slli	a2,a2,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80001118:	00c707b3          	add	a5,a4,a2
                size_t newSize = curr->size - allocatedSize;
    8000111c:	40c686b3          	sub	a3,a3,a2
                newSeg->baseAddr = newBaseAddr;
    80001120:	00f7b023          	sd	a5,0(a5)
                newSeg->size = newSize;
    80001124:	00d7b423          	sd	a3,8(a5)
                newSeg->next = curr->next;
    80001128:	01053683          	ld	a3,16(a0)
    8000112c:	00d7b823          	sd	a3,16(a5)
                if(!prev) {
    80001130:	06058a63          	beqz	a1,800011a4 <_ZN15MemoryAllocator9mem_allocEm+0x140>
            if(!prev->next) return;
    80001134:	0105b783          	ld	a5,16(a1)
    80001138:	00078663          	beqz	a5,80001144 <_ZN15MemoryAllocator9mem_allocEm+0xe0>
            prev->next = curr->next;
    8000113c:	0107b783          	ld	a5,16(a5)
    80001140:	00f5b823          	sd	a5,16(a1)
            curr->next = prev->next;
    80001144:	0105b783          	ld	a5,16(a1)
    80001148:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    8000114c:	00a5b823          	sd	a0,16(a1)
            return startOfAllocatedSpace;
    80001150:	00070513          	mv	a0,a4
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80001154:	00813403          	ld	s0,8(sp)
    80001158:	01010113          	addi	sp,sp,16
    8000115c:	00008067          	ret
                if(prev == nullptr) { // ako smo na head pokazivacu
    80001160:	00058c63          	beqz	a1,80001178 <_ZN15MemoryAllocator9mem_allocEm+0x114>
            if(!prev->next) return;
    80001164:	0105b783          	ld	a5,16(a1)
    80001168:	fe0784e3          	beqz	a5,80001150 <_ZN15MemoryAllocator9mem_allocEm+0xec>
            prev->next = curr->next;
    8000116c:	0107b783          	ld	a5,16(a5)
    80001170:	00f5b823          	sd	a5,16(a1)
    80001174:	fddff06f          	j	80001150 <_ZN15MemoryAllocator9mem_allocEm+0xec>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001178:	01053783          	ld	a5,16(a0)
    8000117c:	00078863          	beqz	a5,8000118c <_ZN15MemoryAllocator9mem_allocEm+0x128>
                        head = curr->next;
    80001180:	00003697          	auipc	a3,0x3
    80001184:	1af6b023          	sd	a5,416(a3) # 80004320 <_ZN15MemoryAllocator4headE>
    80001188:	fc9ff06f          	j	80001150 <_ZN15MemoryAllocator9mem_allocEm+0xec>
                        head = (FreeSegment*)HEAP_END_ADDR;
    8000118c:	00003797          	auipc	a5,0x3
    80001190:	14c7b783          	ld	a5,332(a5) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001194:	0007b783          	ld	a5,0(a5)
    80001198:	00003697          	auipc	a3,0x3
    8000119c:	18f6b423          	sd	a5,392(a3) # 80004320 <_ZN15MemoryAllocator4headE>
    800011a0:	fb1ff06f          	j	80001150 <_ZN15MemoryAllocator9mem_allocEm+0xec>
                    head = newSeg;
    800011a4:	00003697          	auipc	a3,0x3
    800011a8:	16f6be23          	sd	a5,380(a3) # 80004320 <_ZN15MemoryAllocator4headE>
    800011ac:	fa5ff06f          	j	80001150 <_ZN15MemoryAllocator9mem_allocEm+0xec>
        return nullptr;
    800011b0:	00000513          	li	a0,0
    800011b4:	fa1ff06f          	j	80001154 <_ZN15MemoryAllocator9mem_allocEm+0xf0>

00000000800011b8 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800011b8:	ff010113          	addi	sp,sp,-16
    800011bc:	00813423          	sd	s0,8(sp)
    800011c0:	01010413          	addi	s0,sp,16
    return 0;
}
    800011c4:	00000513          	li	a0,0
    800011c8:	00813403          	ld	s0,8(sp)
    800011cc:	01010113          	addi	sp,sp,16
    800011d0:	00008067          	ret

00000000800011d4 <start>:
    800011d4:	ff010113          	addi	sp,sp,-16
    800011d8:	00813423          	sd	s0,8(sp)
    800011dc:	01010413          	addi	s0,sp,16
    800011e0:	300027f3          	csrr	a5,mstatus
    800011e4:	ffffe737          	lui	a4,0xffffe
    800011e8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff927f>
    800011ec:	00e7f7b3          	and	a5,a5,a4
    800011f0:	00001737          	lui	a4,0x1
    800011f4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800011f8:	00e7e7b3          	or	a5,a5,a4
    800011fc:	30079073          	csrw	mstatus,a5
    80001200:	00000797          	auipc	a5,0x0
    80001204:	16078793          	addi	a5,a5,352 # 80001360 <system_main>
    80001208:	34179073          	csrw	mepc,a5
    8000120c:	00000793          	li	a5,0
    80001210:	18079073          	csrw	satp,a5
    80001214:	000107b7          	lui	a5,0x10
    80001218:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000121c:	30279073          	csrw	medeleg,a5
    80001220:	30379073          	csrw	mideleg,a5
    80001224:	104027f3          	csrr	a5,sie
    80001228:	2227e793          	ori	a5,a5,546
    8000122c:	10479073          	csrw	sie,a5
    80001230:	fff00793          	li	a5,-1
    80001234:	00a7d793          	srli	a5,a5,0xa
    80001238:	3b079073          	csrw	pmpaddr0,a5
    8000123c:	00f00793          	li	a5,15
    80001240:	3a079073          	csrw	pmpcfg0,a5
    80001244:	f14027f3          	csrr	a5,mhartid
    80001248:	0200c737          	lui	a4,0x200c
    8000124c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001250:	0007869b          	sext.w	a3,a5
    80001254:	00269713          	slli	a4,a3,0x2
    80001258:	000f4637          	lui	a2,0xf4
    8000125c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001260:	00d70733          	add	a4,a4,a3
    80001264:	0037979b          	slliw	a5,a5,0x3
    80001268:	020046b7          	lui	a3,0x2004
    8000126c:	00d787b3          	add	a5,a5,a3
    80001270:	00c585b3          	add	a1,a1,a2
    80001274:	00371693          	slli	a3,a4,0x3
    80001278:	00003717          	auipc	a4,0x3
    8000127c:	0b870713          	addi	a4,a4,184 # 80004330 <timer_scratch>
    80001280:	00b7b023          	sd	a1,0(a5)
    80001284:	00d70733          	add	a4,a4,a3
    80001288:	00f73c23          	sd	a5,24(a4)
    8000128c:	02c73023          	sd	a2,32(a4)
    80001290:	34071073          	csrw	mscratch,a4
    80001294:	00000797          	auipc	a5,0x0
    80001298:	6ec78793          	addi	a5,a5,1772 # 80001980 <timervec>
    8000129c:	30579073          	csrw	mtvec,a5
    800012a0:	300027f3          	csrr	a5,mstatus
    800012a4:	0087e793          	ori	a5,a5,8
    800012a8:	30079073          	csrw	mstatus,a5
    800012ac:	304027f3          	csrr	a5,mie
    800012b0:	0807e793          	ori	a5,a5,128
    800012b4:	30479073          	csrw	mie,a5
    800012b8:	f14027f3          	csrr	a5,mhartid
    800012bc:	0007879b          	sext.w	a5,a5
    800012c0:	00078213          	mv	tp,a5
    800012c4:	30200073          	mret
    800012c8:	00813403          	ld	s0,8(sp)
    800012cc:	01010113          	addi	sp,sp,16
    800012d0:	00008067          	ret

00000000800012d4 <timerinit>:
    800012d4:	ff010113          	addi	sp,sp,-16
    800012d8:	00813423          	sd	s0,8(sp)
    800012dc:	01010413          	addi	s0,sp,16
    800012e0:	f14027f3          	csrr	a5,mhartid
    800012e4:	0200c737          	lui	a4,0x200c
    800012e8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800012ec:	0007869b          	sext.w	a3,a5
    800012f0:	00269713          	slli	a4,a3,0x2
    800012f4:	000f4637          	lui	a2,0xf4
    800012f8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800012fc:	00d70733          	add	a4,a4,a3
    80001300:	0037979b          	slliw	a5,a5,0x3
    80001304:	020046b7          	lui	a3,0x2004
    80001308:	00d787b3          	add	a5,a5,a3
    8000130c:	00c585b3          	add	a1,a1,a2
    80001310:	00371693          	slli	a3,a4,0x3
    80001314:	00003717          	auipc	a4,0x3
    80001318:	01c70713          	addi	a4,a4,28 # 80004330 <timer_scratch>
    8000131c:	00b7b023          	sd	a1,0(a5)
    80001320:	00d70733          	add	a4,a4,a3
    80001324:	00f73c23          	sd	a5,24(a4)
    80001328:	02c73023          	sd	a2,32(a4)
    8000132c:	34071073          	csrw	mscratch,a4
    80001330:	00000797          	auipc	a5,0x0
    80001334:	65078793          	addi	a5,a5,1616 # 80001980 <timervec>
    80001338:	30579073          	csrw	mtvec,a5
    8000133c:	300027f3          	csrr	a5,mstatus
    80001340:	0087e793          	ori	a5,a5,8
    80001344:	30079073          	csrw	mstatus,a5
    80001348:	304027f3          	csrr	a5,mie
    8000134c:	0807e793          	ori	a5,a5,128
    80001350:	30479073          	csrw	mie,a5
    80001354:	00813403          	ld	s0,8(sp)
    80001358:	01010113          	addi	sp,sp,16
    8000135c:	00008067          	ret

0000000080001360 <system_main>:
    80001360:	fe010113          	addi	sp,sp,-32
    80001364:	00813823          	sd	s0,16(sp)
    80001368:	00913423          	sd	s1,8(sp)
    8000136c:	00113c23          	sd	ra,24(sp)
    80001370:	02010413          	addi	s0,sp,32
    80001374:	00000097          	auipc	ra,0x0
    80001378:	0c4080e7          	jalr	196(ra) # 80001438 <cpuid>
    8000137c:	00003497          	auipc	s1,0x3
    80001380:	f7448493          	addi	s1,s1,-140 # 800042f0 <started>
    80001384:	02050263          	beqz	a0,800013a8 <system_main+0x48>
    80001388:	0004a783          	lw	a5,0(s1)
    8000138c:	0007879b          	sext.w	a5,a5
    80001390:	fe078ce3          	beqz	a5,80001388 <system_main+0x28>
    80001394:	0ff0000f          	fence
    80001398:	00003517          	auipc	a0,0x3
    8000139c:	cb850513          	addi	a0,a0,-840 # 80004050 <CONSOLE_STATUS+0x40>
    800013a0:	00001097          	auipc	ra,0x1
    800013a4:	a7c080e7          	jalr	-1412(ra) # 80001e1c <panic>
    800013a8:	00001097          	auipc	ra,0x1
    800013ac:	9d0080e7          	jalr	-1584(ra) # 80001d78 <consoleinit>
    800013b0:	00001097          	auipc	ra,0x1
    800013b4:	15c080e7          	jalr	348(ra) # 8000250c <printfinit>
    800013b8:	00003517          	auipc	a0,0x3
    800013bc:	d7850513          	addi	a0,a0,-648 # 80004130 <CONSOLE_STATUS+0x120>
    800013c0:	00001097          	auipc	ra,0x1
    800013c4:	ab8080e7          	jalr	-1352(ra) # 80001e78 <__printf>
    800013c8:	00003517          	auipc	a0,0x3
    800013cc:	c5850513          	addi	a0,a0,-936 # 80004020 <CONSOLE_STATUS+0x10>
    800013d0:	00001097          	auipc	ra,0x1
    800013d4:	aa8080e7          	jalr	-1368(ra) # 80001e78 <__printf>
    800013d8:	00003517          	auipc	a0,0x3
    800013dc:	d5850513          	addi	a0,a0,-680 # 80004130 <CONSOLE_STATUS+0x120>
    800013e0:	00001097          	auipc	ra,0x1
    800013e4:	a98080e7          	jalr	-1384(ra) # 80001e78 <__printf>
    800013e8:	00001097          	auipc	ra,0x1
    800013ec:	4b0080e7          	jalr	1200(ra) # 80002898 <kinit>
    800013f0:	00000097          	auipc	ra,0x0
    800013f4:	148080e7          	jalr	328(ra) # 80001538 <trapinit>
    800013f8:	00000097          	auipc	ra,0x0
    800013fc:	16c080e7          	jalr	364(ra) # 80001564 <trapinithart>
    80001400:	00000097          	auipc	ra,0x0
    80001404:	5c0080e7          	jalr	1472(ra) # 800019c0 <plicinit>
    80001408:	00000097          	auipc	ra,0x0
    8000140c:	5e0080e7          	jalr	1504(ra) # 800019e8 <plicinithart>
    80001410:	00000097          	auipc	ra,0x0
    80001414:	078080e7          	jalr	120(ra) # 80001488 <userinit>
    80001418:	0ff0000f          	fence
    8000141c:	00100793          	li	a5,1
    80001420:	00003517          	auipc	a0,0x3
    80001424:	c1850513          	addi	a0,a0,-1000 # 80004038 <CONSOLE_STATUS+0x28>
    80001428:	00f4a023          	sw	a5,0(s1)
    8000142c:	00001097          	auipc	ra,0x1
    80001430:	a4c080e7          	jalr	-1460(ra) # 80001e78 <__printf>
    80001434:	0000006f          	j	80001434 <system_main+0xd4>

0000000080001438 <cpuid>:
    80001438:	ff010113          	addi	sp,sp,-16
    8000143c:	00813423          	sd	s0,8(sp)
    80001440:	01010413          	addi	s0,sp,16
    80001444:	00020513          	mv	a0,tp
    80001448:	00813403          	ld	s0,8(sp)
    8000144c:	0005051b          	sext.w	a0,a0
    80001450:	01010113          	addi	sp,sp,16
    80001454:	00008067          	ret

0000000080001458 <mycpu>:
    80001458:	ff010113          	addi	sp,sp,-16
    8000145c:	00813423          	sd	s0,8(sp)
    80001460:	01010413          	addi	s0,sp,16
    80001464:	00020793          	mv	a5,tp
    80001468:	00813403          	ld	s0,8(sp)
    8000146c:	0007879b          	sext.w	a5,a5
    80001470:	00779793          	slli	a5,a5,0x7
    80001474:	00004517          	auipc	a0,0x4
    80001478:	eec50513          	addi	a0,a0,-276 # 80005360 <cpus>
    8000147c:	00f50533          	add	a0,a0,a5
    80001480:	01010113          	addi	sp,sp,16
    80001484:	00008067          	ret

0000000080001488 <userinit>:
    80001488:	ff010113          	addi	sp,sp,-16
    8000148c:	00813423          	sd	s0,8(sp)
    80001490:	01010413          	addi	s0,sp,16
    80001494:	00813403          	ld	s0,8(sp)
    80001498:	01010113          	addi	sp,sp,16
    8000149c:	00000317          	auipc	t1,0x0
    800014a0:	b6430067          	jr	-1180(t1) # 80001000 <main>

00000000800014a4 <either_copyout>:
    800014a4:	ff010113          	addi	sp,sp,-16
    800014a8:	00813023          	sd	s0,0(sp)
    800014ac:	00113423          	sd	ra,8(sp)
    800014b0:	01010413          	addi	s0,sp,16
    800014b4:	02051663          	bnez	a0,800014e0 <either_copyout+0x3c>
    800014b8:	00058513          	mv	a0,a1
    800014bc:	00060593          	mv	a1,a2
    800014c0:	0006861b          	sext.w	a2,a3
    800014c4:	00002097          	auipc	ra,0x2
    800014c8:	c60080e7          	jalr	-928(ra) # 80003124 <__memmove>
    800014cc:	00813083          	ld	ra,8(sp)
    800014d0:	00013403          	ld	s0,0(sp)
    800014d4:	00000513          	li	a0,0
    800014d8:	01010113          	addi	sp,sp,16
    800014dc:	00008067          	ret
    800014e0:	00003517          	auipc	a0,0x3
    800014e4:	b9850513          	addi	a0,a0,-1128 # 80004078 <CONSOLE_STATUS+0x68>
    800014e8:	00001097          	auipc	ra,0x1
    800014ec:	934080e7          	jalr	-1740(ra) # 80001e1c <panic>

00000000800014f0 <either_copyin>:
    800014f0:	ff010113          	addi	sp,sp,-16
    800014f4:	00813023          	sd	s0,0(sp)
    800014f8:	00113423          	sd	ra,8(sp)
    800014fc:	01010413          	addi	s0,sp,16
    80001500:	02059463          	bnez	a1,80001528 <either_copyin+0x38>
    80001504:	00060593          	mv	a1,a2
    80001508:	0006861b          	sext.w	a2,a3
    8000150c:	00002097          	auipc	ra,0x2
    80001510:	c18080e7          	jalr	-1000(ra) # 80003124 <__memmove>
    80001514:	00813083          	ld	ra,8(sp)
    80001518:	00013403          	ld	s0,0(sp)
    8000151c:	00000513          	li	a0,0
    80001520:	01010113          	addi	sp,sp,16
    80001524:	00008067          	ret
    80001528:	00003517          	auipc	a0,0x3
    8000152c:	b7850513          	addi	a0,a0,-1160 # 800040a0 <CONSOLE_STATUS+0x90>
    80001530:	00001097          	auipc	ra,0x1
    80001534:	8ec080e7          	jalr	-1812(ra) # 80001e1c <panic>

0000000080001538 <trapinit>:
    80001538:	ff010113          	addi	sp,sp,-16
    8000153c:	00813423          	sd	s0,8(sp)
    80001540:	01010413          	addi	s0,sp,16
    80001544:	00813403          	ld	s0,8(sp)
    80001548:	00003597          	auipc	a1,0x3
    8000154c:	b8058593          	addi	a1,a1,-1152 # 800040c8 <CONSOLE_STATUS+0xb8>
    80001550:	00004517          	auipc	a0,0x4
    80001554:	e9050513          	addi	a0,a0,-368 # 800053e0 <tickslock>
    80001558:	01010113          	addi	sp,sp,16
    8000155c:	00001317          	auipc	t1,0x1
    80001560:	5cc30067          	jr	1484(t1) # 80002b28 <initlock>

0000000080001564 <trapinithart>:
    80001564:	ff010113          	addi	sp,sp,-16
    80001568:	00813423          	sd	s0,8(sp)
    8000156c:	01010413          	addi	s0,sp,16
    80001570:	00000797          	auipc	a5,0x0
    80001574:	30078793          	addi	a5,a5,768 # 80001870 <kernelvec>
    80001578:	10579073          	csrw	stvec,a5
    8000157c:	00813403          	ld	s0,8(sp)
    80001580:	01010113          	addi	sp,sp,16
    80001584:	00008067          	ret

0000000080001588 <usertrap>:
    80001588:	ff010113          	addi	sp,sp,-16
    8000158c:	00813423          	sd	s0,8(sp)
    80001590:	01010413          	addi	s0,sp,16
    80001594:	00813403          	ld	s0,8(sp)
    80001598:	01010113          	addi	sp,sp,16
    8000159c:	00008067          	ret

00000000800015a0 <usertrapret>:
    800015a0:	ff010113          	addi	sp,sp,-16
    800015a4:	00813423          	sd	s0,8(sp)
    800015a8:	01010413          	addi	s0,sp,16
    800015ac:	00813403          	ld	s0,8(sp)
    800015b0:	01010113          	addi	sp,sp,16
    800015b4:	00008067          	ret

00000000800015b8 <kerneltrap>:
    800015b8:	fe010113          	addi	sp,sp,-32
    800015bc:	00813823          	sd	s0,16(sp)
    800015c0:	00113c23          	sd	ra,24(sp)
    800015c4:	00913423          	sd	s1,8(sp)
    800015c8:	02010413          	addi	s0,sp,32
    800015cc:	142025f3          	csrr	a1,scause
    800015d0:	100027f3          	csrr	a5,sstatus
    800015d4:	0027f793          	andi	a5,a5,2
    800015d8:	10079c63          	bnez	a5,800016f0 <kerneltrap+0x138>
    800015dc:	142027f3          	csrr	a5,scause
    800015e0:	0207ce63          	bltz	a5,8000161c <kerneltrap+0x64>
    800015e4:	00003517          	auipc	a0,0x3
    800015e8:	b2c50513          	addi	a0,a0,-1236 # 80004110 <CONSOLE_STATUS+0x100>
    800015ec:	00001097          	auipc	ra,0x1
    800015f0:	88c080e7          	jalr	-1908(ra) # 80001e78 <__printf>
    800015f4:	141025f3          	csrr	a1,sepc
    800015f8:	14302673          	csrr	a2,stval
    800015fc:	00003517          	auipc	a0,0x3
    80001600:	b2450513          	addi	a0,a0,-1244 # 80004120 <CONSOLE_STATUS+0x110>
    80001604:	00001097          	auipc	ra,0x1
    80001608:	874080e7          	jalr	-1932(ra) # 80001e78 <__printf>
    8000160c:	00003517          	auipc	a0,0x3
    80001610:	b2c50513          	addi	a0,a0,-1236 # 80004138 <CONSOLE_STATUS+0x128>
    80001614:	00001097          	auipc	ra,0x1
    80001618:	808080e7          	jalr	-2040(ra) # 80001e1c <panic>
    8000161c:	0ff7f713          	andi	a4,a5,255
    80001620:	00900693          	li	a3,9
    80001624:	04d70063          	beq	a4,a3,80001664 <kerneltrap+0xac>
    80001628:	fff00713          	li	a4,-1
    8000162c:	03f71713          	slli	a4,a4,0x3f
    80001630:	00170713          	addi	a4,a4,1
    80001634:	fae798e3          	bne	a5,a4,800015e4 <kerneltrap+0x2c>
    80001638:	00000097          	auipc	ra,0x0
    8000163c:	e00080e7          	jalr	-512(ra) # 80001438 <cpuid>
    80001640:	06050663          	beqz	a0,800016ac <kerneltrap+0xf4>
    80001644:	144027f3          	csrr	a5,sip
    80001648:	ffd7f793          	andi	a5,a5,-3
    8000164c:	14479073          	csrw	sip,a5
    80001650:	01813083          	ld	ra,24(sp)
    80001654:	01013403          	ld	s0,16(sp)
    80001658:	00813483          	ld	s1,8(sp)
    8000165c:	02010113          	addi	sp,sp,32
    80001660:	00008067          	ret
    80001664:	00000097          	auipc	ra,0x0
    80001668:	3d0080e7          	jalr	976(ra) # 80001a34 <plic_claim>
    8000166c:	00a00793          	li	a5,10
    80001670:	00050493          	mv	s1,a0
    80001674:	06f50863          	beq	a0,a5,800016e4 <kerneltrap+0x12c>
    80001678:	fc050ce3          	beqz	a0,80001650 <kerneltrap+0x98>
    8000167c:	00050593          	mv	a1,a0
    80001680:	00003517          	auipc	a0,0x3
    80001684:	a7050513          	addi	a0,a0,-1424 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001688:	00000097          	auipc	ra,0x0
    8000168c:	7f0080e7          	jalr	2032(ra) # 80001e78 <__printf>
    80001690:	01013403          	ld	s0,16(sp)
    80001694:	01813083          	ld	ra,24(sp)
    80001698:	00048513          	mv	a0,s1
    8000169c:	00813483          	ld	s1,8(sp)
    800016a0:	02010113          	addi	sp,sp,32
    800016a4:	00000317          	auipc	t1,0x0
    800016a8:	3c830067          	jr	968(t1) # 80001a6c <plic_complete>
    800016ac:	00004517          	auipc	a0,0x4
    800016b0:	d3450513          	addi	a0,a0,-716 # 800053e0 <tickslock>
    800016b4:	00001097          	auipc	ra,0x1
    800016b8:	498080e7          	jalr	1176(ra) # 80002b4c <acquire>
    800016bc:	00003717          	auipc	a4,0x3
    800016c0:	c3870713          	addi	a4,a4,-968 # 800042f4 <ticks>
    800016c4:	00072783          	lw	a5,0(a4)
    800016c8:	00004517          	auipc	a0,0x4
    800016cc:	d1850513          	addi	a0,a0,-744 # 800053e0 <tickslock>
    800016d0:	0017879b          	addiw	a5,a5,1
    800016d4:	00f72023          	sw	a5,0(a4)
    800016d8:	00001097          	auipc	ra,0x1
    800016dc:	540080e7          	jalr	1344(ra) # 80002c18 <release>
    800016e0:	f65ff06f          	j	80001644 <kerneltrap+0x8c>
    800016e4:	00001097          	auipc	ra,0x1
    800016e8:	09c080e7          	jalr	156(ra) # 80002780 <uartintr>
    800016ec:	fa5ff06f          	j	80001690 <kerneltrap+0xd8>
    800016f0:	00003517          	auipc	a0,0x3
    800016f4:	9e050513          	addi	a0,a0,-1568 # 800040d0 <CONSOLE_STATUS+0xc0>
    800016f8:	00000097          	auipc	ra,0x0
    800016fc:	724080e7          	jalr	1828(ra) # 80001e1c <panic>

0000000080001700 <clockintr>:
    80001700:	fe010113          	addi	sp,sp,-32
    80001704:	00813823          	sd	s0,16(sp)
    80001708:	00913423          	sd	s1,8(sp)
    8000170c:	00113c23          	sd	ra,24(sp)
    80001710:	02010413          	addi	s0,sp,32
    80001714:	00004497          	auipc	s1,0x4
    80001718:	ccc48493          	addi	s1,s1,-820 # 800053e0 <tickslock>
    8000171c:	00048513          	mv	a0,s1
    80001720:	00001097          	auipc	ra,0x1
    80001724:	42c080e7          	jalr	1068(ra) # 80002b4c <acquire>
    80001728:	00003717          	auipc	a4,0x3
    8000172c:	bcc70713          	addi	a4,a4,-1076 # 800042f4 <ticks>
    80001730:	00072783          	lw	a5,0(a4)
    80001734:	01013403          	ld	s0,16(sp)
    80001738:	01813083          	ld	ra,24(sp)
    8000173c:	00048513          	mv	a0,s1
    80001740:	0017879b          	addiw	a5,a5,1
    80001744:	00813483          	ld	s1,8(sp)
    80001748:	00f72023          	sw	a5,0(a4)
    8000174c:	02010113          	addi	sp,sp,32
    80001750:	00001317          	auipc	t1,0x1
    80001754:	4c830067          	jr	1224(t1) # 80002c18 <release>

0000000080001758 <devintr>:
    80001758:	142027f3          	csrr	a5,scause
    8000175c:	00000513          	li	a0,0
    80001760:	0007c463          	bltz	a5,80001768 <devintr+0x10>
    80001764:	00008067          	ret
    80001768:	fe010113          	addi	sp,sp,-32
    8000176c:	00813823          	sd	s0,16(sp)
    80001770:	00113c23          	sd	ra,24(sp)
    80001774:	00913423          	sd	s1,8(sp)
    80001778:	02010413          	addi	s0,sp,32
    8000177c:	0ff7f713          	andi	a4,a5,255
    80001780:	00900693          	li	a3,9
    80001784:	04d70c63          	beq	a4,a3,800017dc <devintr+0x84>
    80001788:	fff00713          	li	a4,-1
    8000178c:	03f71713          	slli	a4,a4,0x3f
    80001790:	00170713          	addi	a4,a4,1
    80001794:	00e78c63          	beq	a5,a4,800017ac <devintr+0x54>
    80001798:	01813083          	ld	ra,24(sp)
    8000179c:	01013403          	ld	s0,16(sp)
    800017a0:	00813483          	ld	s1,8(sp)
    800017a4:	02010113          	addi	sp,sp,32
    800017a8:	00008067          	ret
    800017ac:	00000097          	auipc	ra,0x0
    800017b0:	c8c080e7          	jalr	-884(ra) # 80001438 <cpuid>
    800017b4:	06050663          	beqz	a0,80001820 <devintr+0xc8>
    800017b8:	144027f3          	csrr	a5,sip
    800017bc:	ffd7f793          	andi	a5,a5,-3
    800017c0:	14479073          	csrw	sip,a5
    800017c4:	01813083          	ld	ra,24(sp)
    800017c8:	01013403          	ld	s0,16(sp)
    800017cc:	00813483          	ld	s1,8(sp)
    800017d0:	00200513          	li	a0,2
    800017d4:	02010113          	addi	sp,sp,32
    800017d8:	00008067          	ret
    800017dc:	00000097          	auipc	ra,0x0
    800017e0:	258080e7          	jalr	600(ra) # 80001a34 <plic_claim>
    800017e4:	00a00793          	li	a5,10
    800017e8:	00050493          	mv	s1,a0
    800017ec:	06f50663          	beq	a0,a5,80001858 <devintr+0x100>
    800017f0:	00100513          	li	a0,1
    800017f4:	fa0482e3          	beqz	s1,80001798 <devintr+0x40>
    800017f8:	00048593          	mv	a1,s1
    800017fc:	00003517          	auipc	a0,0x3
    80001800:	8f450513          	addi	a0,a0,-1804 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001804:	00000097          	auipc	ra,0x0
    80001808:	674080e7          	jalr	1652(ra) # 80001e78 <__printf>
    8000180c:	00048513          	mv	a0,s1
    80001810:	00000097          	auipc	ra,0x0
    80001814:	25c080e7          	jalr	604(ra) # 80001a6c <plic_complete>
    80001818:	00100513          	li	a0,1
    8000181c:	f7dff06f          	j	80001798 <devintr+0x40>
    80001820:	00004517          	auipc	a0,0x4
    80001824:	bc050513          	addi	a0,a0,-1088 # 800053e0 <tickslock>
    80001828:	00001097          	auipc	ra,0x1
    8000182c:	324080e7          	jalr	804(ra) # 80002b4c <acquire>
    80001830:	00003717          	auipc	a4,0x3
    80001834:	ac470713          	addi	a4,a4,-1340 # 800042f4 <ticks>
    80001838:	00072783          	lw	a5,0(a4)
    8000183c:	00004517          	auipc	a0,0x4
    80001840:	ba450513          	addi	a0,a0,-1116 # 800053e0 <tickslock>
    80001844:	0017879b          	addiw	a5,a5,1
    80001848:	00f72023          	sw	a5,0(a4)
    8000184c:	00001097          	auipc	ra,0x1
    80001850:	3cc080e7          	jalr	972(ra) # 80002c18 <release>
    80001854:	f65ff06f          	j	800017b8 <devintr+0x60>
    80001858:	00001097          	auipc	ra,0x1
    8000185c:	f28080e7          	jalr	-216(ra) # 80002780 <uartintr>
    80001860:	fadff06f          	j	8000180c <devintr+0xb4>
	...

0000000080001870 <kernelvec>:
    80001870:	f0010113          	addi	sp,sp,-256
    80001874:	00113023          	sd	ra,0(sp)
    80001878:	00213423          	sd	sp,8(sp)
    8000187c:	00313823          	sd	gp,16(sp)
    80001880:	00413c23          	sd	tp,24(sp)
    80001884:	02513023          	sd	t0,32(sp)
    80001888:	02613423          	sd	t1,40(sp)
    8000188c:	02713823          	sd	t2,48(sp)
    80001890:	02813c23          	sd	s0,56(sp)
    80001894:	04913023          	sd	s1,64(sp)
    80001898:	04a13423          	sd	a0,72(sp)
    8000189c:	04b13823          	sd	a1,80(sp)
    800018a0:	04c13c23          	sd	a2,88(sp)
    800018a4:	06d13023          	sd	a3,96(sp)
    800018a8:	06e13423          	sd	a4,104(sp)
    800018ac:	06f13823          	sd	a5,112(sp)
    800018b0:	07013c23          	sd	a6,120(sp)
    800018b4:	09113023          	sd	a7,128(sp)
    800018b8:	09213423          	sd	s2,136(sp)
    800018bc:	09313823          	sd	s3,144(sp)
    800018c0:	09413c23          	sd	s4,152(sp)
    800018c4:	0b513023          	sd	s5,160(sp)
    800018c8:	0b613423          	sd	s6,168(sp)
    800018cc:	0b713823          	sd	s7,176(sp)
    800018d0:	0b813c23          	sd	s8,184(sp)
    800018d4:	0d913023          	sd	s9,192(sp)
    800018d8:	0da13423          	sd	s10,200(sp)
    800018dc:	0db13823          	sd	s11,208(sp)
    800018e0:	0dc13c23          	sd	t3,216(sp)
    800018e4:	0fd13023          	sd	t4,224(sp)
    800018e8:	0fe13423          	sd	t5,232(sp)
    800018ec:	0ff13823          	sd	t6,240(sp)
    800018f0:	cc9ff0ef          	jal	ra,800015b8 <kerneltrap>
    800018f4:	00013083          	ld	ra,0(sp)
    800018f8:	00813103          	ld	sp,8(sp)
    800018fc:	01013183          	ld	gp,16(sp)
    80001900:	02013283          	ld	t0,32(sp)
    80001904:	02813303          	ld	t1,40(sp)
    80001908:	03013383          	ld	t2,48(sp)
    8000190c:	03813403          	ld	s0,56(sp)
    80001910:	04013483          	ld	s1,64(sp)
    80001914:	04813503          	ld	a0,72(sp)
    80001918:	05013583          	ld	a1,80(sp)
    8000191c:	05813603          	ld	a2,88(sp)
    80001920:	06013683          	ld	a3,96(sp)
    80001924:	06813703          	ld	a4,104(sp)
    80001928:	07013783          	ld	a5,112(sp)
    8000192c:	07813803          	ld	a6,120(sp)
    80001930:	08013883          	ld	a7,128(sp)
    80001934:	08813903          	ld	s2,136(sp)
    80001938:	09013983          	ld	s3,144(sp)
    8000193c:	09813a03          	ld	s4,152(sp)
    80001940:	0a013a83          	ld	s5,160(sp)
    80001944:	0a813b03          	ld	s6,168(sp)
    80001948:	0b013b83          	ld	s7,176(sp)
    8000194c:	0b813c03          	ld	s8,184(sp)
    80001950:	0c013c83          	ld	s9,192(sp)
    80001954:	0c813d03          	ld	s10,200(sp)
    80001958:	0d013d83          	ld	s11,208(sp)
    8000195c:	0d813e03          	ld	t3,216(sp)
    80001960:	0e013e83          	ld	t4,224(sp)
    80001964:	0e813f03          	ld	t5,232(sp)
    80001968:	0f013f83          	ld	t6,240(sp)
    8000196c:	10010113          	addi	sp,sp,256
    80001970:	10200073          	sret
    80001974:	00000013          	nop
    80001978:	00000013          	nop
    8000197c:	00000013          	nop

0000000080001980 <timervec>:
    80001980:	34051573          	csrrw	a0,mscratch,a0
    80001984:	00b53023          	sd	a1,0(a0)
    80001988:	00c53423          	sd	a2,8(a0)
    8000198c:	00d53823          	sd	a3,16(a0)
    80001990:	01853583          	ld	a1,24(a0)
    80001994:	02053603          	ld	a2,32(a0)
    80001998:	0005b683          	ld	a3,0(a1)
    8000199c:	00c686b3          	add	a3,a3,a2
    800019a0:	00d5b023          	sd	a3,0(a1)
    800019a4:	00200593          	li	a1,2
    800019a8:	14459073          	csrw	sip,a1
    800019ac:	01053683          	ld	a3,16(a0)
    800019b0:	00853603          	ld	a2,8(a0)
    800019b4:	00053583          	ld	a1,0(a0)
    800019b8:	34051573          	csrrw	a0,mscratch,a0
    800019bc:	30200073          	mret

00000000800019c0 <plicinit>:
    800019c0:	ff010113          	addi	sp,sp,-16
    800019c4:	00813423          	sd	s0,8(sp)
    800019c8:	01010413          	addi	s0,sp,16
    800019cc:	00813403          	ld	s0,8(sp)
    800019d0:	0c0007b7          	lui	a5,0xc000
    800019d4:	00100713          	li	a4,1
    800019d8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800019dc:	00e7a223          	sw	a4,4(a5)
    800019e0:	01010113          	addi	sp,sp,16
    800019e4:	00008067          	ret

00000000800019e8 <plicinithart>:
    800019e8:	ff010113          	addi	sp,sp,-16
    800019ec:	00813023          	sd	s0,0(sp)
    800019f0:	00113423          	sd	ra,8(sp)
    800019f4:	01010413          	addi	s0,sp,16
    800019f8:	00000097          	auipc	ra,0x0
    800019fc:	a40080e7          	jalr	-1472(ra) # 80001438 <cpuid>
    80001a00:	0085171b          	slliw	a4,a0,0x8
    80001a04:	0c0027b7          	lui	a5,0xc002
    80001a08:	00e787b3          	add	a5,a5,a4
    80001a0c:	40200713          	li	a4,1026
    80001a10:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001a14:	00813083          	ld	ra,8(sp)
    80001a18:	00013403          	ld	s0,0(sp)
    80001a1c:	00d5151b          	slliw	a0,a0,0xd
    80001a20:	0c2017b7          	lui	a5,0xc201
    80001a24:	00a78533          	add	a0,a5,a0
    80001a28:	00052023          	sw	zero,0(a0)
    80001a2c:	01010113          	addi	sp,sp,16
    80001a30:	00008067          	ret

0000000080001a34 <plic_claim>:
    80001a34:	ff010113          	addi	sp,sp,-16
    80001a38:	00813023          	sd	s0,0(sp)
    80001a3c:	00113423          	sd	ra,8(sp)
    80001a40:	01010413          	addi	s0,sp,16
    80001a44:	00000097          	auipc	ra,0x0
    80001a48:	9f4080e7          	jalr	-1548(ra) # 80001438 <cpuid>
    80001a4c:	00813083          	ld	ra,8(sp)
    80001a50:	00013403          	ld	s0,0(sp)
    80001a54:	00d5151b          	slliw	a0,a0,0xd
    80001a58:	0c2017b7          	lui	a5,0xc201
    80001a5c:	00a78533          	add	a0,a5,a0
    80001a60:	00452503          	lw	a0,4(a0)
    80001a64:	01010113          	addi	sp,sp,16
    80001a68:	00008067          	ret

0000000080001a6c <plic_complete>:
    80001a6c:	fe010113          	addi	sp,sp,-32
    80001a70:	00813823          	sd	s0,16(sp)
    80001a74:	00913423          	sd	s1,8(sp)
    80001a78:	00113c23          	sd	ra,24(sp)
    80001a7c:	02010413          	addi	s0,sp,32
    80001a80:	00050493          	mv	s1,a0
    80001a84:	00000097          	auipc	ra,0x0
    80001a88:	9b4080e7          	jalr	-1612(ra) # 80001438 <cpuid>
    80001a8c:	01813083          	ld	ra,24(sp)
    80001a90:	01013403          	ld	s0,16(sp)
    80001a94:	00d5179b          	slliw	a5,a0,0xd
    80001a98:	0c201737          	lui	a4,0xc201
    80001a9c:	00f707b3          	add	a5,a4,a5
    80001aa0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001aa4:	00813483          	ld	s1,8(sp)
    80001aa8:	02010113          	addi	sp,sp,32
    80001aac:	00008067          	ret

0000000080001ab0 <consolewrite>:
    80001ab0:	fb010113          	addi	sp,sp,-80
    80001ab4:	04813023          	sd	s0,64(sp)
    80001ab8:	04113423          	sd	ra,72(sp)
    80001abc:	02913c23          	sd	s1,56(sp)
    80001ac0:	03213823          	sd	s2,48(sp)
    80001ac4:	03313423          	sd	s3,40(sp)
    80001ac8:	03413023          	sd	s4,32(sp)
    80001acc:	01513c23          	sd	s5,24(sp)
    80001ad0:	05010413          	addi	s0,sp,80
    80001ad4:	06c05c63          	blez	a2,80001b4c <consolewrite+0x9c>
    80001ad8:	00060993          	mv	s3,a2
    80001adc:	00050a13          	mv	s4,a0
    80001ae0:	00058493          	mv	s1,a1
    80001ae4:	00000913          	li	s2,0
    80001ae8:	fff00a93          	li	s5,-1
    80001aec:	01c0006f          	j	80001b08 <consolewrite+0x58>
    80001af0:	fbf44503          	lbu	a0,-65(s0)
    80001af4:	0019091b          	addiw	s2,s2,1
    80001af8:	00148493          	addi	s1,s1,1
    80001afc:	00001097          	auipc	ra,0x1
    80001b00:	a9c080e7          	jalr	-1380(ra) # 80002598 <uartputc>
    80001b04:	03298063          	beq	s3,s2,80001b24 <consolewrite+0x74>
    80001b08:	00048613          	mv	a2,s1
    80001b0c:	00100693          	li	a3,1
    80001b10:	000a0593          	mv	a1,s4
    80001b14:	fbf40513          	addi	a0,s0,-65
    80001b18:	00000097          	auipc	ra,0x0
    80001b1c:	9d8080e7          	jalr	-1576(ra) # 800014f0 <either_copyin>
    80001b20:	fd5518e3          	bne	a0,s5,80001af0 <consolewrite+0x40>
    80001b24:	04813083          	ld	ra,72(sp)
    80001b28:	04013403          	ld	s0,64(sp)
    80001b2c:	03813483          	ld	s1,56(sp)
    80001b30:	02813983          	ld	s3,40(sp)
    80001b34:	02013a03          	ld	s4,32(sp)
    80001b38:	01813a83          	ld	s5,24(sp)
    80001b3c:	00090513          	mv	a0,s2
    80001b40:	03013903          	ld	s2,48(sp)
    80001b44:	05010113          	addi	sp,sp,80
    80001b48:	00008067          	ret
    80001b4c:	00000913          	li	s2,0
    80001b50:	fd5ff06f          	j	80001b24 <consolewrite+0x74>

0000000080001b54 <consoleread>:
    80001b54:	f9010113          	addi	sp,sp,-112
    80001b58:	06813023          	sd	s0,96(sp)
    80001b5c:	04913c23          	sd	s1,88(sp)
    80001b60:	05213823          	sd	s2,80(sp)
    80001b64:	05313423          	sd	s3,72(sp)
    80001b68:	05413023          	sd	s4,64(sp)
    80001b6c:	03513c23          	sd	s5,56(sp)
    80001b70:	03613823          	sd	s6,48(sp)
    80001b74:	03713423          	sd	s7,40(sp)
    80001b78:	03813023          	sd	s8,32(sp)
    80001b7c:	06113423          	sd	ra,104(sp)
    80001b80:	01913c23          	sd	s9,24(sp)
    80001b84:	07010413          	addi	s0,sp,112
    80001b88:	00060b93          	mv	s7,a2
    80001b8c:	00050913          	mv	s2,a0
    80001b90:	00058c13          	mv	s8,a1
    80001b94:	00060b1b          	sext.w	s6,a2
    80001b98:	00004497          	auipc	s1,0x4
    80001b9c:	86048493          	addi	s1,s1,-1952 # 800053f8 <cons>
    80001ba0:	00400993          	li	s3,4
    80001ba4:	fff00a13          	li	s4,-1
    80001ba8:	00a00a93          	li	s5,10
    80001bac:	05705e63          	blez	s7,80001c08 <consoleread+0xb4>
    80001bb0:	09c4a703          	lw	a4,156(s1)
    80001bb4:	0984a783          	lw	a5,152(s1)
    80001bb8:	0007071b          	sext.w	a4,a4
    80001bbc:	08e78463          	beq	a5,a4,80001c44 <consoleread+0xf0>
    80001bc0:	07f7f713          	andi	a4,a5,127
    80001bc4:	00e48733          	add	a4,s1,a4
    80001bc8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001bcc:	0017869b          	addiw	a3,a5,1
    80001bd0:	08d4ac23          	sw	a3,152(s1)
    80001bd4:	00070c9b          	sext.w	s9,a4
    80001bd8:	0b370663          	beq	a4,s3,80001c84 <consoleread+0x130>
    80001bdc:	00100693          	li	a3,1
    80001be0:	f9f40613          	addi	a2,s0,-97
    80001be4:	000c0593          	mv	a1,s8
    80001be8:	00090513          	mv	a0,s2
    80001bec:	f8e40fa3          	sb	a4,-97(s0)
    80001bf0:	00000097          	auipc	ra,0x0
    80001bf4:	8b4080e7          	jalr	-1868(ra) # 800014a4 <either_copyout>
    80001bf8:	01450863          	beq	a0,s4,80001c08 <consoleread+0xb4>
    80001bfc:	001c0c13          	addi	s8,s8,1
    80001c00:	fffb8b9b          	addiw	s7,s7,-1
    80001c04:	fb5c94e3          	bne	s9,s5,80001bac <consoleread+0x58>
    80001c08:	000b851b          	sext.w	a0,s7
    80001c0c:	06813083          	ld	ra,104(sp)
    80001c10:	06013403          	ld	s0,96(sp)
    80001c14:	05813483          	ld	s1,88(sp)
    80001c18:	05013903          	ld	s2,80(sp)
    80001c1c:	04813983          	ld	s3,72(sp)
    80001c20:	04013a03          	ld	s4,64(sp)
    80001c24:	03813a83          	ld	s5,56(sp)
    80001c28:	02813b83          	ld	s7,40(sp)
    80001c2c:	02013c03          	ld	s8,32(sp)
    80001c30:	01813c83          	ld	s9,24(sp)
    80001c34:	40ab053b          	subw	a0,s6,a0
    80001c38:	03013b03          	ld	s6,48(sp)
    80001c3c:	07010113          	addi	sp,sp,112
    80001c40:	00008067          	ret
    80001c44:	00001097          	auipc	ra,0x1
    80001c48:	1d8080e7          	jalr	472(ra) # 80002e1c <push_on>
    80001c4c:	0984a703          	lw	a4,152(s1)
    80001c50:	09c4a783          	lw	a5,156(s1)
    80001c54:	0007879b          	sext.w	a5,a5
    80001c58:	fef70ce3          	beq	a4,a5,80001c50 <consoleread+0xfc>
    80001c5c:	00001097          	auipc	ra,0x1
    80001c60:	234080e7          	jalr	564(ra) # 80002e90 <pop_on>
    80001c64:	0984a783          	lw	a5,152(s1)
    80001c68:	07f7f713          	andi	a4,a5,127
    80001c6c:	00e48733          	add	a4,s1,a4
    80001c70:	01874703          	lbu	a4,24(a4)
    80001c74:	0017869b          	addiw	a3,a5,1
    80001c78:	08d4ac23          	sw	a3,152(s1)
    80001c7c:	00070c9b          	sext.w	s9,a4
    80001c80:	f5371ee3          	bne	a4,s3,80001bdc <consoleread+0x88>
    80001c84:	000b851b          	sext.w	a0,s7
    80001c88:	f96bf2e3          	bgeu	s7,s6,80001c0c <consoleread+0xb8>
    80001c8c:	08f4ac23          	sw	a5,152(s1)
    80001c90:	f7dff06f          	j	80001c0c <consoleread+0xb8>

0000000080001c94 <consputc>:
    80001c94:	10000793          	li	a5,256
    80001c98:	00f50663          	beq	a0,a5,80001ca4 <consputc+0x10>
    80001c9c:	00001317          	auipc	t1,0x1
    80001ca0:	9f430067          	jr	-1548(t1) # 80002690 <uartputc_sync>
    80001ca4:	ff010113          	addi	sp,sp,-16
    80001ca8:	00113423          	sd	ra,8(sp)
    80001cac:	00813023          	sd	s0,0(sp)
    80001cb0:	01010413          	addi	s0,sp,16
    80001cb4:	00800513          	li	a0,8
    80001cb8:	00001097          	auipc	ra,0x1
    80001cbc:	9d8080e7          	jalr	-1576(ra) # 80002690 <uartputc_sync>
    80001cc0:	02000513          	li	a0,32
    80001cc4:	00001097          	auipc	ra,0x1
    80001cc8:	9cc080e7          	jalr	-1588(ra) # 80002690 <uartputc_sync>
    80001ccc:	00013403          	ld	s0,0(sp)
    80001cd0:	00813083          	ld	ra,8(sp)
    80001cd4:	00800513          	li	a0,8
    80001cd8:	01010113          	addi	sp,sp,16
    80001cdc:	00001317          	auipc	t1,0x1
    80001ce0:	9b430067          	jr	-1612(t1) # 80002690 <uartputc_sync>

0000000080001ce4 <consoleintr>:
    80001ce4:	fe010113          	addi	sp,sp,-32
    80001ce8:	00813823          	sd	s0,16(sp)
    80001cec:	00913423          	sd	s1,8(sp)
    80001cf0:	01213023          	sd	s2,0(sp)
    80001cf4:	00113c23          	sd	ra,24(sp)
    80001cf8:	02010413          	addi	s0,sp,32
    80001cfc:	00003917          	auipc	s2,0x3
    80001d00:	6fc90913          	addi	s2,s2,1788 # 800053f8 <cons>
    80001d04:	00050493          	mv	s1,a0
    80001d08:	00090513          	mv	a0,s2
    80001d0c:	00001097          	auipc	ra,0x1
    80001d10:	e40080e7          	jalr	-448(ra) # 80002b4c <acquire>
    80001d14:	02048c63          	beqz	s1,80001d4c <consoleintr+0x68>
    80001d18:	0a092783          	lw	a5,160(s2)
    80001d1c:	09892703          	lw	a4,152(s2)
    80001d20:	07f00693          	li	a3,127
    80001d24:	40e7873b          	subw	a4,a5,a4
    80001d28:	02e6e263          	bltu	a3,a4,80001d4c <consoleintr+0x68>
    80001d2c:	00d00713          	li	a4,13
    80001d30:	04e48063          	beq	s1,a4,80001d70 <consoleintr+0x8c>
    80001d34:	07f7f713          	andi	a4,a5,127
    80001d38:	00e90733          	add	a4,s2,a4
    80001d3c:	0017879b          	addiw	a5,a5,1
    80001d40:	0af92023          	sw	a5,160(s2)
    80001d44:	00970c23          	sb	s1,24(a4)
    80001d48:	08f92e23          	sw	a5,156(s2)
    80001d4c:	01013403          	ld	s0,16(sp)
    80001d50:	01813083          	ld	ra,24(sp)
    80001d54:	00813483          	ld	s1,8(sp)
    80001d58:	00013903          	ld	s2,0(sp)
    80001d5c:	00003517          	auipc	a0,0x3
    80001d60:	69c50513          	addi	a0,a0,1692 # 800053f8 <cons>
    80001d64:	02010113          	addi	sp,sp,32
    80001d68:	00001317          	auipc	t1,0x1
    80001d6c:	eb030067          	jr	-336(t1) # 80002c18 <release>
    80001d70:	00a00493          	li	s1,10
    80001d74:	fc1ff06f          	j	80001d34 <consoleintr+0x50>

0000000080001d78 <consoleinit>:
    80001d78:	fe010113          	addi	sp,sp,-32
    80001d7c:	00113c23          	sd	ra,24(sp)
    80001d80:	00813823          	sd	s0,16(sp)
    80001d84:	00913423          	sd	s1,8(sp)
    80001d88:	02010413          	addi	s0,sp,32
    80001d8c:	00003497          	auipc	s1,0x3
    80001d90:	66c48493          	addi	s1,s1,1644 # 800053f8 <cons>
    80001d94:	00048513          	mv	a0,s1
    80001d98:	00002597          	auipc	a1,0x2
    80001d9c:	3b058593          	addi	a1,a1,944 # 80004148 <CONSOLE_STATUS+0x138>
    80001da0:	00001097          	auipc	ra,0x1
    80001da4:	d88080e7          	jalr	-632(ra) # 80002b28 <initlock>
    80001da8:	00000097          	auipc	ra,0x0
    80001dac:	7ac080e7          	jalr	1964(ra) # 80002554 <uartinit>
    80001db0:	01813083          	ld	ra,24(sp)
    80001db4:	01013403          	ld	s0,16(sp)
    80001db8:	00000797          	auipc	a5,0x0
    80001dbc:	d9c78793          	addi	a5,a5,-612 # 80001b54 <consoleread>
    80001dc0:	0af4bc23          	sd	a5,184(s1)
    80001dc4:	00000797          	auipc	a5,0x0
    80001dc8:	cec78793          	addi	a5,a5,-788 # 80001ab0 <consolewrite>
    80001dcc:	0cf4b023          	sd	a5,192(s1)
    80001dd0:	00813483          	ld	s1,8(sp)
    80001dd4:	02010113          	addi	sp,sp,32
    80001dd8:	00008067          	ret

0000000080001ddc <console_read>:
    80001ddc:	ff010113          	addi	sp,sp,-16
    80001de0:	00813423          	sd	s0,8(sp)
    80001de4:	01010413          	addi	s0,sp,16
    80001de8:	00813403          	ld	s0,8(sp)
    80001dec:	00003317          	auipc	t1,0x3
    80001df0:	6c433303          	ld	t1,1732(t1) # 800054b0 <devsw+0x10>
    80001df4:	01010113          	addi	sp,sp,16
    80001df8:	00030067          	jr	t1

0000000080001dfc <console_write>:
    80001dfc:	ff010113          	addi	sp,sp,-16
    80001e00:	00813423          	sd	s0,8(sp)
    80001e04:	01010413          	addi	s0,sp,16
    80001e08:	00813403          	ld	s0,8(sp)
    80001e0c:	00003317          	auipc	t1,0x3
    80001e10:	6ac33303          	ld	t1,1708(t1) # 800054b8 <devsw+0x18>
    80001e14:	01010113          	addi	sp,sp,16
    80001e18:	00030067          	jr	t1

0000000080001e1c <panic>:
    80001e1c:	fe010113          	addi	sp,sp,-32
    80001e20:	00113c23          	sd	ra,24(sp)
    80001e24:	00813823          	sd	s0,16(sp)
    80001e28:	00913423          	sd	s1,8(sp)
    80001e2c:	02010413          	addi	s0,sp,32
    80001e30:	00050493          	mv	s1,a0
    80001e34:	00002517          	auipc	a0,0x2
    80001e38:	31c50513          	addi	a0,a0,796 # 80004150 <CONSOLE_STATUS+0x140>
    80001e3c:	00003797          	auipc	a5,0x3
    80001e40:	7007ae23          	sw	zero,1820(a5) # 80005558 <pr+0x18>
    80001e44:	00000097          	auipc	ra,0x0
    80001e48:	034080e7          	jalr	52(ra) # 80001e78 <__printf>
    80001e4c:	00048513          	mv	a0,s1
    80001e50:	00000097          	auipc	ra,0x0
    80001e54:	028080e7          	jalr	40(ra) # 80001e78 <__printf>
    80001e58:	00002517          	auipc	a0,0x2
    80001e5c:	2d850513          	addi	a0,a0,728 # 80004130 <CONSOLE_STATUS+0x120>
    80001e60:	00000097          	auipc	ra,0x0
    80001e64:	018080e7          	jalr	24(ra) # 80001e78 <__printf>
    80001e68:	00100793          	li	a5,1
    80001e6c:	00002717          	auipc	a4,0x2
    80001e70:	48f72623          	sw	a5,1164(a4) # 800042f8 <panicked>
    80001e74:	0000006f          	j	80001e74 <panic+0x58>

0000000080001e78 <__printf>:
    80001e78:	f3010113          	addi	sp,sp,-208
    80001e7c:	08813023          	sd	s0,128(sp)
    80001e80:	07313423          	sd	s3,104(sp)
    80001e84:	09010413          	addi	s0,sp,144
    80001e88:	05813023          	sd	s8,64(sp)
    80001e8c:	08113423          	sd	ra,136(sp)
    80001e90:	06913c23          	sd	s1,120(sp)
    80001e94:	07213823          	sd	s2,112(sp)
    80001e98:	07413023          	sd	s4,96(sp)
    80001e9c:	05513c23          	sd	s5,88(sp)
    80001ea0:	05613823          	sd	s6,80(sp)
    80001ea4:	05713423          	sd	s7,72(sp)
    80001ea8:	03913c23          	sd	s9,56(sp)
    80001eac:	03a13823          	sd	s10,48(sp)
    80001eb0:	03b13423          	sd	s11,40(sp)
    80001eb4:	00003317          	auipc	t1,0x3
    80001eb8:	68c30313          	addi	t1,t1,1676 # 80005540 <pr>
    80001ebc:	01832c03          	lw	s8,24(t1)
    80001ec0:	00b43423          	sd	a1,8(s0)
    80001ec4:	00c43823          	sd	a2,16(s0)
    80001ec8:	00d43c23          	sd	a3,24(s0)
    80001ecc:	02e43023          	sd	a4,32(s0)
    80001ed0:	02f43423          	sd	a5,40(s0)
    80001ed4:	03043823          	sd	a6,48(s0)
    80001ed8:	03143c23          	sd	a7,56(s0)
    80001edc:	00050993          	mv	s3,a0
    80001ee0:	4a0c1663          	bnez	s8,8000238c <__printf+0x514>
    80001ee4:	60098c63          	beqz	s3,800024fc <__printf+0x684>
    80001ee8:	0009c503          	lbu	a0,0(s3)
    80001eec:	00840793          	addi	a5,s0,8
    80001ef0:	f6f43c23          	sd	a5,-136(s0)
    80001ef4:	00000493          	li	s1,0
    80001ef8:	22050063          	beqz	a0,80002118 <__printf+0x2a0>
    80001efc:	00002a37          	lui	s4,0x2
    80001f00:	00018ab7          	lui	s5,0x18
    80001f04:	000f4b37          	lui	s6,0xf4
    80001f08:	00989bb7          	lui	s7,0x989
    80001f0c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80001f10:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80001f14:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80001f18:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80001f1c:	00148c9b          	addiw	s9,s1,1
    80001f20:	02500793          	li	a5,37
    80001f24:	01998933          	add	s2,s3,s9
    80001f28:	38f51263          	bne	a0,a5,800022ac <__printf+0x434>
    80001f2c:	00094783          	lbu	a5,0(s2)
    80001f30:	00078c9b          	sext.w	s9,a5
    80001f34:	1e078263          	beqz	a5,80002118 <__printf+0x2a0>
    80001f38:	0024849b          	addiw	s1,s1,2
    80001f3c:	07000713          	li	a4,112
    80001f40:	00998933          	add	s2,s3,s1
    80001f44:	38e78a63          	beq	a5,a4,800022d8 <__printf+0x460>
    80001f48:	20f76863          	bltu	a4,a5,80002158 <__printf+0x2e0>
    80001f4c:	42a78863          	beq	a5,a0,8000237c <__printf+0x504>
    80001f50:	06400713          	li	a4,100
    80001f54:	40e79663          	bne	a5,a4,80002360 <__printf+0x4e8>
    80001f58:	f7843783          	ld	a5,-136(s0)
    80001f5c:	0007a603          	lw	a2,0(a5)
    80001f60:	00878793          	addi	a5,a5,8
    80001f64:	f6f43c23          	sd	a5,-136(s0)
    80001f68:	42064a63          	bltz	a2,8000239c <__printf+0x524>
    80001f6c:	00a00713          	li	a4,10
    80001f70:	02e677bb          	remuw	a5,a2,a4
    80001f74:	00002d97          	auipc	s11,0x2
    80001f78:	204d8d93          	addi	s11,s11,516 # 80004178 <digits>
    80001f7c:	00900593          	li	a1,9
    80001f80:	0006051b          	sext.w	a0,a2
    80001f84:	00000c93          	li	s9,0
    80001f88:	02079793          	slli	a5,a5,0x20
    80001f8c:	0207d793          	srli	a5,a5,0x20
    80001f90:	00fd87b3          	add	a5,s11,a5
    80001f94:	0007c783          	lbu	a5,0(a5)
    80001f98:	02e656bb          	divuw	a3,a2,a4
    80001f9c:	f8f40023          	sb	a5,-128(s0)
    80001fa0:	14c5d863          	bge	a1,a2,800020f0 <__printf+0x278>
    80001fa4:	06300593          	li	a1,99
    80001fa8:	00100c93          	li	s9,1
    80001fac:	02e6f7bb          	remuw	a5,a3,a4
    80001fb0:	02079793          	slli	a5,a5,0x20
    80001fb4:	0207d793          	srli	a5,a5,0x20
    80001fb8:	00fd87b3          	add	a5,s11,a5
    80001fbc:	0007c783          	lbu	a5,0(a5)
    80001fc0:	02e6d73b          	divuw	a4,a3,a4
    80001fc4:	f8f400a3          	sb	a5,-127(s0)
    80001fc8:	12a5f463          	bgeu	a1,a0,800020f0 <__printf+0x278>
    80001fcc:	00a00693          	li	a3,10
    80001fd0:	00900593          	li	a1,9
    80001fd4:	02d777bb          	remuw	a5,a4,a3
    80001fd8:	02079793          	slli	a5,a5,0x20
    80001fdc:	0207d793          	srli	a5,a5,0x20
    80001fe0:	00fd87b3          	add	a5,s11,a5
    80001fe4:	0007c503          	lbu	a0,0(a5)
    80001fe8:	02d757bb          	divuw	a5,a4,a3
    80001fec:	f8a40123          	sb	a0,-126(s0)
    80001ff0:	48e5f263          	bgeu	a1,a4,80002474 <__printf+0x5fc>
    80001ff4:	06300513          	li	a0,99
    80001ff8:	02d7f5bb          	remuw	a1,a5,a3
    80001ffc:	02059593          	slli	a1,a1,0x20
    80002000:	0205d593          	srli	a1,a1,0x20
    80002004:	00bd85b3          	add	a1,s11,a1
    80002008:	0005c583          	lbu	a1,0(a1)
    8000200c:	02d7d7bb          	divuw	a5,a5,a3
    80002010:	f8b401a3          	sb	a1,-125(s0)
    80002014:	48e57263          	bgeu	a0,a4,80002498 <__printf+0x620>
    80002018:	3e700513          	li	a0,999
    8000201c:	02d7f5bb          	remuw	a1,a5,a3
    80002020:	02059593          	slli	a1,a1,0x20
    80002024:	0205d593          	srli	a1,a1,0x20
    80002028:	00bd85b3          	add	a1,s11,a1
    8000202c:	0005c583          	lbu	a1,0(a1)
    80002030:	02d7d7bb          	divuw	a5,a5,a3
    80002034:	f8b40223          	sb	a1,-124(s0)
    80002038:	46e57663          	bgeu	a0,a4,800024a4 <__printf+0x62c>
    8000203c:	02d7f5bb          	remuw	a1,a5,a3
    80002040:	02059593          	slli	a1,a1,0x20
    80002044:	0205d593          	srli	a1,a1,0x20
    80002048:	00bd85b3          	add	a1,s11,a1
    8000204c:	0005c583          	lbu	a1,0(a1)
    80002050:	02d7d7bb          	divuw	a5,a5,a3
    80002054:	f8b402a3          	sb	a1,-123(s0)
    80002058:	46ea7863          	bgeu	s4,a4,800024c8 <__printf+0x650>
    8000205c:	02d7f5bb          	remuw	a1,a5,a3
    80002060:	02059593          	slli	a1,a1,0x20
    80002064:	0205d593          	srli	a1,a1,0x20
    80002068:	00bd85b3          	add	a1,s11,a1
    8000206c:	0005c583          	lbu	a1,0(a1)
    80002070:	02d7d7bb          	divuw	a5,a5,a3
    80002074:	f8b40323          	sb	a1,-122(s0)
    80002078:	3eeaf863          	bgeu	s5,a4,80002468 <__printf+0x5f0>
    8000207c:	02d7f5bb          	remuw	a1,a5,a3
    80002080:	02059593          	slli	a1,a1,0x20
    80002084:	0205d593          	srli	a1,a1,0x20
    80002088:	00bd85b3          	add	a1,s11,a1
    8000208c:	0005c583          	lbu	a1,0(a1)
    80002090:	02d7d7bb          	divuw	a5,a5,a3
    80002094:	f8b403a3          	sb	a1,-121(s0)
    80002098:	42eb7e63          	bgeu	s6,a4,800024d4 <__printf+0x65c>
    8000209c:	02d7f5bb          	remuw	a1,a5,a3
    800020a0:	02059593          	slli	a1,a1,0x20
    800020a4:	0205d593          	srli	a1,a1,0x20
    800020a8:	00bd85b3          	add	a1,s11,a1
    800020ac:	0005c583          	lbu	a1,0(a1)
    800020b0:	02d7d7bb          	divuw	a5,a5,a3
    800020b4:	f8b40423          	sb	a1,-120(s0)
    800020b8:	42ebfc63          	bgeu	s7,a4,800024f0 <__printf+0x678>
    800020bc:	02079793          	slli	a5,a5,0x20
    800020c0:	0207d793          	srli	a5,a5,0x20
    800020c4:	00fd8db3          	add	s11,s11,a5
    800020c8:	000dc703          	lbu	a4,0(s11)
    800020cc:	00a00793          	li	a5,10
    800020d0:	00900c93          	li	s9,9
    800020d4:	f8e404a3          	sb	a4,-119(s0)
    800020d8:	00065c63          	bgez	a2,800020f0 <__printf+0x278>
    800020dc:	f9040713          	addi	a4,s0,-112
    800020e0:	00f70733          	add	a4,a4,a5
    800020e4:	02d00693          	li	a3,45
    800020e8:	fed70823          	sb	a3,-16(a4)
    800020ec:	00078c93          	mv	s9,a5
    800020f0:	f8040793          	addi	a5,s0,-128
    800020f4:	01978cb3          	add	s9,a5,s9
    800020f8:	f7f40d13          	addi	s10,s0,-129
    800020fc:	000cc503          	lbu	a0,0(s9)
    80002100:	fffc8c93          	addi	s9,s9,-1
    80002104:	00000097          	auipc	ra,0x0
    80002108:	b90080e7          	jalr	-1136(ra) # 80001c94 <consputc>
    8000210c:	ffac98e3          	bne	s9,s10,800020fc <__printf+0x284>
    80002110:	00094503          	lbu	a0,0(s2)
    80002114:	e00514e3          	bnez	a0,80001f1c <__printf+0xa4>
    80002118:	1a0c1663          	bnez	s8,800022c4 <__printf+0x44c>
    8000211c:	08813083          	ld	ra,136(sp)
    80002120:	08013403          	ld	s0,128(sp)
    80002124:	07813483          	ld	s1,120(sp)
    80002128:	07013903          	ld	s2,112(sp)
    8000212c:	06813983          	ld	s3,104(sp)
    80002130:	06013a03          	ld	s4,96(sp)
    80002134:	05813a83          	ld	s5,88(sp)
    80002138:	05013b03          	ld	s6,80(sp)
    8000213c:	04813b83          	ld	s7,72(sp)
    80002140:	04013c03          	ld	s8,64(sp)
    80002144:	03813c83          	ld	s9,56(sp)
    80002148:	03013d03          	ld	s10,48(sp)
    8000214c:	02813d83          	ld	s11,40(sp)
    80002150:	0d010113          	addi	sp,sp,208
    80002154:	00008067          	ret
    80002158:	07300713          	li	a4,115
    8000215c:	1ce78a63          	beq	a5,a4,80002330 <__printf+0x4b8>
    80002160:	07800713          	li	a4,120
    80002164:	1ee79e63          	bne	a5,a4,80002360 <__printf+0x4e8>
    80002168:	f7843783          	ld	a5,-136(s0)
    8000216c:	0007a703          	lw	a4,0(a5)
    80002170:	00878793          	addi	a5,a5,8
    80002174:	f6f43c23          	sd	a5,-136(s0)
    80002178:	28074263          	bltz	a4,800023fc <__printf+0x584>
    8000217c:	00002d97          	auipc	s11,0x2
    80002180:	ffcd8d93          	addi	s11,s11,-4 # 80004178 <digits>
    80002184:	00f77793          	andi	a5,a4,15
    80002188:	00fd87b3          	add	a5,s11,a5
    8000218c:	0007c683          	lbu	a3,0(a5)
    80002190:	00f00613          	li	a2,15
    80002194:	0007079b          	sext.w	a5,a4
    80002198:	f8d40023          	sb	a3,-128(s0)
    8000219c:	0047559b          	srliw	a1,a4,0x4
    800021a0:	0047569b          	srliw	a3,a4,0x4
    800021a4:	00000c93          	li	s9,0
    800021a8:	0ee65063          	bge	a2,a4,80002288 <__printf+0x410>
    800021ac:	00f6f693          	andi	a3,a3,15
    800021b0:	00dd86b3          	add	a3,s11,a3
    800021b4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800021b8:	0087d79b          	srliw	a5,a5,0x8
    800021bc:	00100c93          	li	s9,1
    800021c0:	f8d400a3          	sb	a3,-127(s0)
    800021c4:	0cb67263          	bgeu	a2,a1,80002288 <__printf+0x410>
    800021c8:	00f7f693          	andi	a3,a5,15
    800021cc:	00dd86b3          	add	a3,s11,a3
    800021d0:	0006c583          	lbu	a1,0(a3)
    800021d4:	00f00613          	li	a2,15
    800021d8:	0047d69b          	srliw	a3,a5,0x4
    800021dc:	f8b40123          	sb	a1,-126(s0)
    800021e0:	0047d593          	srli	a1,a5,0x4
    800021e4:	28f67e63          	bgeu	a2,a5,80002480 <__printf+0x608>
    800021e8:	00f6f693          	andi	a3,a3,15
    800021ec:	00dd86b3          	add	a3,s11,a3
    800021f0:	0006c503          	lbu	a0,0(a3)
    800021f4:	0087d813          	srli	a6,a5,0x8
    800021f8:	0087d69b          	srliw	a3,a5,0x8
    800021fc:	f8a401a3          	sb	a0,-125(s0)
    80002200:	28b67663          	bgeu	a2,a1,8000248c <__printf+0x614>
    80002204:	00f6f693          	andi	a3,a3,15
    80002208:	00dd86b3          	add	a3,s11,a3
    8000220c:	0006c583          	lbu	a1,0(a3)
    80002210:	00c7d513          	srli	a0,a5,0xc
    80002214:	00c7d69b          	srliw	a3,a5,0xc
    80002218:	f8b40223          	sb	a1,-124(s0)
    8000221c:	29067a63          	bgeu	a2,a6,800024b0 <__printf+0x638>
    80002220:	00f6f693          	andi	a3,a3,15
    80002224:	00dd86b3          	add	a3,s11,a3
    80002228:	0006c583          	lbu	a1,0(a3)
    8000222c:	0107d813          	srli	a6,a5,0x10
    80002230:	0107d69b          	srliw	a3,a5,0x10
    80002234:	f8b402a3          	sb	a1,-123(s0)
    80002238:	28a67263          	bgeu	a2,a0,800024bc <__printf+0x644>
    8000223c:	00f6f693          	andi	a3,a3,15
    80002240:	00dd86b3          	add	a3,s11,a3
    80002244:	0006c683          	lbu	a3,0(a3)
    80002248:	0147d79b          	srliw	a5,a5,0x14
    8000224c:	f8d40323          	sb	a3,-122(s0)
    80002250:	21067663          	bgeu	a2,a6,8000245c <__printf+0x5e4>
    80002254:	02079793          	slli	a5,a5,0x20
    80002258:	0207d793          	srli	a5,a5,0x20
    8000225c:	00fd8db3          	add	s11,s11,a5
    80002260:	000dc683          	lbu	a3,0(s11)
    80002264:	00800793          	li	a5,8
    80002268:	00700c93          	li	s9,7
    8000226c:	f8d403a3          	sb	a3,-121(s0)
    80002270:	00075c63          	bgez	a4,80002288 <__printf+0x410>
    80002274:	f9040713          	addi	a4,s0,-112
    80002278:	00f70733          	add	a4,a4,a5
    8000227c:	02d00693          	li	a3,45
    80002280:	fed70823          	sb	a3,-16(a4)
    80002284:	00078c93          	mv	s9,a5
    80002288:	f8040793          	addi	a5,s0,-128
    8000228c:	01978cb3          	add	s9,a5,s9
    80002290:	f7f40d13          	addi	s10,s0,-129
    80002294:	000cc503          	lbu	a0,0(s9)
    80002298:	fffc8c93          	addi	s9,s9,-1
    8000229c:	00000097          	auipc	ra,0x0
    800022a0:	9f8080e7          	jalr	-1544(ra) # 80001c94 <consputc>
    800022a4:	ff9d18e3          	bne	s10,s9,80002294 <__printf+0x41c>
    800022a8:	0100006f          	j	800022b8 <__printf+0x440>
    800022ac:	00000097          	auipc	ra,0x0
    800022b0:	9e8080e7          	jalr	-1560(ra) # 80001c94 <consputc>
    800022b4:	000c8493          	mv	s1,s9
    800022b8:	00094503          	lbu	a0,0(s2)
    800022bc:	c60510e3          	bnez	a0,80001f1c <__printf+0xa4>
    800022c0:	e40c0ee3          	beqz	s8,8000211c <__printf+0x2a4>
    800022c4:	00003517          	auipc	a0,0x3
    800022c8:	27c50513          	addi	a0,a0,636 # 80005540 <pr>
    800022cc:	00001097          	auipc	ra,0x1
    800022d0:	94c080e7          	jalr	-1716(ra) # 80002c18 <release>
    800022d4:	e49ff06f          	j	8000211c <__printf+0x2a4>
    800022d8:	f7843783          	ld	a5,-136(s0)
    800022dc:	03000513          	li	a0,48
    800022e0:	01000d13          	li	s10,16
    800022e4:	00878713          	addi	a4,a5,8
    800022e8:	0007bc83          	ld	s9,0(a5)
    800022ec:	f6e43c23          	sd	a4,-136(s0)
    800022f0:	00000097          	auipc	ra,0x0
    800022f4:	9a4080e7          	jalr	-1628(ra) # 80001c94 <consputc>
    800022f8:	07800513          	li	a0,120
    800022fc:	00000097          	auipc	ra,0x0
    80002300:	998080e7          	jalr	-1640(ra) # 80001c94 <consputc>
    80002304:	00002d97          	auipc	s11,0x2
    80002308:	e74d8d93          	addi	s11,s11,-396 # 80004178 <digits>
    8000230c:	03ccd793          	srli	a5,s9,0x3c
    80002310:	00fd87b3          	add	a5,s11,a5
    80002314:	0007c503          	lbu	a0,0(a5)
    80002318:	fffd0d1b          	addiw	s10,s10,-1
    8000231c:	004c9c93          	slli	s9,s9,0x4
    80002320:	00000097          	auipc	ra,0x0
    80002324:	974080e7          	jalr	-1676(ra) # 80001c94 <consputc>
    80002328:	fe0d12e3          	bnez	s10,8000230c <__printf+0x494>
    8000232c:	f8dff06f          	j	800022b8 <__printf+0x440>
    80002330:	f7843783          	ld	a5,-136(s0)
    80002334:	0007bc83          	ld	s9,0(a5)
    80002338:	00878793          	addi	a5,a5,8
    8000233c:	f6f43c23          	sd	a5,-136(s0)
    80002340:	000c9a63          	bnez	s9,80002354 <__printf+0x4dc>
    80002344:	1080006f          	j	8000244c <__printf+0x5d4>
    80002348:	001c8c93          	addi	s9,s9,1
    8000234c:	00000097          	auipc	ra,0x0
    80002350:	948080e7          	jalr	-1720(ra) # 80001c94 <consputc>
    80002354:	000cc503          	lbu	a0,0(s9)
    80002358:	fe0518e3          	bnez	a0,80002348 <__printf+0x4d0>
    8000235c:	f5dff06f          	j	800022b8 <__printf+0x440>
    80002360:	02500513          	li	a0,37
    80002364:	00000097          	auipc	ra,0x0
    80002368:	930080e7          	jalr	-1744(ra) # 80001c94 <consputc>
    8000236c:	000c8513          	mv	a0,s9
    80002370:	00000097          	auipc	ra,0x0
    80002374:	924080e7          	jalr	-1756(ra) # 80001c94 <consputc>
    80002378:	f41ff06f          	j	800022b8 <__printf+0x440>
    8000237c:	02500513          	li	a0,37
    80002380:	00000097          	auipc	ra,0x0
    80002384:	914080e7          	jalr	-1772(ra) # 80001c94 <consputc>
    80002388:	f31ff06f          	j	800022b8 <__printf+0x440>
    8000238c:	00030513          	mv	a0,t1
    80002390:	00000097          	auipc	ra,0x0
    80002394:	7bc080e7          	jalr	1980(ra) # 80002b4c <acquire>
    80002398:	b4dff06f          	j	80001ee4 <__printf+0x6c>
    8000239c:	40c0053b          	negw	a0,a2
    800023a0:	00a00713          	li	a4,10
    800023a4:	02e576bb          	remuw	a3,a0,a4
    800023a8:	00002d97          	auipc	s11,0x2
    800023ac:	dd0d8d93          	addi	s11,s11,-560 # 80004178 <digits>
    800023b0:	ff700593          	li	a1,-9
    800023b4:	02069693          	slli	a3,a3,0x20
    800023b8:	0206d693          	srli	a3,a3,0x20
    800023bc:	00dd86b3          	add	a3,s11,a3
    800023c0:	0006c683          	lbu	a3,0(a3)
    800023c4:	02e557bb          	divuw	a5,a0,a4
    800023c8:	f8d40023          	sb	a3,-128(s0)
    800023cc:	10b65e63          	bge	a2,a1,800024e8 <__printf+0x670>
    800023d0:	06300593          	li	a1,99
    800023d4:	02e7f6bb          	remuw	a3,a5,a4
    800023d8:	02069693          	slli	a3,a3,0x20
    800023dc:	0206d693          	srli	a3,a3,0x20
    800023e0:	00dd86b3          	add	a3,s11,a3
    800023e4:	0006c683          	lbu	a3,0(a3)
    800023e8:	02e7d73b          	divuw	a4,a5,a4
    800023ec:	00200793          	li	a5,2
    800023f0:	f8d400a3          	sb	a3,-127(s0)
    800023f4:	bca5ece3          	bltu	a1,a0,80001fcc <__printf+0x154>
    800023f8:	ce5ff06f          	j	800020dc <__printf+0x264>
    800023fc:	40e007bb          	negw	a5,a4
    80002400:	00002d97          	auipc	s11,0x2
    80002404:	d78d8d93          	addi	s11,s11,-648 # 80004178 <digits>
    80002408:	00f7f693          	andi	a3,a5,15
    8000240c:	00dd86b3          	add	a3,s11,a3
    80002410:	0006c583          	lbu	a1,0(a3)
    80002414:	ff100613          	li	a2,-15
    80002418:	0047d69b          	srliw	a3,a5,0x4
    8000241c:	f8b40023          	sb	a1,-128(s0)
    80002420:	0047d59b          	srliw	a1,a5,0x4
    80002424:	0ac75e63          	bge	a4,a2,800024e0 <__printf+0x668>
    80002428:	00f6f693          	andi	a3,a3,15
    8000242c:	00dd86b3          	add	a3,s11,a3
    80002430:	0006c603          	lbu	a2,0(a3)
    80002434:	00f00693          	li	a3,15
    80002438:	0087d79b          	srliw	a5,a5,0x8
    8000243c:	f8c400a3          	sb	a2,-127(s0)
    80002440:	d8b6e4e3          	bltu	a3,a1,800021c8 <__printf+0x350>
    80002444:	00200793          	li	a5,2
    80002448:	e2dff06f          	j	80002274 <__printf+0x3fc>
    8000244c:	00002c97          	auipc	s9,0x2
    80002450:	d0cc8c93          	addi	s9,s9,-756 # 80004158 <CONSOLE_STATUS+0x148>
    80002454:	02800513          	li	a0,40
    80002458:	ef1ff06f          	j	80002348 <__printf+0x4d0>
    8000245c:	00700793          	li	a5,7
    80002460:	00600c93          	li	s9,6
    80002464:	e0dff06f          	j	80002270 <__printf+0x3f8>
    80002468:	00700793          	li	a5,7
    8000246c:	00600c93          	li	s9,6
    80002470:	c69ff06f          	j	800020d8 <__printf+0x260>
    80002474:	00300793          	li	a5,3
    80002478:	00200c93          	li	s9,2
    8000247c:	c5dff06f          	j	800020d8 <__printf+0x260>
    80002480:	00300793          	li	a5,3
    80002484:	00200c93          	li	s9,2
    80002488:	de9ff06f          	j	80002270 <__printf+0x3f8>
    8000248c:	00400793          	li	a5,4
    80002490:	00300c93          	li	s9,3
    80002494:	dddff06f          	j	80002270 <__printf+0x3f8>
    80002498:	00400793          	li	a5,4
    8000249c:	00300c93          	li	s9,3
    800024a0:	c39ff06f          	j	800020d8 <__printf+0x260>
    800024a4:	00500793          	li	a5,5
    800024a8:	00400c93          	li	s9,4
    800024ac:	c2dff06f          	j	800020d8 <__printf+0x260>
    800024b0:	00500793          	li	a5,5
    800024b4:	00400c93          	li	s9,4
    800024b8:	db9ff06f          	j	80002270 <__printf+0x3f8>
    800024bc:	00600793          	li	a5,6
    800024c0:	00500c93          	li	s9,5
    800024c4:	dadff06f          	j	80002270 <__printf+0x3f8>
    800024c8:	00600793          	li	a5,6
    800024cc:	00500c93          	li	s9,5
    800024d0:	c09ff06f          	j	800020d8 <__printf+0x260>
    800024d4:	00800793          	li	a5,8
    800024d8:	00700c93          	li	s9,7
    800024dc:	bfdff06f          	j	800020d8 <__printf+0x260>
    800024e0:	00100793          	li	a5,1
    800024e4:	d91ff06f          	j	80002274 <__printf+0x3fc>
    800024e8:	00100793          	li	a5,1
    800024ec:	bf1ff06f          	j	800020dc <__printf+0x264>
    800024f0:	00900793          	li	a5,9
    800024f4:	00800c93          	li	s9,8
    800024f8:	be1ff06f          	j	800020d8 <__printf+0x260>
    800024fc:	00002517          	auipc	a0,0x2
    80002500:	c6450513          	addi	a0,a0,-924 # 80004160 <CONSOLE_STATUS+0x150>
    80002504:	00000097          	auipc	ra,0x0
    80002508:	918080e7          	jalr	-1768(ra) # 80001e1c <panic>

000000008000250c <printfinit>:
    8000250c:	fe010113          	addi	sp,sp,-32
    80002510:	00813823          	sd	s0,16(sp)
    80002514:	00913423          	sd	s1,8(sp)
    80002518:	00113c23          	sd	ra,24(sp)
    8000251c:	02010413          	addi	s0,sp,32
    80002520:	00003497          	auipc	s1,0x3
    80002524:	02048493          	addi	s1,s1,32 # 80005540 <pr>
    80002528:	00048513          	mv	a0,s1
    8000252c:	00002597          	auipc	a1,0x2
    80002530:	c4458593          	addi	a1,a1,-956 # 80004170 <CONSOLE_STATUS+0x160>
    80002534:	00000097          	auipc	ra,0x0
    80002538:	5f4080e7          	jalr	1524(ra) # 80002b28 <initlock>
    8000253c:	01813083          	ld	ra,24(sp)
    80002540:	01013403          	ld	s0,16(sp)
    80002544:	0004ac23          	sw	zero,24(s1)
    80002548:	00813483          	ld	s1,8(sp)
    8000254c:	02010113          	addi	sp,sp,32
    80002550:	00008067          	ret

0000000080002554 <uartinit>:
    80002554:	ff010113          	addi	sp,sp,-16
    80002558:	00813423          	sd	s0,8(sp)
    8000255c:	01010413          	addi	s0,sp,16
    80002560:	100007b7          	lui	a5,0x10000
    80002564:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002568:	f8000713          	li	a4,-128
    8000256c:	00e781a3          	sb	a4,3(a5)
    80002570:	00300713          	li	a4,3
    80002574:	00e78023          	sb	a4,0(a5)
    80002578:	000780a3          	sb	zero,1(a5)
    8000257c:	00e781a3          	sb	a4,3(a5)
    80002580:	00700693          	li	a3,7
    80002584:	00d78123          	sb	a3,2(a5)
    80002588:	00e780a3          	sb	a4,1(a5)
    8000258c:	00813403          	ld	s0,8(sp)
    80002590:	01010113          	addi	sp,sp,16
    80002594:	00008067          	ret

0000000080002598 <uartputc>:
    80002598:	00002797          	auipc	a5,0x2
    8000259c:	d607a783          	lw	a5,-672(a5) # 800042f8 <panicked>
    800025a0:	00078463          	beqz	a5,800025a8 <uartputc+0x10>
    800025a4:	0000006f          	j	800025a4 <uartputc+0xc>
    800025a8:	fd010113          	addi	sp,sp,-48
    800025ac:	02813023          	sd	s0,32(sp)
    800025b0:	00913c23          	sd	s1,24(sp)
    800025b4:	01213823          	sd	s2,16(sp)
    800025b8:	01313423          	sd	s3,8(sp)
    800025bc:	02113423          	sd	ra,40(sp)
    800025c0:	03010413          	addi	s0,sp,48
    800025c4:	00002917          	auipc	s2,0x2
    800025c8:	d3c90913          	addi	s2,s2,-708 # 80004300 <uart_tx_r>
    800025cc:	00093783          	ld	a5,0(s2)
    800025d0:	00002497          	auipc	s1,0x2
    800025d4:	d3848493          	addi	s1,s1,-712 # 80004308 <uart_tx_w>
    800025d8:	0004b703          	ld	a4,0(s1)
    800025dc:	02078693          	addi	a3,a5,32
    800025e0:	00050993          	mv	s3,a0
    800025e4:	02e69c63          	bne	a3,a4,8000261c <uartputc+0x84>
    800025e8:	00001097          	auipc	ra,0x1
    800025ec:	834080e7          	jalr	-1996(ra) # 80002e1c <push_on>
    800025f0:	00093783          	ld	a5,0(s2)
    800025f4:	0004b703          	ld	a4,0(s1)
    800025f8:	02078793          	addi	a5,a5,32
    800025fc:	00e79463          	bne	a5,a4,80002604 <uartputc+0x6c>
    80002600:	0000006f          	j	80002600 <uartputc+0x68>
    80002604:	00001097          	auipc	ra,0x1
    80002608:	88c080e7          	jalr	-1908(ra) # 80002e90 <pop_on>
    8000260c:	00093783          	ld	a5,0(s2)
    80002610:	0004b703          	ld	a4,0(s1)
    80002614:	02078693          	addi	a3,a5,32
    80002618:	fce688e3          	beq	a3,a4,800025e8 <uartputc+0x50>
    8000261c:	01f77693          	andi	a3,a4,31
    80002620:	00003597          	auipc	a1,0x3
    80002624:	f4058593          	addi	a1,a1,-192 # 80005560 <uart_tx_buf>
    80002628:	00d586b3          	add	a3,a1,a3
    8000262c:	00170713          	addi	a4,a4,1
    80002630:	01368023          	sb	s3,0(a3)
    80002634:	00e4b023          	sd	a4,0(s1)
    80002638:	10000637          	lui	a2,0x10000
    8000263c:	02f71063          	bne	a4,a5,8000265c <uartputc+0xc4>
    80002640:	0340006f          	j	80002674 <uartputc+0xdc>
    80002644:	00074703          	lbu	a4,0(a4)
    80002648:	00f93023          	sd	a5,0(s2)
    8000264c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002650:	00093783          	ld	a5,0(s2)
    80002654:	0004b703          	ld	a4,0(s1)
    80002658:	00f70e63          	beq	a4,a5,80002674 <uartputc+0xdc>
    8000265c:	00564683          	lbu	a3,5(a2)
    80002660:	01f7f713          	andi	a4,a5,31
    80002664:	00e58733          	add	a4,a1,a4
    80002668:	0206f693          	andi	a3,a3,32
    8000266c:	00178793          	addi	a5,a5,1
    80002670:	fc069ae3          	bnez	a3,80002644 <uartputc+0xac>
    80002674:	02813083          	ld	ra,40(sp)
    80002678:	02013403          	ld	s0,32(sp)
    8000267c:	01813483          	ld	s1,24(sp)
    80002680:	01013903          	ld	s2,16(sp)
    80002684:	00813983          	ld	s3,8(sp)
    80002688:	03010113          	addi	sp,sp,48
    8000268c:	00008067          	ret

0000000080002690 <uartputc_sync>:
    80002690:	ff010113          	addi	sp,sp,-16
    80002694:	00813423          	sd	s0,8(sp)
    80002698:	01010413          	addi	s0,sp,16
    8000269c:	00002717          	auipc	a4,0x2
    800026a0:	c5c72703          	lw	a4,-932(a4) # 800042f8 <panicked>
    800026a4:	02071663          	bnez	a4,800026d0 <uartputc_sync+0x40>
    800026a8:	00050793          	mv	a5,a0
    800026ac:	100006b7          	lui	a3,0x10000
    800026b0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800026b4:	02077713          	andi	a4,a4,32
    800026b8:	fe070ce3          	beqz	a4,800026b0 <uartputc_sync+0x20>
    800026bc:	0ff7f793          	andi	a5,a5,255
    800026c0:	00f68023          	sb	a5,0(a3)
    800026c4:	00813403          	ld	s0,8(sp)
    800026c8:	01010113          	addi	sp,sp,16
    800026cc:	00008067          	ret
    800026d0:	0000006f          	j	800026d0 <uartputc_sync+0x40>

00000000800026d4 <uartstart>:
    800026d4:	ff010113          	addi	sp,sp,-16
    800026d8:	00813423          	sd	s0,8(sp)
    800026dc:	01010413          	addi	s0,sp,16
    800026e0:	00002617          	auipc	a2,0x2
    800026e4:	c2060613          	addi	a2,a2,-992 # 80004300 <uart_tx_r>
    800026e8:	00002517          	auipc	a0,0x2
    800026ec:	c2050513          	addi	a0,a0,-992 # 80004308 <uart_tx_w>
    800026f0:	00063783          	ld	a5,0(a2)
    800026f4:	00053703          	ld	a4,0(a0)
    800026f8:	04f70263          	beq	a4,a5,8000273c <uartstart+0x68>
    800026fc:	100005b7          	lui	a1,0x10000
    80002700:	00003817          	auipc	a6,0x3
    80002704:	e6080813          	addi	a6,a6,-416 # 80005560 <uart_tx_buf>
    80002708:	01c0006f          	j	80002724 <uartstart+0x50>
    8000270c:	0006c703          	lbu	a4,0(a3)
    80002710:	00f63023          	sd	a5,0(a2)
    80002714:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002718:	00063783          	ld	a5,0(a2)
    8000271c:	00053703          	ld	a4,0(a0)
    80002720:	00f70e63          	beq	a4,a5,8000273c <uartstart+0x68>
    80002724:	01f7f713          	andi	a4,a5,31
    80002728:	00e806b3          	add	a3,a6,a4
    8000272c:	0055c703          	lbu	a4,5(a1)
    80002730:	00178793          	addi	a5,a5,1
    80002734:	02077713          	andi	a4,a4,32
    80002738:	fc071ae3          	bnez	a4,8000270c <uartstart+0x38>
    8000273c:	00813403          	ld	s0,8(sp)
    80002740:	01010113          	addi	sp,sp,16
    80002744:	00008067          	ret

0000000080002748 <uartgetc>:
    80002748:	ff010113          	addi	sp,sp,-16
    8000274c:	00813423          	sd	s0,8(sp)
    80002750:	01010413          	addi	s0,sp,16
    80002754:	10000737          	lui	a4,0x10000
    80002758:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000275c:	0017f793          	andi	a5,a5,1
    80002760:	00078c63          	beqz	a5,80002778 <uartgetc+0x30>
    80002764:	00074503          	lbu	a0,0(a4)
    80002768:	0ff57513          	andi	a0,a0,255
    8000276c:	00813403          	ld	s0,8(sp)
    80002770:	01010113          	addi	sp,sp,16
    80002774:	00008067          	ret
    80002778:	fff00513          	li	a0,-1
    8000277c:	ff1ff06f          	j	8000276c <uartgetc+0x24>

0000000080002780 <uartintr>:
    80002780:	100007b7          	lui	a5,0x10000
    80002784:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002788:	0017f793          	andi	a5,a5,1
    8000278c:	0a078463          	beqz	a5,80002834 <uartintr+0xb4>
    80002790:	fe010113          	addi	sp,sp,-32
    80002794:	00813823          	sd	s0,16(sp)
    80002798:	00913423          	sd	s1,8(sp)
    8000279c:	00113c23          	sd	ra,24(sp)
    800027a0:	02010413          	addi	s0,sp,32
    800027a4:	100004b7          	lui	s1,0x10000
    800027a8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800027ac:	0ff57513          	andi	a0,a0,255
    800027b0:	fffff097          	auipc	ra,0xfffff
    800027b4:	534080e7          	jalr	1332(ra) # 80001ce4 <consoleintr>
    800027b8:	0054c783          	lbu	a5,5(s1)
    800027bc:	0017f793          	andi	a5,a5,1
    800027c0:	fe0794e3          	bnez	a5,800027a8 <uartintr+0x28>
    800027c4:	00002617          	auipc	a2,0x2
    800027c8:	b3c60613          	addi	a2,a2,-1220 # 80004300 <uart_tx_r>
    800027cc:	00002517          	auipc	a0,0x2
    800027d0:	b3c50513          	addi	a0,a0,-1220 # 80004308 <uart_tx_w>
    800027d4:	00063783          	ld	a5,0(a2)
    800027d8:	00053703          	ld	a4,0(a0)
    800027dc:	04f70263          	beq	a4,a5,80002820 <uartintr+0xa0>
    800027e0:	100005b7          	lui	a1,0x10000
    800027e4:	00003817          	auipc	a6,0x3
    800027e8:	d7c80813          	addi	a6,a6,-644 # 80005560 <uart_tx_buf>
    800027ec:	01c0006f          	j	80002808 <uartintr+0x88>
    800027f0:	0006c703          	lbu	a4,0(a3)
    800027f4:	00f63023          	sd	a5,0(a2)
    800027f8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800027fc:	00063783          	ld	a5,0(a2)
    80002800:	00053703          	ld	a4,0(a0)
    80002804:	00f70e63          	beq	a4,a5,80002820 <uartintr+0xa0>
    80002808:	01f7f713          	andi	a4,a5,31
    8000280c:	00e806b3          	add	a3,a6,a4
    80002810:	0055c703          	lbu	a4,5(a1)
    80002814:	00178793          	addi	a5,a5,1
    80002818:	02077713          	andi	a4,a4,32
    8000281c:	fc071ae3          	bnez	a4,800027f0 <uartintr+0x70>
    80002820:	01813083          	ld	ra,24(sp)
    80002824:	01013403          	ld	s0,16(sp)
    80002828:	00813483          	ld	s1,8(sp)
    8000282c:	02010113          	addi	sp,sp,32
    80002830:	00008067          	ret
    80002834:	00002617          	auipc	a2,0x2
    80002838:	acc60613          	addi	a2,a2,-1332 # 80004300 <uart_tx_r>
    8000283c:	00002517          	auipc	a0,0x2
    80002840:	acc50513          	addi	a0,a0,-1332 # 80004308 <uart_tx_w>
    80002844:	00063783          	ld	a5,0(a2)
    80002848:	00053703          	ld	a4,0(a0)
    8000284c:	04f70263          	beq	a4,a5,80002890 <uartintr+0x110>
    80002850:	100005b7          	lui	a1,0x10000
    80002854:	00003817          	auipc	a6,0x3
    80002858:	d0c80813          	addi	a6,a6,-756 # 80005560 <uart_tx_buf>
    8000285c:	01c0006f          	j	80002878 <uartintr+0xf8>
    80002860:	0006c703          	lbu	a4,0(a3)
    80002864:	00f63023          	sd	a5,0(a2)
    80002868:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000286c:	00063783          	ld	a5,0(a2)
    80002870:	00053703          	ld	a4,0(a0)
    80002874:	02f70063          	beq	a4,a5,80002894 <uartintr+0x114>
    80002878:	01f7f713          	andi	a4,a5,31
    8000287c:	00e806b3          	add	a3,a6,a4
    80002880:	0055c703          	lbu	a4,5(a1)
    80002884:	00178793          	addi	a5,a5,1
    80002888:	02077713          	andi	a4,a4,32
    8000288c:	fc071ae3          	bnez	a4,80002860 <uartintr+0xe0>
    80002890:	00008067          	ret
    80002894:	00008067          	ret

0000000080002898 <kinit>:
    80002898:	fc010113          	addi	sp,sp,-64
    8000289c:	02913423          	sd	s1,40(sp)
    800028a0:	fffff7b7          	lui	a5,0xfffff
    800028a4:	00004497          	auipc	s1,0x4
    800028a8:	cdb48493          	addi	s1,s1,-805 # 8000657f <end+0xfff>
    800028ac:	02813823          	sd	s0,48(sp)
    800028b0:	01313c23          	sd	s3,24(sp)
    800028b4:	00f4f4b3          	and	s1,s1,a5
    800028b8:	02113c23          	sd	ra,56(sp)
    800028bc:	03213023          	sd	s2,32(sp)
    800028c0:	01413823          	sd	s4,16(sp)
    800028c4:	01513423          	sd	s5,8(sp)
    800028c8:	04010413          	addi	s0,sp,64
    800028cc:	000017b7          	lui	a5,0x1
    800028d0:	01100993          	li	s3,17
    800028d4:	00f487b3          	add	a5,s1,a5
    800028d8:	01b99993          	slli	s3,s3,0x1b
    800028dc:	06f9e063          	bltu	s3,a5,8000293c <kinit+0xa4>
    800028e0:	00003a97          	auipc	s5,0x3
    800028e4:	ca0a8a93          	addi	s5,s5,-864 # 80005580 <end>
    800028e8:	0754ec63          	bltu	s1,s5,80002960 <kinit+0xc8>
    800028ec:	0734fa63          	bgeu	s1,s3,80002960 <kinit+0xc8>
    800028f0:	00088a37          	lui	s4,0x88
    800028f4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800028f8:	00002917          	auipc	s2,0x2
    800028fc:	a1890913          	addi	s2,s2,-1512 # 80004310 <kmem>
    80002900:	00ca1a13          	slli	s4,s4,0xc
    80002904:	0140006f          	j	80002918 <kinit+0x80>
    80002908:	000017b7          	lui	a5,0x1
    8000290c:	00f484b3          	add	s1,s1,a5
    80002910:	0554e863          	bltu	s1,s5,80002960 <kinit+0xc8>
    80002914:	0534f663          	bgeu	s1,s3,80002960 <kinit+0xc8>
    80002918:	00001637          	lui	a2,0x1
    8000291c:	00100593          	li	a1,1
    80002920:	00048513          	mv	a0,s1
    80002924:	00000097          	auipc	ra,0x0
    80002928:	5e4080e7          	jalr	1508(ra) # 80002f08 <__memset>
    8000292c:	00093783          	ld	a5,0(s2)
    80002930:	00f4b023          	sd	a5,0(s1)
    80002934:	00993023          	sd	s1,0(s2)
    80002938:	fd4498e3          	bne	s1,s4,80002908 <kinit+0x70>
    8000293c:	03813083          	ld	ra,56(sp)
    80002940:	03013403          	ld	s0,48(sp)
    80002944:	02813483          	ld	s1,40(sp)
    80002948:	02013903          	ld	s2,32(sp)
    8000294c:	01813983          	ld	s3,24(sp)
    80002950:	01013a03          	ld	s4,16(sp)
    80002954:	00813a83          	ld	s5,8(sp)
    80002958:	04010113          	addi	sp,sp,64
    8000295c:	00008067          	ret
    80002960:	00002517          	auipc	a0,0x2
    80002964:	83050513          	addi	a0,a0,-2000 # 80004190 <digits+0x18>
    80002968:	fffff097          	auipc	ra,0xfffff
    8000296c:	4b4080e7          	jalr	1204(ra) # 80001e1c <panic>

0000000080002970 <freerange>:
    80002970:	fc010113          	addi	sp,sp,-64
    80002974:	000017b7          	lui	a5,0x1
    80002978:	02913423          	sd	s1,40(sp)
    8000297c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002980:	009504b3          	add	s1,a0,s1
    80002984:	fffff537          	lui	a0,0xfffff
    80002988:	02813823          	sd	s0,48(sp)
    8000298c:	02113c23          	sd	ra,56(sp)
    80002990:	03213023          	sd	s2,32(sp)
    80002994:	01313c23          	sd	s3,24(sp)
    80002998:	01413823          	sd	s4,16(sp)
    8000299c:	01513423          	sd	s5,8(sp)
    800029a0:	01613023          	sd	s6,0(sp)
    800029a4:	04010413          	addi	s0,sp,64
    800029a8:	00a4f4b3          	and	s1,s1,a0
    800029ac:	00f487b3          	add	a5,s1,a5
    800029b0:	06f5e463          	bltu	a1,a5,80002a18 <freerange+0xa8>
    800029b4:	00003a97          	auipc	s5,0x3
    800029b8:	bcca8a93          	addi	s5,s5,-1076 # 80005580 <end>
    800029bc:	0954e263          	bltu	s1,s5,80002a40 <freerange+0xd0>
    800029c0:	01100993          	li	s3,17
    800029c4:	01b99993          	slli	s3,s3,0x1b
    800029c8:	0734fc63          	bgeu	s1,s3,80002a40 <freerange+0xd0>
    800029cc:	00058a13          	mv	s4,a1
    800029d0:	00002917          	auipc	s2,0x2
    800029d4:	94090913          	addi	s2,s2,-1728 # 80004310 <kmem>
    800029d8:	00002b37          	lui	s6,0x2
    800029dc:	0140006f          	j	800029f0 <freerange+0x80>
    800029e0:	000017b7          	lui	a5,0x1
    800029e4:	00f484b3          	add	s1,s1,a5
    800029e8:	0554ec63          	bltu	s1,s5,80002a40 <freerange+0xd0>
    800029ec:	0534fa63          	bgeu	s1,s3,80002a40 <freerange+0xd0>
    800029f0:	00001637          	lui	a2,0x1
    800029f4:	00100593          	li	a1,1
    800029f8:	00048513          	mv	a0,s1
    800029fc:	00000097          	auipc	ra,0x0
    80002a00:	50c080e7          	jalr	1292(ra) # 80002f08 <__memset>
    80002a04:	00093703          	ld	a4,0(s2)
    80002a08:	016487b3          	add	a5,s1,s6
    80002a0c:	00e4b023          	sd	a4,0(s1)
    80002a10:	00993023          	sd	s1,0(s2)
    80002a14:	fcfa76e3          	bgeu	s4,a5,800029e0 <freerange+0x70>
    80002a18:	03813083          	ld	ra,56(sp)
    80002a1c:	03013403          	ld	s0,48(sp)
    80002a20:	02813483          	ld	s1,40(sp)
    80002a24:	02013903          	ld	s2,32(sp)
    80002a28:	01813983          	ld	s3,24(sp)
    80002a2c:	01013a03          	ld	s4,16(sp)
    80002a30:	00813a83          	ld	s5,8(sp)
    80002a34:	00013b03          	ld	s6,0(sp)
    80002a38:	04010113          	addi	sp,sp,64
    80002a3c:	00008067          	ret
    80002a40:	00001517          	auipc	a0,0x1
    80002a44:	75050513          	addi	a0,a0,1872 # 80004190 <digits+0x18>
    80002a48:	fffff097          	auipc	ra,0xfffff
    80002a4c:	3d4080e7          	jalr	980(ra) # 80001e1c <panic>

0000000080002a50 <kfree>:
    80002a50:	fe010113          	addi	sp,sp,-32
    80002a54:	00813823          	sd	s0,16(sp)
    80002a58:	00113c23          	sd	ra,24(sp)
    80002a5c:	00913423          	sd	s1,8(sp)
    80002a60:	02010413          	addi	s0,sp,32
    80002a64:	03451793          	slli	a5,a0,0x34
    80002a68:	04079c63          	bnez	a5,80002ac0 <kfree+0x70>
    80002a6c:	00003797          	auipc	a5,0x3
    80002a70:	b1478793          	addi	a5,a5,-1260 # 80005580 <end>
    80002a74:	00050493          	mv	s1,a0
    80002a78:	04f56463          	bltu	a0,a5,80002ac0 <kfree+0x70>
    80002a7c:	01100793          	li	a5,17
    80002a80:	01b79793          	slli	a5,a5,0x1b
    80002a84:	02f57e63          	bgeu	a0,a5,80002ac0 <kfree+0x70>
    80002a88:	00001637          	lui	a2,0x1
    80002a8c:	00100593          	li	a1,1
    80002a90:	00000097          	auipc	ra,0x0
    80002a94:	478080e7          	jalr	1144(ra) # 80002f08 <__memset>
    80002a98:	00002797          	auipc	a5,0x2
    80002a9c:	87878793          	addi	a5,a5,-1928 # 80004310 <kmem>
    80002aa0:	0007b703          	ld	a4,0(a5)
    80002aa4:	01813083          	ld	ra,24(sp)
    80002aa8:	01013403          	ld	s0,16(sp)
    80002aac:	00e4b023          	sd	a4,0(s1)
    80002ab0:	0097b023          	sd	s1,0(a5)
    80002ab4:	00813483          	ld	s1,8(sp)
    80002ab8:	02010113          	addi	sp,sp,32
    80002abc:	00008067          	ret
    80002ac0:	00001517          	auipc	a0,0x1
    80002ac4:	6d050513          	addi	a0,a0,1744 # 80004190 <digits+0x18>
    80002ac8:	fffff097          	auipc	ra,0xfffff
    80002acc:	354080e7          	jalr	852(ra) # 80001e1c <panic>

0000000080002ad0 <kalloc>:
    80002ad0:	fe010113          	addi	sp,sp,-32
    80002ad4:	00813823          	sd	s0,16(sp)
    80002ad8:	00913423          	sd	s1,8(sp)
    80002adc:	00113c23          	sd	ra,24(sp)
    80002ae0:	02010413          	addi	s0,sp,32
    80002ae4:	00002797          	auipc	a5,0x2
    80002ae8:	82c78793          	addi	a5,a5,-2004 # 80004310 <kmem>
    80002aec:	0007b483          	ld	s1,0(a5)
    80002af0:	02048063          	beqz	s1,80002b10 <kalloc+0x40>
    80002af4:	0004b703          	ld	a4,0(s1)
    80002af8:	00001637          	lui	a2,0x1
    80002afc:	00500593          	li	a1,5
    80002b00:	00048513          	mv	a0,s1
    80002b04:	00e7b023          	sd	a4,0(a5)
    80002b08:	00000097          	auipc	ra,0x0
    80002b0c:	400080e7          	jalr	1024(ra) # 80002f08 <__memset>
    80002b10:	01813083          	ld	ra,24(sp)
    80002b14:	01013403          	ld	s0,16(sp)
    80002b18:	00048513          	mv	a0,s1
    80002b1c:	00813483          	ld	s1,8(sp)
    80002b20:	02010113          	addi	sp,sp,32
    80002b24:	00008067          	ret

0000000080002b28 <initlock>:
    80002b28:	ff010113          	addi	sp,sp,-16
    80002b2c:	00813423          	sd	s0,8(sp)
    80002b30:	01010413          	addi	s0,sp,16
    80002b34:	00813403          	ld	s0,8(sp)
    80002b38:	00b53423          	sd	a1,8(a0)
    80002b3c:	00052023          	sw	zero,0(a0)
    80002b40:	00053823          	sd	zero,16(a0)
    80002b44:	01010113          	addi	sp,sp,16
    80002b48:	00008067          	ret

0000000080002b4c <acquire>:
    80002b4c:	fe010113          	addi	sp,sp,-32
    80002b50:	00813823          	sd	s0,16(sp)
    80002b54:	00913423          	sd	s1,8(sp)
    80002b58:	00113c23          	sd	ra,24(sp)
    80002b5c:	01213023          	sd	s2,0(sp)
    80002b60:	02010413          	addi	s0,sp,32
    80002b64:	00050493          	mv	s1,a0
    80002b68:	10002973          	csrr	s2,sstatus
    80002b6c:	100027f3          	csrr	a5,sstatus
    80002b70:	ffd7f793          	andi	a5,a5,-3
    80002b74:	10079073          	csrw	sstatus,a5
    80002b78:	fffff097          	auipc	ra,0xfffff
    80002b7c:	8e0080e7          	jalr	-1824(ra) # 80001458 <mycpu>
    80002b80:	07852783          	lw	a5,120(a0)
    80002b84:	06078e63          	beqz	a5,80002c00 <acquire+0xb4>
    80002b88:	fffff097          	auipc	ra,0xfffff
    80002b8c:	8d0080e7          	jalr	-1840(ra) # 80001458 <mycpu>
    80002b90:	07852783          	lw	a5,120(a0)
    80002b94:	0004a703          	lw	a4,0(s1)
    80002b98:	0017879b          	addiw	a5,a5,1
    80002b9c:	06f52c23          	sw	a5,120(a0)
    80002ba0:	04071063          	bnez	a4,80002be0 <acquire+0x94>
    80002ba4:	00100713          	li	a4,1
    80002ba8:	00070793          	mv	a5,a4
    80002bac:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002bb0:	0007879b          	sext.w	a5,a5
    80002bb4:	fe079ae3          	bnez	a5,80002ba8 <acquire+0x5c>
    80002bb8:	0ff0000f          	fence
    80002bbc:	fffff097          	auipc	ra,0xfffff
    80002bc0:	89c080e7          	jalr	-1892(ra) # 80001458 <mycpu>
    80002bc4:	01813083          	ld	ra,24(sp)
    80002bc8:	01013403          	ld	s0,16(sp)
    80002bcc:	00a4b823          	sd	a0,16(s1)
    80002bd0:	00013903          	ld	s2,0(sp)
    80002bd4:	00813483          	ld	s1,8(sp)
    80002bd8:	02010113          	addi	sp,sp,32
    80002bdc:	00008067          	ret
    80002be0:	0104b903          	ld	s2,16(s1)
    80002be4:	fffff097          	auipc	ra,0xfffff
    80002be8:	874080e7          	jalr	-1932(ra) # 80001458 <mycpu>
    80002bec:	faa91ce3          	bne	s2,a0,80002ba4 <acquire+0x58>
    80002bf0:	00001517          	auipc	a0,0x1
    80002bf4:	5a850513          	addi	a0,a0,1448 # 80004198 <digits+0x20>
    80002bf8:	fffff097          	auipc	ra,0xfffff
    80002bfc:	224080e7          	jalr	548(ra) # 80001e1c <panic>
    80002c00:	00195913          	srli	s2,s2,0x1
    80002c04:	fffff097          	auipc	ra,0xfffff
    80002c08:	854080e7          	jalr	-1964(ra) # 80001458 <mycpu>
    80002c0c:	00197913          	andi	s2,s2,1
    80002c10:	07252e23          	sw	s2,124(a0)
    80002c14:	f75ff06f          	j	80002b88 <acquire+0x3c>

0000000080002c18 <release>:
    80002c18:	fe010113          	addi	sp,sp,-32
    80002c1c:	00813823          	sd	s0,16(sp)
    80002c20:	00113c23          	sd	ra,24(sp)
    80002c24:	00913423          	sd	s1,8(sp)
    80002c28:	01213023          	sd	s2,0(sp)
    80002c2c:	02010413          	addi	s0,sp,32
    80002c30:	00052783          	lw	a5,0(a0)
    80002c34:	00079a63          	bnez	a5,80002c48 <release+0x30>
    80002c38:	00001517          	auipc	a0,0x1
    80002c3c:	56850513          	addi	a0,a0,1384 # 800041a0 <digits+0x28>
    80002c40:	fffff097          	auipc	ra,0xfffff
    80002c44:	1dc080e7          	jalr	476(ra) # 80001e1c <panic>
    80002c48:	01053903          	ld	s2,16(a0)
    80002c4c:	00050493          	mv	s1,a0
    80002c50:	fffff097          	auipc	ra,0xfffff
    80002c54:	808080e7          	jalr	-2040(ra) # 80001458 <mycpu>
    80002c58:	fea910e3          	bne	s2,a0,80002c38 <release+0x20>
    80002c5c:	0004b823          	sd	zero,16(s1)
    80002c60:	0ff0000f          	fence
    80002c64:	0f50000f          	fence	iorw,ow
    80002c68:	0804a02f          	amoswap.w	zero,zero,(s1)
    80002c6c:	ffffe097          	auipc	ra,0xffffe
    80002c70:	7ec080e7          	jalr	2028(ra) # 80001458 <mycpu>
    80002c74:	100027f3          	csrr	a5,sstatus
    80002c78:	0027f793          	andi	a5,a5,2
    80002c7c:	04079a63          	bnez	a5,80002cd0 <release+0xb8>
    80002c80:	07852783          	lw	a5,120(a0)
    80002c84:	02f05e63          	blez	a5,80002cc0 <release+0xa8>
    80002c88:	fff7871b          	addiw	a4,a5,-1
    80002c8c:	06e52c23          	sw	a4,120(a0)
    80002c90:	00071c63          	bnez	a4,80002ca8 <release+0x90>
    80002c94:	07c52783          	lw	a5,124(a0)
    80002c98:	00078863          	beqz	a5,80002ca8 <release+0x90>
    80002c9c:	100027f3          	csrr	a5,sstatus
    80002ca0:	0027e793          	ori	a5,a5,2
    80002ca4:	10079073          	csrw	sstatus,a5
    80002ca8:	01813083          	ld	ra,24(sp)
    80002cac:	01013403          	ld	s0,16(sp)
    80002cb0:	00813483          	ld	s1,8(sp)
    80002cb4:	00013903          	ld	s2,0(sp)
    80002cb8:	02010113          	addi	sp,sp,32
    80002cbc:	00008067          	ret
    80002cc0:	00001517          	auipc	a0,0x1
    80002cc4:	50050513          	addi	a0,a0,1280 # 800041c0 <digits+0x48>
    80002cc8:	fffff097          	auipc	ra,0xfffff
    80002ccc:	154080e7          	jalr	340(ra) # 80001e1c <panic>
    80002cd0:	00001517          	auipc	a0,0x1
    80002cd4:	4d850513          	addi	a0,a0,1240 # 800041a8 <digits+0x30>
    80002cd8:	fffff097          	auipc	ra,0xfffff
    80002cdc:	144080e7          	jalr	324(ra) # 80001e1c <panic>

0000000080002ce0 <holding>:
    80002ce0:	00052783          	lw	a5,0(a0)
    80002ce4:	00079663          	bnez	a5,80002cf0 <holding+0x10>
    80002ce8:	00000513          	li	a0,0
    80002cec:	00008067          	ret
    80002cf0:	fe010113          	addi	sp,sp,-32
    80002cf4:	00813823          	sd	s0,16(sp)
    80002cf8:	00913423          	sd	s1,8(sp)
    80002cfc:	00113c23          	sd	ra,24(sp)
    80002d00:	02010413          	addi	s0,sp,32
    80002d04:	01053483          	ld	s1,16(a0)
    80002d08:	ffffe097          	auipc	ra,0xffffe
    80002d0c:	750080e7          	jalr	1872(ra) # 80001458 <mycpu>
    80002d10:	01813083          	ld	ra,24(sp)
    80002d14:	01013403          	ld	s0,16(sp)
    80002d18:	40a48533          	sub	a0,s1,a0
    80002d1c:	00153513          	seqz	a0,a0
    80002d20:	00813483          	ld	s1,8(sp)
    80002d24:	02010113          	addi	sp,sp,32
    80002d28:	00008067          	ret

0000000080002d2c <push_off>:
    80002d2c:	fe010113          	addi	sp,sp,-32
    80002d30:	00813823          	sd	s0,16(sp)
    80002d34:	00113c23          	sd	ra,24(sp)
    80002d38:	00913423          	sd	s1,8(sp)
    80002d3c:	02010413          	addi	s0,sp,32
    80002d40:	100024f3          	csrr	s1,sstatus
    80002d44:	100027f3          	csrr	a5,sstatus
    80002d48:	ffd7f793          	andi	a5,a5,-3
    80002d4c:	10079073          	csrw	sstatus,a5
    80002d50:	ffffe097          	auipc	ra,0xffffe
    80002d54:	708080e7          	jalr	1800(ra) # 80001458 <mycpu>
    80002d58:	07852783          	lw	a5,120(a0)
    80002d5c:	02078663          	beqz	a5,80002d88 <push_off+0x5c>
    80002d60:	ffffe097          	auipc	ra,0xffffe
    80002d64:	6f8080e7          	jalr	1784(ra) # 80001458 <mycpu>
    80002d68:	07852783          	lw	a5,120(a0)
    80002d6c:	01813083          	ld	ra,24(sp)
    80002d70:	01013403          	ld	s0,16(sp)
    80002d74:	0017879b          	addiw	a5,a5,1
    80002d78:	06f52c23          	sw	a5,120(a0)
    80002d7c:	00813483          	ld	s1,8(sp)
    80002d80:	02010113          	addi	sp,sp,32
    80002d84:	00008067          	ret
    80002d88:	0014d493          	srli	s1,s1,0x1
    80002d8c:	ffffe097          	auipc	ra,0xffffe
    80002d90:	6cc080e7          	jalr	1740(ra) # 80001458 <mycpu>
    80002d94:	0014f493          	andi	s1,s1,1
    80002d98:	06952e23          	sw	s1,124(a0)
    80002d9c:	fc5ff06f          	j	80002d60 <push_off+0x34>

0000000080002da0 <pop_off>:
    80002da0:	ff010113          	addi	sp,sp,-16
    80002da4:	00813023          	sd	s0,0(sp)
    80002da8:	00113423          	sd	ra,8(sp)
    80002dac:	01010413          	addi	s0,sp,16
    80002db0:	ffffe097          	auipc	ra,0xffffe
    80002db4:	6a8080e7          	jalr	1704(ra) # 80001458 <mycpu>
    80002db8:	100027f3          	csrr	a5,sstatus
    80002dbc:	0027f793          	andi	a5,a5,2
    80002dc0:	04079663          	bnez	a5,80002e0c <pop_off+0x6c>
    80002dc4:	07852783          	lw	a5,120(a0)
    80002dc8:	02f05a63          	blez	a5,80002dfc <pop_off+0x5c>
    80002dcc:	fff7871b          	addiw	a4,a5,-1
    80002dd0:	06e52c23          	sw	a4,120(a0)
    80002dd4:	00071c63          	bnez	a4,80002dec <pop_off+0x4c>
    80002dd8:	07c52783          	lw	a5,124(a0)
    80002ddc:	00078863          	beqz	a5,80002dec <pop_off+0x4c>
    80002de0:	100027f3          	csrr	a5,sstatus
    80002de4:	0027e793          	ori	a5,a5,2
    80002de8:	10079073          	csrw	sstatus,a5
    80002dec:	00813083          	ld	ra,8(sp)
    80002df0:	00013403          	ld	s0,0(sp)
    80002df4:	01010113          	addi	sp,sp,16
    80002df8:	00008067          	ret
    80002dfc:	00001517          	auipc	a0,0x1
    80002e00:	3c450513          	addi	a0,a0,964 # 800041c0 <digits+0x48>
    80002e04:	fffff097          	auipc	ra,0xfffff
    80002e08:	018080e7          	jalr	24(ra) # 80001e1c <panic>
    80002e0c:	00001517          	auipc	a0,0x1
    80002e10:	39c50513          	addi	a0,a0,924 # 800041a8 <digits+0x30>
    80002e14:	fffff097          	auipc	ra,0xfffff
    80002e18:	008080e7          	jalr	8(ra) # 80001e1c <panic>

0000000080002e1c <push_on>:
    80002e1c:	fe010113          	addi	sp,sp,-32
    80002e20:	00813823          	sd	s0,16(sp)
    80002e24:	00113c23          	sd	ra,24(sp)
    80002e28:	00913423          	sd	s1,8(sp)
    80002e2c:	02010413          	addi	s0,sp,32
    80002e30:	100024f3          	csrr	s1,sstatus
    80002e34:	100027f3          	csrr	a5,sstatus
    80002e38:	0027e793          	ori	a5,a5,2
    80002e3c:	10079073          	csrw	sstatus,a5
    80002e40:	ffffe097          	auipc	ra,0xffffe
    80002e44:	618080e7          	jalr	1560(ra) # 80001458 <mycpu>
    80002e48:	07852783          	lw	a5,120(a0)
    80002e4c:	02078663          	beqz	a5,80002e78 <push_on+0x5c>
    80002e50:	ffffe097          	auipc	ra,0xffffe
    80002e54:	608080e7          	jalr	1544(ra) # 80001458 <mycpu>
    80002e58:	07852783          	lw	a5,120(a0)
    80002e5c:	01813083          	ld	ra,24(sp)
    80002e60:	01013403          	ld	s0,16(sp)
    80002e64:	0017879b          	addiw	a5,a5,1
    80002e68:	06f52c23          	sw	a5,120(a0)
    80002e6c:	00813483          	ld	s1,8(sp)
    80002e70:	02010113          	addi	sp,sp,32
    80002e74:	00008067          	ret
    80002e78:	0014d493          	srli	s1,s1,0x1
    80002e7c:	ffffe097          	auipc	ra,0xffffe
    80002e80:	5dc080e7          	jalr	1500(ra) # 80001458 <mycpu>
    80002e84:	0014f493          	andi	s1,s1,1
    80002e88:	06952e23          	sw	s1,124(a0)
    80002e8c:	fc5ff06f          	j	80002e50 <push_on+0x34>

0000000080002e90 <pop_on>:
    80002e90:	ff010113          	addi	sp,sp,-16
    80002e94:	00813023          	sd	s0,0(sp)
    80002e98:	00113423          	sd	ra,8(sp)
    80002e9c:	01010413          	addi	s0,sp,16
    80002ea0:	ffffe097          	auipc	ra,0xffffe
    80002ea4:	5b8080e7          	jalr	1464(ra) # 80001458 <mycpu>
    80002ea8:	100027f3          	csrr	a5,sstatus
    80002eac:	0027f793          	andi	a5,a5,2
    80002eb0:	04078463          	beqz	a5,80002ef8 <pop_on+0x68>
    80002eb4:	07852783          	lw	a5,120(a0)
    80002eb8:	02f05863          	blez	a5,80002ee8 <pop_on+0x58>
    80002ebc:	fff7879b          	addiw	a5,a5,-1
    80002ec0:	06f52c23          	sw	a5,120(a0)
    80002ec4:	07853783          	ld	a5,120(a0)
    80002ec8:	00079863          	bnez	a5,80002ed8 <pop_on+0x48>
    80002ecc:	100027f3          	csrr	a5,sstatus
    80002ed0:	ffd7f793          	andi	a5,a5,-3
    80002ed4:	10079073          	csrw	sstatus,a5
    80002ed8:	00813083          	ld	ra,8(sp)
    80002edc:	00013403          	ld	s0,0(sp)
    80002ee0:	01010113          	addi	sp,sp,16
    80002ee4:	00008067          	ret
    80002ee8:	00001517          	auipc	a0,0x1
    80002eec:	30050513          	addi	a0,a0,768 # 800041e8 <digits+0x70>
    80002ef0:	fffff097          	auipc	ra,0xfffff
    80002ef4:	f2c080e7          	jalr	-212(ra) # 80001e1c <panic>
    80002ef8:	00001517          	auipc	a0,0x1
    80002efc:	2d050513          	addi	a0,a0,720 # 800041c8 <digits+0x50>
    80002f00:	fffff097          	auipc	ra,0xfffff
    80002f04:	f1c080e7          	jalr	-228(ra) # 80001e1c <panic>

0000000080002f08 <__memset>:
    80002f08:	ff010113          	addi	sp,sp,-16
    80002f0c:	00813423          	sd	s0,8(sp)
    80002f10:	01010413          	addi	s0,sp,16
    80002f14:	1a060e63          	beqz	a2,800030d0 <__memset+0x1c8>
    80002f18:	40a007b3          	neg	a5,a0
    80002f1c:	0077f793          	andi	a5,a5,7
    80002f20:	00778693          	addi	a3,a5,7
    80002f24:	00b00813          	li	a6,11
    80002f28:	0ff5f593          	andi	a1,a1,255
    80002f2c:	fff6071b          	addiw	a4,a2,-1
    80002f30:	1b06e663          	bltu	a3,a6,800030dc <__memset+0x1d4>
    80002f34:	1cd76463          	bltu	a4,a3,800030fc <__memset+0x1f4>
    80002f38:	1a078e63          	beqz	a5,800030f4 <__memset+0x1ec>
    80002f3c:	00b50023          	sb	a1,0(a0)
    80002f40:	00100713          	li	a4,1
    80002f44:	1ae78463          	beq	a5,a4,800030ec <__memset+0x1e4>
    80002f48:	00b500a3          	sb	a1,1(a0)
    80002f4c:	00200713          	li	a4,2
    80002f50:	1ae78a63          	beq	a5,a4,80003104 <__memset+0x1fc>
    80002f54:	00b50123          	sb	a1,2(a0)
    80002f58:	00300713          	li	a4,3
    80002f5c:	18e78463          	beq	a5,a4,800030e4 <__memset+0x1dc>
    80002f60:	00b501a3          	sb	a1,3(a0)
    80002f64:	00400713          	li	a4,4
    80002f68:	1ae78263          	beq	a5,a4,8000310c <__memset+0x204>
    80002f6c:	00b50223          	sb	a1,4(a0)
    80002f70:	00500713          	li	a4,5
    80002f74:	1ae78063          	beq	a5,a4,80003114 <__memset+0x20c>
    80002f78:	00b502a3          	sb	a1,5(a0)
    80002f7c:	00700713          	li	a4,7
    80002f80:	18e79e63          	bne	a5,a4,8000311c <__memset+0x214>
    80002f84:	00b50323          	sb	a1,6(a0)
    80002f88:	00700e93          	li	t4,7
    80002f8c:	00859713          	slli	a4,a1,0x8
    80002f90:	00e5e733          	or	a4,a1,a4
    80002f94:	01059e13          	slli	t3,a1,0x10
    80002f98:	01c76e33          	or	t3,a4,t3
    80002f9c:	01859313          	slli	t1,a1,0x18
    80002fa0:	006e6333          	or	t1,t3,t1
    80002fa4:	02059893          	slli	a7,a1,0x20
    80002fa8:	40f60e3b          	subw	t3,a2,a5
    80002fac:	011368b3          	or	a7,t1,a7
    80002fb0:	02859813          	slli	a6,a1,0x28
    80002fb4:	0108e833          	or	a6,a7,a6
    80002fb8:	03059693          	slli	a3,a1,0x30
    80002fbc:	003e589b          	srliw	a7,t3,0x3
    80002fc0:	00d866b3          	or	a3,a6,a3
    80002fc4:	03859713          	slli	a4,a1,0x38
    80002fc8:	00389813          	slli	a6,a7,0x3
    80002fcc:	00f507b3          	add	a5,a0,a5
    80002fd0:	00e6e733          	or	a4,a3,a4
    80002fd4:	000e089b          	sext.w	a7,t3
    80002fd8:	00f806b3          	add	a3,a6,a5
    80002fdc:	00e7b023          	sd	a4,0(a5)
    80002fe0:	00878793          	addi	a5,a5,8
    80002fe4:	fed79ce3          	bne	a5,a3,80002fdc <__memset+0xd4>
    80002fe8:	ff8e7793          	andi	a5,t3,-8
    80002fec:	0007871b          	sext.w	a4,a5
    80002ff0:	01d787bb          	addw	a5,a5,t4
    80002ff4:	0ce88e63          	beq	a7,a4,800030d0 <__memset+0x1c8>
    80002ff8:	00f50733          	add	a4,a0,a5
    80002ffc:	00b70023          	sb	a1,0(a4)
    80003000:	0017871b          	addiw	a4,a5,1
    80003004:	0cc77663          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    80003008:	00e50733          	add	a4,a0,a4
    8000300c:	00b70023          	sb	a1,0(a4)
    80003010:	0027871b          	addiw	a4,a5,2
    80003014:	0ac77e63          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    80003018:	00e50733          	add	a4,a0,a4
    8000301c:	00b70023          	sb	a1,0(a4)
    80003020:	0037871b          	addiw	a4,a5,3
    80003024:	0ac77663          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    80003028:	00e50733          	add	a4,a0,a4
    8000302c:	00b70023          	sb	a1,0(a4)
    80003030:	0047871b          	addiw	a4,a5,4
    80003034:	08c77e63          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    80003038:	00e50733          	add	a4,a0,a4
    8000303c:	00b70023          	sb	a1,0(a4)
    80003040:	0057871b          	addiw	a4,a5,5
    80003044:	08c77663          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    80003048:	00e50733          	add	a4,a0,a4
    8000304c:	00b70023          	sb	a1,0(a4)
    80003050:	0067871b          	addiw	a4,a5,6
    80003054:	06c77e63          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    80003058:	00e50733          	add	a4,a0,a4
    8000305c:	00b70023          	sb	a1,0(a4)
    80003060:	0077871b          	addiw	a4,a5,7
    80003064:	06c77663          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    80003068:	00e50733          	add	a4,a0,a4
    8000306c:	00b70023          	sb	a1,0(a4)
    80003070:	0087871b          	addiw	a4,a5,8
    80003074:	04c77e63          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    80003078:	00e50733          	add	a4,a0,a4
    8000307c:	00b70023          	sb	a1,0(a4)
    80003080:	0097871b          	addiw	a4,a5,9
    80003084:	04c77663          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    80003088:	00e50733          	add	a4,a0,a4
    8000308c:	00b70023          	sb	a1,0(a4)
    80003090:	00a7871b          	addiw	a4,a5,10
    80003094:	02c77e63          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    80003098:	00e50733          	add	a4,a0,a4
    8000309c:	00b70023          	sb	a1,0(a4)
    800030a0:	00b7871b          	addiw	a4,a5,11
    800030a4:	02c77663          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    800030a8:	00e50733          	add	a4,a0,a4
    800030ac:	00b70023          	sb	a1,0(a4)
    800030b0:	00c7871b          	addiw	a4,a5,12
    800030b4:	00c77e63          	bgeu	a4,a2,800030d0 <__memset+0x1c8>
    800030b8:	00e50733          	add	a4,a0,a4
    800030bc:	00b70023          	sb	a1,0(a4)
    800030c0:	00d7879b          	addiw	a5,a5,13
    800030c4:	00c7f663          	bgeu	a5,a2,800030d0 <__memset+0x1c8>
    800030c8:	00f507b3          	add	a5,a0,a5
    800030cc:	00b78023          	sb	a1,0(a5)
    800030d0:	00813403          	ld	s0,8(sp)
    800030d4:	01010113          	addi	sp,sp,16
    800030d8:	00008067          	ret
    800030dc:	00b00693          	li	a3,11
    800030e0:	e55ff06f          	j	80002f34 <__memset+0x2c>
    800030e4:	00300e93          	li	t4,3
    800030e8:	ea5ff06f          	j	80002f8c <__memset+0x84>
    800030ec:	00100e93          	li	t4,1
    800030f0:	e9dff06f          	j	80002f8c <__memset+0x84>
    800030f4:	00000e93          	li	t4,0
    800030f8:	e95ff06f          	j	80002f8c <__memset+0x84>
    800030fc:	00000793          	li	a5,0
    80003100:	ef9ff06f          	j	80002ff8 <__memset+0xf0>
    80003104:	00200e93          	li	t4,2
    80003108:	e85ff06f          	j	80002f8c <__memset+0x84>
    8000310c:	00400e93          	li	t4,4
    80003110:	e7dff06f          	j	80002f8c <__memset+0x84>
    80003114:	00500e93          	li	t4,5
    80003118:	e75ff06f          	j	80002f8c <__memset+0x84>
    8000311c:	00600e93          	li	t4,6
    80003120:	e6dff06f          	j	80002f8c <__memset+0x84>

0000000080003124 <__memmove>:
    80003124:	ff010113          	addi	sp,sp,-16
    80003128:	00813423          	sd	s0,8(sp)
    8000312c:	01010413          	addi	s0,sp,16
    80003130:	0e060863          	beqz	a2,80003220 <__memmove+0xfc>
    80003134:	fff6069b          	addiw	a3,a2,-1
    80003138:	0006881b          	sext.w	a6,a3
    8000313c:	0ea5e863          	bltu	a1,a0,8000322c <__memmove+0x108>
    80003140:	00758713          	addi	a4,a1,7
    80003144:	00a5e7b3          	or	a5,a1,a0
    80003148:	40a70733          	sub	a4,a4,a0
    8000314c:	0077f793          	andi	a5,a5,7
    80003150:	00f73713          	sltiu	a4,a4,15
    80003154:	00174713          	xori	a4,a4,1
    80003158:	0017b793          	seqz	a5,a5
    8000315c:	00e7f7b3          	and	a5,a5,a4
    80003160:	10078863          	beqz	a5,80003270 <__memmove+0x14c>
    80003164:	00900793          	li	a5,9
    80003168:	1107f463          	bgeu	a5,a6,80003270 <__memmove+0x14c>
    8000316c:	0036581b          	srliw	a6,a2,0x3
    80003170:	fff8081b          	addiw	a6,a6,-1
    80003174:	02081813          	slli	a6,a6,0x20
    80003178:	01d85893          	srli	a7,a6,0x1d
    8000317c:	00858813          	addi	a6,a1,8
    80003180:	00058793          	mv	a5,a1
    80003184:	00050713          	mv	a4,a0
    80003188:	01088833          	add	a6,a7,a6
    8000318c:	0007b883          	ld	a7,0(a5)
    80003190:	00878793          	addi	a5,a5,8
    80003194:	00870713          	addi	a4,a4,8
    80003198:	ff173c23          	sd	a7,-8(a4)
    8000319c:	ff0798e3          	bne	a5,a6,8000318c <__memmove+0x68>
    800031a0:	ff867713          	andi	a4,a2,-8
    800031a4:	02071793          	slli	a5,a4,0x20
    800031a8:	0207d793          	srli	a5,a5,0x20
    800031ac:	00f585b3          	add	a1,a1,a5
    800031b0:	40e686bb          	subw	a3,a3,a4
    800031b4:	00f507b3          	add	a5,a0,a5
    800031b8:	06e60463          	beq	a2,a4,80003220 <__memmove+0xfc>
    800031bc:	0005c703          	lbu	a4,0(a1)
    800031c0:	00e78023          	sb	a4,0(a5)
    800031c4:	04068e63          	beqz	a3,80003220 <__memmove+0xfc>
    800031c8:	0015c603          	lbu	a2,1(a1)
    800031cc:	00100713          	li	a4,1
    800031d0:	00c780a3          	sb	a2,1(a5)
    800031d4:	04e68663          	beq	a3,a4,80003220 <__memmove+0xfc>
    800031d8:	0025c603          	lbu	a2,2(a1)
    800031dc:	00200713          	li	a4,2
    800031e0:	00c78123          	sb	a2,2(a5)
    800031e4:	02e68e63          	beq	a3,a4,80003220 <__memmove+0xfc>
    800031e8:	0035c603          	lbu	a2,3(a1)
    800031ec:	00300713          	li	a4,3
    800031f0:	00c781a3          	sb	a2,3(a5)
    800031f4:	02e68663          	beq	a3,a4,80003220 <__memmove+0xfc>
    800031f8:	0045c603          	lbu	a2,4(a1)
    800031fc:	00400713          	li	a4,4
    80003200:	00c78223          	sb	a2,4(a5)
    80003204:	00e68e63          	beq	a3,a4,80003220 <__memmove+0xfc>
    80003208:	0055c603          	lbu	a2,5(a1)
    8000320c:	00500713          	li	a4,5
    80003210:	00c782a3          	sb	a2,5(a5)
    80003214:	00e68663          	beq	a3,a4,80003220 <__memmove+0xfc>
    80003218:	0065c703          	lbu	a4,6(a1)
    8000321c:	00e78323          	sb	a4,6(a5)
    80003220:	00813403          	ld	s0,8(sp)
    80003224:	01010113          	addi	sp,sp,16
    80003228:	00008067          	ret
    8000322c:	02061713          	slli	a4,a2,0x20
    80003230:	02075713          	srli	a4,a4,0x20
    80003234:	00e587b3          	add	a5,a1,a4
    80003238:	f0f574e3          	bgeu	a0,a5,80003140 <__memmove+0x1c>
    8000323c:	02069613          	slli	a2,a3,0x20
    80003240:	02065613          	srli	a2,a2,0x20
    80003244:	fff64613          	not	a2,a2
    80003248:	00e50733          	add	a4,a0,a4
    8000324c:	00c78633          	add	a2,a5,a2
    80003250:	fff7c683          	lbu	a3,-1(a5)
    80003254:	fff78793          	addi	a5,a5,-1
    80003258:	fff70713          	addi	a4,a4,-1
    8000325c:	00d70023          	sb	a3,0(a4)
    80003260:	fec798e3          	bne	a5,a2,80003250 <__memmove+0x12c>
    80003264:	00813403          	ld	s0,8(sp)
    80003268:	01010113          	addi	sp,sp,16
    8000326c:	00008067          	ret
    80003270:	02069713          	slli	a4,a3,0x20
    80003274:	02075713          	srli	a4,a4,0x20
    80003278:	00170713          	addi	a4,a4,1
    8000327c:	00e50733          	add	a4,a0,a4
    80003280:	00050793          	mv	a5,a0
    80003284:	0005c683          	lbu	a3,0(a1)
    80003288:	00178793          	addi	a5,a5,1
    8000328c:	00158593          	addi	a1,a1,1
    80003290:	fed78fa3          	sb	a3,-1(a5)
    80003294:	fee798e3          	bne	a5,a4,80003284 <__memmove+0x160>
    80003298:	f89ff06f          	j	80003220 <__memmove+0xfc>

000000008000329c <__putc>:
    8000329c:	fe010113          	addi	sp,sp,-32
    800032a0:	00813823          	sd	s0,16(sp)
    800032a4:	00113c23          	sd	ra,24(sp)
    800032a8:	02010413          	addi	s0,sp,32
    800032ac:	00050793          	mv	a5,a0
    800032b0:	fef40593          	addi	a1,s0,-17
    800032b4:	00100613          	li	a2,1
    800032b8:	00000513          	li	a0,0
    800032bc:	fef407a3          	sb	a5,-17(s0)
    800032c0:	fffff097          	auipc	ra,0xfffff
    800032c4:	b3c080e7          	jalr	-1220(ra) # 80001dfc <console_write>
    800032c8:	01813083          	ld	ra,24(sp)
    800032cc:	01013403          	ld	s0,16(sp)
    800032d0:	02010113          	addi	sp,sp,32
    800032d4:	00008067          	ret

00000000800032d8 <__getc>:
    800032d8:	fe010113          	addi	sp,sp,-32
    800032dc:	00813823          	sd	s0,16(sp)
    800032e0:	00113c23          	sd	ra,24(sp)
    800032e4:	02010413          	addi	s0,sp,32
    800032e8:	fe840593          	addi	a1,s0,-24
    800032ec:	00100613          	li	a2,1
    800032f0:	00000513          	li	a0,0
    800032f4:	fffff097          	auipc	ra,0xfffff
    800032f8:	ae8080e7          	jalr	-1304(ra) # 80001ddc <console_read>
    800032fc:	fe844503          	lbu	a0,-24(s0)
    80003300:	01813083          	ld	ra,24(sp)
    80003304:	01013403          	ld	s0,16(sp)
    80003308:	02010113          	addi	sp,sp,32
    8000330c:	00008067          	ret

0000000080003310 <console_handler>:
    80003310:	fe010113          	addi	sp,sp,-32
    80003314:	00813823          	sd	s0,16(sp)
    80003318:	00113c23          	sd	ra,24(sp)
    8000331c:	00913423          	sd	s1,8(sp)
    80003320:	02010413          	addi	s0,sp,32
    80003324:	14202773          	csrr	a4,scause
    80003328:	100027f3          	csrr	a5,sstatus
    8000332c:	0027f793          	andi	a5,a5,2
    80003330:	06079e63          	bnez	a5,800033ac <console_handler+0x9c>
    80003334:	00074c63          	bltz	a4,8000334c <console_handler+0x3c>
    80003338:	01813083          	ld	ra,24(sp)
    8000333c:	01013403          	ld	s0,16(sp)
    80003340:	00813483          	ld	s1,8(sp)
    80003344:	02010113          	addi	sp,sp,32
    80003348:	00008067          	ret
    8000334c:	0ff77713          	andi	a4,a4,255
    80003350:	00900793          	li	a5,9
    80003354:	fef712e3          	bne	a4,a5,80003338 <console_handler+0x28>
    80003358:	ffffe097          	auipc	ra,0xffffe
    8000335c:	6dc080e7          	jalr	1756(ra) # 80001a34 <plic_claim>
    80003360:	00a00793          	li	a5,10
    80003364:	00050493          	mv	s1,a0
    80003368:	02f50c63          	beq	a0,a5,800033a0 <console_handler+0x90>
    8000336c:	fc0506e3          	beqz	a0,80003338 <console_handler+0x28>
    80003370:	00050593          	mv	a1,a0
    80003374:	00001517          	auipc	a0,0x1
    80003378:	d7c50513          	addi	a0,a0,-644 # 800040f0 <CONSOLE_STATUS+0xe0>
    8000337c:	fffff097          	auipc	ra,0xfffff
    80003380:	afc080e7          	jalr	-1284(ra) # 80001e78 <__printf>
    80003384:	01013403          	ld	s0,16(sp)
    80003388:	01813083          	ld	ra,24(sp)
    8000338c:	00048513          	mv	a0,s1
    80003390:	00813483          	ld	s1,8(sp)
    80003394:	02010113          	addi	sp,sp,32
    80003398:	ffffe317          	auipc	t1,0xffffe
    8000339c:	6d430067          	jr	1748(t1) # 80001a6c <plic_complete>
    800033a0:	fffff097          	auipc	ra,0xfffff
    800033a4:	3e0080e7          	jalr	992(ra) # 80002780 <uartintr>
    800033a8:	fddff06f          	j	80003384 <console_handler+0x74>
    800033ac:	00001517          	auipc	a0,0x1
    800033b0:	e4450513          	addi	a0,a0,-444 # 800041f0 <digits+0x78>
    800033b4:	fffff097          	auipc	ra,0xfffff
    800033b8:	a68080e7          	jalr	-1432(ra) # 80001e1c <panic>
	...
