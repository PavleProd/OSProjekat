
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
    8000001c:	1a0010ef          	jal	ra,800011bc <start>

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

    int* par = (int*)MemoryAllocator::mem_alloc(3*sizeof(int));
    80001010:	00c00513          	li	a0,12
    80001014:	00000097          	auipc	ra,0x0
    80001018:	038080e7          	jalr	56(ra) # 8000104c <_ZN15MemoryAllocator9mem_allocEm>
    *par = 5;
    8000101c:	00500793          	li	a5,5
    80001020:	00f52023          	sw	a5,0(a0) # 1000 <_entry-0x7ffff000>
    *(par + 1) = 3;
    80001024:	00300793          	li	a5,3
    80001028:	00f52223          	sw	a5,4(a0)

    int x = sizeof(par);
    __putc('0' + x);
    8000102c:	03800513          	li	a0,56
    80001030:	00002097          	auipc	ra,0x2
    80001034:	24c080e7          	jalr	588(ra) # 8000327c <__putc>

    return 0;
    80001038:	00000513          	li	a0,0
    8000103c:	00813083          	ld	ra,8(sp)
    80001040:	00013403          	ld	s0,0(sp)
    80001044:	01010113          	addi	sp,sp,16
    80001048:	00008067          	ret

000000008000104c <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    8000104c:	ff010113          	addi	sp,sp,-16
    80001050:	00813423          	sd	s0,8(sp)
    80001054:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80001058:	00003797          	auipc	a5,0x3
    8000105c:	2c87b783          	ld	a5,712(a5) # 80004320 <_ZN15MemoryAllocator4headE>
    80001060:	04078e63          	beqz	a5,800010bc <_ZN15MemoryAllocator9mem_allocEm+0x70>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 1);
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80001064:	00003717          	auipc	a4,0x3
    80001068:	27473703          	ld	a4,628(a4) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000106c:	00073703          	ld	a4,0(a4)
    80001070:	12e78463          	beq	a5,a4,80001198 <_ZN15MemoryAllocator9mem_allocEm+0x14c>
    static MemoryAllocator* memAllocator;
    MemoryAllocator() {}

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80001074:	00655613          	srli	a2,a0,0x6
    80001078:	03f57513          	andi	a0,a0,63
    8000107c:	00a036b3          	snez	a3,a0
    80001080:	00d60633          	add	a2,a2,a3
        return nullptr;
    }

    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80001084:	00003517          	auipc	a0,0x3
    80001088:	29c53503          	ld	a0,668(a0) # 80004320 <_ZN15MemoryAllocator4headE>
    8000108c:	00000593          	li	a1,0
    while(curr) {
    80001090:	0a050663          	beqz	a0,8000113c <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        size_t freeSegSizeInBlocks = sizeInBlocks(curr->size);
    80001094:	00853683          	ld	a3,8(a0)
    80001098:	0066d793          	srli	a5,a3,0x6
    8000109c:	03f6f713          	andi	a4,a3,63
    800010a0:	00e03733          	snez	a4,a4
    800010a4:	00e787b3          	add	a5,a5,a4
        size_t allocatedSize = 0;
        void* startOfAllocatedSpace = curr->baseAddr;
    800010a8:	00053703          	ld	a4,0(a0)
        if(freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    800010ac:	04c7f663          	bgeu	a5,a2,800010f8 <_ZN15MemoryAllocator9mem_allocEm+0xac>
            }

            return startOfAllocatedSpace;
        }

        prev = curr;
    800010b0:	00050593          	mv	a1,a0
        curr = curr->next;
    800010b4:	01053503          	ld	a0,16(a0)
    while(curr) {
    800010b8:	fd9ff06f          	j	80001090 <_ZN15MemoryAllocator9mem_allocEm+0x44>
        head = (FreeSegment*)HEAP_START_ADDR;
    800010bc:	00003697          	auipc	a3,0x3
    800010c0:	20c6b683          	ld	a3,524(a3) # 800042c8 <_GLOBAL_OFFSET_TABLE_+0x8>
    800010c4:	0006b783          	ld	a5,0(a3)
    800010c8:	00003717          	auipc	a4,0x3
    800010cc:	24f73c23          	sd	a5,600(a4) # 80004320 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    800010d0:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 1);
    800010d4:	00003717          	auipc	a4,0x3
    800010d8:	20473703          	ld	a4,516(a4) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800010dc:	00073703          	ld	a4,0(a4)
    800010e0:	0006b683          	ld	a3,0(a3)
    800010e4:	40d70733          	sub	a4,a4,a3
    800010e8:	00170713          	addi	a4,a4,1
    800010ec:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    800010f0:	0007b823          	sd	zero,16(a5)
    800010f4:	f81ff06f          	j	80001074 <_ZN15MemoryAllocator9mem_allocEm+0x28>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    800010f8:	04f60863          	beq	a2,a5,80001148 <_ZN15MemoryAllocator9mem_allocEm+0xfc>
    }

    // Vraca velicinu numOfBlocks blokova u bajtovima
    static inline size_t blocksInSize(size_t numOfBlocks) {
        return numOfBlocks * MEM_BLOCK_SIZE;
    800010fc:	00661613          	slli	a2,a2,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80001100:	00c707b3          	add	a5,a4,a2
                size_t newSize = curr->size - allocatedSize;
    80001104:	40c686b3          	sub	a3,a3,a2
                newSeg->baseAddr = newBaseAddr;
    80001108:	00f7b023          	sd	a5,0(a5)
                newSeg->size = newSize;
    8000110c:	00d7b423          	sd	a3,8(a5)
                newSeg->next = curr->next;
    80001110:	01053683          	ld	a3,16(a0)
    80001114:	00d7b823          	sd	a3,16(a5)
                if(!prev) {
    80001118:	06058a63          	beqz	a1,8000118c <_ZN15MemoryAllocator9mem_allocEm+0x140>
            if(!prev->next) return;
    8000111c:	0105b783          	ld	a5,16(a1)
    80001120:	00078663          	beqz	a5,8000112c <_ZN15MemoryAllocator9mem_allocEm+0xe0>
            prev->next = curr->next;
    80001124:	0107b783          	ld	a5,16(a5)
    80001128:	00f5b823          	sd	a5,16(a1)
            curr->next = prev->next;
    8000112c:	0105b783          	ld	a5,16(a1)
    80001130:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80001134:	00a5b823          	sd	a0,16(a1)
            return startOfAllocatedSpace;
    80001138:	00070513          	mv	a0,a4
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    8000113c:	00813403          	ld	s0,8(sp)
    80001140:	01010113          	addi	sp,sp,16
    80001144:	00008067          	ret
                if(prev == nullptr) { // ako smo na head pokazivacu
    80001148:	00058c63          	beqz	a1,80001160 <_ZN15MemoryAllocator9mem_allocEm+0x114>
            if(!prev->next) return;
    8000114c:	0105b783          	ld	a5,16(a1)
    80001150:	fe0784e3          	beqz	a5,80001138 <_ZN15MemoryAllocator9mem_allocEm+0xec>
            prev->next = curr->next;
    80001154:	0107b783          	ld	a5,16(a5)
    80001158:	00f5b823          	sd	a5,16(a1)
    8000115c:	fddff06f          	j	80001138 <_ZN15MemoryAllocator9mem_allocEm+0xec>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001160:	01053783          	ld	a5,16(a0)
    80001164:	00078863          	beqz	a5,80001174 <_ZN15MemoryAllocator9mem_allocEm+0x128>
                        head = curr->next;
    80001168:	00003697          	auipc	a3,0x3
    8000116c:	1af6bc23          	sd	a5,440(a3) # 80004320 <_ZN15MemoryAllocator4headE>
    80001170:	fc9ff06f          	j	80001138 <_ZN15MemoryAllocator9mem_allocEm+0xec>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001174:	00003797          	auipc	a5,0x3
    80001178:	1647b783          	ld	a5,356(a5) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000117c:	0007b783          	ld	a5,0(a5)
    80001180:	00003697          	auipc	a3,0x3
    80001184:	1af6b023          	sd	a5,416(a3) # 80004320 <_ZN15MemoryAllocator4headE>
    80001188:	fb1ff06f          	j	80001138 <_ZN15MemoryAllocator9mem_allocEm+0xec>
                    head = newSeg;
    8000118c:	00003697          	auipc	a3,0x3
    80001190:	18f6ba23          	sd	a5,404(a3) # 80004320 <_ZN15MemoryAllocator4headE>
    80001194:	fa5ff06f          	j	80001138 <_ZN15MemoryAllocator9mem_allocEm+0xec>
        return nullptr;
    80001198:	00000513          	li	a0,0
    8000119c:	fa1ff06f          	j	8000113c <_ZN15MemoryAllocator9mem_allocEm+0xf0>

00000000800011a0 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800011a0:	ff010113          	addi	sp,sp,-16
    800011a4:	00813423          	sd	s0,8(sp)
    800011a8:	01010413          	addi	s0,sp,16
            newFreeSegment->baseAddr = memSegment;
        }
    }

    return 0;
}
    800011ac:	fff00513          	li	a0,-1
    800011b0:	00813403          	ld	s0,8(sp)
    800011b4:	01010113          	addi	sp,sp,16
    800011b8:	00008067          	ret

00000000800011bc <start>:
    800011bc:	ff010113          	addi	sp,sp,-16
    800011c0:	00813423          	sd	s0,8(sp)
    800011c4:	01010413          	addi	s0,sp,16
    800011c8:	300027f3          	csrr	a5,mstatus
    800011cc:	ffffe737          	lui	a4,0xffffe
    800011d0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff927f>
    800011d4:	00e7f7b3          	and	a5,a5,a4
    800011d8:	00001737          	lui	a4,0x1
    800011dc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800011e0:	00e7e7b3          	or	a5,a5,a4
    800011e4:	30079073          	csrw	mstatus,a5
    800011e8:	00000797          	auipc	a5,0x0
    800011ec:	16078793          	addi	a5,a5,352 # 80001348 <system_main>
    800011f0:	34179073          	csrw	mepc,a5
    800011f4:	00000793          	li	a5,0
    800011f8:	18079073          	csrw	satp,a5
    800011fc:	000107b7          	lui	a5,0x10
    80001200:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001204:	30279073          	csrw	medeleg,a5
    80001208:	30379073          	csrw	mideleg,a5
    8000120c:	104027f3          	csrr	a5,sie
    80001210:	2227e793          	ori	a5,a5,546
    80001214:	10479073          	csrw	sie,a5
    80001218:	fff00793          	li	a5,-1
    8000121c:	00a7d793          	srli	a5,a5,0xa
    80001220:	3b079073          	csrw	pmpaddr0,a5
    80001224:	00f00793          	li	a5,15
    80001228:	3a079073          	csrw	pmpcfg0,a5
    8000122c:	f14027f3          	csrr	a5,mhartid
    80001230:	0200c737          	lui	a4,0x200c
    80001234:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001238:	0007869b          	sext.w	a3,a5
    8000123c:	00269713          	slli	a4,a3,0x2
    80001240:	000f4637          	lui	a2,0xf4
    80001244:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001248:	00d70733          	add	a4,a4,a3
    8000124c:	0037979b          	slliw	a5,a5,0x3
    80001250:	020046b7          	lui	a3,0x2004
    80001254:	00d787b3          	add	a5,a5,a3
    80001258:	00c585b3          	add	a1,a1,a2
    8000125c:	00371693          	slli	a3,a4,0x3
    80001260:	00003717          	auipc	a4,0x3
    80001264:	0d070713          	addi	a4,a4,208 # 80004330 <timer_scratch>
    80001268:	00b7b023          	sd	a1,0(a5)
    8000126c:	00d70733          	add	a4,a4,a3
    80001270:	00f73c23          	sd	a5,24(a4)
    80001274:	02c73023          	sd	a2,32(a4)
    80001278:	34071073          	csrw	mscratch,a4
    8000127c:	00000797          	auipc	a5,0x0
    80001280:	6e478793          	addi	a5,a5,1764 # 80001960 <timervec>
    80001284:	30579073          	csrw	mtvec,a5
    80001288:	300027f3          	csrr	a5,mstatus
    8000128c:	0087e793          	ori	a5,a5,8
    80001290:	30079073          	csrw	mstatus,a5
    80001294:	304027f3          	csrr	a5,mie
    80001298:	0807e793          	ori	a5,a5,128
    8000129c:	30479073          	csrw	mie,a5
    800012a0:	f14027f3          	csrr	a5,mhartid
    800012a4:	0007879b          	sext.w	a5,a5
    800012a8:	00078213          	mv	tp,a5
    800012ac:	30200073          	mret
    800012b0:	00813403          	ld	s0,8(sp)
    800012b4:	01010113          	addi	sp,sp,16
    800012b8:	00008067          	ret

00000000800012bc <timerinit>:
    800012bc:	ff010113          	addi	sp,sp,-16
    800012c0:	00813423          	sd	s0,8(sp)
    800012c4:	01010413          	addi	s0,sp,16
    800012c8:	f14027f3          	csrr	a5,mhartid
    800012cc:	0200c737          	lui	a4,0x200c
    800012d0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800012d4:	0007869b          	sext.w	a3,a5
    800012d8:	00269713          	slli	a4,a3,0x2
    800012dc:	000f4637          	lui	a2,0xf4
    800012e0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800012e4:	00d70733          	add	a4,a4,a3
    800012e8:	0037979b          	slliw	a5,a5,0x3
    800012ec:	020046b7          	lui	a3,0x2004
    800012f0:	00d787b3          	add	a5,a5,a3
    800012f4:	00c585b3          	add	a1,a1,a2
    800012f8:	00371693          	slli	a3,a4,0x3
    800012fc:	00003717          	auipc	a4,0x3
    80001300:	03470713          	addi	a4,a4,52 # 80004330 <timer_scratch>
    80001304:	00b7b023          	sd	a1,0(a5)
    80001308:	00d70733          	add	a4,a4,a3
    8000130c:	00f73c23          	sd	a5,24(a4)
    80001310:	02c73023          	sd	a2,32(a4)
    80001314:	34071073          	csrw	mscratch,a4
    80001318:	00000797          	auipc	a5,0x0
    8000131c:	64878793          	addi	a5,a5,1608 # 80001960 <timervec>
    80001320:	30579073          	csrw	mtvec,a5
    80001324:	300027f3          	csrr	a5,mstatus
    80001328:	0087e793          	ori	a5,a5,8
    8000132c:	30079073          	csrw	mstatus,a5
    80001330:	304027f3          	csrr	a5,mie
    80001334:	0807e793          	ori	a5,a5,128
    80001338:	30479073          	csrw	mie,a5
    8000133c:	00813403          	ld	s0,8(sp)
    80001340:	01010113          	addi	sp,sp,16
    80001344:	00008067          	ret

0000000080001348 <system_main>:
    80001348:	fe010113          	addi	sp,sp,-32
    8000134c:	00813823          	sd	s0,16(sp)
    80001350:	00913423          	sd	s1,8(sp)
    80001354:	00113c23          	sd	ra,24(sp)
    80001358:	02010413          	addi	s0,sp,32
    8000135c:	00000097          	auipc	ra,0x0
    80001360:	0c4080e7          	jalr	196(ra) # 80001420 <cpuid>
    80001364:	00003497          	auipc	s1,0x3
    80001368:	f8c48493          	addi	s1,s1,-116 # 800042f0 <started>
    8000136c:	02050263          	beqz	a0,80001390 <system_main+0x48>
    80001370:	0004a783          	lw	a5,0(s1)
    80001374:	0007879b          	sext.w	a5,a5
    80001378:	fe078ce3          	beqz	a5,80001370 <system_main+0x28>
    8000137c:	0ff0000f          	fence
    80001380:	00003517          	auipc	a0,0x3
    80001384:	cd050513          	addi	a0,a0,-816 # 80004050 <CONSOLE_STATUS+0x40>
    80001388:	00001097          	auipc	ra,0x1
    8000138c:	a74080e7          	jalr	-1420(ra) # 80001dfc <panic>
    80001390:	00001097          	auipc	ra,0x1
    80001394:	9c8080e7          	jalr	-1592(ra) # 80001d58 <consoleinit>
    80001398:	00001097          	auipc	ra,0x1
    8000139c:	154080e7          	jalr	340(ra) # 800024ec <printfinit>
    800013a0:	00003517          	auipc	a0,0x3
    800013a4:	d9050513          	addi	a0,a0,-624 # 80004130 <CONSOLE_STATUS+0x120>
    800013a8:	00001097          	auipc	ra,0x1
    800013ac:	ab0080e7          	jalr	-1360(ra) # 80001e58 <__printf>
    800013b0:	00003517          	auipc	a0,0x3
    800013b4:	c7050513          	addi	a0,a0,-912 # 80004020 <CONSOLE_STATUS+0x10>
    800013b8:	00001097          	auipc	ra,0x1
    800013bc:	aa0080e7          	jalr	-1376(ra) # 80001e58 <__printf>
    800013c0:	00003517          	auipc	a0,0x3
    800013c4:	d7050513          	addi	a0,a0,-656 # 80004130 <CONSOLE_STATUS+0x120>
    800013c8:	00001097          	auipc	ra,0x1
    800013cc:	a90080e7          	jalr	-1392(ra) # 80001e58 <__printf>
    800013d0:	00001097          	auipc	ra,0x1
    800013d4:	4a8080e7          	jalr	1192(ra) # 80002878 <kinit>
    800013d8:	00000097          	auipc	ra,0x0
    800013dc:	148080e7          	jalr	328(ra) # 80001520 <trapinit>
    800013e0:	00000097          	auipc	ra,0x0
    800013e4:	16c080e7          	jalr	364(ra) # 8000154c <trapinithart>
    800013e8:	00000097          	auipc	ra,0x0
    800013ec:	5b8080e7          	jalr	1464(ra) # 800019a0 <plicinit>
    800013f0:	00000097          	auipc	ra,0x0
    800013f4:	5d8080e7          	jalr	1496(ra) # 800019c8 <plicinithart>
    800013f8:	00000097          	auipc	ra,0x0
    800013fc:	078080e7          	jalr	120(ra) # 80001470 <userinit>
    80001400:	0ff0000f          	fence
    80001404:	00100793          	li	a5,1
    80001408:	00003517          	auipc	a0,0x3
    8000140c:	c3050513          	addi	a0,a0,-976 # 80004038 <CONSOLE_STATUS+0x28>
    80001410:	00f4a023          	sw	a5,0(s1)
    80001414:	00001097          	auipc	ra,0x1
    80001418:	a44080e7          	jalr	-1468(ra) # 80001e58 <__printf>
    8000141c:	0000006f          	j	8000141c <system_main+0xd4>

0000000080001420 <cpuid>:
    80001420:	ff010113          	addi	sp,sp,-16
    80001424:	00813423          	sd	s0,8(sp)
    80001428:	01010413          	addi	s0,sp,16
    8000142c:	00020513          	mv	a0,tp
    80001430:	00813403          	ld	s0,8(sp)
    80001434:	0005051b          	sext.w	a0,a0
    80001438:	01010113          	addi	sp,sp,16
    8000143c:	00008067          	ret

0000000080001440 <mycpu>:
    80001440:	ff010113          	addi	sp,sp,-16
    80001444:	00813423          	sd	s0,8(sp)
    80001448:	01010413          	addi	s0,sp,16
    8000144c:	00020793          	mv	a5,tp
    80001450:	00813403          	ld	s0,8(sp)
    80001454:	0007879b          	sext.w	a5,a5
    80001458:	00779793          	slli	a5,a5,0x7
    8000145c:	00004517          	auipc	a0,0x4
    80001460:	f0450513          	addi	a0,a0,-252 # 80005360 <cpus>
    80001464:	00f50533          	add	a0,a0,a5
    80001468:	01010113          	addi	sp,sp,16
    8000146c:	00008067          	ret

0000000080001470 <userinit>:
    80001470:	ff010113          	addi	sp,sp,-16
    80001474:	00813423          	sd	s0,8(sp)
    80001478:	01010413          	addi	s0,sp,16
    8000147c:	00813403          	ld	s0,8(sp)
    80001480:	01010113          	addi	sp,sp,16
    80001484:	00000317          	auipc	t1,0x0
    80001488:	b7c30067          	jr	-1156(t1) # 80001000 <main>

000000008000148c <either_copyout>:
    8000148c:	ff010113          	addi	sp,sp,-16
    80001490:	00813023          	sd	s0,0(sp)
    80001494:	00113423          	sd	ra,8(sp)
    80001498:	01010413          	addi	s0,sp,16
    8000149c:	02051663          	bnez	a0,800014c8 <either_copyout+0x3c>
    800014a0:	00058513          	mv	a0,a1
    800014a4:	00060593          	mv	a1,a2
    800014a8:	0006861b          	sext.w	a2,a3
    800014ac:	00002097          	auipc	ra,0x2
    800014b0:	c58080e7          	jalr	-936(ra) # 80003104 <__memmove>
    800014b4:	00813083          	ld	ra,8(sp)
    800014b8:	00013403          	ld	s0,0(sp)
    800014bc:	00000513          	li	a0,0
    800014c0:	01010113          	addi	sp,sp,16
    800014c4:	00008067          	ret
    800014c8:	00003517          	auipc	a0,0x3
    800014cc:	bb050513          	addi	a0,a0,-1104 # 80004078 <CONSOLE_STATUS+0x68>
    800014d0:	00001097          	auipc	ra,0x1
    800014d4:	92c080e7          	jalr	-1748(ra) # 80001dfc <panic>

00000000800014d8 <either_copyin>:
    800014d8:	ff010113          	addi	sp,sp,-16
    800014dc:	00813023          	sd	s0,0(sp)
    800014e0:	00113423          	sd	ra,8(sp)
    800014e4:	01010413          	addi	s0,sp,16
    800014e8:	02059463          	bnez	a1,80001510 <either_copyin+0x38>
    800014ec:	00060593          	mv	a1,a2
    800014f0:	0006861b          	sext.w	a2,a3
    800014f4:	00002097          	auipc	ra,0x2
    800014f8:	c10080e7          	jalr	-1008(ra) # 80003104 <__memmove>
    800014fc:	00813083          	ld	ra,8(sp)
    80001500:	00013403          	ld	s0,0(sp)
    80001504:	00000513          	li	a0,0
    80001508:	01010113          	addi	sp,sp,16
    8000150c:	00008067          	ret
    80001510:	00003517          	auipc	a0,0x3
    80001514:	b9050513          	addi	a0,a0,-1136 # 800040a0 <CONSOLE_STATUS+0x90>
    80001518:	00001097          	auipc	ra,0x1
    8000151c:	8e4080e7          	jalr	-1820(ra) # 80001dfc <panic>

0000000080001520 <trapinit>:
    80001520:	ff010113          	addi	sp,sp,-16
    80001524:	00813423          	sd	s0,8(sp)
    80001528:	01010413          	addi	s0,sp,16
    8000152c:	00813403          	ld	s0,8(sp)
    80001530:	00003597          	auipc	a1,0x3
    80001534:	b9858593          	addi	a1,a1,-1128 # 800040c8 <CONSOLE_STATUS+0xb8>
    80001538:	00004517          	auipc	a0,0x4
    8000153c:	ea850513          	addi	a0,a0,-344 # 800053e0 <tickslock>
    80001540:	01010113          	addi	sp,sp,16
    80001544:	00001317          	auipc	t1,0x1
    80001548:	5c430067          	jr	1476(t1) # 80002b08 <initlock>

000000008000154c <trapinithart>:
    8000154c:	ff010113          	addi	sp,sp,-16
    80001550:	00813423          	sd	s0,8(sp)
    80001554:	01010413          	addi	s0,sp,16
    80001558:	00000797          	auipc	a5,0x0
    8000155c:	2f878793          	addi	a5,a5,760 # 80001850 <kernelvec>
    80001560:	10579073          	csrw	stvec,a5
    80001564:	00813403          	ld	s0,8(sp)
    80001568:	01010113          	addi	sp,sp,16
    8000156c:	00008067          	ret

0000000080001570 <usertrap>:
    80001570:	ff010113          	addi	sp,sp,-16
    80001574:	00813423          	sd	s0,8(sp)
    80001578:	01010413          	addi	s0,sp,16
    8000157c:	00813403          	ld	s0,8(sp)
    80001580:	01010113          	addi	sp,sp,16
    80001584:	00008067          	ret

0000000080001588 <usertrapret>:
    80001588:	ff010113          	addi	sp,sp,-16
    8000158c:	00813423          	sd	s0,8(sp)
    80001590:	01010413          	addi	s0,sp,16
    80001594:	00813403          	ld	s0,8(sp)
    80001598:	01010113          	addi	sp,sp,16
    8000159c:	00008067          	ret

00000000800015a0 <kerneltrap>:
    800015a0:	fe010113          	addi	sp,sp,-32
    800015a4:	00813823          	sd	s0,16(sp)
    800015a8:	00113c23          	sd	ra,24(sp)
    800015ac:	00913423          	sd	s1,8(sp)
    800015b0:	02010413          	addi	s0,sp,32
    800015b4:	142025f3          	csrr	a1,scause
    800015b8:	100027f3          	csrr	a5,sstatus
    800015bc:	0027f793          	andi	a5,a5,2
    800015c0:	10079c63          	bnez	a5,800016d8 <kerneltrap+0x138>
    800015c4:	142027f3          	csrr	a5,scause
    800015c8:	0207ce63          	bltz	a5,80001604 <kerneltrap+0x64>
    800015cc:	00003517          	auipc	a0,0x3
    800015d0:	b4450513          	addi	a0,a0,-1212 # 80004110 <CONSOLE_STATUS+0x100>
    800015d4:	00001097          	auipc	ra,0x1
    800015d8:	884080e7          	jalr	-1916(ra) # 80001e58 <__printf>
    800015dc:	141025f3          	csrr	a1,sepc
    800015e0:	14302673          	csrr	a2,stval
    800015e4:	00003517          	auipc	a0,0x3
    800015e8:	b3c50513          	addi	a0,a0,-1220 # 80004120 <CONSOLE_STATUS+0x110>
    800015ec:	00001097          	auipc	ra,0x1
    800015f0:	86c080e7          	jalr	-1940(ra) # 80001e58 <__printf>
    800015f4:	00003517          	auipc	a0,0x3
    800015f8:	b4450513          	addi	a0,a0,-1212 # 80004138 <CONSOLE_STATUS+0x128>
    800015fc:	00001097          	auipc	ra,0x1
    80001600:	800080e7          	jalr	-2048(ra) # 80001dfc <panic>
    80001604:	0ff7f713          	andi	a4,a5,255
    80001608:	00900693          	li	a3,9
    8000160c:	04d70063          	beq	a4,a3,8000164c <kerneltrap+0xac>
    80001610:	fff00713          	li	a4,-1
    80001614:	03f71713          	slli	a4,a4,0x3f
    80001618:	00170713          	addi	a4,a4,1
    8000161c:	fae798e3          	bne	a5,a4,800015cc <kerneltrap+0x2c>
    80001620:	00000097          	auipc	ra,0x0
    80001624:	e00080e7          	jalr	-512(ra) # 80001420 <cpuid>
    80001628:	06050663          	beqz	a0,80001694 <kerneltrap+0xf4>
    8000162c:	144027f3          	csrr	a5,sip
    80001630:	ffd7f793          	andi	a5,a5,-3
    80001634:	14479073          	csrw	sip,a5
    80001638:	01813083          	ld	ra,24(sp)
    8000163c:	01013403          	ld	s0,16(sp)
    80001640:	00813483          	ld	s1,8(sp)
    80001644:	02010113          	addi	sp,sp,32
    80001648:	00008067          	ret
    8000164c:	00000097          	auipc	ra,0x0
    80001650:	3c8080e7          	jalr	968(ra) # 80001a14 <plic_claim>
    80001654:	00a00793          	li	a5,10
    80001658:	00050493          	mv	s1,a0
    8000165c:	06f50863          	beq	a0,a5,800016cc <kerneltrap+0x12c>
    80001660:	fc050ce3          	beqz	a0,80001638 <kerneltrap+0x98>
    80001664:	00050593          	mv	a1,a0
    80001668:	00003517          	auipc	a0,0x3
    8000166c:	a8850513          	addi	a0,a0,-1400 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001670:	00000097          	auipc	ra,0x0
    80001674:	7e8080e7          	jalr	2024(ra) # 80001e58 <__printf>
    80001678:	01013403          	ld	s0,16(sp)
    8000167c:	01813083          	ld	ra,24(sp)
    80001680:	00048513          	mv	a0,s1
    80001684:	00813483          	ld	s1,8(sp)
    80001688:	02010113          	addi	sp,sp,32
    8000168c:	00000317          	auipc	t1,0x0
    80001690:	3c030067          	jr	960(t1) # 80001a4c <plic_complete>
    80001694:	00004517          	auipc	a0,0x4
    80001698:	d4c50513          	addi	a0,a0,-692 # 800053e0 <tickslock>
    8000169c:	00001097          	auipc	ra,0x1
    800016a0:	490080e7          	jalr	1168(ra) # 80002b2c <acquire>
    800016a4:	00003717          	auipc	a4,0x3
    800016a8:	c5070713          	addi	a4,a4,-944 # 800042f4 <ticks>
    800016ac:	00072783          	lw	a5,0(a4)
    800016b0:	00004517          	auipc	a0,0x4
    800016b4:	d3050513          	addi	a0,a0,-720 # 800053e0 <tickslock>
    800016b8:	0017879b          	addiw	a5,a5,1
    800016bc:	00f72023          	sw	a5,0(a4)
    800016c0:	00001097          	auipc	ra,0x1
    800016c4:	538080e7          	jalr	1336(ra) # 80002bf8 <release>
    800016c8:	f65ff06f          	j	8000162c <kerneltrap+0x8c>
    800016cc:	00001097          	auipc	ra,0x1
    800016d0:	094080e7          	jalr	148(ra) # 80002760 <uartintr>
    800016d4:	fa5ff06f          	j	80001678 <kerneltrap+0xd8>
    800016d8:	00003517          	auipc	a0,0x3
    800016dc:	9f850513          	addi	a0,a0,-1544 # 800040d0 <CONSOLE_STATUS+0xc0>
    800016e0:	00000097          	auipc	ra,0x0
    800016e4:	71c080e7          	jalr	1820(ra) # 80001dfc <panic>

00000000800016e8 <clockintr>:
    800016e8:	fe010113          	addi	sp,sp,-32
    800016ec:	00813823          	sd	s0,16(sp)
    800016f0:	00913423          	sd	s1,8(sp)
    800016f4:	00113c23          	sd	ra,24(sp)
    800016f8:	02010413          	addi	s0,sp,32
    800016fc:	00004497          	auipc	s1,0x4
    80001700:	ce448493          	addi	s1,s1,-796 # 800053e0 <tickslock>
    80001704:	00048513          	mv	a0,s1
    80001708:	00001097          	auipc	ra,0x1
    8000170c:	424080e7          	jalr	1060(ra) # 80002b2c <acquire>
    80001710:	00003717          	auipc	a4,0x3
    80001714:	be470713          	addi	a4,a4,-1052 # 800042f4 <ticks>
    80001718:	00072783          	lw	a5,0(a4)
    8000171c:	01013403          	ld	s0,16(sp)
    80001720:	01813083          	ld	ra,24(sp)
    80001724:	00048513          	mv	a0,s1
    80001728:	0017879b          	addiw	a5,a5,1
    8000172c:	00813483          	ld	s1,8(sp)
    80001730:	00f72023          	sw	a5,0(a4)
    80001734:	02010113          	addi	sp,sp,32
    80001738:	00001317          	auipc	t1,0x1
    8000173c:	4c030067          	jr	1216(t1) # 80002bf8 <release>

0000000080001740 <devintr>:
    80001740:	142027f3          	csrr	a5,scause
    80001744:	00000513          	li	a0,0
    80001748:	0007c463          	bltz	a5,80001750 <devintr+0x10>
    8000174c:	00008067          	ret
    80001750:	fe010113          	addi	sp,sp,-32
    80001754:	00813823          	sd	s0,16(sp)
    80001758:	00113c23          	sd	ra,24(sp)
    8000175c:	00913423          	sd	s1,8(sp)
    80001760:	02010413          	addi	s0,sp,32
    80001764:	0ff7f713          	andi	a4,a5,255
    80001768:	00900693          	li	a3,9
    8000176c:	04d70c63          	beq	a4,a3,800017c4 <devintr+0x84>
    80001770:	fff00713          	li	a4,-1
    80001774:	03f71713          	slli	a4,a4,0x3f
    80001778:	00170713          	addi	a4,a4,1
    8000177c:	00e78c63          	beq	a5,a4,80001794 <devintr+0x54>
    80001780:	01813083          	ld	ra,24(sp)
    80001784:	01013403          	ld	s0,16(sp)
    80001788:	00813483          	ld	s1,8(sp)
    8000178c:	02010113          	addi	sp,sp,32
    80001790:	00008067          	ret
    80001794:	00000097          	auipc	ra,0x0
    80001798:	c8c080e7          	jalr	-884(ra) # 80001420 <cpuid>
    8000179c:	06050663          	beqz	a0,80001808 <devintr+0xc8>
    800017a0:	144027f3          	csrr	a5,sip
    800017a4:	ffd7f793          	andi	a5,a5,-3
    800017a8:	14479073          	csrw	sip,a5
    800017ac:	01813083          	ld	ra,24(sp)
    800017b0:	01013403          	ld	s0,16(sp)
    800017b4:	00813483          	ld	s1,8(sp)
    800017b8:	00200513          	li	a0,2
    800017bc:	02010113          	addi	sp,sp,32
    800017c0:	00008067          	ret
    800017c4:	00000097          	auipc	ra,0x0
    800017c8:	250080e7          	jalr	592(ra) # 80001a14 <plic_claim>
    800017cc:	00a00793          	li	a5,10
    800017d0:	00050493          	mv	s1,a0
    800017d4:	06f50663          	beq	a0,a5,80001840 <devintr+0x100>
    800017d8:	00100513          	li	a0,1
    800017dc:	fa0482e3          	beqz	s1,80001780 <devintr+0x40>
    800017e0:	00048593          	mv	a1,s1
    800017e4:	00003517          	auipc	a0,0x3
    800017e8:	90c50513          	addi	a0,a0,-1780 # 800040f0 <CONSOLE_STATUS+0xe0>
    800017ec:	00000097          	auipc	ra,0x0
    800017f0:	66c080e7          	jalr	1644(ra) # 80001e58 <__printf>
    800017f4:	00048513          	mv	a0,s1
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	254080e7          	jalr	596(ra) # 80001a4c <plic_complete>
    80001800:	00100513          	li	a0,1
    80001804:	f7dff06f          	j	80001780 <devintr+0x40>
    80001808:	00004517          	auipc	a0,0x4
    8000180c:	bd850513          	addi	a0,a0,-1064 # 800053e0 <tickslock>
    80001810:	00001097          	auipc	ra,0x1
    80001814:	31c080e7          	jalr	796(ra) # 80002b2c <acquire>
    80001818:	00003717          	auipc	a4,0x3
    8000181c:	adc70713          	addi	a4,a4,-1316 # 800042f4 <ticks>
    80001820:	00072783          	lw	a5,0(a4)
    80001824:	00004517          	auipc	a0,0x4
    80001828:	bbc50513          	addi	a0,a0,-1092 # 800053e0 <tickslock>
    8000182c:	0017879b          	addiw	a5,a5,1
    80001830:	00f72023          	sw	a5,0(a4)
    80001834:	00001097          	auipc	ra,0x1
    80001838:	3c4080e7          	jalr	964(ra) # 80002bf8 <release>
    8000183c:	f65ff06f          	j	800017a0 <devintr+0x60>
    80001840:	00001097          	auipc	ra,0x1
    80001844:	f20080e7          	jalr	-224(ra) # 80002760 <uartintr>
    80001848:	fadff06f          	j	800017f4 <devintr+0xb4>
    8000184c:	0000                	unimp
	...

0000000080001850 <kernelvec>:
    80001850:	f0010113          	addi	sp,sp,-256
    80001854:	00113023          	sd	ra,0(sp)
    80001858:	00213423          	sd	sp,8(sp)
    8000185c:	00313823          	sd	gp,16(sp)
    80001860:	00413c23          	sd	tp,24(sp)
    80001864:	02513023          	sd	t0,32(sp)
    80001868:	02613423          	sd	t1,40(sp)
    8000186c:	02713823          	sd	t2,48(sp)
    80001870:	02813c23          	sd	s0,56(sp)
    80001874:	04913023          	sd	s1,64(sp)
    80001878:	04a13423          	sd	a0,72(sp)
    8000187c:	04b13823          	sd	a1,80(sp)
    80001880:	04c13c23          	sd	a2,88(sp)
    80001884:	06d13023          	sd	a3,96(sp)
    80001888:	06e13423          	sd	a4,104(sp)
    8000188c:	06f13823          	sd	a5,112(sp)
    80001890:	07013c23          	sd	a6,120(sp)
    80001894:	09113023          	sd	a7,128(sp)
    80001898:	09213423          	sd	s2,136(sp)
    8000189c:	09313823          	sd	s3,144(sp)
    800018a0:	09413c23          	sd	s4,152(sp)
    800018a4:	0b513023          	sd	s5,160(sp)
    800018a8:	0b613423          	sd	s6,168(sp)
    800018ac:	0b713823          	sd	s7,176(sp)
    800018b0:	0b813c23          	sd	s8,184(sp)
    800018b4:	0d913023          	sd	s9,192(sp)
    800018b8:	0da13423          	sd	s10,200(sp)
    800018bc:	0db13823          	sd	s11,208(sp)
    800018c0:	0dc13c23          	sd	t3,216(sp)
    800018c4:	0fd13023          	sd	t4,224(sp)
    800018c8:	0fe13423          	sd	t5,232(sp)
    800018cc:	0ff13823          	sd	t6,240(sp)
    800018d0:	cd1ff0ef          	jal	ra,800015a0 <kerneltrap>
    800018d4:	00013083          	ld	ra,0(sp)
    800018d8:	00813103          	ld	sp,8(sp)
    800018dc:	01013183          	ld	gp,16(sp)
    800018e0:	02013283          	ld	t0,32(sp)
    800018e4:	02813303          	ld	t1,40(sp)
    800018e8:	03013383          	ld	t2,48(sp)
    800018ec:	03813403          	ld	s0,56(sp)
    800018f0:	04013483          	ld	s1,64(sp)
    800018f4:	04813503          	ld	a0,72(sp)
    800018f8:	05013583          	ld	a1,80(sp)
    800018fc:	05813603          	ld	a2,88(sp)
    80001900:	06013683          	ld	a3,96(sp)
    80001904:	06813703          	ld	a4,104(sp)
    80001908:	07013783          	ld	a5,112(sp)
    8000190c:	07813803          	ld	a6,120(sp)
    80001910:	08013883          	ld	a7,128(sp)
    80001914:	08813903          	ld	s2,136(sp)
    80001918:	09013983          	ld	s3,144(sp)
    8000191c:	09813a03          	ld	s4,152(sp)
    80001920:	0a013a83          	ld	s5,160(sp)
    80001924:	0a813b03          	ld	s6,168(sp)
    80001928:	0b013b83          	ld	s7,176(sp)
    8000192c:	0b813c03          	ld	s8,184(sp)
    80001930:	0c013c83          	ld	s9,192(sp)
    80001934:	0c813d03          	ld	s10,200(sp)
    80001938:	0d013d83          	ld	s11,208(sp)
    8000193c:	0d813e03          	ld	t3,216(sp)
    80001940:	0e013e83          	ld	t4,224(sp)
    80001944:	0e813f03          	ld	t5,232(sp)
    80001948:	0f013f83          	ld	t6,240(sp)
    8000194c:	10010113          	addi	sp,sp,256
    80001950:	10200073          	sret
    80001954:	00000013          	nop
    80001958:	00000013          	nop
    8000195c:	00000013          	nop

0000000080001960 <timervec>:
    80001960:	34051573          	csrrw	a0,mscratch,a0
    80001964:	00b53023          	sd	a1,0(a0)
    80001968:	00c53423          	sd	a2,8(a0)
    8000196c:	00d53823          	sd	a3,16(a0)
    80001970:	01853583          	ld	a1,24(a0)
    80001974:	02053603          	ld	a2,32(a0)
    80001978:	0005b683          	ld	a3,0(a1)
    8000197c:	00c686b3          	add	a3,a3,a2
    80001980:	00d5b023          	sd	a3,0(a1)
    80001984:	00200593          	li	a1,2
    80001988:	14459073          	csrw	sip,a1
    8000198c:	01053683          	ld	a3,16(a0)
    80001990:	00853603          	ld	a2,8(a0)
    80001994:	00053583          	ld	a1,0(a0)
    80001998:	34051573          	csrrw	a0,mscratch,a0
    8000199c:	30200073          	mret

00000000800019a0 <plicinit>:
    800019a0:	ff010113          	addi	sp,sp,-16
    800019a4:	00813423          	sd	s0,8(sp)
    800019a8:	01010413          	addi	s0,sp,16
    800019ac:	00813403          	ld	s0,8(sp)
    800019b0:	0c0007b7          	lui	a5,0xc000
    800019b4:	00100713          	li	a4,1
    800019b8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800019bc:	00e7a223          	sw	a4,4(a5)
    800019c0:	01010113          	addi	sp,sp,16
    800019c4:	00008067          	ret

00000000800019c8 <plicinithart>:
    800019c8:	ff010113          	addi	sp,sp,-16
    800019cc:	00813023          	sd	s0,0(sp)
    800019d0:	00113423          	sd	ra,8(sp)
    800019d4:	01010413          	addi	s0,sp,16
    800019d8:	00000097          	auipc	ra,0x0
    800019dc:	a48080e7          	jalr	-1464(ra) # 80001420 <cpuid>
    800019e0:	0085171b          	slliw	a4,a0,0x8
    800019e4:	0c0027b7          	lui	a5,0xc002
    800019e8:	00e787b3          	add	a5,a5,a4
    800019ec:	40200713          	li	a4,1026
    800019f0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800019f4:	00813083          	ld	ra,8(sp)
    800019f8:	00013403          	ld	s0,0(sp)
    800019fc:	00d5151b          	slliw	a0,a0,0xd
    80001a00:	0c2017b7          	lui	a5,0xc201
    80001a04:	00a78533          	add	a0,a5,a0
    80001a08:	00052023          	sw	zero,0(a0)
    80001a0c:	01010113          	addi	sp,sp,16
    80001a10:	00008067          	ret

0000000080001a14 <plic_claim>:
    80001a14:	ff010113          	addi	sp,sp,-16
    80001a18:	00813023          	sd	s0,0(sp)
    80001a1c:	00113423          	sd	ra,8(sp)
    80001a20:	01010413          	addi	s0,sp,16
    80001a24:	00000097          	auipc	ra,0x0
    80001a28:	9fc080e7          	jalr	-1540(ra) # 80001420 <cpuid>
    80001a2c:	00813083          	ld	ra,8(sp)
    80001a30:	00013403          	ld	s0,0(sp)
    80001a34:	00d5151b          	slliw	a0,a0,0xd
    80001a38:	0c2017b7          	lui	a5,0xc201
    80001a3c:	00a78533          	add	a0,a5,a0
    80001a40:	00452503          	lw	a0,4(a0)
    80001a44:	01010113          	addi	sp,sp,16
    80001a48:	00008067          	ret

0000000080001a4c <plic_complete>:
    80001a4c:	fe010113          	addi	sp,sp,-32
    80001a50:	00813823          	sd	s0,16(sp)
    80001a54:	00913423          	sd	s1,8(sp)
    80001a58:	00113c23          	sd	ra,24(sp)
    80001a5c:	02010413          	addi	s0,sp,32
    80001a60:	00050493          	mv	s1,a0
    80001a64:	00000097          	auipc	ra,0x0
    80001a68:	9bc080e7          	jalr	-1604(ra) # 80001420 <cpuid>
    80001a6c:	01813083          	ld	ra,24(sp)
    80001a70:	01013403          	ld	s0,16(sp)
    80001a74:	00d5179b          	slliw	a5,a0,0xd
    80001a78:	0c201737          	lui	a4,0xc201
    80001a7c:	00f707b3          	add	a5,a4,a5
    80001a80:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001a84:	00813483          	ld	s1,8(sp)
    80001a88:	02010113          	addi	sp,sp,32
    80001a8c:	00008067          	ret

0000000080001a90 <consolewrite>:
    80001a90:	fb010113          	addi	sp,sp,-80
    80001a94:	04813023          	sd	s0,64(sp)
    80001a98:	04113423          	sd	ra,72(sp)
    80001a9c:	02913c23          	sd	s1,56(sp)
    80001aa0:	03213823          	sd	s2,48(sp)
    80001aa4:	03313423          	sd	s3,40(sp)
    80001aa8:	03413023          	sd	s4,32(sp)
    80001aac:	01513c23          	sd	s5,24(sp)
    80001ab0:	05010413          	addi	s0,sp,80
    80001ab4:	06c05c63          	blez	a2,80001b2c <consolewrite+0x9c>
    80001ab8:	00060993          	mv	s3,a2
    80001abc:	00050a13          	mv	s4,a0
    80001ac0:	00058493          	mv	s1,a1
    80001ac4:	00000913          	li	s2,0
    80001ac8:	fff00a93          	li	s5,-1
    80001acc:	01c0006f          	j	80001ae8 <consolewrite+0x58>
    80001ad0:	fbf44503          	lbu	a0,-65(s0)
    80001ad4:	0019091b          	addiw	s2,s2,1
    80001ad8:	00148493          	addi	s1,s1,1
    80001adc:	00001097          	auipc	ra,0x1
    80001ae0:	a9c080e7          	jalr	-1380(ra) # 80002578 <uartputc>
    80001ae4:	03298063          	beq	s3,s2,80001b04 <consolewrite+0x74>
    80001ae8:	00048613          	mv	a2,s1
    80001aec:	00100693          	li	a3,1
    80001af0:	000a0593          	mv	a1,s4
    80001af4:	fbf40513          	addi	a0,s0,-65
    80001af8:	00000097          	auipc	ra,0x0
    80001afc:	9e0080e7          	jalr	-1568(ra) # 800014d8 <either_copyin>
    80001b00:	fd5518e3          	bne	a0,s5,80001ad0 <consolewrite+0x40>
    80001b04:	04813083          	ld	ra,72(sp)
    80001b08:	04013403          	ld	s0,64(sp)
    80001b0c:	03813483          	ld	s1,56(sp)
    80001b10:	02813983          	ld	s3,40(sp)
    80001b14:	02013a03          	ld	s4,32(sp)
    80001b18:	01813a83          	ld	s5,24(sp)
    80001b1c:	00090513          	mv	a0,s2
    80001b20:	03013903          	ld	s2,48(sp)
    80001b24:	05010113          	addi	sp,sp,80
    80001b28:	00008067          	ret
    80001b2c:	00000913          	li	s2,0
    80001b30:	fd5ff06f          	j	80001b04 <consolewrite+0x74>

0000000080001b34 <consoleread>:
    80001b34:	f9010113          	addi	sp,sp,-112
    80001b38:	06813023          	sd	s0,96(sp)
    80001b3c:	04913c23          	sd	s1,88(sp)
    80001b40:	05213823          	sd	s2,80(sp)
    80001b44:	05313423          	sd	s3,72(sp)
    80001b48:	05413023          	sd	s4,64(sp)
    80001b4c:	03513c23          	sd	s5,56(sp)
    80001b50:	03613823          	sd	s6,48(sp)
    80001b54:	03713423          	sd	s7,40(sp)
    80001b58:	03813023          	sd	s8,32(sp)
    80001b5c:	06113423          	sd	ra,104(sp)
    80001b60:	01913c23          	sd	s9,24(sp)
    80001b64:	07010413          	addi	s0,sp,112
    80001b68:	00060b93          	mv	s7,a2
    80001b6c:	00050913          	mv	s2,a0
    80001b70:	00058c13          	mv	s8,a1
    80001b74:	00060b1b          	sext.w	s6,a2
    80001b78:	00004497          	auipc	s1,0x4
    80001b7c:	88048493          	addi	s1,s1,-1920 # 800053f8 <cons>
    80001b80:	00400993          	li	s3,4
    80001b84:	fff00a13          	li	s4,-1
    80001b88:	00a00a93          	li	s5,10
    80001b8c:	05705e63          	blez	s7,80001be8 <consoleread+0xb4>
    80001b90:	09c4a703          	lw	a4,156(s1)
    80001b94:	0984a783          	lw	a5,152(s1)
    80001b98:	0007071b          	sext.w	a4,a4
    80001b9c:	08e78463          	beq	a5,a4,80001c24 <consoleread+0xf0>
    80001ba0:	07f7f713          	andi	a4,a5,127
    80001ba4:	00e48733          	add	a4,s1,a4
    80001ba8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001bac:	0017869b          	addiw	a3,a5,1
    80001bb0:	08d4ac23          	sw	a3,152(s1)
    80001bb4:	00070c9b          	sext.w	s9,a4
    80001bb8:	0b370663          	beq	a4,s3,80001c64 <consoleread+0x130>
    80001bbc:	00100693          	li	a3,1
    80001bc0:	f9f40613          	addi	a2,s0,-97
    80001bc4:	000c0593          	mv	a1,s8
    80001bc8:	00090513          	mv	a0,s2
    80001bcc:	f8e40fa3          	sb	a4,-97(s0)
    80001bd0:	00000097          	auipc	ra,0x0
    80001bd4:	8bc080e7          	jalr	-1860(ra) # 8000148c <either_copyout>
    80001bd8:	01450863          	beq	a0,s4,80001be8 <consoleread+0xb4>
    80001bdc:	001c0c13          	addi	s8,s8,1
    80001be0:	fffb8b9b          	addiw	s7,s7,-1
    80001be4:	fb5c94e3          	bne	s9,s5,80001b8c <consoleread+0x58>
    80001be8:	000b851b          	sext.w	a0,s7
    80001bec:	06813083          	ld	ra,104(sp)
    80001bf0:	06013403          	ld	s0,96(sp)
    80001bf4:	05813483          	ld	s1,88(sp)
    80001bf8:	05013903          	ld	s2,80(sp)
    80001bfc:	04813983          	ld	s3,72(sp)
    80001c00:	04013a03          	ld	s4,64(sp)
    80001c04:	03813a83          	ld	s5,56(sp)
    80001c08:	02813b83          	ld	s7,40(sp)
    80001c0c:	02013c03          	ld	s8,32(sp)
    80001c10:	01813c83          	ld	s9,24(sp)
    80001c14:	40ab053b          	subw	a0,s6,a0
    80001c18:	03013b03          	ld	s6,48(sp)
    80001c1c:	07010113          	addi	sp,sp,112
    80001c20:	00008067          	ret
    80001c24:	00001097          	auipc	ra,0x1
    80001c28:	1d8080e7          	jalr	472(ra) # 80002dfc <push_on>
    80001c2c:	0984a703          	lw	a4,152(s1)
    80001c30:	09c4a783          	lw	a5,156(s1)
    80001c34:	0007879b          	sext.w	a5,a5
    80001c38:	fef70ce3          	beq	a4,a5,80001c30 <consoleread+0xfc>
    80001c3c:	00001097          	auipc	ra,0x1
    80001c40:	234080e7          	jalr	564(ra) # 80002e70 <pop_on>
    80001c44:	0984a783          	lw	a5,152(s1)
    80001c48:	07f7f713          	andi	a4,a5,127
    80001c4c:	00e48733          	add	a4,s1,a4
    80001c50:	01874703          	lbu	a4,24(a4)
    80001c54:	0017869b          	addiw	a3,a5,1
    80001c58:	08d4ac23          	sw	a3,152(s1)
    80001c5c:	00070c9b          	sext.w	s9,a4
    80001c60:	f5371ee3          	bne	a4,s3,80001bbc <consoleread+0x88>
    80001c64:	000b851b          	sext.w	a0,s7
    80001c68:	f96bf2e3          	bgeu	s7,s6,80001bec <consoleread+0xb8>
    80001c6c:	08f4ac23          	sw	a5,152(s1)
    80001c70:	f7dff06f          	j	80001bec <consoleread+0xb8>

0000000080001c74 <consputc>:
    80001c74:	10000793          	li	a5,256
    80001c78:	00f50663          	beq	a0,a5,80001c84 <consputc+0x10>
    80001c7c:	00001317          	auipc	t1,0x1
    80001c80:	9f430067          	jr	-1548(t1) # 80002670 <uartputc_sync>
    80001c84:	ff010113          	addi	sp,sp,-16
    80001c88:	00113423          	sd	ra,8(sp)
    80001c8c:	00813023          	sd	s0,0(sp)
    80001c90:	01010413          	addi	s0,sp,16
    80001c94:	00800513          	li	a0,8
    80001c98:	00001097          	auipc	ra,0x1
    80001c9c:	9d8080e7          	jalr	-1576(ra) # 80002670 <uartputc_sync>
    80001ca0:	02000513          	li	a0,32
    80001ca4:	00001097          	auipc	ra,0x1
    80001ca8:	9cc080e7          	jalr	-1588(ra) # 80002670 <uartputc_sync>
    80001cac:	00013403          	ld	s0,0(sp)
    80001cb0:	00813083          	ld	ra,8(sp)
    80001cb4:	00800513          	li	a0,8
    80001cb8:	01010113          	addi	sp,sp,16
    80001cbc:	00001317          	auipc	t1,0x1
    80001cc0:	9b430067          	jr	-1612(t1) # 80002670 <uartputc_sync>

0000000080001cc4 <consoleintr>:
    80001cc4:	fe010113          	addi	sp,sp,-32
    80001cc8:	00813823          	sd	s0,16(sp)
    80001ccc:	00913423          	sd	s1,8(sp)
    80001cd0:	01213023          	sd	s2,0(sp)
    80001cd4:	00113c23          	sd	ra,24(sp)
    80001cd8:	02010413          	addi	s0,sp,32
    80001cdc:	00003917          	auipc	s2,0x3
    80001ce0:	71c90913          	addi	s2,s2,1820 # 800053f8 <cons>
    80001ce4:	00050493          	mv	s1,a0
    80001ce8:	00090513          	mv	a0,s2
    80001cec:	00001097          	auipc	ra,0x1
    80001cf0:	e40080e7          	jalr	-448(ra) # 80002b2c <acquire>
    80001cf4:	02048c63          	beqz	s1,80001d2c <consoleintr+0x68>
    80001cf8:	0a092783          	lw	a5,160(s2)
    80001cfc:	09892703          	lw	a4,152(s2)
    80001d00:	07f00693          	li	a3,127
    80001d04:	40e7873b          	subw	a4,a5,a4
    80001d08:	02e6e263          	bltu	a3,a4,80001d2c <consoleintr+0x68>
    80001d0c:	00d00713          	li	a4,13
    80001d10:	04e48063          	beq	s1,a4,80001d50 <consoleintr+0x8c>
    80001d14:	07f7f713          	andi	a4,a5,127
    80001d18:	00e90733          	add	a4,s2,a4
    80001d1c:	0017879b          	addiw	a5,a5,1
    80001d20:	0af92023          	sw	a5,160(s2)
    80001d24:	00970c23          	sb	s1,24(a4)
    80001d28:	08f92e23          	sw	a5,156(s2)
    80001d2c:	01013403          	ld	s0,16(sp)
    80001d30:	01813083          	ld	ra,24(sp)
    80001d34:	00813483          	ld	s1,8(sp)
    80001d38:	00013903          	ld	s2,0(sp)
    80001d3c:	00003517          	auipc	a0,0x3
    80001d40:	6bc50513          	addi	a0,a0,1724 # 800053f8 <cons>
    80001d44:	02010113          	addi	sp,sp,32
    80001d48:	00001317          	auipc	t1,0x1
    80001d4c:	eb030067          	jr	-336(t1) # 80002bf8 <release>
    80001d50:	00a00493          	li	s1,10
    80001d54:	fc1ff06f          	j	80001d14 <consoleintr+0x50>

0000000080001d58 <consoleinit>:
    80001d58:	fe010113          	addi	sp,sp,-32
    80001d5c:	00113c23          	sd	ra,24(sp)
    80001d60:	00813823          	sd	s0,16(sp)
    80001d64:	00913423          	sd	s1,8(sp)
    80001d68:	02010413          	addi	s0,sp,32
    80001d6c:	00003497          	auipc	s1,0x3
    80001d70:	68c48493          	addi	s1,s1,1676 # 800053f8 <cons>
    80001d74:	00048513          	mv	a0,s1
    80001d78:	00002597          	auipc	a1,0x2
    80001d7c:	3d058593          	addi	a1,a1,976 # 80004148 <CONSOLE_STATUS+0x138>
    80001d80:	00001097          	auipc	ra,0x1
    80001d84:	d88080e7          	jalr	-632(ra) # 80002b08 <initlock>
    80001d88:	00000097          	auipc	ra,0x0
    80001d8c:	7ac080e7          	jalr	1964(ra) # 80002534 <uartinit>
    80001d90:	01813083          	ld	ra,24(sp)
    80001d94:	01013403          	ld	s0,16(sp)
    80001d98:	00000797          	auipc	a5,0x0
    80001d9c:	d9c78793          	addi	a5,a5,-612 # 80001b34 <consoleread>
    80001da0:	0af4bc23          	sd	a5,184(s1)
    80001da4:	00000797          	auipc	a5,0x0
    80001da8:	cec78793          	addi	a5,a5,-788 # 80001a90 <consolewrite>
    80001dac:	0cf4b023          	sd	a5,192(s1)
    80001db0:	00813483          	ld	s1,8(sp)
    80001db4:	02010113          	addi	sp,sp,32
    80001db8:	00008067          	ret

0000000080001dbc <console_read>:
    80001dbc:	ff010113          	addi	sp,sp,-16
    80001dc0:	00813423          	sd	s0,8(sp)
    80001dc4:	01010413          	addi	s0,sp,16
    80001dc8:	00813403          	ld	s0,8(sp)
    80001dcc:	00003317          	auipc	t1,0x3
    80001dd0:	6e433303          	ld	t1,1764(t1) # 800054b0 <devsw+0x10>
    80001dd4:	01010113          	addi	sp,sp,16
    80001dd8:	00030067          	jr	t1

0000000080001ddc <console_write>:
    80001ddc:	ff010113          	addi	sp,sp,-16
    80001de0:	00813423          	sd	s0,8(sp)
    80001de4:	01010413          	addi	s0,sp,16
    80001de8:	00813403          	ld	s0,8(sp)
    80001dec:	00003317          	auipc	t1,0x3
    80001df0:	6cc33303          	ld	t1,1740(t1) # 800054b8 <devsw+0x18>
    80001df4:	01010113          	addi	sp,sp,16
    80001df8:	00030067          	jr	t1

0000000080001dfc <panic>:
    80001dfc:	fe010113          	addi	sp,sp,-32
    80001e00:	00113c23          	sd	ra,24(sp)
    80001e04:	00813823          	sd	s0,16(sp)
    80001e08:	00913423          	sd	s1,8(sp)
    80001e0c:	02010413          	addi	s0,sp,32
    80001e10:	00050493          	mv	s1,a0
    80001e14:	00002517          	auipc	a0,0x2
    80001e18:	33c50513          	addi	a0,a0,828 # 80004150 <CONSOLE_STATUS+0x140>
    80001e1c:	00003797          	auipc	a5,0x3
    80001e20:	7207ae23          	sw	zero,1852(a5) # 80005558 <pr+0x18>
    80001e24:	00000097          	auipc	ra,0x0
    80001e28:	034080e7          	jalr	52(ra) # 80001e58 <__printf>
    80001e2c:	00048513          	mv	a0,s1
    80001e30:	00000097          	auipc	ra,0x0
    80001e34:	028080e7          	jalr	40(ra) # 80001e58 <__printf>
    80001e38:	00002517          	auipc	a0,0x2
    80001e3c:	2f850513          	addi	a0,a0,760 # 80004130 <CONSOLE_STATUS+0x120>
    80001e40:	00000097          	auipc	ra,0x0
    80001e44:	018080e7          	jalr	24(ra) # 80001e58 <__printf>
    80001e48:	00100793          	li	a5,1
    80001e4c:	00002717          	auipc	a4,0x2
    80001e50:	4af72623          	sw	a5,1196(a4) # 800042f8 <panicked>
    80001e54:	0000006f          	j	80001e54 <panic+0x58>

0000000080001e58 <__printf>:
    80001e58:	f3010113          	addi	sp,sp,-208
    80001e5c:	08813023          	sd	s0,128(sp)
    80001e60:	07313423          	sd	s3,104(sp)
    80001e64:	09010413          	addi	s0,sp,144
    80001e68:	05813023          	sd	s8,64(sp)
    80001e6c:	08113423          	sd	ra,136(sp)
    80001e70:	06913c23          	sd	s1,120(sp)
    80001e74:	07213823          	sd	s2,112(sp)
    80001e78:	07413023          	sd	s4,96(sp)
    80001e7c:	05513c23          	sd	s5,88(sp)
    80001e80:	05613823          	sd	s6,80(sp)
    80001e84:	05713423          	sd	s7,72(sp)
    80001e88:	03913c23          	sd	s9,56(sp)
    80001e8c:	03a13823          	sd	s10,48(sp)
    80001e90:	03b13423          	sd	s11,40(sp)
    80001e94:	00003317          	auipc	t1,0x3
    80001e98:	6ac30313          	addi	t1,t1,1708 # 80005540 <pr>
    80001e9c:	01832c03          	lw	s8,24(t1)
    80001ea0:	00b43423          	sd	a1,8(s0)
    80001ea4:	00c43823          	sd	a2,16(s0)
    80001ea8:	00d43c23          	sd	a3,24(s0)
    80001eac:	02e43023          	sd	a4,32(s0)
    80001eb0:	02f43423          	sd	a5,40(s0)
    80001eb4:	03043823          	sd	a6,48(s0)
    80001eb8:	03143c23          	sd	a7,56(s0)
    80001ebc:	00050993          	mv	s3,a0
    80001ec0:	4a0c1663          	bnez	s8,8000236c <__printf+0x514>
    80001ec4:	60098c63          	beqz	s3,800024dc <__printf+0x684>
    80001ec8:	0009c503          	lbu	a0,0(s3)
    80001ecc:	00840793          	addi	a5,s0,8
    80001ed0:	f6f43c23          	sd	a5,-136(s0)
    80001ed4:	00000493          	li	s1,0
    80001ed8:	22050063          	beqz	a0,800020f8 <__printf+0x2a0>
    80001edc:	00002a37          	lui	s4,0x2
    80001ee0:	00018ab7          	lui	s5,0x18
    80001ee4:	000f4b37          	lui	s6,0xf4
    80001ee8:	00989bb7          	lui	s7,0x989
    80001eec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80001ef0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80001ef4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80001ef8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80001efc:	00148c9b          	addiw	s9,s1,1
    80001f00:	02500793          	li	a5,37
    80001f04:	01998933          	add	s2,s3,s9
    80001f08:	38f51263          	bne	a0,a5,8000228c <__printf+0x434>
    80001f0c:	00094783          	lbu	a5,0(s2)
    80001f10:	00078c9b          	sext.w	s9,a5
    80001f14:	1e078263          	beqz	a5,800020f8 <__printf+0x2a0>
    80001f18:	0024849b          	addiw	s1,s1,2
    80001f1c:	07000713          	li	a4,112
    80001f20:	00998933          	add	s2,s3,s1
    80001f24:	38e78a63          	beq	a5,a4,800022b8 <__printf+0x460>
    80001f28:	20f76863          	bltu	a4,a5,80002138 <__printf+0x2e0>
    80001f2c:	42a78863          	beq	a5,a0,8000235c <__printf+0x504>
    80001f30:	06400713          	li	a4,100
    80001f34:	40e79663          	bne	a5,a4,80002340 <__printf+0x4e8>
    80001f38:	f7843783          	ld	a5,-136(s0)
    80001f3c:	0007a603          	lw	a2,0(a5)
    80001f40:	00878793          	addi	a5,a5,8
    80001f44:	f6f43c23          	sd	a5,-136(s0)
    80001f48:	42064a63          	bltz	a2,8000237c <__printf+0x524>
    80001f4c:	00a00713          	li	a4,10
    80001f50:	02e677bb          	remuw	a5,a2,a4
    80001f54:	00002d97          	auipc	s11,0x2
    80001f58:	224d8d93          	addi	s11,s11,548 # 80004178 <digits>
    80001f5c:	00900593          	li	a1,9
    80001f60:	0006051b          	sext.w	a0,a2
    80001f64:	00000c93          	li	s9,0
    80001f68:	02079793          	slli	a5,a5,0x20
    80001f6c:	0207d793          	srli	a5,a5,0x20
    80001f70:	00fd87b3          	add	a5,s11,a5
    80001f74:	0007c783          	lbu	a5,0(a5)
    80001f78:	02e656bb          	divuw	a3,a2,a4
    80001f7c:	f8f40023          	sb	a5,-128(s0)
    80001f80:	14c5d863          	bge	a1,a2,800020d0 <__printf+0x278>
    80001f84:	06300593          	li	a1,99
    80001f88:	00100c93          	li	s9,1
    80001f8c:	02e6f7bb          	remuw	a5,a3,a4
    80001f90:	02079793          	slli	a5,a5,0x20
    80001f94:	0207d793          	srli	a5,a5,0x20
    80001f98:	00fd87b3          	add	a5,s11,a5
    80001f9c:	0007c783          	lbu	a5,0(a5)
    80001fa0:	02e6d73b          	divuw	a4,a3,a4
    80001fa4:	f8f400a3          	sb	a5,-127(s0)
    80001fa8:	12a5f463          	bgeu	a1,a0,800020d0 <__printf+0x278>
    80001fac:	00a00693          	li	a3,10
    80001fb0:	00900593          	li	a1,9
    80001fb4:	02d777bb          	remuw	a5,a4,a3
    80001fb8:	02079793          	slli	a5,a5,0x20
    80001fbc:	0207d793          	srli	a5,a5,0x20
    80001fc0:	00fd87b3          	add	a5,s11,a5
    80001fc4:	0007c503          	lbu	a0,0(a5)
    80001fc8:	02d757bb          	divuw	a5,a4,a3
    80001fcc:	f8a40123          	sb	a0,-126(s0)
    80001fd0:	48e5f263          	bgeu	a1,a4,80002454 <__printf+0x5fc>
    80001fd4:	06300513          	li	a0,99
    80001fd8:	02d7f5bb          	remuw	a1,a5,a3
    80001fdc:	02059593          	slli	a1,a1,0x20
    80001fe0:	0205d593          	srli	a1,a1,0x20
    80001fe4:	00bd85b3          	add	a1,s11,a1
    80001fe8:	0005c583          	lbu	a1,0(a1)
    80001fec:	02d7d7bb          	divuw	a5,a5,a3
    80001ff0:	f8b401a3          	sb	a1,-125(s0)
    80001ff4:	48e57263          	bgeu	a0,a4,80002478 <__printf+0x620>
    80001ff8:	3e700513          	li	a0,999
    80001ffc:	02d7f5bb          	remuw	a1,a5,a3
    80002000:	02059593          	slli	a1,a1,0x20
    80002004:	0205d593          	srli	a1,a1,0x20
    80002008:	00bd85b3          	add	a1,s11,a1
    8000200c:	0005c583          	lbu	a1,0(a1)
    80002010:	02d7d7bb          	divuw	a5,a5,a3
    80002014:	f8b40223          	sb	a1,-124(s0)
    80002018:	46e57663          	bgeu	a0,a4,80002484 <__printf+0x62c>
    8000201c:	02d7f5bb          	remuw	a1,a5,a3
    80002020:	02059593          	slli	a1,a1,0x20
    80002024:	0205d593          	srli	a1,a1,0x20
    80002028:	00bd85b3          	add	a1,s11,a1
    8000202c:	0005c583          	lbu	a1,0(a1)
    80002030:	02d7d7bb          	divuw	a5,a5,a3
    80002034:	f8b402a3          	sb	a1,-123(s0)
    80002038:	46ea7863          	bgeu	s4,a4,800024a8 <__printf+0x650>
    8000203c:	02d7f5bb          	remuw	a1,a5,a3
    80002040:	02059593          	slli	a1,a1,0x20
    80002044:	0205d593          	srli	a1,a1,0x20
    80002048:	00bd85b3          	add	a1,s11,a1
    8000204c:	0005c583          	lbu	a1,0(a1)
    80002050:	02d7d7bb          	divuw	a5,a5,a3
    80002054:	f8b40323          	sb	a1,-122(s0)
    80002058:	3eeaf863          	bgeu	s5,a4,80002448 <__printf+0x5f0>
    8000205c:	02d7f5bb          	remuw	a1,a5,a3
    80002060:	02059593          	slli	a1,a1,0x20
    80002064:	0205d593          	srli	a1,a1,0x20
    80002068:	00bd85b3          	add	a1,s11,a1
    8000206c:	0005c583          	lbu	a1,0(a1)
    80002070:	02d7d7bb          	divuw	a5,a5,a3
    80002074:	f8b403a3          	sb	a1,-121(s0)
    80002078:	42eb7e63          	bgeu	s6,a4,800024b4 <__printf+0x65c>
    8000207c:	02d7f5bb          	remuw	a1,a5,a3
    80002080:	02059593          	slli	a1,a1,0x20
    80002084:	0205d593          	srli	a1,a1,0x20
    80002088:	00bd85b3          	add	a1,s11,a1
    8000208c:	0005c583          	lbu	a1,0(a1)
    80002090:	02d7d7bb          	divuw	a5,a5,a3
    80002094:	f8b40423          	sb	a1,-120(s0)
    80002098:	42ebfc63          	bgeu	s7,a4,800024d0 <__printf+0x678>
    8000209c:	02079793          	slli	a5,a5,0x20
    800020a0:	0207d793          	srli	a5,a5,0x20
    800020a4:	00fd8db3          	add	s11,s11,a5
    800020a8:	000dc703          	lbu	a4,0(s11)
    800020ac:	00a00793          	li	a5,10
    800020b0:	00900c93          	li	s9,9
    800020b4:	f8e404a3          	sb	a4,-119(s0)
    800020b8:	00065c63          	bgez	a2,800020d0 <__printf+0x278>
    800020bc:	f9040713          	addi	a4,s0,-112
    800020c0:	00f70733          	add	a4,a4,a5
    800020c4:	02d00693          	li	a3,45
    800020c8:	fed70823          	sb	a3,-16(a4)
    800020cc:	00078c93          	mv	s9,a5
    800020d0:	f8040793          	addi	a5,s0,-128
    800020d4:	01978cb3          	add	s9,a5,s9
    800020d8:	f7f40d13          	addi	s10,s0,-129
    800020dc:	000cc503          	lbu	a0,0(s9)
    800020e0:	fffc8c93          	addi	s9,s9,-1
    800020e4:	00000097          	auipc	ra,0x0
    800020e8:	b90080e7          	jalr	-1136(ra) # 80001c74 <consputc>
    800020ec:	ffac98e3          	bne	s9,s10,800020dc <__printf+0x284>
    800020f0:	00094503          	lbu	a0,0(s2)
    800020f4:	e00514e3          	bnez	a0,80001efc <__printf+0xa4>
    800020f8:	1a0c1663          	bnez	s8,800022a4 <__printf+0x44c>
    800020fc:	08813083          	ld	ra,136(sp)
    80002100:	08013403          	ld	s0,128(sp)
    80002104:	07813483          	ld	s1,120(sp)
    80002108:	07013903          	ld	s2,112(sp)
    8000210c:	06813983          	ld	s3,104(sp)
    80002110:	06013a03          	ld	s4,96(sp)
    80002114:	05813a83          	ld	s5,88(sp)
    80002118:	05013b03          	ld	s6,80(sp)
    8000211c:	04813b83          	ld	s7,72(sp)
    80002120:	04013c03          	ld	s8,64(sp)
    80002124:	03813c83          	ld	s9,56(sp)
    80002128:	03013d03          	ld	s10,48(sp)
    8000212c:	02813d83          	ld	s11,40(sp)
    80002130:	0d010113          	addi	sp,sp,208
    80002134:	00008067          	ret
    80002138:	07300713          	li	a4,115
    8000213c:	1ce78a63          	beq	a5,a4,80002310 <__printf+0x4b8>
    80002140:	07800713          	li	a4,120
    80002144:	1ee79e63          	bne	a5,a4,80002340 <__printf+0x4e8>
    80002148:	f7843783          	ld	a5,-136(s0)
    8000214c:	0007a703          	lw	a4,0(a5)
    80002150:	00878793          	addi	a5,a5,8
    80002154:	f6f43c23          	sd	a5,-136(s0)
    80002158:	28074263          	bltz	a4,800023dc <__printf+0x584>
    8000215c:	00002d97          	auipc	s11,0x2
    80002160:	01cd8d93          	addi	s11,s11,28 # 80004178 <digits>
    80002164:	00f77793          	andi	a5,a4,15
    80002168:	00fd87b3          	add	a5,s11,a5
    8000216c:	0007c683          	lbu	a3,0(a5)
    80002170:	00f00613          	li	a2,15
    80002174:	0007079b          	sext.w	a5,a4
    80002178:	f8d40023          	sb	a3,-128(s0)
    8000217c:	0047559b          	srliw	a1,a4,0x4
    80002180:	0047569b          	srliw	a3,a4,0x4
    80002184:	00000c93          	li	s9,0
    80002188:	0ee65063          	bge	a2,a4,80002268 <__printf+0x410>
    8000218c:	00f6f693          	andi	a3,a3,15
    80002190:	00dd86b3          	add	a3,s11,a3
    80002194:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002198:	0087d79b          	srliw	a5,a5,0x8
    8000219c:	00100c93          	li	s9,1
    800021a0:	f8d400a3          	sb	a3,-127(s0)
    800021a4:	0cb67263          	bgeu	a2,a1,80002268 <__printf+0x410>
    800021a8:	00f7f693          	andi	a3,a5,15
    800021ac:	00dd86b3          	add	a3,s11,a3
    800021b0:	0006c583          	lbu	a1,0(a3)
    800021b4:	00f00613          	li	a2,15
    800021b8:	0047d69b          	srliw	a3,a5,0x4
    800021bc:	f8b40123          	sb	a1,-126(s0)
    800021c0:	0047d593          	srli	a1,a5,0x4
    800021c4:	28f67e63          	bgeu	a2,a5,80002460 <__printf+0x608>
    800021c8:	00f6f693          	andi	a3,a3,15
    800021cc:	00dd86b3          	add	a3,s11,a3
    800021d0:	0006c503          	lbu	a0,0(a3)
    800021d4:	0087d813          	srli	a6,a5,0x8
    800021d8:	0087d69b          	srliw	a3,a5,0x8
    800021dc:	f8a401a3          	sb	a0,-125(s0)
    800021e0:	28b67663          	bgeu	a2,a1,8000246c <__printf+0x614>
    800021e4:	00f6f693          	andi	a3,a3,15
    800021e8:	00dd86b3          	add	a3,s11,a3
    800021ec:	0006c583          	lbu	a1,0(a3)
    800021f0:	00c7d513          	srli	a0,a5,0xc
    800021f4:	00c7d69b          	srliw	a3,a5,0xc
    800021f8:	f8b40223          	sb	a1,-124(s0)
    800021fc:	29067a63          	bgeu	a2,a6,80002490 <__printf+0x638>
    80002200:	00f6f693          	andi	a3,a3,15
    80002204:	00dd86b3          	add	a3,s11,a3
    80002208:	0006c583          	lbu	a1,0(a3)
    8000220c:	0107d813          	srli	a6,a5,0x10
    80002210:	0107d69b          	srliw	a3,a5,0x10
    80002214:	f8b402a3          	sb	a1,-123(s0)
    80002218:	28a67263          	bgeu	a2,a0,8000249c <__printf+0x644>
    8000221c:	00f6f693          	andi	a3,a3,15
    80002220:	00dd86b3          	add	a3,s11,a3
    80002224:	0006c683          	lbu	a3,0(a3)
    80002228:	0147d79b          	srliw	a5,a5,0x14
    8000222c:	f8d40323          	sb	a3,-122(s0)
    80002230:	21067663          	bgeu	a2,a6,8000243c <__printf+0x5e4>
    80002234:	02079793          	slli	a5,a5,0x20
    80002238:	0207d793          	srli	a5,a5,0x20
    8000223c:	00fd8db3          	add	s11,s11,a5
    80002240:	000dc683          	lbu	a3,0(s11)
    80002244:	00800793          	li	a5,8
    80002248:	00700c93          	li	s9,7
    8000224c:	f8d403a3          	sb	a3,-121(s0)
    80002250:	00075c63          	bgez	a4,80002268 <__printf+0x410>
    80002254:	f9040713          	addi	a4,s0,-112
    80002258:	00f70733          	add	a4,a4,a5
    8000225c:	02d00693          	li	a3,45
    80002260:	fed70823          	sb	a3,-16(a4)
    80002264:	00078c93          	mv	s9,a5
    80002268:	f8040793          	addi	a5,s0,-128
    8000226c:	01978cb3          	add	s9,a5,s9
    80002270:	f7f40d13          	addi	s10,s0,-129
    80002274:	000cc503          	lbu	a0,0(s9)
    80002278:	fffc8c93          	addi	s9,s9,-1
    8000227c:	00000097          	auipc	ra,0x0
    80002280:	9f8080e7          	jalr	-1544(ra) # 80001c74 <consputc>
    80002284:	ff9d18e3          	bne	s10,s9,80002274 <__printf+0x41c>
    80002288:	0100006f          	j	80002298 <__printf+0x440>
    8000228c:	00000097          	auipc	ra,0x0
    80002290:	9e8080e7          	jalr	-1560(ra) # 80001c74 <consputc>
    80002294:	000c8493          	mv	s1,s9
    80002298:	00094503          	lbu	a0,0(s2)
    8000229c:	c60510e3          	bnez	a0,80001efc <__printf+0xa4>
    800022a0:	e40c0ee3          	beqz	s8,800020fc <__printf+0x2a4>
    800022a4:	00003517          	auipc	a0,0x3
    800022a8:	29c50513          	addi	a0,a0,668 # 80005540 <pr>
    800022ac:	00001097          	auipc	ra,0x1
    800022b0:	94c080e7          	jalr	-1716(ra) # 80002bf8 <release>
    800022b4:	e49ff06f          	j	800020fc <__printf+0x2a4>
    800022b8:	f7843783          	ld	a5,-136(s0)
    800022bc:	03000513          	li	a0,48
    800022c0:	01000d13          	li	s10,16
    800022c4:	00878713          	addi	a4,a5,8
    800022c8:	0007bc83          	ld	s9,0(a5)
    800022cc:	f6e43c23          	sd	a4,-136(s0)
    800022d0:	00000097          	auipc	ra,0x0
    800022d4:	9a4080e7          	jalr	-1628(ra) # 80001c74 <consputc>
    800022d8:	07800513          	li	a0,120
    800022dc:	00000097          	auipc	ra,0x0
    800022e0:	998080e7          	jalr	-1640(ra) # 80001c74 <consputc>
    800022e4:	00002d97          	auipc	s11,0x2
    800022e8:	e94d8d93          	addi	s11,s11,-364 # 80004178 <digits>
    800022ec:	03ccd793          	srli	a5,s9,0x3c
    800022f0:	00fd87b3          	add	a5,s11,a5
    800022f4:	0007c503          	lbu	a0,0(a5)
    800022f8:	fffd0d1b          	addiw	s10,s10,-1
    800022fc:	004c9c93          	slli	s9,s9,0x4
    80002300:	00000097          	auipc	ra,0x0
    80002304:	974080e7          	jalr	-1676(ra) # 80001c74 <consputc>
    80002308:	fe0d12e3          	bnez	s10,800022ec <__printf+0x494>
    8000230c:	f8dff06f          	j	80002298 <__printf+0x440>
    80002310:	f7843783          	ld	a5,-136(s0)
    80002314:	0007bc83          	ld	s9,0(a5)
    80002318:	00878793          	addi	a5,a5,8
    8000231c:	f6f43c23          	sd	a5,-136(s0)
    80002320:	000c9a63          	bnez	s9,80002334 <__printf+0x4dc>
    80002324:	1080006f          	j	8000242c <__printf+0x5d4>
    80002328:	001c8c93          	addi	s9,s9,1
    8000232c:	00000097          	auipc	ra,0x0
    80002330:	948080e7          	jalr	-1720(ra) # 80001c74 <consputc>
    80002334:	000cc503          	lbu	a0,0(s9)
    80002338:	fe0518e3          	bnez	a0,80002328 <__printf+0x4d0>
    8000233c:	f5dff06f          	j	80002298 <__printf+0x440>
    80002340:	02500513          	li	a0,37
    80002344:	00000097          	auipc	ra,0x0
    80002348:	930080e7          	jalr	-1744(ra) # 80001c74 <consputc>
    8000234c:	000c8513          	mv	a0,s9
    80002350:	00000097          	auipc	ra,0x0
    80002354:	924080e7          	jalr	-1756(ra) # 80001c74 <consputc>
    80002358:	f41ff06f          	j	80002298 <__printf+0x440>
    8000235c:	02500513          	li	a0,37
    80002360:	00000097          	auipc	ra,0x0
    80002364:	914080e7          	jalr	-1772(ra) # 80001c74 <consputc>
    80002368:	f31ff06f          	j	80002298 <__printf+0x440>
    8000236c:	00030513          	mv	a0,t1
    80002370:	00000097          	auipc	ra,0x0
    80002374:	7bc080e7          	jalr	1980(ra) # 80002b2c <acquire>
    80002378:	b4dff06f          	j	80001ec4 <__printf+0x6c>
    8000237c:	40c0053b          	negw	a0,a2
    80002380:	00a00713          	li	a4,10
    80002384:	02e576bb          	remuw	a3,a0,a4
    80002388:	00002d97          	auipc	s11,0x2
    8000238c:	df0d8d93          	addi	s11,s11,-528 # 80004178 <digits>
    80002390:	ff700593          	li	a1,-9
    80002394:	02069693          	slli	a3,a3,0x20
    80002398:	0206d693          	srli	a3,a3,0x20
    8000239c:	00dd86b3          	add	a3,s11,a3
    800023a0:	0006c683          	lbu	a3,0(a3)
    800023a4:	02e557bb          	divuw	a5,a0,a4
    800023a8:	f8d40023          	sb	a3,-128(s0)
    800023ac:	10b65e63          	bge	a2,a1,800024c8 <__printf+0x670>
    800023b0:	06300593          	li	a1,99
    800023b4:	02e7f6bb          	remuw	a3,a5,a4
    800023b8:	02069693          	slli	a3,a3,0x20
    800023bc:	0206d693          	srli	a3,a3,0x20
    800023c0:	00dd86b3          	add	a3,s11,a3
    800023c4:	0006c683          	lbu	a3,0(a3)
    800023c8:	02e7d73b          	divuw	a4,a5,a4
    800023cc:	00200793          	li	a5,2
    800023d0:	f8d400a3          	sb	a3,-127(s0)
    800023d4:	bca5ece3          	bltu	a1,a0,80001fac <__printf+0x154>
    800023d8:	ce5ff06f          	j	800020bc <__printf+0x264>
    800023dc:	40e007bb          	negw	a5,a4
    800023e0:	00002d97          	auipc	s11,0x2
    800023e4:	d98d8d93          	addi	s11,s11,-616 # 80004178 <digits>
    800023e8:	00f7f693          	andi	a3,a5,15
    800023ec:	00dd86b3          	add	a3,s11,a3
    800023f0:	0006c583          	lbu	a1,0(a3)
    800023f4:	ff100613          	li	a2,-15
    800023f8:	0047d69b          	srliw	a3,a5,0x4
    800023fc:	f8b40023          	sb	a1,-128(s0)
    80002400:	0047d59b          	srliw	a1,a5,0x4
    80002404:	0ac75e63          	bge	a4,a2,800024c0 <__printf+0x668>
    80002408:	00f6f693          	andi	a3,a3,15
    8000240c:	00dd86b3          	add	a3,s11,a3
    80002410:	0006c603          	lbu	a2,0(a3)
    80002414:	00f00693          	li	a3,15
    80002418:	0087d79b          	srliw	a5,a5,0x8
    8000241c:	f8c400a3          	sb	a2,-127(s0)
    80002420:	d8b6e4e3          	bltu	a3,a1,800021a8 <__printf+0x350>
    80002424:	00200793          	li	a5,2
    80002428:	e2dff06f          	j	80002254 <__printf+0x3fc>
    8000242c:	00002c97          	auipc	s9,0x2
    80002430:	d2cc8c93          	addi	s9,s9,-724 # 80004158 <CONSOLE_STATUS+0x148>
    80002434:	02800513          	li	a0,40
    80002438:	ef1ff06f          	j	80002328 <__printf+0x4d0>
    8000243c:	00700793          	li	a5,7
    80002440:	00600c93          	li	s9,6
    80002444:	e0dff06f          	j	80002250 <__printf+0x3f8>
    80002448:	00700793          	li	a5,7
    8000244c:	00600c93          	li	s9,6
    80002450:	c69ff06f          	j	800020b8 <__printf+0x260>
    80002454:	00300793          	li	a5,3
    80002458:	00200c93          	li	s9,2
    8000245c:	c5dff06f          	j	800020b8 <__printf+0x260>
    80002460:	00300793          	li	a5,3
    80002464:	00200c93          	li	s9,2
    80002468:	de9ff06f          	j	80002250 <__printf+0x3f8>
    8000246c:	00400793          	li	a5,4
    80002470:	00300c93          	li	s9,3
    80002474:	dddff06f          	j	80002250 <__printf+0x3f8>
    80002478:	00400793          	li	a5,4
    8000247c:	00300c93          	li	s9,3
    80002480:	c39ff06f          	j	800020b8 <__printf+0x260>
    80002484:	00500793          	li	a5,5
    80002488:	00400c93          	li	s9,4
    8000248c:	c2dff06f          	j	800020b8 <__printf+0x260>
    80002490:	00500793          	li	a5,5
    80002494:	00400c93          	li	s9,4
    80002498:	db9ff06f          	j	80002250 <__printf+0x3f8>
    8000249c:	00600793          	li	a5,6
    800024a0:	00500c93          	li	s9,5
    800024a4:	dadff06f          	j	80002250 <__printf+0x3f8>
    800024a8:	00600793          	li	a5,6
    800024ac:	00500c93          	li	s9,5
    800024b0:	c09ff06f          	j	800020b8 <__printf+0x260>
    800024b4:	00800793          	li	a5,8
    800024b8:	00700c93          	li	s9,7
    800024bc:	bfdff06f          	j	800020b8 <__printf+0x260>
    800024c0:	00100793          	li	a5,1
    800024c4:	d91ff06f          	j	80002254 <__printf+0x3fc>
    800024c8:	00100793          	li	a5,1
    800024cc:	bf1ff06f          	j	800020bc <__printf+0x264>
    800024d0:	00900793          	li	a5,9
    800024d4:	00800c93          	li	s9,8
    800024d8:	be1ff06f          	j	800020b8 <__printf+0x260>
    800024dc:	00002517          	auipc	a0,0x2
    800024e0:	c8450513          	addi	a0,a0,-892 # 80004160 <CONSOLE_STATUS+0x150>
    800024e4:	00000097          	auipc	ra,0x0
    800024e8:	918080e7          	jalr	-1768(ra) # 80001dfc <panic>

00000000800024ec <printfinit>:
    800024ec:	fe010113          	addi	sp,sp,-32
    800024f0:	00813823          	sd	s0,16(sp)
    800024f4:	00913423          	sd	s1,8(sp)
    800024f8:	00113c23          	sd	ra,24(sp)
    800024fc:	02010413          	addi	s0,sp,32
    80002500:	00003497          	auipc	s1,0x3
    80002504:	04048493          	addi	s1,s1,64 # 80005540 <pr>
    80002508:	00048513          	mv	a0,s1
    8000250c:	00002597          	auipc	a1,0x2
    80002510:	c6458593          	addi	a1,a1,-924 # 80004170 <CONSOLE_STATUS+0x160>
    80002514:	00000097          	auipc	ra,0x0
    80002518:	5f4080e7          	jalr	1524(ra) # 80002b08 <initlock>
    8000251c:	01813083          	ld	ra,24(sp)
    80002520:	01013403          	ld	s0,16(sp)
    80002524:	0004ac23          	sw	zero,24(s1)
    80002528:	00813483          	ld	s1,8(sp)
    8000252c:	02010113          	addi	sp,sp,32
    80002530:	00008067          	ret

0000000080002534 <uartinit>:
    80002534:	ff010113          	addi	sp,sp,-16
    80002538:	00813423          	sd	s0,8(sp)
    8000253c:	01010413          	addi	s0,sp,16
    80002540:	100007b7          	lui	a5,0x10000
    80002544:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002548:	f8000713          	li	a4,-128
    8000254c:	00e781a3          	sb	a4,3(a5)
    80002550:	00300713          	li	a4,3
    80002554:	00e78023          	sb	a4,0(a5)
    80002558:	000780a3          	sb	zero,1(a5)
    8000255c:	00e781a3          	sb	a4,3(a5)
    80002560:	00700693          	li	a3,7
    80002564:	00d78123          	sb	a3,2(a5)
    80002568:	00e780a3          	sb	a4,1(a5)
    8000256c:	00813403          	ld	s0,8(sp)
    80002570:	01010113          	addi	sp,sp,16
    80002574:	00008067          	ret

0000000080002578 <uartputc>:
    80002578:	00002797          	auipc	a5,0x2
    8000257c:	d807a783          	lw	a5,-640(a5) # 800042f8 <panicked>
    80002580:	00078463          	beqz	a5,80002588 <uartputc+0x10>
    80002584:	0000006f          	j	80002584 <uartputc+0xc>
    80002588:	fd010113          	addi	sp,sp,-48
    8000258c:	02813023          	sd	s0,32(sp)
    80002590:	00913c23          	sd	s1,24(sp)
    80002594:	01213823          	sd	s2,16(sp)
    80002598:	01313423          	sd	s3,8(sp)
    8000259c:	02113423          	sd	ra,40(sp)
    800025a0:	03010413          	addi	s0,sp,48
    800025a4:	00002917          	auipc	s2,0x2
    800025a8:	d5c90913          	addi	s2,s2,-676 # 80004300 <uart_tx_r>
    800025ac:	00093783          	ld	a5,0(s2)
    800025b0:	00002497          	auipc	s1,0x2
    800025b4:	d5848493          	addi	s1,s1,-680 # 80004308 <uart_tx_w>
    800025b8:	0004b703          	ld	a4,0(s1)
    800025bc:	02078693          	addi	a3,a5,32
    800025c0:	00050993          	mv	s3,a0
    800025c4:	02e69c63          	bne	a3,a4,800025fc <uartputc+0x84>
    800025c8:	00001097          	auipc	ra,0x1
    800025cc:	834080e7          	jalr	-1996(ra) # 80002dfc <push_on>
    800025d0:	00093783          	ld	a5,0(s2)
    800025d4:	0004b703          	ld	a4,0(s1)
    800025d8:	02078793          	addi	a5,a5,32
    800025dc:	00e79463          	bne	a5,a4,800025e4 <uartputc+0x6c>
    800025e0:	0000006f          	j	800025e0 <uartputc+0x68>
    800025e4:	00001097          	auipc	ra,0x1
    800025e8:	88c080e7          	jalr	-1908(ra) # 80002e70 <pop_on>
    800025ec:	00093783          	ld	a5,0(s2)
    800025f0:	0004b703          	ld	a4,0(s1)
    800025f4:	02078693          	addi	a3,a5,32
    800025f8:	fce688e3          	beq	a3,a4,800025c8 <uartputc+0x50>
    800025fc:	01f77693          	andi	a3,a4,31
    80002600:	00003597          	auipc	a1,0x3
    80002604:	f6058593          	addi	a1,a1,-160 # 80005560 <uart_tx_buf>
    80002608:	00d586b3          	add	a3,a1,a3
    8000260c:	00170713          	addi	a4,a4,1
    80002610:	01368023          	sb	s3,0(a3)
    80002614:	00e4b023          	sd	a4,0(s1)
    80002618:	10000637          	lui	a2,0x10000
    8000261c:	02f71063          	bne	a4,a5,8000263c <uartputc+0xc4>
    80002620:	0340006f          	j	80002654 <uartputc+0xdc>
    80002624:	00074703          	lbu	a4,0(a4)
    80002628:	00f93023          	sd	a5,0(s2)
    8000262c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002630:	00093783          	ld	a5,0(s2)
    80002634:	0004b703          	ld	a4,0(s1)
    80002638:	00f70e63          	beq	a4,a5,80002654 <uartputc+0xdc>
    8000263c:	00564683          	lbu	a3,5(a2)
    80002640:	01f7f713          	andi	a4,a5,31
    80002644:	00e58733          	add	a4,a1,a4
    80002648:	0206f693          	andi	a3,a3,32
    8000264c:	00178793          	addi	a5,a5,1
    80002650:	fc069ae3          	bnez	a3,80002624 <uartputc+0xac>
    80002654:	02813083          	ld	ra,40(sp)
    80002658:	02013403          	ld	s0,32(sp)
    8000265c:	01813483          	ld	s1,24(sp)
    80002660:	01013903          	ld	s2,16(sp)
    80002664:	00813983          	ld	s3,8(sp)
    80002668:	03010113          	addi	sp,sp,48
    8000266c:	00008067          	ret

0000000080002670 <uartputc_sync>:
    80002670:	ff010113          	addi	sp,sp,-16
    80002674:	00813423          	sd	s0,8(sp)
    80002678:	01010413          	addi	s0,sp,16
    8000267c:	00002717          	auipc	a4,0x2
    80002680:	c7c72703          	lw	a4,-900(a4) # 800042f8 <panicked>
    80002684:	02071663          	bnez	a4,800026b0 <uartputc_sync+0x40>
    80002688:	00050793          	mv	a5,a0
    8000268c:	100006b7          	lui	a3,0x10000
    80002690:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002694:	02077713          	andi	a4,a4,32
    80002698:	fe070ce3          	beqz	a4,80002690 <uartputc_sync+0x20>
    8000269c:	0ff7f793          	andi	a5,a5,255
    800026a0:	00f68023          	sb	a5,0(a3)
    800026a4:	00813403          	ld	s0,8(sp)
    800026a8:	01010113          	addi	sp,sp,16
    800026ac:	00008067          	ret
    800026b0:	0000006f          	j	800026b0 <uartputc_sync+0x40>

00000000800026b4 <uartstart>:
    800026b4:	ff010113          	addi	sp,sp,-16
    800026b8:	00813423          	sd	s0,8(sp)
    800026bc:	01010413          	addi	s0,sp,16
    800026c0:	00002617          	auipc	a2,0x2
    800026c4:	c4060613          	addi	a2,a2,-960 # 80004300 <uart_tx_r>
    800026c8:	00002517          	auipc	a0,0x2
    800026cc:	c4050513          	addi	a0,a0,-960 # 80004308 <uart_tx_w>
    800026d0:	00063783          	ld	a5,0(a2)
    800026d4:	00053703          	ld	a4,0(a0)
    800026d8:	04f70263          	beq	a4,a5,8000271c <uartstart+0x68>
    800026dc:	100005b7          	lui	a1,0x10000
    800026e0:	00003817          	auipc	a6,0x3
    800026e4:	e8080813          	addi	a6,a6,-384 # 80005560 <uart_tx_buf>
    800026e8:	01c0006f          	j	80002704 <uartstart+0x50>
    800026ec:	0006c703          	lbu	a4,0(a3)
    800026f0:	00f63023          	sd	a5,0(a2)
    800026f4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800026f8:	00063783          	ld	a5,0(a2)
    800026fc:	00053703          	ld	a4,0(a0)
    80002700:	00f70e63          	beq	a4,a5,8000271c <uartstart+0x68>
    80002704:	01f7f713          	andi	a4,a5,31
    80002708:	00e806b3          	add	a3,a6,a4
    8000270c:	0055c703          	lbu	a4,5(a1)
    80002710:	00178793          	addi	a5,a5,1
    80002714:	02077713          	andi	a4,a4,32
    80002718:	fc071ae3          	bnez	a4,800026ec <uartstart+0x38>
    8000271c:	00813403          	ld	s0,8(sp)
    80002720:	01010113          	addi	sp,sp,16
    80002724:	00008067          	ret

0000000080002728 <uartgetc>:
    80002728:	ff010113          	addi	sp,sp,-16
    8000272c:	00813423          	sd	s0,8(sp)
    80002730:	01010413          	addi	s0,sp,16
    80002734:	10000737          	lui	a4,0x10000
    80002738:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000273c:	0017f793          	andi	a5,a5,1
    80002740:	00078c63          	beqz	a5,80002758 <uartgetc+0x30>
    80002744:	00074503          	lbu	a0,0(a4)
    80002748:	0ff57513          	andi	a0,a0,255
    8000274c:	00813403          	ld	s0,8(sp)
    80002750:	01010113          	addi	sp,sp,16
    80002754:	00008067          	ret
    80002758:	fff00513          	li	a0,-1
    8000275c:	ff1ff06f          	j	8000274c <uartgetc+0x24>

0000000080002760 <uartintr>:
    80002760:	100007b7          	lui	a5,0x10000
    80002764:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002768:	0017f793          	andi	a5,a5,1
    8000276c:	0a078463          	beqz	a5,80002814 <uartintr+0xb4>
    80002770:	fe010113          	addi	sp,sp,-32
    80002774:	00813823          	sd	s0,16(sp)
    80002778:	00913423          	sd	s1,8(sp)
    8000277c:	00113c23          	sd	ra,24(sp)
    80002780:	02010413          	addi	s0,sp,32
    80002784:	100004b7          	lui	s1,0x10000
    80002788:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000278c:	0ff57513          	andi	a0,a0,255
    80002790:	fffff097          	auipc	ra,0xfffff
    80002794:	534080e7          	jalr	1332(ra) # 80001cc4 <consoleintr>
    80002798:	0054c783          	lbu	a5,5(s1)
    8000279c:	0017f793          	andi	a5,a5,1
    800027a0:	fe0794e3          	bnez	a5,80002788 <uartintr+0x28>
    800027a4:	00002617          	auipc	a2,0x2
    800027a8:	b5c60613          	addi	a2,a2,-1188 # 80004300 <uart_tx_r>
    800027ac:	00002517          	auipc	a0,0x2
    800027b0:	b5c50513          	addi	a0,a0,-1188 # 80004308 <uart_tx_w>
    800027b4:	00063783          	ld	a5,0(a2)
    800027b8:	00053703          	ld	a4,0(a0)
    800027bc:	04f70263          	beq	a4,a5,80002800 <uartintr+0xa0>
    800027c0:	100005b7          	lui	a1,0x10000
    800027c4:	00003817          	auipc	a6,0x3
    800027c8:	d9c80813          	addi	a6,a6,-612 # 80005560 <uart_tx_buf>
    800027cc:	01c0006f          	j	800027e8 <uartintr+0x88>
    800027d0:	0006c703          	lbu	a4,0(a3)
    800027d4:	00f63023          	sd	a5,0(a2)
    800027d8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800027dc:	00063783          	ld	a5,0(a2)
    800027e0:	00053703          	ld	a4,0(a0)
    800027e4:	00f70e63          	beq	a4,a5,80002800 <uartintr+0xa0>
    800027e8:	01f7f713          	andi	a4,a5,31
    800027ec:	00e806b3          	add	a3,a6,a4
    800027f0:	0055c703          	lbu	a4,5(a1)
    800027f4:	00178793          	addi	a5,a5,1
    800027f8:	02077713          	andi	a4,a4,32
    800027fc:	fc071ae3          	bnez	a4,800027d0 <uartintr+0x70>
    80002800:	01813083          	ld	ra,24(sp)
    80002804:	01013403          	ld	s0,16(sp)
    80002808:	00813483          	ld	s1,8(sp)
    8000280c:	02010113          	addi	sp,sp,32
    80002810:	00008067          	ret
    80002814:	00002617          	auipc	a2,0x2
    80002818:	aec60613          	addi	a2,a2,-1300 # 80004300 <uart_tx_r>
    8000281c:	00002517          	auipc	a0,0x2
    80002820:	aec50513          	addi	a0,a0,-1300 # 80004308 <uart_tx_w>
    80002824:	00063783          	ld	a5,0(a2)
    80002828:	00053703          	ld	a4,0(a0)
    8000282c:	04f70263          	beq	a4,a5,80002870 <uartintr+0x110>
    80002830:	100005b7          	lui	a1,0x10000
    80002834:	00003817          	auipc	a6,0x3
    80002838:	d2c80813          	addi	a6,a6,-724 # 80005560 <uart_tx_buf>
    8000283c:	01c0006f          	j	80002858 <uartintr+0xf8>
    80002840:	0006c703          	lbu	a4,0(a3)
    80002844:	00f63023          	sd	a5,0(a2)
    80002848:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000284c:	00063783          	ld	a5,0(a2)
    80002850:	00053703          	ld	a4,0(a0)
    80002854:	02f70063          	beq	a4,a5,80002874 <uartintr+0x114>
    80002858:	01f7f713          	andi	a4,a5,31
    8000285c:	00e806b3          	add	a3,a6,a4
    80002860:	0055c703          	lbu	a4,5(a1)
    80002864:	00178793          	addi	a5,a5,1
    80002868:	02077713          	andi	a4,a4,32
    8000286c:	fc071ae3          	bnez	a4,80002840 <uartintr+0xe0>
    80002870:	00008067          	ret
    80002874:	00008067          	ret

0000000080002878 <kinit>:
    80002878:	fc010113          	addi	sp,sp,-64
    8000287c:	02913423          	sd	s1,40(sp)
    80002880:	fffff7b7          	lui	a5,0xfffff
    80002884:	00004497          	auipc	s1,0x4
    80002888:	cfb48493          	addi	s1,s1,-773 # 8000657f <end+0xfff>
    8000288c:	02813823          	sd	s0,48(sp)
    80002890:	01313c23          	sd	s3,24(sp)
    80002894:	00f4f4b3          	and	s1,s1,a5
    80002898:	02113c23          	sd	ra,56(sp)
    8000289c:	03213023          	sd	s2,32(sp)
    800028a0:	01413823          	sd	s4,16(sp)
    800028a4:	01513423          	sd	s5,8(sp)
    800028a8:	04010413          	addi	s0,sp,64
    800028ac:	000017b7          	lui	a5,0x1
    800028b0:	01100993          	li	s3,17
    800028b4:	00f487b3          	add	a5,s1,a5
    800028b8:	01b99993          	slli	s3,s3,0x1b
    800028bc:	06f9e063          	bltu	s3,a5,8000291c <kinit+0xa4>
    800028c0:	00003a97          	auipc	s5,0x3
    800028c4:	cc0a8a93          	addi	s5,s5,-832 # 80005580 <end>
    800028c8:	0754ec63          	bltu	s1,s5,80002940 <kinit+0xc8>
    800028cc:	0734fa63          	bgeu	s1,s3,80002940 <kinit+0xc8>
    800028d0:	00088a37          	lui	s4,0x88
    800028d4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800028d8:	00002917          	auipc	s2,0x2
    800028dc:	a3890913          	addi	s2,s2,-1480 # 80004310 <kmem>
    800028e0:	00ca1a13          	slli	s4,s4,0xc
    800028e4:	0140006f          	j	800028f8 <kinit+0x80>
    800028e8:	000017b7          	lui	a5,0x1
    800028ec:	00f484b3          	add	s1,s1,a5
    800028f0:	0554e863          	bltu	s1,s5,80002940 <kinit+0xc8>
    800028f4:	0534f663          	bgeu	s1,s3,80002940 <kinit+0xc8>
    800028f8:	00001637          	lui	a2,0x1
    800028fc:	00100593          	li	a1,1
    80002900:	00048513          	mv	a0,s1
    80002904:	00000097          	auipc	ra,0x0
    80002908:	5e4080e7          	jalr	1508(ra) # 80002ee8 <__memset>
    8000290c:	00093783          	ld	a5,0(s2)
    80002910:	00f4b023          	sd	a5,0(s1)
    80002914:	00993023          	sd	s1,0(s2)
    80002918:	fd4498e3          	bne	s1,s4,800028e8 <kinit+0x70>
    8000291c:	03813083          	ld	ra,56(sp)
    80002920:	03013403          	ld	s0,48(sp)
    80002924:	02813483          	ld	s1,40(sp)
    80002928:	02013903          	ld	s2,32(sp)
    8000292c:	01813983          	ld	s3,24(sp)
    80002930:	01013a03          	ld	s4,16(sp)
    80002934:	00813a83          	ld	s5,8(sp)
    80002938:	04010113          	addi	sp,sp,64
    8000293c:	00008067          	ret
    80002940:	00002517          	auipc	a0,0x2
    80002944:	85050513          	addi	a0,a0,-1968 # 80004190 <digits+0x18>
    80002948:	fffff097          	auipc	ra,0xfffff
    8000294c:	4b4080e7          	jalr	1204(ra) # 80001dfc <panic>

0000000080002950 <freerange>:
    80002950:	fc010113          	addi	sp,sp,-64
    80002954:	000017b7          	lui	a5,0x1
    80002958:	02913423          	sd	s1,40(sp)
    8000295c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002960:	009504b3          	add	s1,a0,s1
    80002964:	fffff537          	lui	a0,0xfffff
    80002968:	02813823          	sd	s0,48(sp)
    8000296c:	02113c23          	sd	ra,56(sp)
    80002970:	03213023          	sd	s2,32(sp)
    80002974:	01313c23          	sd	s3,24(sp)
    80002978:	01413823          	sd	s4,16(sp)
    8000297c:	01513423          	sd	s5,8(sp)
    80002980:	01613023          	sd	s6,0(sp)
    80002984:	04010413          	addi	s0,sp,64
    80002988:	00a4f4b3          	and	s1,s1,a0
    8000298c:	00f487b3          	add	a5,s1,a5
    80002990:	06f5e463          	bltu	a1,a5,800029f8 <freerange+0xa8>
    80002994:	00003a97          	auipc	s5,0x3
    80002998:	beca8a93          	addi	s5,s5,-1044 # 80005580 <end>
    8000299c:	0954e263          	bltu	s1,s5,80002a20 <freerange+0xd0>
    800029a0:	01100993          	li	s3,17
    800029a4:	01b99993          	slli	s3,s3,0x1b
    800029a8:	0734fc63          	bgeu	s1,s3,80002a20 <freerange+0xd0>
    800029ac:	00058a13          	mv	s4,a1
    800029b0:	00002917          	auipc	s2,0x2
    800029b4:	96090913          	addi	s2,s2,-1696 # 80004310 <kmem>
    800029b8:	00002b37          	lui	s6,0x2
    800029bc:	0140006f          	j	800029d0 <freerange+0x80>
    800029c0:	000017b7          	lui	a5,0x1
    800029c4:	00f484b3          	add	s1,s1,a5
    800029c8:	0554ec63          	bltu	s1,s5,80002a20 <freerange+0xd0>
    800029cc:	0534fa63          	bgeu	s1,s3,80002a20 <freerange+0xd0>
    800029d0:	00001637          	lui	a2,0x1
    800029d4:	00100593          	li	a1,1
    800029d8:	00048513          	mv	a0,s1
    800029dc:	00000097          	auipc	ra,0x0
    800029e0:	50c080e7          	jalr	1292(ra) # 80002ee8 <__memset>
    800029e4:	00093703          	ld	a4,0(s2)
    800029e8:	016487b3          	add	a5,s1,s6
    800029ec:	00e4b023          	sd	a4,0(s1)
    800029f0:	00993023          	sd	s1,0(s2)
    800029f4:	fcfa76e3          	bgeu	s4,a5,800029c0 <freerange+0x70>
    800029f8:	03813083          	ld	ra,56(sp)
    800029fc:	03013403          	ld	s0,48(sp)
    80002a00:	02813483          	ld	s1,40(sp)
    80002a04:	02013903          	ld	s2,32(sp)
    80002a08:	01813983          	ld	s3,24(sp)
    80002a0c:	01013a03          	ld	s4,16(sp)
    80002a10:	00813a83          	ld	s5,8(sp)
    80002a14:	00013b03          	ld	s6,0(sp)
    80002a18:	04010113          	addi	sp,sp,64
    80002a1c:	00008067          	ret
    80002a20:	00001517          	auipc	a0,0x1
    80002a24:	77050513          	addi	a0,a0,1904 # 80004190 <digits+0x18>
    80002a28:	fffff097          	auipc	ra,0xfffff
    80002a2c:	3d4080e7          	jalr	980(ra) # 80001dfc <panic>

0000000080002a30 <kfree>:
    80002a30:	fe010113          	addi	sp,sp,-32
    80002a34:	00813823          	sd	s0,16(sp)
    80002a38:	00113c23          	sd	ra,24(sp)
    80002a3c:	00913423          	sd	s1,8(sp)
    80002a40:	02010413          	addi	s0,sp,32
    80002a44:	03451793          	slli	a5,a0,0x34
    80002a48:	04079c63          	bnez	a5,80002aa0 <kfree+0x70>
    80002a4c:	00003797          	auipc	a5,0x3
    80002a50:	b3478793          	addi	a5,a5,-1228 # 80005580 <end>
    80002a54:	00050493          	mv	s1,a0
    80002a58:	04f56463          	bltu	a0,a5,80002aa0 <kfree+0x70>
    80002a5c:	01100793          	li	a5,17
    80002a60:	01b79793          	slli	a5,a5,0x1b
    80002a64:	02f57e63          	bgeu	a0,a5,80002aa0 <kfree+0x70>
    80002a68:	00001637          	lui	a2,0x1
    80002a6c:	00100593          	li	a1,1
    80002a70:	00000097          	auipc	ra,0x0
    80002a74:	478080e7          	jalr	1144(ra) # 80002ee8 <__memset>
    80002a78:	00002797          	auipc	a5,0x2
    80002a7c:	89878793          	addi	a5,a5,-1896 # 80004310 <kmem>
    80002a80:	0007b703          	ld	a4,0(a5)
    80002a84:	01813083          	ld	ra,24(sp)
    80002a88:	01013403          	ld	s0,16(sp)
    80002a8c:	00e4b023          	sd	a4,0(s1)
    80002a90:	0097b023          	sd	s1,0(a5)
    80002a94:	00813483          	ld	s1,8(sp)
    80002a98:	02010113          	addi	sp,sp,32
    80002a9c:	00008067          	ret
    80002aa0:	00001517          	auipc	a0,0x1
    80002aa4:	6f050513          	addi	a0,a0,1776 # 80004190 <digits+0x18>
    80002aa8:	fffff097          	auipc	ra,0xfffff
    80002aac:	354080e7          	jalr	852(ra) # 80001dfc <panic>

0000000080002ab0 <kalloc>:
    80002ab0:	fe010113          	addi	sp,sp,-32
    80002ab4:	00813823          	sd	s0,16(sp)
    80002ab8:	00913423          	sd	s1,8(sp)
    80002abc:	00113c23          	sd	ra,24(sp)
    80002ac0:	02010413          	addi	s0,sp,32
    80002ac4:	00002797          	auipc	a5,0x2
    80002ac8:	84c78793          	addi	a5,a5,-1972 # 80004310 <kmem>
    80002acc:	0007b483          	ld	s1,0(a5)
    80002ad0:	02048063          	beqz	s1,80002af0 <kalloc+0x40>
    80002ad4:	0004b703          	ld	a4,0(s1)
    80002ad8:	00001637          	lui	a2,0x1
    80002adc:	00500593          	li	a1,5
    80002ae0:	00048513          	mv	a0,s1
    80002ae4:	00e7b023          	sd	a4,0(a5)
    80002ae8:	00000097          	auipc	ra,0x0
    80002aec:	400080e7          	jalr	1024(ra) # 80002ee8 <__memset>
    80002af0:	01813083          	ld	ra,24(sp)
    80002af4:	01013403          	ld	s0,16(sp)
    80002af8:	00048513          	mv	a0,s1
    80002afc:	00813483          	ld	s1,8(sp)
    80002b00:	02010113          	addi	sp,sp,32
    80002b04:	00008067          	ret

0000000080002b08 <initlock>:
    80002b08:	ff010113          	addi	sp,sp,-16
    80002b0c:	00813423          	sd	s0,8(sp)
    80002b10:	01010413          	addi	s0,sp,16
    80002b14:	00813403          	ld	s0,8(sp)
    80002b18:	00b53423          	sd	a1,8(a0)
    80002b1c:	00052023          	sw	zero,0(a0)
    80002b20:	00053823          	sd	zero,16(a0)
    80002b24:	01010113          	addi	sp,sp,16
    80002b28:	00008067          	ret

0000000080002b2c <acquire>:
    80002b2c:	fe010113          	addi	sp,sp,-32
    80002b30:	00813823          	sd	s0,16(sp)
    80002b34:	00913423          	sd	s1,8(sp)
    80002b38:	00113c23          	sd	ra,24(sp)
    80002b3c:	01213023          	sd	s2,0(sp)
    80002b40:	02010413          	addi	s0,sp,32
    80002b44:	00050493          	mv	s1,a0
    80002b48:	10002973          	csrr	s2,sstatus
    80002b4c:	100027f3          	csrr	a5,sstatus
    80002b50:	ffd7f793          	andi	a5,a5,-3
    80002b54:	10079073          	csrw	sstatus,a5
    80002b58:	fffff097          	auipc	ra,0xfffff
    80002b5c:	8e8080e7          	jalr	-1816(ra) # 80001440 <mycpu>
    80002b60:	07852783          	lw	a5,120(a0)
    80002b64:	06078e63          	beqz	a5,80002be0 <acquire+0xb4>
    80002b68:	fffff097          	auipc	ra,0xfffff
    80002b6c:	8d8080e7          	jalr	-1832(ra) # 80001440 <mycpu>
    80002b70:	07852783          	lw	a5,120(a0)
    80002b74:	0004a703          	lw	a4,0(s1)
    80002b78:	0017879b          	addiw	a5,a5,1
    80002b7c:	06f52c23          	sw	a5,120(a0)
    80002b80:	04071063          	bnez	a4,80002bc0 <acquire+0x94>
    80002b84:	00100713          	li	a4,1
    80002b88:	00070793          	mv	a5,a4
    80002b8c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002b90:	0007879b          	sext.w	a5,a5
    80002b94:	fe079ae3          	bnez	a5,80002b88 <acquire+0x5c>
    80002b98:	0ff0000f          	fence
    80002b9c:	fffff097          	auipc	ra,0xfffff
    80002ba0:	8a4080e7          	jalr	-1884(ra) # 80001440 <mycpu>
    80002ba4:	01813083          	ld	ra,24(sp)
    80002ba8:	01013403          	ld	s0,16(sp)
    80002bac:	00a4b823          	sd	a0,16(s1)
    80002bb0:	00013903          	ld	s2,0(sp)
    80002bb4:	00813483          	ld	s1,8(sp)
    80002bb8:	02010113          	addi	sp,sp,32
    80002bbc:	00008067          	ret
    80002bc0:	0104b903          	ld	s2,16(s1)
    80002bc4:	fffff097          	auipc	ra,0xfffff
    80002bc8:	87c080e7          	jalr	-1924(ra) # 80001440 <mycpu>
    80002bcc:	faa91ce3          	bne	s2,a0,80002b84 <acquire+0x58>
    80002bd0:	00001517          	auipc	a0,0x1
    80002bd4:	5c850513          	addi	a0,a0,1480 # 80004198 <digits+0x20>
    80002bd8:	fffff097          	auipc	ra,0xfffff
    80002bdc:	224080e7          	jalr	548(ra) # 80001dfc <panic>
    80002be0:	00195913          	srli	s2,s2,0x1
    80002be4:	fffff097          	auipc	ra,0xfffff
    80002be8:	85c080e7          	jalr	-1956(ra) # 80001440 <mycpu>
    80002bec:	00197913          	andi	s2,s2,1
    80002bf0:	07252e23          	sw	s2,124(a0)
    80002bf4:	f75ff06f          	j	80002b68 <acquire+0x3c>

0000000080002bf8 <release>:
    80002bf8:	fe010113          	addi	sp,sp,-32
    80002bfc:	00813823          	sd	s0,16(sp)
    80002c00:	00113c23          	sd	ra,24(sp)
    80002c04:	00913423          	sd	s1,8(sp)
    80002c08:	01213023          	sd	s2,0(sp)
    80002c0c:	02010413          	addi	s0,sp,32
    80002c10:	00052783          	lw	a5,0(a0)
    80002c14:	00079a63          	bnez	a5,80002c28 <release+0x30>
    80002c18:	00001517          	auipc	a0,0x1
    80002c1c:	58850513          	addi	a0,a0,1416 # 800041a0 <digits+0x28>
    80002c20:	fffff097          	auipc	ra,0xfffff
    80002c24:	1dc080e7          	jalr	476(ra) # 80001dfc <panic>
    80002c28:	01053903          	ld	s2,16(a0)
    80002c2c:	00050493          	mv	s1,a0
    80002c30:	fffff097          	auipc	ra,0xfffff
    80002c34:	810080e7          	jalr	-2032(ra) # 80001440 <mycpu>
    80002c38:	fea910e3          	bne	s2,a0,80002c18 <release+0x20>
    80002c3c:	0004b823          	sd	zero,16(s1)
    80002c40:	0ff0000f          	fence
    80002c44:	0f50000f          	fence	iorw,ow
    80002c48:	0804a02f          	amoswap.w	zero,zero,(s1)
    80002c4c:	ffffe097          	auipc	ra,0xffffe
    80002c50:	7f4080e7          	jalr	2036(ra) # 80001440 <mycpu>
    80002c54:	100027f3          	csrr	a5,sstatus
    80002c58:	0027f793          	andi	a5,a5,2
    80002c5c:	04079a63          	bnez	a5,80002cb0 <release+0xb8>
    80002c60:	07852783          	lw	a5,120(a0)
    80002c64:	02f05e63          	blez	a5,80002ca0 <release+0xa8>
    80002c68:	fff7871b          	addiw	a4,a5,-1
    80002c6c:	06e52c23          	sw	a4,120(a0)
    80002c70:	00071c63          	bnez	a4,80002c88 <release+0x90>
    80002c74:	07c52783          	lw	a5,124(a0)
    80002c78:	00078863          	beqz	a5,80002c88 <release+0x90>
    80002c7c:	100027f3          	csrr	a5,sstatus
    80002c80:	0027e793          	ori	a5,a5,2
    80002c84:	10079073          	csrw	sstatus,a5
    80002c88:	01813083          	ld	ra,24(sp)
    80002c8c:	01013403          	ld	s0,16(sp)
    80002c90:	00813483          	ld	s1,8(sp)
    80002c94:	00013903          	ld	s2,0(sp)
    80002c98:	02010113          	addi	sp,sp,32
    80002c9c:	00008067          	ret
    80002ca0:	00001517          	auipc	a0,0x1
    80002ca4:	52050513          	addi	a0,a0,1312 # 800041c0 <digits+0x48>
    80002ca8:	fffff097          	auipc	ra,0xfffff
    80002cac:	154080e7          	jalr	340(ra) # 80001dfc <panic>
    80002cb0:	00001517          	auipc	a0,0x1
    80002cb4:	4f850513          	addi	a0,a0,1272 # 800041a8 <digits+0x30>
    80002cb8:	fffff097          	auipc	ra,0xfffff
    80002cbc:	144080e7          	jalr	324(ra) # 80001dfc <panic>

0000000080002cc0 <holding>:
    80002cc0:	00052783          	lw	a5,0(a0)
    80002cc4:	00079663          	bnez	a5,80002cd0 <holding+0x10>
    80002cc8:	00000513          	li	a0,0
    80002ccc:	00008067          	ret
    80002cd0:	fe010113          	addi	sp,sp,-32
    80002cd4:	00813823          	sd	s0,16(sp)
    80002cd8:	00913423          	sd	s1,8(sp)
    80002cdc:	00113c23          	sd	ra,24(sp)
    80002ce0:	02010413          	addi	s0,sp,32
    80002ce4:	01053483          	ld	s1,16(a0)
    80002ce8:	ffffe097          	auipc	ra,0xffffe
    80002cec:	758080e7          	jalr	1880(ra) # 80001440 <mycpu>
    80002cf0:	01813083          	ld	ra,24(sp)
    80002cf4:	01013403          	ld	s0,16(sp)
    80002cf8:	40a48533          	sub	a0,s1,a0
    80002cfc:	00153513          	seqz	a0,a0
    80002d00:	00813483          	ld	s1,8(sp)
    80002d04:	02010113          	addi	sp,sp,32
    80002d08:	00008067          	ret

0000000080002d0c <push_off>:
    80002d0c:	fe010113          	addi	sp,sp,-32
    80002d10:	00813823          	sd	s0,16(sp)
    80002d14:	00113c23          	sd	ra,24(sp)
    80002d18:	00913423          	sd	s1,8(sp)
    80002d1c:	02010413          	addi	s0,sp,32
    80002d20:	100024f3          	csrr	s1,sstatus
    80002d24:	100027f3          	csrr	a5,sstatus
    80002d28:	ffd7f793          	andi	a5,a5,-3
    80002d2c:	10079073          	csrw	sstatus,a5
    80002d30:	ffffe097          	auipc	ra,0xffffe
    80002d34:	710080e7          	jalr	1808(ra) # 80001440 <mycpu>
    80002d38:	07852783          	lw	a5,120(a0)
    80002d3c:	02078663          	beqz	a5,80002d68 <push_off+0x5c>
    80002d40:	ffffe097          	auipc	ra,0xffffe
    80002d44:	700080e7          	jalr	1792(ra) # 80001440 <mycpu>
    80002d48:	07852783          	lw	a5,120(a0)
    80002d4c:	01813083          	ld	ra,24(sp)
    80002d50:	01013403          	ld	s0,16(sp)
    80002d54:	0017879b          	addiw	a5,a5,1
    80002d58:	06f52c23          	sw	a5,120(a0)
    80002d5c:	00813483          	ld	s1,8(sp)
    80002d60:	02010113          	addi	sp,sp,32
    80002d64:	00008067          	ret
    80002d68:	0014d493          	srli	s1,s1,0x1
    80002d6c:	ffffe097          	auipc	ra,0xffffe
    80002d70:	6d4080e7          	jalr	1748(ra) # 80001440 <mycpu>
    80002d74:	0014f493          	andi	s1,s1,1
    80002d78:	06952e23          	sw	s1,124(a0)
    80002d7c:	fc5ff06f          	j	80002d40 <push_off+0x34>

0000000080002d80 <pop_off>:
    80002d80:	ff010113          	addi	sp,sp,-16
    80002d84:	00813023          	sd	s0,0(sp)
    80002d88:	00113423          	sd	ra,8(sp)
    80002d8c:	01010413          	addi	s0,sp,16
    80002d90:	ffffe097          	auipc	ra,0xffffe
    80002d94:	6b0080e7          	jalr	1712(ra) # 80001440 <mycpu>
    80002d98:	100027f3          	csrr	a5,sstatus
    80002d9c:	0027f793          	andi	a5,a5,2
    80002da0:	04079663          	bnez	a5,80002dec <pop_off+0x6c>
    80002da4:	07852783          	lw	a5,120(a0)
    80002da8:	02f05a63          	blez	a5,80002ddc <pop_off+0x5c>
    80002dac:	fff7871b          	addiw	a4,a5,-1
    80002db0:	06e52c23          	sw	a4,120(a0)
    80002db4:	00071c63          	bnez	a4,80002dcc <pop_off+0x4c>
    80002db8:	07c52783          	lw	a5,124(a0)
    80002dbc:	00078863          	beqz	a5,80002dcc <pop_off+0x4c>
    80002dc0:	100027f3          	csrr	a5,sstatus
    80002dc4:	0027e793          	ori	a5,a5,2
    80002dc8:	10079073          	csrw	sstatus,a5
    80002dcc:	00813083          	ld	ra,8(sp)
    80002dd0:	00013403          	ld	s0,0(sp)
    80002dd4:	01010113          	addi	sp,sp,16
    80002dd8:	00008067          	ret
    80002ddc:	00001517          	auipc	a0,0x1
    80002de0:	3e450513          	addi	a0,a0,996 # 800041c0 <digits+0x48>
    80002de4:	fffff097          	auipc	ra,0xfffff
    80002de8:	018080e7          	jalr	24(ra) # 80001dfc <panic>
    80002dec:	00001517          	auipc	a0,0x1
    80002df0:	3bc50513          	addi	a0,a0,956 # 800041a8 <digits+0x30>
    80002df4:	fffff097          	auipc	ra,0xfffff
    80002df8:	008080e7          	jalr	8(ra) # 80001dfc <panic>

0000000080002dfc <push_on>:
    80002dfc:	fe010113          	addi	sp,sp,-32
    80002e00:	00813823          	sd	s0,16(sp)
    80002e04:	00113c23          	sd	ra,24(sp)
    80002e08:	00913423          	sd	s1,8(sp)
    80002e0c:	02010413          	addi	s0,sp,32
    80002e10:	100024f3          	csrr	s1,sstatus
    80002e14:	100027f3          	csrr	a5,sstatus
    80002e18:	0027e793          	ori	a5,a5,2
    80002e1c:	10079073          	csrw	sstatus,a5
    80002e20:	ffffe097          	auipc	ra,0xffffe
    80002e24:	620080e7          	jalr	1568(ra) # 80001440 <mycpu>
    80002e28:	07852783          	lw	a5,120(a0)
    80002e2c:	02078663          	beqz	a5,80002e58 <push_on+0x5c>
    80002e30:	ffffe097          	auipc	ra,0xffffe
    80002e34:	610080e7          	jalr	1552(ra) # 80001440 <mycpu>
    80002e38:	07852783          	lw	a5,120(a0)
    80002e3c:	01813083          	ld	ra,24(sp)
    80002e40:	01013403          	ld	s0,16(sp)
    80002e44:	0017879b          	addiw	a5,a5,1
    80002e48:	06f52c23          	sw	a5,120(a0)
    80002e4c:	00813483          	ld	s1,8(sp)
    80002e50:	02010113          	addi	sp,sp,32
    80002e54:	00008067          	ret
    80002e58:	0014d493          	srli	s1,s1,0x1
    80002e5c:	ffffe097          	auipc	ra,0xffffe
    80002e60:	5e4080e7          	jalr	1508(ra) # 80001440 <mycpu>
    80002e64:	0014f493          	andi	s1,s1,1
    80002e68:	06952e23          	sw	s1,124(a0)
    80002e6c:	fc5ff06f          	j	80002e30 <push_on+0x34>

0000000080002e70 <pop_on>:
    80002e70:	ff010113          	addi	sp,sp,-16
    80002e74:	00813023          	sd	s0,0(sp)
    80002e78:	00113423          	sd	ra,8(sp)
    80002e7c:	01010413          	addi	s0,sp,16
    80002e80:	ffffe097          	auipc	ra,0xffffe
    80002e84:	5c0080e7          	jalr	1472(ra) # 80001440 <mycpu>
    80002e88:	100027f3          	csrr	a5,sstatus
    80002e8c:	0027f793          	andi	a5,a5,2
    80002e90:	04078463          	beqz	a5,80002ed8 <pop_on+0x68>
    80002e94:	07852783          	lw	a5,120(a0)
    80002e98:	02f05863          	blez	a5,80002ec8 <pop_on+0x58>
    80002e9c:	fff7879b          	addiw	a5,a5,-1
    80002ea0:	06f52c23          	sw	a5,120(a0)
    80002ea4:	07853783          	ld	a5,120(a0)
    80002ea8:	00079863          	bnez	a5,80002eb8 <pop_on+0x48>
    80002eac:	100027f3          	csrr	a5,sstatus
    80002eb0:	ffd7f793          	andi	a5,a5,-3
    80002eb4:	10079073          	csrw	sstatus,a5
    80002eb8:	00813083          	ld	ra,8(sp)
    80002ebc:	00013403          	ld	s0,0(sp)
    80002ec0:	01010113          	addi	sp,sp,16
    80002ec4:	00008067          	ret
    80002ec8:	00001517          	auipc	a0,0x1
    80002ecc:	32050513          	addi	a0,a0,800 # 800041e8 <digits+0x70>
    80002ed0:	fffff097          	auipc	ra,0xfffff
    80002ed4:	f2c080e7          	jalr	-212(ra) # 80001dfc <panic>
    80002ed8:	00001517          	auipc	a0,0x1
    80002edc:	2f050513          	addi	a0,a0,752 # 800041c8 <digits+0x50>
    80002ee0:	fffff097          	auipc	ra,0xfffff
    80002ee4:	f1c080e7          	jalr	-228(ra) # 80001dfc <panic>

0000000080002ee8 <__memset>:
    80002ee8:	ff010113          	addi	sp,sp,-16
    80002eec:	00813423          	sd	s0,8(sp)
    80002ef0:	01010413          	addi	s0,sp,16
    80002ef4:	1a060e63          	beqz	a2,800030b0 <__memset+0x1c8>
    80002ef8:	40a007b3          	neg	a5,a0
    80002efc:	0077f793          	andi	a5,a5,7
    80002f00:	00778693          	addi	a3,a5,7
    80002f04:	00b00813          	li	a6,11
    80002f08:	0ff5f593          	andi	a1,a1,255
    80002f0c:	fff6071b          	addiw	a4,a2,-1
    80002f10:	1b06e663          	bltu	a3,a6,800030bc <__memset+0x1d4>
    80002f14:	1cd76463          	bltu	a4,a3,800030dc <__memset+0x1f4>
    80002f18:	1a078e63          	beqz	a5,800030d4 <__memset+0x1ec>
    80002f1c:	00b50023          	sb	a1,0(a0)
    80002f20:	00100713          	li	a4,1
    80002f24:	1ae78463          	beq	a5,a4,800030cc <__memset+0x1e4>
    80002f28:	00b500a3          	sb	a1,1(a0)
    80002f2c:	00200713          	li	a4,2
    80002f30:	1ae78a63          	beq	a5,a4,800030e4 <__memset+0x1fc>
    80002f34:	00b50123          	sb	a1,2(a0)
    80002f38:	00300713          	li	a4,3
    80002f3c:	18e78463          	beq	a5,a4,800030c4 <__memset+0x1dc>
    80002f40:	00b501a3          	sb	a1,3(a0)
    80002f44:	00400713          	li	a4,4
    80002f48:	1ae78263          	beq	a5,a4,800030ec <__memset+0x204>
    80002f4c:	00b50223          	sb	a1,4(a0)
    80002f50:	00500713          	li	a4,5
    80002f54:	1ae78063          	beq	a5,a4,800030f4 <__memset+0x20c>
    80002f58:	00b502a3          	sb	a1,5(a0)
    80002f5c:	00700713          	li	a4,7
    80002f60:	18e79e63          	bne	a5,a4,800030fc <__memset+0x214>
    80002f64:	00b50323          	sb	a1,6(a0)
    80002f68:	00700e93          	li	t4,7
    80002f6c:	00859713          	slli	a4,a1,0x8
    80002f70:	00e5e733          	or	a4,a1,a4
    80002f74:	01059e13          	slli	t3,a1,0x10
    80002f78:	01c76e33          	or	t3,a4,t3
    80002f7c:	01859313          	slli	t1,a1,0x18
    80002f80:	006e6333          	or	t1,t3,t1
    80002f84:	02059893          	slli	a7,a1,0x20
    80002f88:	40f60e3b          	subw	t3,a2,a5
    80002f8c:	011368b3          	or	a7,t1,a7
    80002f90:	02859813          	slli	a6,a1,0x28
    80002f94:	0108e833          	or	a6,a7,a6
    80002f98:	03059693          	slli	a3,a1,0x30
    80002f9c:	003e589b          	srliw	a7,t3,0x3
    80002fa0:	00d866b3          	or	a3,a6,a3
    80002fa4:	03859713          	slli	a4,a1,0x38
    80002fa8:	00389813          	slli	a6,a7,0x3
    80002fac:	00f507b3          	add	a5,a0,a5
    80002fb0:	00e6e733          	or	a4,a3,a4
    80002fb4:	000e089b          	sext.w	a7,t3
    80002fb8:	00f806b3          	add	a3,a6,a5
    80002fbc:	00e7b023          	sd	a4,0(a5)
    80002fc0:	00878793          	addi	a5,a5,8
    80002fc4:	fed79ce3          	bne	a5,a3,80002fbc <__memset+0xd4>
    80002fc8:	ff8e7793          	andi	a5,t3,-8
    80002fcc:	0007871b          	sext.w	a4,a5
    80002fd0:	01d787bb          	addw	a5,a5,t4
    80002fd4:	0ce88e63          	beq	a7,a4,800030b0 <__memset+0x1c8>
    80002fd8:	00f50733          	add	a4,a0,a5
    80002fdc:	00b70023          	sb	a1,0(a4)
    80002fe0:	0017871b          	addiw	a4,a5,1
    80002fe4:	0cc77663          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80002fe8:	00e50733          	add	a4,a0,a4
    80002fec:	00b70023          	sb	a1,0(a4)
    80002ff0:	0027871b          	addiw	a4,a5,2
    80002ff4:	0ac77e63          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80002ff8:	00e50733          	add	a4,a0,a4
    80002ffc:	00b70023          	sb	a1,0(a4)
    80003000:	0037871b          	addiw	a4,a5,3
    80003004:	0ac77663          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80003008:	00e50733          	add	a4,a0,a4
    8000300c:	00b70023          	sb	a1,0(a4)
    80003010:	0047871b          	addiw	a4,a5,4
    80003014:	08c77e63          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80003018:	00e50733          	add	a4,a0,a4
    8000301c:	00b70023          	sb	a1,0(a4)
    80003020:	0057871b          	addiw	a4,a5,5
    80003024:	08c77663          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80003028:	00e50733          	add	a4,a0,a4
    8000302c:	00b70023          	sb	a1,0(a4)
    80003030:	0067871b          	addiw	a4,a5,6
    80003034:	06c77e63          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80003038:	00e50733          	add	a4,a0,a4
    8000303c:	00b70023          	sb	a1,0(a4)
    80003040:	0077871b          	addiw	a4,a5,7
    80003044:	06c77663          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80003048:	00e50733          	add	a4,a0,a4
    8000304c:	00b70023          	sb	a1,0(a4)
    80003050:	0087871b          	addiw	a4,a5,8
    80003054:	04c77e63          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80003058:	00e50733          	add	a4,a0,a4
    8000305c:	00b70023          	sb	a1,0(a4)
    80003060:	0097871b          	addiw	a4,a5,9
    80003064:	04c77663          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80003068:	00e50733          	add	a4,a0,a4
    8000306c:	00b70023          	sb	a1,0(a4)
    80003070:	00a7871b          	addiw	a4,a5,10
    80003074:	02c77e63          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80003078:	00e50733          	add	a4,a0,a4
    8000307c:	00b70023          	sb	a1,0(a4)
    80003080:	00b7871b          	addiw	a4,a5,11
    80003084:	02c77663          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80003088:	00e50733          	add	a4,a0,a4
    8000308c:	00b70023          	sb	a1,0(a4)
    80003090:	00c7871b          	addiw	a4,a5,12
    80003094:	00c77e63          	bgeu	a4,a2,800030b0 <__memset+0x1c8>
    80003098:	00e50733          	add	a4,a0,a4
    8000309c:	00b70023          	sb	a1,0(a4)
    800030a0:	00d7879b          	addiw	a5,a5,13
    800030a4:	00c7f663          	bgeu	a5,a2,800030b0 <__memset+0x1c8>
    800030a8:	00f507b3          	add	a5,a0,a5
    800030ac:	00b78023          	sb	a1,0(a5)
    800030b0:	00813403          	ld	s0,8(sp)
    800030b4:	01010113          	addi	sp,sp,16
    800030b8:	00008067          	ret
    800030bc:	00b00693          	li	a3,11
    800030c0:	e55ff06f          	j	80002f14 <__memset+0x2c>
    800030c4:	00300e93          	li	t4,3
    800030c8:	ea5ff06f          	j	80002f6c <__memset+0x84>
    800030cc:	00100e93          	li	t4,1
    800030d0:	e9dff06f          	j	80002f6c <__memset+0x84>
    800030d4:	00000e93          	li	t4,0
    800030d8:	e95ff06f          	j	80002f6c <__memset+0x84>
    800030dc:	00000793          	li	a5,0
    800030e0:	ef9ff06f          	j	80002fd8 <__memset+0xf0>
    800030e4:	00200e93          	li	t4,2
    800030e8:	e85ff06f          	j	80002f6c <__memset+0x84>
    800030ec:	00400e93          	li	t4,4
    800030f0:	e7dff06f          	j	80002f6c <__memset+0x84>
    800030f4:	00500e93          	li	t4,5
    800030f8:	e75ff06f          	j	80002f6c <__memset+0x84>
    800030fc:	00600e93          	li	t4,6
    80003100:	e6dff06f          	j	80002f6c <__memset+0x84>

0000000080003104 <__memmove>:
    80003104:	ff010113          	addi	sp,sp,-16
    80003108:	00813423          	sd	s0,8(sp)
    8000310c:	01010413          	addi	s0,sp,16
    80003110:	0e060863          	beqz	a2,80003200 <__memmove+0xfc>
    80003114:	fff6069b          	addiw	a3,a2,-1
    80003118:	0006881b          	sext.w	a6,a3
    8000311c:	0ea5e863          	bltu	a1,a0,8000320c <__memmove+0x108>
    80003120:	00758713          	addi	a4,a1,7
    80003124:	00a5e7b3          	or	a5,a1,a0
    80003128:	40a70733          	sub	a4,a4,a0
    8000312c:	0077f793          	andi	a5,a5,7
    80003130:	00f73713          	sltiu	a4,a4,15
    80003134:	00174713          	xori	a4,a4,1
    80003138:	0017b793          	seqz	a5,a5
    8000313c:	00e7f7b3          	and	a5,a5,a4
    80003140:	10078863          	beqz	a5,80003250 <__memmove+0x14c>
    80003144:	00900793          	li	a5,9
    80003148:	1107f463          	bgeu	a5,a6,80003250 <__memmove+0x14c>
    8000314c:	0036581b          	srliw	a6,a2,0x3
    80003150:	fff8081b          	addiw	a6,a6,-1
    80003154:	02081813          	slli	a6,a6,0x20
    80003158:	01d85893          	srli	a7,a6,0x1d
    8000315c:	00858813          	addi	a6,a1,8
    80003160:	00058793          	mv	a5,a1
    80003164:	00050713          	mv	a4,a0
    80003168:	01088833          	add	a6,a7,a6
    8000316c:	0007b883          	ld	a7,0(a5)
    80003170:	00878793          	addi	a5,a5,8
    80003174:	00870713          	addi	a4,a4,8
    80003178:	ff173c23          	sd	a7,-8(a4)
    8000317c:	ff0798e3          	bne	a5,a6,8000316c <__memmove+0x68>
    80003180:	ff867713          	andi	a4,a2,-8
    80003184:	02071793          	slli	a5,a4,0x20
    80003188:	0207d793          	srli	a5,a5,0x20
    8000318c:	00f585b3          	add	a1,a1,a5
    80003190:	40e686bb          	subw	a3,a3,a4
    80003194:	00f507b3          	add	a5,a0,a5
    80003198:	06e60463          	beq	a2,a4,80003200 <__memmove+0xfc>
    8000319c:	0005c703          	lbu	a4,0(a1)
    800031a0:	00e78023          	sb	a4,0(a5)
    800031a4:	04068e63          	beqz	a3,80003200 <__memmove+0xfc>
    800031a8:	0015c603          	lbu	a2,1(a1)
    800031ac:	00100713          	li	a4,1
    800031b0:	00c780a3          	sb	a2,1(a5)
    800031b4:	04e68663          	beq	a3,a4,80003200 <__memmove+0xfc>
    800031b8:	0025c603          	lbu	a2,2(a1)
    800031bc:	00200713          	li	a4,2
    800031c0:	00c78123          	sb	a2,2(a5)
    800031c4:	02e68e63          	beq	a3,a4,80003200 <__memmove+0xfc>
    800031c8:	0035c603          	lbu	a2,3(a1)
    800031cc:	00300713          	li	a4,3
    800031d0:	00c781a3          	sb	a2,3(a5)
    800031d4:	02e68663          	beq	a3,a4,80003200 <__memmove+0xfc>
    800031d8:	0045c603          	lbu	a2,4(a1)
    800031dc:	00400713          	li	a4,4
    800031e0:	00c78223          	sb	a2,4(a5)
    800031e4:	00e68e63          	beq	a3,a4,80003200 <__memmove+0xfc>
    800031e8:	0055c603          	lbu	a2,5(a1)
    800031ec:	00500713          	li	a4,5
    800031f0:	00c782a3          	sb	a2,5(a5)
    800031f4:	00e68663          	beq	a3,a4,80003200 <__memmove+0xfc>
    800031f8:	0065c703          	lbu	a4,6(a1)
    800031fc:	00e78323          	sb	a4,6(a5)
    80003200:	00813403          	ld	s0,8(sp)
    80003204:	01010113          	addi	sp,sp,16
    80003208:	00008067          	ret
    8000320c:	02061713          	slli	a4,a2,0x20
    80003210:	02075713          	srli	a4,a4,0x20
    80003214:	00e587b3          	add	a5,a1,a4
    80003218:	f0f574e3          	bgeu	a0,a5,80003120 <__memmove+0x1c>
    8000321c:	02069613          	slli	a2,a3,0x20
    80003220:	02065613          	srli	a2,a2,0x20
    80003224:	fff64613          	not	a2,a2
    80003228:	00e50733          	add	a4,a0,a4
    8000322c:	00c78633          	add	a2,a5,a2
    80003230:	fff7c683          	lbu	a3,-1(a5)
    80003234:	fff78793          	addi	a5,a5,-1
    80003238:	fff70713          	addi	a4,a4,-1
    8000323c:	00d70023          	sb	a3,0(a4)
    80003240:	fec798e3          	bne	a5,a2,80003230 <__memmove+0x12c>
    80003244:	00813403          	ld	s0,8(sp)
    80003248:	01010113          	addi	sp,sp,16
    8000324c:	00008067          	ret
    80003250:	02069713          	slli	a4,a3,0x20
    80003254:	02075713          	srli	a4,a4,0x20
    80003258:	00170713          	addi	a4,a4,1
    8000325c:	00e50733          	add	a4,a0,a4
    80003260:	00050793          	mv	a5,a0
    80003264:	0005c683          	lbu	a3,0(a1)
    80003268:	00178793          	addi	a5,a5,1
    8000326c:	00158593          	addi	a1,a1,1
    80003270:	fed78fa3          	sb	a3,-1(a5)
    80003274:	fee798e3          	bne	a5,a4,80003264 <__memmove+0x160>
    80003278:	f89ff06f          	j	80003200 <__memmove+0xfc>

000000008000327c <__putc>:
    8000327c:	fe010113          	addi	sp,sp,-32
    80003280:	00813823          	sd	s0,16(sp)
    80003284:	00113c23          	sd	ra,24(sp)
    80003288:	02010413          	addi	s0,sp,32
    8000328c:	00050793          	mv	a5,a0
    80003290:	fef40593          	addi	a1,s0,-17
    80003294:	00100613          	li	a2,1
    80003298:	00000513          	li	a0,0
    8000329c:	fef407a3          	sb	a5,-17(s0)
    800032a0:	fffff097          	auipc	ra,0xfffff
    800032a4:	b3c080e7          	jalr	-1220(ra) # 80001ddc <console_write>
    800032a8:	01813083          	ld	ra,24(sp)
    800032ac:	01013403          	ld	s0,16(sp)
    800032b0:	02010113          	addi	sp,sp,32
    800032b4:	00008067          	ret

00000000800032b8 <__getc>:
    800032b8:	fe010113          	addi	sp,sp,-32
    800032bc:	00813823          	sd	s0,16(sp)
    800032c0:	00113c23          	sd	ra,24(sp)
    800032c4:	02010413          	addi	s0,sp,32
    800032c8:	fe840593          	addi	a1,s0,-24
    800032cc:	00100613          	li	a2,1
    800032d0:	00000513          	li	a0,0
    800032d4:	fffff097          	auipc	ra,0xfffff
    800032d8:	ae8080e7          	jalr	-1304(ra) # 80001dbc <console_read>
    800032dc:	fe844503          	lbu	a0,-24(s0)
    800032e0:	01813083          	ld	ra,24(sp)
    800032e4:	01013403          	ld	s0,16(sp)
    800032e8:	02010113          	addi	sp,sp,32
    800032ec:	00008067          	ret

00000000800032f0 <console_handler>:
    800032f0:	fe010113          	addi	sp,sp,-32
    800032f4:	00813823          	sd	s0,16(sp)
    800032f8:	00113c23          	sd	ra,24(sp)
    800032fc:	00913423          	sd	s1,8(sp)
    80003300:	02010413          	addi	s0,sp,32
    80003304:	14202773          	csrr	a4,scause
    80003308:	100027f3          	csrr	a5,sstatus
    8000330c:	0027f793          	andi	a5,a5,2
    80003310:	06079e63          	bnez	a5,8000338c <console_handler+0x9c>
    80003314:	00074c63          	bltz	a4,8000332c <console_handler+0x3c>
    80003318:	01813083          	ld	ra,24(sp)
    8000331c:	01013403          	ld	s0,16(sp)
    80003320:	00813483          	ld	s1,8(sp)
    80003324:	02010113          	addi	sp,sp,32
    80003328:	00008067          	ret
    8000332c:	0ff77713          	andi	a4,a4,255
    80003330:	00900793          	li	a5,9
    80003334:	fef712e3          	bne	a4,a5,80003318 <console_handler+0x28>
    80003338:	ffffe097          	auipc	ra,0xffffe
    8000333c:	6dc080e7          	jalr	1756(ra) # 80001a14 <plic_claim>
    80003340:	00a00793          	li	a5,10
    80003344:	00050493          	mv	s1,a0
    80003348:	02f50c63          	beq	a0,a5,80003380 <console_handler+0x90>
    8000334c:	fc0506e3          	beqz	a0,80003318 <console_handler+0x28>
    80003350:	00050593          	mv	a1,a0
    80003354:	00001517          	auipc	a0,0x1
    80003358:	d9c50513          	addi	a0,a0,-612 # 800040f0 <CONSOLE_STATUS+0xe0>
    8000335c:	fffff097          	auipc	ra,0xfffff
    80003360:	afc080e7          	jalr	-1284(ra) # 80001e58 <__printf>
    80003364:	01013403          	ld	s0,16(sp)
    80003368:	01813083          	ld	ra,24(sp)
    8000336c:	00048513          	mv	a0,s1
    80003370:	00813483          	ld	s1,8(sp)
    80003374:	02010113          	addi	sp,sp,32
    80003378:	ffffe317          	auipc	t1,0xffffe
    8000337c:	6d430067          	jr	1748(t1) # 80001a4c <plic_complete>
    80003380:	fffff097          	auipc	ra,0xfffff
    80003384:	3e0080e7          	jalr	992(ra) # 80002760 <uartintr>
    80003388:	fddff06f          	j	80003364 <console_handler+0x74>
    8000338c:	00001517          	auipc	a0,0x1
    80003390:	e6450513          	addi	a0,a0,-412 # 800041f0 <digits+0x78>
    80003394:	fffff097          	auipc	ra,0xfffff
    80003398:	a68080e7          	jalr	-1432(ra) # 80001dfc <panic>
	...
