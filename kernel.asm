
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	2b013103          	ld	sp,688(sp) # 800042b0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	204010ef          	jal	ra,80001220 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <main>:
#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"

int main() {
    80001000:	fe010113          	addi	sp,sp,-32
    80001004:	00113c23          	sd	ra,24(sp)
    80001008:	00813823          	sd	s0,16(sp)
    8000100c:	00913423          	sd	s1,8(sp)
    80001010:	01213023          	sd	s2,0(sp)
    80001014:	02010413          	addi	s0,sp,32

    int* par = (int*)MemoryAllocator::mem_alloc(3*sizeof(int));
    80001018:	00c00513          	li	a0,12
    8000101c:	00000097          	auipc	ra,0x0
    80001020:	094080e7          	jalr	148(ra) # 800010b0 <_ZN15MemoryAllocator9mem_allocEm>
    80001024:	00050913          	mv	s2,a0
    for(int i = 1; i < 4; i++) {
    80001028:	00100713          	li	a4,1
    8000102c:	0180006f          	j	80001044 <main+0x44>
        par[i-1] = i;
    80001030:	00271793          	slli	a5,a4,0x2
    80001034:	ffc78793          	addi	a5,a5,-4
    80001038:	00f907b3          	add	a5,s2,a5
    8000103c:	00e7a023          	sw	a4,0(a5)
    for(int i = 1; i < 4; i++) {
    80001040:	0017071b          	addiw	a4,a4,1
    80001044:	00300793          	li	a5,3
    80001048:	fee7d4e3          	bge	a5,a4,80001030 <main+0x30>
    }

    size_t t = *(size_t*)((char*)par - MemoryAllocator::SegmentOffset);
    __putc(t);
    8000104c:	ff894503          	lbu	a0,-8(s2)
    80001050:	00002097          	auipc	ra,0x2
    80001054:	28c080e7          	jalr	652(ra) # 800032dc <__putc>

    for(int i = 0; i < 3; i++) {
    80001058:	00000493          	li	s1,0
    8000105c:	0300006f          	j	8000108c <main+0x8c>
        __putc('0' + par[i]);
    80001060:	00249793          	slli	a5,s1,0x2
    80001064:	00f907b3          	add	a5,s2,a5
    80001068:	0007a503          	lw	a0,0(a5)
    8000106c:	0305051b          	addiw	a0,a0,48
    80001070:	0ff57513          	andi	a0,a0,255
    80001074:	00002097          	auipc	ra,0x2
    80001078:	268080e7          	jalr	616(ra) # 800032dc <__putc>
        __putc('\n');
    8000107c:	00a00513          	li	a0,10
    80001080:	00002097          	auipc	ra,0x2
    80001084:	25c080e7          	jalr	604(ra) # 800032dc <__putc>
    for(int i = 0; i < 3; i++) {
    80001088:	0014849b          	addiw	s1,s1,1
    8000108c:	00200793          	li	a5,2
    80001090:	fc97d8e3          	bge	a5,s1,80001060 <main+0x60>
    }

    return 0;
    80001094:	00000513          	li	a0,0
    80001098:	01813083          	ld	ra,24(sp)
    8000109c:	01013403          	ld	s0,16(sp)
    800010a0:	00813483          	ld	s1,8(sp)
    800010a4:	00013903          	ld	s2,0(sp)
    800010a8:	02010113          	addi	sp,sp,32
    800010ac:	00008067          	ret

00000000800010b0 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    800010b0:	ff010113          	addi	sp,sp,-16
    800010b4:	00813423          	sd	s0,8(sp)
    800010b8:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    800010bc:	00003797          	auipc	a5,0x3
    800010c0:	2447b783          	ld	a5,580(a5) # 80004300 <_ZN15MemoryAllocator4headE>
    800010c4:	06078063          	beqz	a5,80001124 <_ZN15MemoryAllocator9mem_allocEm+0x74>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 1);
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    800010c8:	00003717          	auipc	a4,0x3
    800010cc:	1f073703          	ld	a4,496(a4) # 800042b8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800010d0:	00073703          	ld	a4,0(a4)
    800010d4:	14e78263          	beq	a5,a4,80001218 <_ZN15MemoryAllocator9mem_allocEm+0x168>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    800010d8:	00850513          	addi	a0,a0,8 # 1008 <_entry-0x7fffeff8>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800010dc:	00655613          	srli	a2,a0,0x6
    800010e0:	03f57513          	andi	a0,a0,63
    800010e4:	00a03533          	snez	a0,a0
    800010e8:	00a60633          	add	a2,a2,a0
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    800010ec:	00003517          	auipc	a0,0x3
    800010f0:	21453503          	ld	a0,532(a0) # 80004300 <_ZN15MemoryAllocator4headE>
    800010f4:	00000593          	li	a1,0
    while(curr) {
    800010f8:	0a050863          	beqz	a0,800011a8 <_ZN15MemoryAllocator9mem_allocEm+0xf8>
        size_t freeSegSizeInBlocks = sizeInBlocks(curr->size);
    800010fc:	00853683          	ld	a3,8(a0)
    80001100:	0066d793          	srli	a5,a3,0x6
    80001104:	03f6f713          	andi	a4,a3,63
    80001108:	00e03733          	snez	a4,a4
    8000110c:	00e787b3          	add	a5,a5,a4
        size_t allocatedSize = 0;
        void* startOfAllocatedSpace = curr->baseAddr;
    80001110:	00053703          	ld	a4,0(a0)
        if(freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80001114:	04c7f663          	bgeu	a5,a2,80001160 <_ZN15MemoryAllocator9mem_allocEm+0xb0>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80001118:	00050593          	mv	a1,a0
        curr = curr->next;
    8000111c:	01053503          	ld	a0,16(a0)
    while(curr) {
    80001120:	fd9ff06f          	j	800010f8 <_ZN15MemoryAllocator9mem_allocEm+0x48>
        head = (FreeSegment*)HEAP_START_ADDR;
    80001124:	00003697          	auipc	a3,0x3
    80001128:	1846b683          	ld	a3,388(a3) # 800042a8 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000112c:	0006b783          	ld	a5,0(a3)
    80001130:	00003717          	auipc	a4,0x3
    80001134:	1cf73823          	sd	a5,464(a4) # 80004300 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80001138:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 1);
    8000113c:	00003717          	auipc	a4,0x3
    80001140:	17c73703          	ld	a4,380(a4) # 800042b8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001144:	00073703          	ld	a4,0(a4)
    80001148:	0006b683          	ld	a3,0(a3)
    8000114c:	40d70733          	sub	a4,a4,a3
    80001150:	00170713          	addi	a4,a4,1
    80001154:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80001158:	0007b823          	sd	zero,16(a5)
    8000115c:	f7dff06f          	j	800010d8 <_ZN15MemoryAllocator9mem_allocEm+0x28>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001160:	04f60a63          	beq	a2,a5,800011b4 <_ZN15MemoryAllocator9mem_allocEm+0x104>
    }

    // Vraca velicinu numOfBlocks blokova u bajtovima
    static inline size_t blocksInSize(size_t numOfBlocks) {
        return numOfBlocks * MEM_BLOCK_SIZE;
    80001164:	00661613          	slli	a2,a2,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80001168:	00c707b3          	add	a5,a4,a2
                size_t newSize = curr->size - allocatedSize;
    8000116c:	40c686b3          	sub	a3,a3,a2
                newSeg->baseAddr = newBaseAddr;
    80001170:	00f7b023          	sd	a5,0(a5)
                newSeg->size = newSize;
    80001174:	00d7b423          	sd	a3,8(a5)
                newSeg->next = curr->next;
    80001178:	01053683          	ld	a3,16(a0)
    8000117c:	00d7b823          	sd	a3,16(a5)
                if(!prev) {
    80001180:	08058263          	beqz	a1,80001204 <_ZN15MemoryAllocator9mem_allocEm+0x154>
            if(!prev->next) return;
    80001184:	0105b783          	ld	a5,16(a1)
    80001188:	00078663          	beqz	a5,80001194 <_ZN15MemoryAllocator9mem_allocEm+0xe4>
            prev->next = curr->next;
    8000118c:	0107b783          	ld	a5,16(a5)
    80001190:	00f5b823          	sd	a5,16(a1)
            curr->next = prev->next;
    80001194:	0105b783          	ld	a5,16(a1)
    80001198:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    8000119c:	00a5b823          	sd	a0,16(a1)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    800011a0:	00c73023          	sd	a2,0(a4)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    800011a4:	00870513          	addi	a0,a4,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    800011a8:	00813403          	ld	s0,8(sp)
    800011ac:	01010113          	addi	sp,sp,16
    800011b0:	00008067          	ret
                if(prev == nullptr) { // ako smo na head pokazivacu
    800011b4:	00058e63          	beqz	a1,800011d0 <_ZN15MemoryAllocator9mem_allocEm+0x120>
            if(!prev->next) return;
    800011b8:	0105b783          	ld	a5,16(a1)
    800011bc:	04078a63          	beqz	a5,80001210 <_ZN15MemoryAllocator9mem_allocEm+0x160>
            prev->next = curr->next;
    800011c0:	0107b783          	ld	a5,16(a5)
    800011c4:	00f5b823          	sd	a5,16(a1)
                allocatedSize = curr->size;
    800011c8:	00068613          	mv	a2,a3
    800011cc:	fd5ff06f          	j	800011a0 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    800011d0:	01053783          	ld	a5,16(a0)
    800011d4:	00078a63          	beqz	a5,800011e8 <_ZN15MemoryAllocator9mem_allocEm+0x138>
                        head = curr->next;
    800011d8:	00003617          	auipc	a2,0x3
    800011dc:	12f63423          	sd	a5,296(a2) # 80004300 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800011e0:	00068613          	mv	a2,a3
    800011e4:	fbdff06f          	j	800011a0 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
                        head = (FreeSegment*)HEAP_END_ADDR;
    800011e8:	00003797          	auipc	a5,0x3
    800011ec:	0d07b783          	ld	a5,208(a5) # 800042b8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800011f0:	0007b783          	ld	a5,0(a5)
    800011f4:	00003617          	auipc	a2,0x3
    800011f8:	10f63623          	sd	a5,268(a2) # 80004300 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800011fc:	00068613          	mv	a2,a3
    80001200:	fa1ff06f          	j	800011a0 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
                    head = newSeg;
    80001204:	00003697          	auipc	a3,0x3
    80001208:	0ef6be23          	sd	a5,252(a3) # 80004300 <_ZN15MemoryAllocator4headE>
    8000120c:	f95ff06f          	j	800011a0 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
                allocatedSize = curr->size;
    80001210:	00068613          	mv	a2,a3
    80001214:	f8dff06f          	j	800011a0 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        return nullptr;
    80001218:	00000513          	li	a0,0
    8000121c:	f8dff06f          	j	800011a8 <_ZN15MemoryAllocator9mem_allocEm+0xf8>

0000000080001220 <start>:
    80001220:	ff010113          	addi	sp,sp,-16
    80001224:	00813423          	sd	s0,8(sp)
    80001228:	01010413          	addi	s0,sp,16
    8000122c:	300027f3          	csrr	a5,mstatus
    80001230:	ffffe737          	lui	a4,0xffffe
    80001234:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff929f>
    80001238:	00e7f7b3          	and	a5,a5,a4
    8000123c:	00001737          	lui	a4,0x1
    80001240:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001244:	00e7e7b3          	or	a5,a5,a4
    80001248:	30079073          	csrw	mstatus,a5
    8000124c:	00000797          	auipc	a5,0x0
    80001250:	16078793          	addi	a5,a5,352 # 800013ac <system_main>
    80001254:	34179073          	csrw	mepc,a5
    80001258:	00000793          	li	a5,0
    8000125c:	18079073          	csrw	satp,a5
    80001260:	000107b7          	lui	a5,0x10
    80001264:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001268:	30279073          	csrw	medeleg,a5
    8000126c:	30379073          	csrw	mideleg,a5
    80001270:	104027f3          	csrr	a5,sie
    80001274:	2227e793          	ori	a5,a5,546
    80001278:	10479073          	csrw	sie,a5
    8000127c:	fff00793          	li	a5,-1
    80001280:	00a7d793          	srli	a5,a5,0xa
    80001284:	3b079073          	csrw	pmpaddr0,a5
    80001288:	00f00793          	li	a5,15
    8000128c:	3a079073          	csrw	pmpcfg0,a5
    80001290:	f14027f3          	csrr	a5,mhartid
    80001294:	0200c737          	lui	a4,0x200c
    80001298:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000129c:	0007869b          	sext.w	a3,a5
    800012a0:	00269713          	slli	a4,a3,0x2
    800012a4:	000f4637          	lui	a2,0xf4
    800012a8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800012ac:	00d70733          	add	a4,a4,a3
    800012b0:	0037979b          	slliw	a5,a5,0x3
    800012b4:	020046b7          	lui	a3,0x2004
    800012b8:	00d787b3          	add	a5,a5,a3
    800012bc:	00c585b3          	add	a1,a1,a2
    800012c0:	00371693          	slli	a3,a4,0x3
    800012c4:	00003717          	auipc	a4,0x3
    800012c8:	04c70713          	addi	a4,a4,76 # 80004310 <timer_scratch>
    800012cc:	00b7b023          	sd	a1,0(a5)
    800012d0:	00d70733          	add	a4,a4,a3
    800012d4:	00f73c23          	sd	a5,24(a4)
    800012d8:	02c73023          	sd	a2,32(a4)
    800012dc:	34071073          	csrw	mscratch,a4
    800012e0:	00000797          	auipc	a5,0x0
    800012e4:	6e078793          	addi	a5,a5,1760 # 800019c0 <timervec>
    800012e8:	30579073          	csrw	mtvec,a5
    800012ec:	300027f3          	csrr	a5,mstatus
    800012f0:	0087e793          	ori	a5,a5,8
    800012f4:	30079073          	csrw	mstatus,a5
    800012f8:	304027f3          	csrr	a5,mie
    800012fc:	0807e793          	ori	a5,a5,128
    80001300:	30479073          	csrw	mie,a5
    80001304:	f14027f3          	csrr	a5,mhartid
    80001308:	0007879b          	sext.w	a5,a5
    8000130c:	00078213          	mv	tp,a5
    80001310:	30200073          	mret
    80001314:	00813403          	ld	s0,8(sp)
    80001318:	01010113          	addi	sp,sp,16
    8000131c:	00008067          	ret

0000000080001320 <timerinit>:
    80001320:	ff010113          	addi	sp,sp,-16
    80001324:	00813423          	sd	s0,8(sp)
    80001328:	01010413          	addi	s0,sp,16
    8000132c:	f14027f3          	csrr	a5,mhartid
    80001330:	0200c737          	lui	a4,0x200c
    80001334:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001338:	0007869b          	sext.w	a3,a5
    8000133c:	00269713          	slli	a4,a3,0x2
    80001340:	000f4637          	lui	a2,0xf4
    80001344:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001348:	00d70733          	add	a4,a4,a3
    8000134c:	0037979b          	slliw	a5,a5,0x3
    80001350:	020046b7          	lui	a3,0x2004
    80001354:	00d787b3          	add	a5,a5,a3
    80001358:	00c585b3          	add	a1,a1,a2
    8000135c:	00371693          	slli	a3,a4,0x3
    80001360:	00003717          	auipc	a4,0x3
    80001364:	fb070713          	addi	a4,a4,-80 # 80004310 <timer_scratch>
    80001368:	00b7b023          	sd	a1,0(a5)
    8000136c:	00d70733          	add	a4,a4,a3
    80001370:	00f73c23          	sd	a5,24(a4)
    80001374:	02c73023          	sd	a2,32(a4)
    80001378:	34071073          	csrw	mscratch,a4
    8000137c:	00000797          	auipc	a5,0x0
    80001380:	64478793          	addi	a5,a5,1604 # 800019c0 <timervec>
    80001384:	30579073          	csrw	mtvec,a5
    80001388:	300027f3          	csrr	a5,mstatus
    8000138c:	0087e793          	ori	a5,a5,8
    80001390:	30079073          	csrw	mstatus,a5
    80001394:	304027f3          	csrr	a5,mie
    80001398:	0807e793          	ori	a5,a5,128
    8000139c:	30479073          	csrw	mie,a5
    800013a0:	00813403          	ld	s0,8(sp)
    800013a4:	01010113          	addi	sp,sp,16
    800013a8:	00008067          	ret

00000000800013ac <system_main>:
    800013ac:	fe010113          	addi	sp,sp,-32
    800013b0:	00813823          	sd	s0,16(sp)
    800013b4:	00913423          	sd	s1,8(sp)
    800013b8:	00113c23          	sd	ra,24(sp)
    800013bc:	02010413          	addi	s0,sp,32
    800013c0:	00000097          	auipc	ra,0x0
    800013c4:	0c4080e7          	jalr	196(ra) # 80001484 <cpuid>
    800013c8:	00003497          	auipc	s1,0x3
    800013cc:	f0848493          	addi	s1,s1,-248 # 800042d0 <started>
    800013d0:	02050263          	beqz	a0,800013f4 <system_main+0x48>
    800013d4:	0004a783          	lw	a5,0(s1)
    800013d8:	0007879b          	sext.w	a5,a5
    800013dc:	fe078ce3          	beqz	a5,800013d4 <system_main+0x28>
    800013e0:	0ff0000f          	fence
    800013e4:	00003517          	auipc	a0,0x3
    800013e8:	c6c50513          	addi	a0,a0,-916 # 80004050 <CONSOLE_STATUS+0x40>
    800013ec:	00001097          	auipc	ra,0x1
    800013f0:	a70080e7          	jalr	-1424(ra) # 80001e5c <panic>
    800013f4:	00001097          	auipc	ra,0x1
    800013f8:	9c4080e7          	jalr	-1596(ra) # 80001db8 <consoleinit>
    800013fc:	00001097          	auipc	ra,0x1
    80001400:	150080e7          	jalr	336(ra) # 8000254c <printfinit>
    80001404:	00003517          	auipc	a0,0x3
    80001408:	d2c50513          	addi	a0,a0,-724 # 80004130 <CONSOLE_STATUS+0x120>
    8000140c:	00001097          	auipc	ra,0x1
    80001410:	aac080e7          	jalr	-1364(ra) # 80001eb8 <__printf>
    80001414:	00003517          	auipc	a0,0x3
    80001418:	c0c50513          	addi	a0,a0,-1012 # 80004020 <CONSOLE_STATUS+0x10>
    8000141c:	00001097          	auipc	ra,0x1
    80001420:	a9c080e7          	jalr	-1380(ra) # 80001eb8 <__printf>
    80001424:	00003517          	auipc	a0,0x3
    80001428:	d0c50513          	addi	a0,a0,-756 # 80004130 <CONSOLE_STATUS+0x120>
    8000142c:	00001097          	auipc	ra,0x1
    80001430:	a8c080e7          	jalr	-1396(ra) # 80001eb8 <__printf>
    80001434:	00001097          	auipc	ra,0x1
    80001438:	4a4080e7          	jalr	1188(ra) # 800028d8 <kinit>
    8000143c:	00000097          	auipc	ra,0x0
    80001440:	148080e7          	jalr	328(ra) # 80001584 <trapinit>
    80001444:	00000097          	auipc	ra,0x0
    80001448:	16c080e7          	jalr	364(ra) # 800015b0 <trapinithart>
    8000144c:	00000097          	auipc	ra,0x0
    80001450:	5b4080e7          	jalr	1460(ra) # 80001a00 <plicinit>
    80001454:	00000097          	auipc	ra,0x0
    80001458:	5d4080e7          	jalr	1492(ra) # 80001a28 <plicinithart>
    8000145c:	00000097          	auipc	ra,0x0
    80001460:	078080e7          	jalr	120(ra) # 800014d4 <userinit>
    80001464:	0ff0000f          	fence
    80001468:	00100793          	li	a5,1
    8000146c:	00003517          	auipc	a0,0x3
    80001470:	bcc50513          	addi	a0,a0,-1076 # 80004038 <CONSOLE_STATUS+0x28>
    80001474:	00f4a023          	sw	a5,0(s1)
    80001478:	00001097          	auipc	ra,0x1
    8000147c:	a40080e7          	jalr	-1472(ra) # 80001eb8 <__printf>
    80001480:	0000006f          	j	80001480 <system_main+0xd4>

0000000080001484 <cpuid>:
    80001484:	ff010113          	addi	sp,sp,-16
    80001488:	00813423          	sd	s0,8(sp)
    8000148c:	01010413          	addi	s0,sp,16
    80001490:	00020513          	mv	a0,tp
    80001494:	00813403          	ld	s0,8(sp)
    80001498:	0005051b          	sext.w	a0,a0
    8000149c:	01010113          	addi	sp,sp,16
    800014a0:	00008067          	ret

00000000800014a4 <mycpu>:
    800014a4:	ff010113          	addi	sp,sp,-16
    800014a8:	00813423          	sd	s0,8(sp)
    800014ac:	01010413          	addi	s0,sp,16
    800014b0:	00020793          	mv	a5,tp
    800014b4:	00813403          	ld	s0,8(sp)
    800014b8:	0007879b          	sext.w	a5,a5
    800014bc:	00779793          	slli	a5,a5,0x7
    800014c0:	00004517          	auipc	a0,0x4
    800014c4:	e8050513          	addi	a0,a0,-384 # 80005340 <cpus>
    800014c8:	00f50533          	add	a0,a0,a5
    800014cc:	01010113          	addi	sp,sp,16
    800014d0:	00008067          	ret

00000000800014d4 <userinit>:
    800014d4:	ff010113          	addi	sp,sp,-16
    800014d8:	00813423          	sd	s0,8(sp)
    800014dc:	01010413          	addi	s0,sp,16
    800014e0:	00813403          	ld	s0,8(sp)
    800014e4:	01010113          	addi	sp,sp,16
    800014e8:	00000317          	auipc	t1,0x0
    800014ec:	b1830067          	jr	-1256(t1) # 80001000 <main>

00000000800014f0 <either_copyout>:
    800014f0:	ff010113          	addi	sp,sp,-16
    800014f4:	00813023          	sd	s0,0(sp)
    800014f8:	00113423          	sd	ra,8(sp)
    800014fc:	01010413          	addi	s0,sp,16
    80001500:	02051663          	bnez	a0,8000152c <either_copyout+0x3c>
    80001504:	00058513          	mv	a0,a1
    80001508:	00060593          	mv	a1,a2
    8000150c:	0006861b          	sext.w	a2,a3
    80001510:	00002097          	auipc	ra,0x2
    80001514:	c54080e7          	jalr	-940(ra) # 80003164 <__memmove>
    80001518:	00813083          	ld	ra,8(sp)
    8000151c:	00013403          	ld	s0,0(sp)
    80001520:	00000513          	li	a0,0
    80001524:	01010113          	addi	sp,sp,16
    80001528:	00008067          	ret
    8000152c:	00003517          	auipc	a0,0x3
    80001530:	b4c50513          	addi	a0,a0,-1204 # 80004078 <CONSOLE_STATUS+0x68>
    80001534:	00001097          	auipc	ra,0x1
    80001538:	928080e7          	jalr	-1752(ra) # 80001e5c <panic>

000000008000153c <either_copyin>:
    8000153c:	ff010113          	addi	sp,sp,-16
    80001540:	00813023          	sd	s0,0(sp)
    80001544:	00113423          	sd	ra,8(sp)
    80001548:	01010413          	addi	s0,sp,16
    8000154c:	02059463          	bnez	a1,80001574 <either_copyin+0x38>
    80001550:	00060593          	mv	a1,a2
    80001554:	0006861b          	sext.w	a2,a3
    80001558:	00002097          	auipc	ra,0x2
    8000155c:	c0c080e7          	jalr	-1012(ra) # 80003164 <__memmove>
    80001560:	00813083          	ld	ra,8(sp)
    80001564:	00013403          	ld	s0,0(sp)
    80001568:	00000513          	li	a0,0
    8000156c:	01010113          	addi	sp,sp,16
    80001570:	00008067          	ret
    80001574:	00003517          	auipc	a0,0x3
    80001578:	b2c50513          	addi	a0,a0,-1236 # 800040a0 <CONSOLE_STATUS+0x90>
    8000157c:	00001097          	auipc	ra,0x1
    80001580:	8e0080e7          	jalr	-1824(ra) # 80001e5c <panic>

0000000080001584 <trapinit>:
    80001584:	ff010113          	addi	sp,sp,-16
    80001588:	00813423          	sd	s0,8(sp)
    8000158c:	01010413          	addi	s0,sp,16
    80001590:	00813403          	ld	s0,8(sp)
    80001594:	00003597          	auipc	a1,0x3
    80001598:	b3458593          	addi	a1,a1,-1228 # 800040c8 <CONSOLE_STATUS+0xb8>
    8000159c:	00004517          	auipc	a0,0x4
    800015a0:	e2450513          	addi	a0,a0,-476 # 800053c0 <tickslock>
    800015a4:	01010113          	addi	sp,sp,16
    800015a8:	00001317          	auipc	t1,0x1
    800015ac:	5c030067          	jr	1472(t1) # 80002b68 <initlock>

00000000800015b0 <trapinithart>:
    800015b0:	ff010113          	addi	sp,sp,-16
    800015b4:	00813423          	sd	s0,8(sp)
    800015b8:	01010413          	addi	s0,sp,16
    800015bc:	00000797          	auipc	a5,0x0
    800015c0:	2f478793          	addi	a5,a5,756 # 800018b0 <kernelvec>
    800015c4:	10579073          	csrw	stvec,a5
    800015c8:	00813403          	ld	s0,8(sp)
    800015cc:	01010113          	addi	sp,sp,16
    800015d0:	00008067          	ret

00000000800015d4 <usertrap>:
    800015d4:	ff010113          	addi	sp,sp,-16
    800015d8:	00813423          	sd	s0,8(sp)
    800015dc:	01010413          	addi	s0,sp,16
    800015e0:	00813403          	ld	s0,8(sp)
    800015e4:	01010113          	addi	sp,sp,16
    800015e8:	00008067          	ret

00000000800015ec <usertrapret>:
    800015ec:	ff010113          	addi	sp,sp,-16
    800015f0:	00813423          	sd	s0,8(sp)
    800015f4:	01010413          	addi	s0,sp,16
    800015f8:	00813403          	ld	s0,8(sp)
    800015fc:	01010113          	addi	sp,sp,16
    80001600:	00008067          	ret

0000000080001604 <kerneltrap>:
    80001604:	fe010113          	addi	sp,sp,-32
    80001608:	00813823          	sd	s0,16(sp)
    8000160c:	00113c23          	sd	ra,24(sp)
    80001610:	00913423          	sd	s1,8(sp)
    80001614:	02010413          	addi	s0,sp,32
    80001618:	142025f3          	csrr	a1,scause
    8000161c:	100027f3          	csrr	a5,sstatus
    80001620:	0027f793          	andi	a5,a5,2
    80001624:	10079c63          	bnez	a5,8000173c <kerneltrap+0x138>
    80001628:	142027f3          	csrr	a5,scause
    8000162c:	0207ce63          	bltz	a5,80001668 <kerneltrap+0x64>
    80001630:	00003517          	auipc	a0,0x3
    80001634:	ae050513          	addi	a0,a0,-1312 # 80004110 <CONSOLE_STATUS+0x100>
    80001638:	00001097          	auipc	ra,0x1
    8000163c:	880080e7          	jalr	-1920(ra) # 80001eb8 <__printf>
    80001640:	141025f3          	csrr	a1,sepc
    80001644:	14302673          	csrr	a2,stval
    80001648:	00003517          	auipc	a0,0x3
    8000164c:	ad850513          	addi	a0,a0,-1320 # 80004120 <CONSOLE_STATUS+0x110>
    80001650:	00001097          	auipc	ra,0x1
    80001654:	868080e7          	jalr	-1944(ra) # 80001eb8 <__printf>
    80001658:	00003517          	auipc	a0,0x3
    8000165c:	ae050513          	addi	a0,a0,-1312 # 80004138 <CONSOLE_STATUS+0x128>
    80001660:	00000097          	auipc	ra,0x0
    80001664:	7fc080e7          	jalr	2044(ra) # 80001e5c <panic>
    80001668:	0ff7f713          	andi	a4,a5,255
    8000166c:	00900693          	li	a3,9
    80001670:	04d70063          	beq	a4,a3,800016b0 <kerneltrap+0xac>
    80001674:	fff00713          	li	a4,-1
    80001678:	03f71713          	slli	a4,a4,0x3f
    8000167c:	00170713          	addi	a4,a4,1
    80001680:	fae798e3          	bne	a5,a4,80001630 <kerneltrap+0x2c>
    80001684:	00000097          	auipc	ra,0x0
    80001688:	e00080e7          	jalr	-512(ra) # 80001484 <cpuid>
    8000168c:	06050663          	beqz	a0,800016f8 <kerneltrap+0xf4>
    80001690:	144027f3          	csrr	a5,sip
    80001694:	ffd7f793          	andi	a5,a5,-3
    80001698:	14479073          	csrw	sip,a5
    8000169c:	01813083          	ld	ra,24(sp)
    800016a0:	01013403          	ld	s0,16(sp)
    800016a4:	00813483          	ld	s1,8(sp)
    800016a8:	02010113          	addi	sp,sp,32
    800016ac:	00008067          	ret
    800016b0:	00000097          	auipc	ra,0x0
    800016b4:	3c4080e7          	jalr	964(ra) # 80001a74 <plic_claim>
    800016b8:	00a00793          	li	a5,10
    800016bc:	00050493          	mv	s1,a0
    800016c0:	06f50863          	beq	a0,a5,80001730 <kerneltrap+0x12c>
    800016c4:	fc050ce3          	beqz	a0,8000169c <kerneltrap+0x98>
    800016c8:	00050593          	mv	a1,a0
    800016cc:	00003517          	auipc	a0,0x3
    800016d0:	a2450513          	addi	a0,a0,-1500 # 800040f0 <CONSOLE_STATUS+0xe0>
    800016d4:	00000097          	auipc	ra,0x0
    800016d8:	7e4080e7          	jalr	2020(ra) # 80001eb8 <__printf>
    800016dc:	01013403          	ld	s0,16(sp)
    800016e0:	01813083          	ld	ra,24(sp)
    800016e4:	00048513          	mv	a0,s1
    800016e8:	00813483          	ld	s1,8(sp)
    800016ec:	02010113          	addi	sp,sp,32
    800016f0:	00000317          	auipc	t1,0x0
    800016f4:	3bc30067          	jr	956(t1) # 80001aac <plic_complete>
    800016f8:	00004517          	auipc	a0,0x4
    800016fc:	cc850513          	addi	a0,a0,-824 # 800053c0 <tickslock>
    80001700:	00001097          	auipc	ra,0x1
    80001704:	48c080e7          	jalr	1164(ra) # 80002b8c <acquire>
    80001708:	00003717          	auipc	a4,0x3
    8000170c:	bcc70713          	addi	a4,a4,-1076 # 800042d4 <ticks>
    80001710:	00072783          	lw	a5,0(a4)
    80001714:	00004517          	auipc	a0,0x4
    80001718:	cac50513          	addi	a0,a0,-852 # 800053c0 <tickslock>
    8000171c:	0017879b          	addiw	a5,a5,1
    80001720:	00f72023          	sw	a5,0(a4)
    80001724:	00001097          	auipc	ra,0x1
    80001728:	534080e7          	jalr	1332(ra) # 80002c58 <release>
    8000172c:	f65ff06f          	j	80001690 <kerneltrap+0x8c>
    80001730:	00001097          	auipc	ra,0x1
    80001734:	090080e7          	jalr	144(ra) # 800027c0 <uartintr>
    80001738:	fa5ff06f          	j	800016dc <kerneltrap+0xd8>
    8000173c:	00003517          	auipc	a0,0x3
    80001740:	99450513          	addi	a0,a0,-1644 # 800040d0 <CONSOLE_STATUS+0xc0>
    80001744:	00000097          	auipc	ra,0x0
    80001748:	718080e7          	jalr	1816(ra) # 80001e5c <panic>

000000008000174c <clockintr>:
    8000174c:	fe010113          	addi	sp,sp,-32
    80001750:	00813823          	sd	s0,16(sp)
    80001754:	00913423          	sd	s1,8(sp)
    80001758:	00113c23          	sd	ra,24(sp)
    8000175c:	02010413          	addi	s0,sp,32
    80001760:	00004497          	auipc	s1,0x4
    80001764:	c6048493          	addi	s1,s1,-928 # 800053c0 <tickslock>
    80001768:	00048513          	mv	a0,s1
    8000176c:	00001097          	auipc	ra,0x1
    80001770:	420080e7          	jalr	1056(ra) # 80002b8c <acquire>
    80001774:	00003717          	auipc	a4,0x3
    80001778:	b6070713          	addi	a4,a4,-1184 # 800042d4 <ticks>
    8000177c:	00072783          	lw	a5,0(a4)
    80001780:	01013403          	ld	s0,16(sp)
    80001784:	01813083          	ld	ra,24(sp)
    80001788:	00048513          	mv	a0,s1
    8000178c:	0017879b          	addiw	a5,a5,1
    80001790:	00813483          	ld	s1,8(sp)
    80001794:	00f72023          	sw	a5,0(a4)
    80001798:	02010113          	addi	sp,sp,32
    8000179c:	00001317          	auipc	t1,0x1
    800017a0:	4bc30067          	jr	1212(t1) # 80002c58 <release>

00000000800017a4 <devintr>:
    800017a4:	142027f3          	csrr	a5,scause
    800017a8:	00000513          	li	a0,0
    800017ac:	0007c463          	bltz	a5,800017b4 <devintr+0x10>
    800017b0:	00008067          	ret
    800017b4:	fe010113          	addi	sp,sp,-32
    800017b8:	00813823          	sd	s0,16(sp)
    800017bc:	00113c23          	sd	ra,24(sp)
    800017c0:	00913423          	sd	s1,8(sp)
    800017c4:	02010413          	addi	s0,sp,32
    800017c8:	0ff7f713          	andi	a4,a5,255
    800017cc:	00900693          	li	a3,9
    800017d0:	04d70c63          	beq	a4,a3,80001828 <devintr+0x84>
    800017d4:	fff00713          	li	a4,-1
    800017d8:	03f71713          	slli	a4,a4,0x3f
    800017dc:	00170713          	addi	a4,a4,1
    800017e0:	00e78c63          	beq	a5,a4,800017f8 <devintr+0x54>
    800017e4:	01813083          	ld	ra,24(sp)
    800017e8:	01013403          	ld	s0,16(sp)
    800017ec:	00813483          	ld	s1,8(sp)
    800017f0:	02010113          	addi	sp,sp,32
    800017f4:	00008067          	ret
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	c8c080e7          	jalr	-884(ra) # 80001484 <cpuid>
    80001800:	06050663          	beqz	a0,8000186c <devintr+0xc8>
    80001804:	144027f3          	csrr	a5,sip
    80001808:	ffd7f793          	andi	a5,a5,-3
    8000180c:	14479073          	csrw	sip,a5
    80001810:	01813083          	ld	ra,24(sp)
    80001814:	01013403          	ld	s0,16(sp)
    80001818:	00813483          	ld	s1,8(sp)
    8000181c:	00200513          	li	a0,2
    80001820:	02010113          	addi	sp,sp,32
    80001824:	00008067          	ret
    80001828:	00000097          	auipc	ra,0x0
    8000182c:	24c080e7          	jalr	588(ra) # 80001a74 <plic_claim>
    80001830:	00a00793          	li	a5,10
    80001834:	00050493          	mv	s1,a0
    80001838:	06f50663          	beq	a0,a5,800018a4 <devintr+0x100>
    8000183c:	00100513          	li	a0,1
    80001840:	fa0482e3          	beqz	s1,800017e4 <devintr+0x40>
    80001844:	00048593          	mv	a1,s1
    80001848:	00003517          	auipc	a0,0x3
    8000184c:	8a850513          	addi	a0,a0,-1880 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001850:	00000097          	auipc	ra,0x0
    80001854:	668080e7          	jalr	1640(ra) # 80001eb8 <__printf>
    80001858:	00048513          	mv	a0,s1
    8000185c:	00000097          	auipc	ra,0x0
    80001860:	250080e7          	jalr	592(ra) # 80001aac <plic_complete>
    80001864:	00100513          	li	a0,1
    80001868:	f7dff06f          	j	800017e4 <devintr+0x40>
    8000186c:	00004517          	auipc	a0,0x4
    80001870:	b5450513          	addi	a0,a0,-1196 # 800053c0 <tickslock>
    80001874:	00001097          	auipc	ra,0x1
    80001878:	318080e7          	jalr	792(ra) # 80002b8c <acquire>
    8000187c:	00003717          	auipc	a4,0x3
    80001880:	a5870713          	addi	a4,a4,-1448 # 800042d4 <ticks>
    80001884:	00072783          	lw	a5,0(a4)
    80001888:	00004517          	auipc	a0,0x4
    8000188c:	b3850513          	addi	a0,a0,-1224 # 800053c0 <tickslock>
    80001890:	0017879b          	addiw	a5,a5,1
    80001894:	00f72023          	sw	a5,0(a4)
    80001898:	00001097          	auipc	ra,0x1
    8000189c:	3c0080e7          	jalr	960(ra) # 80002c58 <release>
    800018a0:	f65ff06f          	j	80001804 <devintr+0x60>
    800018a4:	00001097          	auipc	ra,0x1
    800018a8:	f1c080e7          	jalr	-228(ra) # 800027c0 <uartintr>
    800018ac:	fadff06f          	j	80001858 <devintr+0xb4>

00000000800018b0 <kernelvec>:
    800018b0:	f0010113          	addi	sp,sp,-256
    800018b4:	00113023          	sd	ra,0(sp)
    800018b8:	00213423          	sd	sp,8(sp)
    800018bc:	00313823          	sd	gp,16(sp)
    800018c0:	00413c23          	sd	tp,24(sp)
    800018c4:	02513023          	sd	t0,32(sp)
    800018c8:	02613423          	sd	t1,40(sp)
    800018cc:	02713823          	sd	t2,48(sp)
    800018d0:	02813c23          	sd	s0,56(sp)
    800018d4:	04913023          	sd	s1,64(sp)
    800018d8:	04a13423          	sd	a0,72(sp)
    800018dc:	04b13823          	sd	a1,80(sp)
    800018e0:	04c13c23          	sd	a2,88(sp)
    800018e4:	06d13023          	sd	a3,96(sp)
    800018e8:	06e13423          	sd	a4,104(sp)
    800018ec:	06f13823          	sd	a5,112(sp)
    800018f0:	07013c23          	sd	a6,120(sp)
    800018f4:	09113023          	sd	a7,128(sp)
    800018f8:	09213423          	sd	s2,136(sp)
    800018fc:	09313823          	sd	s3,144(sp)
    80001900:	09413c23          	sd	s4,152(sp)
    80001904:	0b513023          	sd	s5,160(sp)
    80001908:	0b613423          	sd	s6,168(sp)
    8000190c:	0b713823          	sd	s7,176(sp)
    80001910:	0b813c23          	sd	s8,184(sp)
    80001914:	0d913023          	sd	s9,192(sp)
    80001918:	0da13423          	sd	s10,200(sp)
    8000191c:	0db13823          	sd	s11,208(sp)
    80001920:	0dc13c23          	sd	t3,216(sp)
    80001924:	0fd13023          	sd	t4,224(sp)
    80001928:	0fe13423          	sd	t5,232(sp)
    8000192c:	0ff13823          	sd	t6,240(sp)
    80001930:	cd5ff0ef          	jal	ra,80001604 <kerneltrap>
    80001934:	00013083          	ld	ra,0(sp)
    80001938:	00813103          	ld	sp,8(sp)
    8000193c:	01013183          	ld	gp,16(sp)
    80001940:	02013283          	ld	t0,32(sp)
    80001944:	02813303          	ld	t1,40(sp)
    80001948:	03013383          	ld	t2,48(sp)
    8000194c:	03813403          	ld	s0,56(sp)
    80001950:	04013483          	ld	s1,64(sp)
    80001954:	04813503          	ld	a0,72(sp)
    80001958:	05013583          	ld	a1,80(sp)
    8000195c:	05813603          	ld	a2,88(sp)
    80001960:	06013683          	ld	a3,96(sp)
    80001964:	06813703          	ld	a4,104(sp)
    80001968:	07013783          	ld	a5,112(sp)
    8000196c:	07813803          	ld	a6,120(sp)
    80001970:	08013883          	ld	a7,128(sp)
    80001974:	08813903          	ld	s2,136(sp)
    80001978:	09013983          	ld	s3,144(sp)
    8000197c:	09813a03          	ld	s4,152(sp)
    80001980:	0a013a83          	ld	s5,160(sp)
    80001984:	0a813b03          	ld	s6,168(sp)
    80001988:	0b013b83          	ld	s7,176(sp)
    8000198c:	0b813c03          	ld	s8,184(sp)
    80001990:	0c013c83          	ld	s9,192(sp)
    80001994:	0c813d03          	ld	s10,200(sp)
    80001998:	0d013d83          	ld	s11,208(sp)
    8000199c:	0d813e03          	ld	t3,216(sp)
    800019a0:	0e013e83          	ld	t4,224(sp)
    800019a4:	0e813f03          	ld	t5,232(sp)
    800019a8:	0f013f83          	ld	t6,240(sp)
    800019ac:	10010113          	addi	sp,sp,256
    800019b0:	10200073          	sret
    800019b4:	00000013          	nop
    800019b8:	00000013          	nop
    800019bc:	00000013          	nop

00000000800019c0 <timervec>:
    800019c0:	34051573          	csrrw	a0,mscratch,a0
    800019c4:	00b53023          	sd	a1,0(a0)
    800019c8:	00c53423          	sd	a2,8(a0)
    800019cc:	00d53823          	sd	a3,16(a0)
    800019d0:	01853583          	ld	a1,24(a0)
    800019d4:	02053603          	ld	a2,32(a0)
    800019d8:	0005b683          	ld	a3,0(a1)
    800019dc:	00c686b3          	add	a3,a3,a2
    800019e0:	00d5b023          	sd	a3,0(a1)
    800019e4:	00200593          	li	a1,2
    800019e8:	14459073          	csrw	sip,a1
    800019ec:	01053683          	ld	a3,16(a0)
    800019f0:	00853603          	ld	a2,8(a0)
    800019f4:	00053583          	ld	a1,0(a0)
    800019f8:	34051573          	csrrw	a0,mscratch,a0
    800019fc:	30200073          	mret

0000000080001a00 <plicinit>:
    80001a00:	ff010113          	addi	sp,sp,-16
    80001a04:	00813423          	sd	s0,8(sp)
    80001a08:	01010413          	addi	s0,sp,16
    80001a0c:	00813403          	ld	s0,8(sp)
    80001a10:	0c0007b7          	lui	a5,0xc000
    80001a14:	00100713          	li	a4,1
    80001a18:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80001a1c:	00e7a223          	sw	a4,4(a5)
    80001a20:	01010113          	addi	sp,sp,16
    80001a24:	00008067          	ret

0000000080001a28 <plicinithart>:
    80001a28:	ff010113          	addi	sp,sp,-16
    80001a2c:	00813023          	sd	s0,0(sp)
    80001a30:	00113423          	sd	ra,8(sp)
    80001a34:	01010413          	addi	s0,sp,16
    80001a38:	00000097          	auipc	ra,0x0
    80001a3c:	a4c080e7          	jalr	-1460(ra) # 80001484 <cpuid>
    80001a40:	0085171b          	slliw	a4,a0,0x8
    80001a44:	0c0027b7          	lui	a5,0xc002
    80001a48:	00e787b3          	add	a5,a5,a4
    80001a4c:	40200713          	li	a4,1026
    80001a50:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001a54:	00813083          	ld	ra,8(sp)
    80001a58:	00013403          	ld	s0,0(sp)
    80001a5c:	00d5151b          	slliw	a0,a0,0xd
    80001a60:	0c2017b7          	lui	a5,0xc201
    80001a64:	00a78533          	add	a0,a5,a0
    80001a68:	00052023          	sw	zero,0(a0)
    80001a6c:	01010113          	addi	sp,sp,16
    80001a70:	00008067          	ret

0000000080001a74 <plic_claim>:
    80001a74:	ff010113          	addi	sp,sp,-16
    80001a78:	00813023          	sd	s0,0(sp)
    80001a7c:	00113423          	sd	ra,8(sp)
    80001a80:	01010413          	addi	s0,sp,16
    80001a84:	00000097          	auipc	ra,0x0
    80001a88:	a00080e7          	jalr	-1536(ra) # 80001484 <cpuid>
    80001a8c:	00813083          	ld	ra,8(sp)
    80001a90:	00013403          	ld	s0,0(sp)
    80001a94:	00d5151b          	slliw	a0,a0,0xd
    80001a98:	0c2017b7          	lui	a5,0xc201
    80001a9c:	00a78533          	add	a0,a5,a0
    80001aa0:	00452503          	lw	a0,4(a0)
    80001aa4:	01010113          	addi	sp,sp,16
    80001aa8:	00008067          	ret

0000000080001aac <plic_complete>:
    80001aac:	fe010113          	addi	sp,sp,-32
    80001ab0:	00813823          	sd	s0,16(sp)
    80001ab4:	00913423          	sd	s1,8(sp)
    80001ab8:	00113c23          	sd	ra,24(sp)
    80001abc:	02010413          	addi	s0,sp,32
    80001ac0:	00050493          	mv	s1,a0
    80001ac4:	00000097          	auipc	ra,0x0
    80001ac8:	9c0080e7          	jalr	-1600(ra) # 80001484 <cpuid>
    80001acc:	01813083          	ld	ra,24(sp)
    80001ad0:	01013403          	ld	s0,16(sp)
    80001ad4:	00d5179b          	slliw	a5,a0,0xd
    80001ad8:	0c201737          	lui	a4,0xc201
    80001adc:	00f707b3          	add	a5,a4,a5
    80001ae0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001ae4:	00813483          	ld	s1,8(sp)
    80001ae8:	02010113          	addi	sp,sp,32
    80001aec:	00008067          	ret

0000000080001af0 <consolewrite>:
    80001af0:	fb010113          	addi	sp,sp,-80
    80001af4:	04813023          	sd	s0,64(sp)
    80001af8:	04113423          	sd	ra,72(sp)
    80001afc:	02913c23          	sd	s1,56(sp)
    80001b00:	03213823          	sd	s2,48(sp)
    80001b04:	03313423          	sd	s3,40(sp)
    80001b08:	03413023          	sd	s4,32(sp)
    80001b0c:	01513c23          	sd	s5,24(sp)
    80001b10:	05010413          	addi	s0,sp,80
    80001b14:	06c05c63          	blez	a2,80001b8c <consolewrite+0x9c>
    80001b18:	00060993          	mv	s3,a2
    80001b1c:	00050a13          	mv	s4,a0
    80001b20:	00058493          	mv	s1,a1
    80001b24:	00000913          	li	s2,0
    80001b28:	fff00a93          	li	s5,-1
    80001b2c:	01c0006f          	j	80001b48 <consolewrite+0x58>
    80001b30:	fbf44503          	lbu	a0,-65(s0)
    80001b34:	0019091b          	addiw	s2,s2,1
    80001b38:	00148493          	addi	s1,s1,1
    80001b3c:	00001097          	auipc	ra,0x1
    80001b40:	a9c080e7          	jalr	-1380(ra) # 800025d8 <uartputc>
    80001b44:	03298063          	beq	s3,s2,80001b64 <consolewrite+0x74>
    80001b48:	00048613          	mv	a2,s1
    80001b4c:	00100693          	li	a3,1
    80001b50:	000a0593          	mv	a1,s4
    80001b54:	fbf40513          	addi	a0,s0,-65
    80001b58:	00000097          	auipc	ra,0x0
    80001b5c:	9e4080e7          	jalr	-1564(ra) # 8000153c <either_copyin>
    80001b60:	fd5518e3          	bne	a0,s5,80001b30 <consolewrite+0x40>
    80001b64:	04813083          	ld	ra,72(sp)
    80001b68:	04013403          	ld	s0,64(sp)
    80001b6c:	03813483          	ld	s1,56(sp)
    80001b70:	02813983          	ld	s3,40(sp)
    80001b74:	02013a03          	ld	s4,32(sp)
    80001b78:	01813a83          	ld	s5,24(sp)
    80001b7c:	00090513          	mv	a0,s2
    80001b80:	03013903          	ld	s2,48(sp)
    80001b84:	05010113          	addi	sp,sp,80
    80001b88:	00008067          	ret
    80001b8c:	00000913          	li	s2,0
    80001b90:	fd5ff06f          	j	80001b64 <consolewrite+0x74>

0000000080001b94 <consoleread>:
    80001b94:	f9010113          	addi	sp,sp,-112
    80001b98:	06813023          	sd	s0,96(sp)
    80001b9c:	04913c23          	sd	s1,88(sp)
    80001ba0:	05213823          	sd	s2,80(sp)
    80001ba4:	05313423          	sd	s3,72(sp)
    80001ba8:	05413023          	sd	s4,64(sp)
    80001bac:	03513c23          	sd	s5,56(sp)
    80001bb0:	03613823          	sd	s6,48(sp)
    80001bb4:	03713423          	sd	s7,40(sp)
    80001bb8:	03813023          	sd	s8,32(sp)
    80001bbc:	06113423          	sd	ra,104(sp)
    80001bc0:	01913c23          	sd	s9,24(sp)
    80001bc4:	07010413          	addi	s0,sp,112
    80001bc8:	00060b93          	mv	s7,a2
    80001bcc:	00050913          	mv	s2,a0
    80001bd0:	00058c13          	mv	s8,a1
    80001bd4:	00060b1b          	sext.w	s6,a2
    80001bd8:	00004497          	auipc	s1,0x4
    80001bdc:	80048493          	addi	s1,s1,-2048 # 800053d8 <cons>
    80001be0:	00400993          	li	s3,4
    80001be4:	fff00a13          	li	s4,-1
    80001be8:	00a00a93          	li	s5,10
    80001bec:	05705e63          	blez	s7,80001c48 <consoleread+0xb4>
    80001bf0:	09c4a703          	lw	a4,156(s1)
    80001bf4:	0984a783          	lw	a5,152(s1)
    80001bf8:	0007071b          	sext.w	a4,a4
    80001bfc:	08e78463          	beq	a5,a4,80001c84 <consoleread+0xf0>
    80001c00:	07f7f713          	andi	a4,a5,127
    80001c04:	00e48733          	add	a4,s1,a4
    80001c08:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001c0c:	0017869b          	addiw	a3,a5,1
    80001c10:	08d4ac23          	sw	a3,152(s1)
    80001c14:	00070c9b          	sext.w	s9,a4
    80001c18:	0b370663          	beq	a4,s3,80001cc4 <consoleread+0x130>
    80001c1c:	00100693          	li	a3,1
    80001c20:	f9f40613          	addi	a2,s0,-97
    80001c24:	000c0593          	mv	a1,s8
    80001c28:	00090513          	mv	a0,s2
    80001c2c:	f8e40fa3          	sb	a4,-97(s0)
    80001c30:	00000097          	auipc	ra,0x0
    80001c34:	8c0080e7          	jalr	-1856(ra) # 800014f0 <either_copyout>
    80001c38:	01450863          	beq	a0,s4,80001c48 <consoleread+0xb4>
    80001c3c:	001c0c13          	addi	s8,s8,1
    80001c40:	fffb8b9b          	addiw	s7,s7,-1
    80001c44:	fb5c94e3          	bne	s9,s5,80001bec <consoleread+0x58>
    80001c48:	000b851b          	sext.w	a0,s7
    80001c4c:	06813083          	ld	ra,104(sp)
    80001c50:	06013403          	ld	s0,96(sp)
    80001c54:	05813483          	ld	s1,88(sp)
    80001c58:	05013903          	ld	s2,80(sp)
    80001c5c:	04813983          	ld	s3,72(sp)
    80001c60:	04013a03          	ld	s4,64(sp)
    80001c64:	03813a83          	ld	s5,56(sp)
    80001c68:	02813b83          	ld	s7,40(sp)
    80001c6c:	02013c03          	ld	s8,32(sp)
    80001c70:	01813c83          	ld	s9,24(sp)
    80001c74:	40ab053b          	subw	a0,s6,a0
    80001c78:	03013b03          	ld	s6,48(sp)
    80001c7c:	07010113          	addi	sp,sp,112
    80001c80:	00008067          	ret
    80001c84:	00001097          	auipc	ra,0x1
    80001c88:	1d8080e7          	jalr	472(ra) # 80002e5c <push_on>
    80001c8c:	0984a703          	lw	a4,152(s1)
    80001c90:	09c4a783          	lw	a5,156(s1)
    80001c94:	0007879b          	sext.w	a5,a5
    80001c98:	fef70ce3          	beq	a4,a5,80001c90 <consoleread+0xfc>
    80001c9c:	00001097          	auipc	ra,0x1
    80001ca0:	234080e7          	jalr	564(ra) # 80002ed0 <pop_on>
    80001ca4:	0984a783          	lw	a5,152(s1)
    80001ca8:	07f7f713          	andi	a4,a5,127
    80001cac:	00e48733          	add	a4,s1,a4
    80001cb0:	01874703          	lbu	a4,24(a4)
    80001cb4:	0017869b          	addiw	a3,a5,1
    80001cb8:	08d4ac23          	sw	a3,152(s1)
    80001cbc:	00070c9b          	sext.w	s9,a4
    80001cc0:	f5371ee3          	bne	a4,s3,80001c1c <consoleread+0x88>
    80001cc4:	000b851b          	sext.w	a0,s7
    80001cc8:	f96bf2e3          	bgeu	s7,s6,80001c4c <consoleread+0xb8>
    80001ccc:	08f4ac23          	sw	a5,152(s1)
    80001cd0:	f7dff06f          	j	80001c4c <consoleread+0xb8>

0000000080001cd4 <consputc>:
    80001cd4:	10000793          	li	a5,256
    80001cd8:	00f50663          	beq	a0,a5,80001ce4 <consputc+0x10>
    80001cdc:	00001317          	auipc	t1,0x1
    80001ce0:	9f430067          	jr	-1548(t1) # 800026d0 <uartputc_sync>
    80001ce4:	ff010113          	addi	sp,sp,-16
    80001ce8:	00113423          	sd	ra,8(sp)
    80001cec:	00813023          	sd	s0,0(sp)
    80001cf0:	01010413          	addi	s0,sp,16
    80001cf4:	00800513          	li	a0,8
    80001cf8:	00001097          	auipc	ra,0x1
    80001cfc:	9d8080e7          	jalr	-1576(ra) # 800026d0 <uartputc_sync>
    80001d00:	02000513          	li	a0,32
    80001d04:	00001097          	auipc	ra,0x1
    80001d08:	9cc080e7          	jalr	-1588(ra) # 800026d0 <uartputc_sync>
    80001d0c:	00013403          	ld	s0,0(sp)
    80001d10:	00813083          	ld	ra,8(sp)
    80001d14:	00800513          	li	a0,8
    80001d18:	01010113          	addi	sp,sp,16
    80001d1c:	00001317          	auipc	t1,0x1
    80001d20:	9b430067          	jr	-1612(t1) # 800026d0 <uartputc_sync>

0000000080001d24 <consoleintr>:
    80001d24:	fe010113          	addi	sp,sp,-32
    80001d28:	00813823          	sd	s0,16(sp)
    80001d2c:	00913423          	sd	s1,8(sp)
    80001d30:	01213023          	sd	s2,0(sp)
    80001d34:	00113c23          	sd	ra,24(sp)
    80001d38:	02010413          	addi	s0,sp,32
    80001d3c:	00003917          	auipc	s2,0x3
    80001d40:	69c90913          	addi	s2,s2,1692 # 800053d8 <cons>
    80001d44:	00050493          	mv	s1,a0
    80001d48:	00090513          	mv	a0,s2
    80001d4c:	00001097          	auipc	ra,0x1
    80001d50:	e40080e7          	jalr	-448(ra) # 80002b8c <acquire>
    80001d54:	02048c63          	beqz	s1,80001d8c <consoleintr+0x68>
    80001d58:	0a092783          	lw	a5,160(s2)
    80001d5c:	09892703          	lw	a4,152(s2)
    80001d60:	07f00693          	li	a3,127
    80001d64:	40e7873b          	subw	a4,a5,a4
    80001d68:	02e6e263          	bltu	a3,a4,80001d8c <consoleintr+0x68>
    80001d6c:	00d00713          	li	a4,13
    80001d70:	04e48063          	beq	s1,a4,80001db0 <consoleintr+0x8c>
    80001d74:	07f7f713          	andi	a4,a5,127
    80001d78:	00e90733          	add	a4,s2,a4
    80001d7c:	0017879b          	addiw	a5,a5,1
    80001d80:	0af92023          	sw	a5,160(s2)
    80001d84:	00970c23          	sb	s1,24(a4)
    80001d88:	08f92e23          	sw	a5,156(s2)
    80001d8c:	01013403          	ld	s0,16(sp)
    80001d90:	01813083          	ld	ra,24(sp)
    80001d94:	00813483          	ld	s1,8(sp)
    80001d98:	00013903          	ld	s2,0(sp)
    80001d9c:	00003517          	auipc	a0,0x3
    80001da0:	63c50513          	addi	a0,a0,1596 # 800053d8 <cons>
    80001da4:	02010113          	addi	sp,sp,32
    80001da8:	00001317          	auipc	t1,0x1
    80001dac:	eb030067          	jr	-336(t1) # 80002c58 <release>
    80001db0:	00a00493          	li	s1,10
    80001db4:	fc1ff06f          	j	80001d74 <consoleintr+0x50>

0000000080001db8 <consoleinit>:
    80001db8:	fe010113          	addi	sp,sp,-32
    80001dbc:	00113c23          	sd	ra,24(sp)
    80001dc0:	00813823          	sd	s0,16(sp)
    80001dc4:	00913423          	sd	s1,8(sp)
    80001dc8:	02010413          	addi	s0,sp,32
    80001dcc:	00003497          	auipc	s1,0x3
    80001dd0:	60c48493          	addi	s1,s1,1548 # 800053d8 <cons>
    80001dd4:	00048513          	mv	a0,s1
    80001dd8:	00002597          	auipc	a1,0x2
    80001ddc:	37058593          	addi	a1,a1,880 # 80004148 <CONSOLE_STATUS+0x138>
    80001de0:	00001097          	auipc	ra,0x1
    80001de4:	d88080e7          	jalr	-632(ra) # 80002b68 <initlock>
    80001de8:	00000097          	auipc	ra,0x0
    80001dec:	7ac080e7          	jalr	1964(ra) # 80002594 <uartinit>
    80001df0:	01813083          	ld	ra,24(sp)
    80001df4:	01013403          	ld	s0,16(sp)
    80001df8:	00000797          	auipc	a5,0x0
    80001dfc:	d9c78793          	addi	a5,a5,-612 # 80001b94 <consoleread>
    80001e00:	0af4bc23          	sd	a5,184(s1)
    80001e04:	00000797          	auipc	a5,0x0
    80001e08:	cec78793          	addi	a5,a5,-788 # 80001af0 <consolewrite>
    80001e0c:	0cf4b023          	sd	a5,192(s1)
    80001e10:	00813483          	ld	s1,8(sp)
    80001e14:	02010113          	addi	sp,sp,32
    80001e18:	00008067          	ret

0000000080001e1c <console_read>:
    80001e1c:	ff010113          	addi	sp,sp,-16
    80001e20:	00813423          	sd	s0,8(sp)
    80001e24:	01010413          	addi	s0,sp,16
    80001e28:	00813403          	ld	s0,8(sp)
    80001e2c:	00003317          	auipc	t1,0x3
    80001e30:	66433303          	ld	t1,1636(t1) # 80005490 <devsw+0x10>
    80001e34:	01010113          	addi	sp,sp,16
    80001e38:	00030067          	jr	t1

0000000080001e3c <console_write>:
    80001e3c:	ff010113          	addi	sp,sp,-16
    80001e40:	00813423          	sd	s0,8(sp)
    80001e44:	01010413          	addi	s0,sp,16
    80001e48:	00813403          	ld	s0,8(sp)
    80001e4c:	00003317          	auipc	t1,0x3
    80001e50:	64c33303          	ld	t1,1612(t1) # 80005498 <devsw+0x18>
    80001e54:	01010113          	addi	sp,sp,16
    80001e58:	00030067          	jr	t1

0000000080001e5c <panic>:
    80001e5c:	fe010113          	addi	sp,sp,-32
    80001e60:	00113c23          	sd	ra,24(sp)
    80001e64:	00813823          	sd	s0,16(sp)
    80001e68:	00913423          	sd	s1,8(sp)
    80001e6c:	02010413          	addi	s0,sp,32
    80001e70:	00050493          	mv	s1,a0
    80001e74:	00002517          	auipc	a0,0x2
    80001e78:	2dc50513          	addi	a0,a0,732 # 80004150 <CONSOLE_STATUS+0x140>
    80001e7c:	00003797          	auipc	a5,0x3
    80001e80:	6a07ae23          	sw	zero,1724(a5) # 80005538 <pr+0x18>
    80001e84:	00000097          	auipc	ra,0x0
    80001e88:	034080e7          	jalr	52(ra) # 80001eb8 <__printf>
    80001e8c:	00048513          	mv	a0,s1
    80001e90:	00000097          	auipc	ra,0x0
    80001e94:	028080e7          	jalr	40(ra) # 80001eb8 <__printf>
    80001e98:	00002517          	auipc	a0,0x2
    80001e9c:	29850513          	addi	a0,a0,664 # 80004130 <CONSOLE_STATUS+0x120>
    80001ea0:	00000097          	auipc	ra,0x0
    80001ea4:	018080e7          	jalr	24(ra) # 80001eb8 <__printf>
    80001ea8:	00100793          	li	a5,1
    80001eac:	00002717          	auipc	a4,0x2
    80001eb0:	42f72623          	sw	a5,1068(a4) # 800042d8 <panicked>
    80001eb4:	0000006f          	j	80001eb4 <panic+0x58>

0000000080001eb8 <__printf>:
    80001eb8:	f3010113          	addi	sp,sp,-208
    80001ebc:	08813023          	sd	s0,128(sp)
    80001ec0:	07313423          	sd	s3,104(sp)
    80001ec4:	09010413          	addi	s0,sp,144
    80001ec8:	05813023          	sd	s8,64(sp)
    80001ecc:	08113423          	sd	ra,136(sp)
    80001ed0:	06913c23          	sd	s1,120(sp)
    80001ed4:	07213823          	sd	s2,112(sp)
    80001ed8:	07413023          	sd	s4,96(sp)
    80001edc:	05513c23          	sd	s5,88(sp)
    80001ee0:	05613823          	sd	s6,80(sp)
    80001ee4:	05713423          	sd	s7,72(sp)
    80001ee8:	03913c23          	sd	s9,56(sp)
    80001eec:	03a13823          	sd	s10,48(sp)
    80001ef0:	03b13423          	sd	s11,40(sp)
    80001ef4:	00003317          	auipc	t1,0x3
    80001ef8:	62c30313          	addi	t1,t1,1580 # 80005520 <pr>
    80001efc:	01832c03          	lw	s8,24(t1)
    80001f00:	00b43423          	sd	a1,8(s0)
    80001f04:	00c43823          	sd	a2,16(s0)
    80001f08:	00d43c23          	sd	a3,24(s0)
    80001f0c:	02e43023          	sd	a4,32(s0)
    80001f10:	02f43423          	sd	a5,40(s0)
    80001f14:	03043823          	sd	a6,48(s0)
    80001f18:	03143c23          	sd	a7,56(s0)
    80001f1c:	00050993          	mv	s3,a0
    80001f20:	4a0c1663          	bnez	s8,800023cc <__printf+0x514>
    80001f24:	60098c63          	beqz	s3,8000253c <__printf+0x684>
    80001f28:	0009c503          	lbu	a0,0(s3)
    80001f2c:	00840793          	addi	a5,s0,8
    80001f30:	f6f43c23          	sd	a5,-136(s0)
    80001f34:	00000493          	li	s1,0
    80001f38:	22050063          	beqz	a0,80002158 <__printf+0x2a0>
    80001f3c:	00002a37          	lui	s4,0x2
    80001f40:	00018ab7          	lui	s5,0x18
    80001f44:	000f4b37          	lui	s6,0xf4
    80001f48:	00989bb7          	lui	s7,0x989
    80001f4c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80001f50:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80001f54:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80001f58:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80001f5c:	00148c9b          	addiw	s9,s1,1
    80001f60:	02500793          	li	a5,37
    80001f64:	01998933          	add	s2,s3,s9
    80001f68:	38f51263          	bne	a0,a5,800022ec <__printf+0x434>
    80001f6c:	00094783          	lbu	a5,0(s2)
    80001f70:	00078c9b          	sext.w	s9,a5
    80001f74:	1e078263          	beqz	a5,80002158 <__printf+0x2a0>
    80001f78:	0024849b          	addiw	s1,s1,2
    80001f7c:	07000713          	li	a4,112
    80001f80:	00998933          	add	s2,s3,s1
    80001f84:	38e78a63          	beq	a5,a4,80002318 <__printf+0x460>
    80001f88:	20f76863          	bltu	a4,a5,80002198 <__printf+0x2e0>
    80001f8c:	42a78863          	beq	a5,a0,800023bc <__printf+0x504>
    80001f90:	06400713          	li	a4,100
    80001f94:	40e79663          	bne	a5,a4,800023a0 <__printf+0x4e8>
    80001f98:	f7843783          	ld	a5,-136(s0)
    80001f9c:	0007a603          	lw	a2,0(a5)
    80001fa0:	00878793          	addi	a5,a5,8
    80001fa4:	f6f43c23          	sd	a5,-136(s0)
    80001fa8:	42064a63          	bltz	a2,800023dc <__printf+0x524>
    80001fac:	00a00713          	li	a4,10
    80001fb0:	02e677bb          	remuw	a5,a2,a4
    80001fb4:	00002d97          	auipc	s11,0x2
    80001fb8:	1c4d8d93          	addi	s11,s11,452 # 80004178 <digits>
    80001fbc:	00900593          	li	a1,9
    80001fc0:	0006051b          	sext.w	a0,a2
    80001fc4:	00000c93          	li	s9,0
    80001fc8:	02079793          	slli	a5,a5,0x20
    80001fcc:	0207d793          	srli	a5,a5,0x20
    80001fd0:	00fd87b3          	add	a5,s11,a5
    80001fd4:	0007c783          	lbu	a5,0(a5)
    80001fd8:	02e656bb          	divuw	a3,a2,a4
    80001fdc:	f8f40023          	sb	a5,-128(s0)
    80001fe0:	14c5d863          	bge	a1,a2,80002130 <__printf+0x278>
    80001fe4:	06300593          	li	a1,99
    80001fe8:	00100c93          	li	s9,1
    80001fec:	02e6f7bb          	remuw	a5,a3,a4
    80001ff0:	02079793          	slli	a5,a5,0x20
    80001ff4:	0207d793          	srli	a5,a5,0x20
    80001ff8:	00fd87b3          	add	a5,s11,a5
    80001ffc:	0007c783          	lbu	a5,0(a5)
    80002000:	02e6d73b          	divuw	a4,a3,a4
    80002004:	f8f400a3          	sb	a5,-127(s0)
    80002008:	12a5f463          	bgeu	a1,a0,80002130 <__printf+0x278>
    8000200c:	00a00693          	li	a3,10
    80002010:	00900593          	li	a1,9
    80002014:	02d777bb          	remuw	a5,a4,a3
    80002018:	02079793          	slli	a5,a5,0x20
    8000201c:	0207d793          	srli	a5,a5,0x20
    80002020:	00fd87b3          	add	a5,s11,a5
    80002024:	0007c503          	lbu	a0,0(a5)
    80002028:	02d757bb          	divuw	a5,a4,a3
    8000202c:	f8a40123          	sb	a0,-126(s0)
    80002030:	48e5f263          	bgeu	a1,a4,800024b4 <__printf+0x5fc>
    80002034:	06300513          	li	a0,99
    80002038:	02d7f5bb          	remuw	a1,a5,a3
    8000203c:	02059593          	slli	a1,a1,0x20
    80002040:	0205d593          	srli	a1,a1,0x20
    80002044:	00bd85b3          	add	a1,s11,a1
    80002048:	0005c583          	lbu	a1,0(a1)
    8000204c:	02d7d7bb          	divuw	a5,a5,a3
    80002050:	f8b401a3          	sb	a1,-125(s0)
    80002054:	48e57263          	bgeu	a0,a4,800024d8 <__printf+0x620>
    80002058:	3e700513          	li	a0,999
    8000205c:	02d7f5bb          	remuw	a1,a5,a3
    80002060:	02059593          	slli	a1,a1,0x20
    80002064:	0205d593          	srli	a1,a1,0x20
    80002068:	00bd85b3          	add	a1,s11,a1
    8000206c:	0005c583          	lbu	a1,0(a1)
    80002070:	02d7d7bb          	divuw	a5,a5,a3
    80002074:	f8b40223          	sb	a1,-124(s0)
    80002078:	46e57663          	bgeu	a0,a4,800024e4 <__printf+0x62c>
    8000207c:	02d7f5bb          	remuw	a1,a5,a3
    80002080:	02059593          	slli	a1,a1,0x20
    80002084:	0205d593          	srli	a1,a1,0x20
    80002088:	00bd85b3          	add	a1,s11,a1
    8000208c:	0005c583          	lbu	a1,0(a1)
    80002090:	02d7d7bb          	divuw	a5,a5,a3
    80002094:	f8b402a3          	sb	a1,-123(s0)
    80002098:	46ea7863          	bgeu	s4,a4,80002508 <__printf+0x650>
    8000209c:	02d7f5bb          	remuw	a1,a5,a3
    800020a0:	02059593          	slli	a1,a1,0x20
    800020a4:	0205d593          	srli	a1,a1,0x20
    800020a8:	00bd85b3          	add	a1,s11,a1
    800020ac:	0005c583          	lbu	a1,0(a1)
    800020b0:	02d7d7bb          	divuw	a5,a5,a3
    800020b4:	f8b40323          	sb	a1,-122(s0)
    800020b8:	3eeaf863          	bgeu	s5,a4,800024a8 <__printf+0x5f0>
    800020bc:	02d7f5bb          	remuw	a1,a5,a3
    800020c0:	02059593          	slli	a1,a1,0x20
    800020c4:	0205d593          	srli	a1,a1,0x20
    800020c8:	00bd85b3          	add	a1,s11,a1
    800020cc:	0005c583          	lbu	a1,0(a1)
    800020d0:	02d7d7bb          	divuw	a5,a5,a3
    800020d4:	f8b403a3          	sb	a1,-121(s0)
    800020d8:	42eb7e63          	bgeu	s6,a4,80002514 <__printf+0x65c>
    800020dc:	02d7f5bb          	remuw	a1,a5,a3
    800020e0:	02059593          	slli	a1,a1,0x20
    800020e4:	0205d593          	srli	a1,a1,0x20
    800020e8:	00bd85b3          	add	a1,s11,a1
    800020ec:	0005c583          	lbu	a1,0(a1)
    800020f0:	02d7d7bb          	divuw	a5,a5,a3
    800020f4:	f8b40423          	sb	a1,-120(s0)
    800020f8:	42ebfc63          	bgeu	s7,a4,80002530 <__printf+0x678>
    800020fc:	02079793          	slli	a5,a5,0x20
    80002100:	0207d793          	srli	a5,a5,0x20
    80002104:	00fd8db3          	add	s11,s11,a5
    80002108:	000dc703          	lbu	a4,0(s11)
    8000210c:	00a00793          	li	a5,10
    80002110:	00900c93          	li	s9,9
    80002114:	f8e404a3          	sb	a4,-119(s0)
    80002118:	00065c63          	bgez	a2,80002130 <__printf+0x278>
    8000211c:	f9040713          	addi	a4,s0,-112
    80002120:	00f70733          	add	a4,a4,a5
    80002124:	02d00693          	li	a3,45
    80002128:	fed70823          	sb	a3,-16(a4)
    8000212c:	00078c93          	mv	s9,a5
    80002130:	f8040793          	addi	a5,s0,-128
    80002134:	01978cb3          	add	s9,a5,s9
    80002138:	f7f40d13          	addi	s10,s0,-129
    8000213c:	000cc503          	lbu	a0,0(s9)
    80002140:	fffc8c93          	addi	s9,s9,-1
    80002144:	00000097          	auipc	ra,0x0
    80002148:	b90080e7          	jalr	-1136(ra) # 80001cd4 <consputc>
    8000214c:	ffac98e3          	bne	s9,s10,8000213c <__printf+0x284>
    80002150:	00094503          	lbu	a0,0(s2)
    80002154:	e00514e3          	bnez	a0,80001f5c <__printf+0xa4>
    80002158:	1a0c1663          	bnez	s8,80002304 <__printf+0x44c>
    8000215c:	08813083          	ld	ra,136(sp)
    80002160:	08013403          	ld	s0,128(sp)
    80002164:	07813483          	ld	s1,120(sp)
    80002168:	07013903          	ld	s2,112(sp)
    8000216c:	06813983          	ld	s3,104(sp)
    80002170:	06013a03          	ld	s4,96(sp)
    80002174:	05813a83          	ld	s5,88(sp)
    80002178:	05013b03          	ld	s6,80(sp)
    8000217c:	04813b83          	ld	s7,72(sp)
    80002180:	04013c03          	ld	s8,64(sp)
    80002184:	03813c83          	ld	s9,56(sp)
    80002188:	03013d03          	ld	s10,48(sp)
    8000218c:	02813d83          	ld	s11,40(sp)
    80002190:	0d010113          	addi	sp,sp,208
    80002194:	00008067          	ret
    80002198:	07300713          	li	a4,115
    8000219c:	1ce78a63          	beq	a5,a4,80002370 <__printf+0x4b8>
    800021a0:	07800713          	li	a4,120
    800021a4:	1ee79e63          	bne	a5,a4,800023a0 <__printf+0x4e8>
    800021a8:	f7843783          	ld	a5,-136(s0)
    800021ac:	0007a703          	lw	a4,0(a5)
    800021b0:	00878793          	addi	a5,a5,8
    800021b4:	f6f43c23          	sd	a5,-136(s0)
    800021b8:	28074263          	bltz	a4,8000243c <__printf+0x584>
    800021bc:	00002d97          	auipc	s11,0x2
    800021c0:	fbcd8d93          	addi	s11,s11,-68 # 80004178 <digits>
    800021c4:	00f77793          	andi	a5,a4,15
    800021c8:	00fd87b3          	add	a5,s11,a5
    800021cc:	0007c683          	lbu	a3,0(a5)
    800021d0:	00f00613          	li	a2,15
    800021d4:	0007079b          	sext.w	a5,a4
    800021d8:	f8d40023          	sb	a3,-128(s0)
    800021dc:	0047559b          	srliw	a1,a4,0x4
    800021e0:	0047569b          	srliw	a3,a4,0x4
    800021e4:	00000c93          	li	s9,0
    800021e8:	0ee65063          	bge	a2,a4,800022c8 <__printf+0x410>
    800021ec:	00f6f693          	andi	a3,a3,15
    800021f0:	00dd86b3          	add	a3,s11,a3
    800021f4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800021f8:	0087d79b          	srliw	a5,a5,0x8
    800021fc:	00100c93          	li	s9,1
    80002200:	f8d400a3          	sb	a3,-127(s0)
    80002204:	0cb67263          	bgeu	a2,a1,800022c8 <__printf+0x410>
    80002208:	00f7f693          	andi	a3,a5,15
    8000220c:	00dd86b3          	add	a3,s11,a3
    80002210:	0006c583          	lbu	a1,0(a3)
    80002214:	00f00613          	li	a2,15
    80002218:	0047d69b          	srliw	a3,a5,0x4
    8000221c:	f8b40123          	sb	a1,-126(s0)
    80002220:	0047d593          	srli	a1,a5,0x4
    80002224:	28f67e63          	bgeu	a2,a5,800024c0 <__printf+0x608>
    80002228:	00f6f693          	andi	a3,a3,15
    8000222c:	00dd86b3          	add	a3,s11,a3
    80002230:	0006c503          	lbu	a0,0(a3)
    80002234:	0087d813          	srli	a6,a5,0x8
    80002238:	0087d69b          	srliw	a3,a5,0x8
    8000223c:	f8a401a3          	sb	a0,-125(s0)
    80002240:	28b67663          	bgeu	a2,a1,800024cc <__printf+0x614>
    80002244:	00f6f693          	andi	a3,a3,15
    80002248:	00dd86b3          	add	a3,s11,a3
    8000224c:	0006c583          	lbu	a1,0(a3)
    80002250:	00c7d513          	srli	a0,a5,0xc
    80002254:	00c7d69b          	srliw	a3,a5,0xc
    80002258:	f8b40223          	sb	a1,-124(s0)
    8000225c:	29067a63          	bgeu	a2,a6,800024f0 <__printf+0x638>
    80002260:	00f6f693          	andi	a3,a3,15
    80002264:	00dd86b3          	add	a3,s11,a3
    80002268:	0006c583          	lbu	a1,0(a3)
    8000226c:	0107d813          	srli	a6,a5,0x10
    80002270:	0107d69b          	srliw	a3,a5,0x10
    80002274:	f8b402a3          	sb	a1,-123(s0)
    80002278:	28a67263          	bgeu	a2,a0,800024fc <__printf+0x644>
    8000227c:	00f6f693          	andi	a3,a3,15
    80002280:	00dd86b3          	add	a3,s11,a3
    80002284:	0006c683          	lbu	a3,0(a3)
    80002288:	0147d79b          	srliw	a5,a5,0x14
    8000228c:	f8d40323          	sb	a3,-122(s0)
    80002290:	21067663          	bgeu	a2,a6,8000249c <__printf+0x5e4>
    80002294:	02079793          	slli	a5,a5,0x20
    80002298:	0207d793          	srli	a5,a5,0x20
    8000229c:	00fd8db3          	add	s11,s11,a5
    800022a0:	000dc683          	lbu	a3,0(s11)
    800022a4:	00800793          	li	a5,8
    800022a8:	00700c93          	li	s9,7
    800022ac:	f8d403a3          	sb	a3,-121(s0)
    800022b0:	00075c63          	bgez	a4,800022c8 <__printf+0x410>
    800022b4:	f9040713          	addi	a4,s0,-112
    800022b8:	00f70733          	add	a4,a4,a5
    800022bc:	02d00693          	li	a3,45
    800022c0:	fed70823          	sb	a3,-16(a4)
    800022c4:	00078c93          	mv	s9,a5
    800022c8:	f8040793          	addi	a5,s0,-128
    800022cc:	01978cb3          	add	s9,a5,s9
    800022d0:	f7f40d13          	addi	s10,s0,-129
    800022d4:	000cc503          	lbu	a0,0(s9)
    800022d8:	fffc8c93          	addi	s9,s9,-1
    800022dc:	00000097          	auipc	ra,0x0
    800022e0:	9f8080e7          	jalr	-1544(ra) # 80001cd4 <consputc>
    800022e4:	ff9d18e3          	bne	s10,s9,800022d4 <__printf+0x41c>
    800022e8:	0100006f          	j	800022f8 <__printf+0x440>
    800022ec:	00000097          	auipc	ra,0x0
    800022f0:	9e8080e7          	jalr	-1560(ra) # 80001cd4 <consputc>
    800022f4:	000c8493          	mv	s1,s9
    800022f8:	00094503          	lbu	a0,0(s2)
    800022fc:	c60510e3          	bnez	a0,80001f5c <__printf+0xa4>
    80002300:	e40c0ee3          	beqz	s8,8000215c <__printf+0x2a4>
    80002304:	00003517          	auipc	a0,0x3
    80002308:	21c50513          	addi	a0,a0,540 # 80005520 <pr>
    8000230c:	00001097          	auipc	ra,0x1
    80002310:	94c080e7          	jalr	-1716(ra) # 80002c58 <release>
    80002314:	e49ff06f          	j	8000215c <__printf+0x2a4>
    80002318:	f7843783          	ld	a5,-136(s0)
    8000231c:	03000513          	li	a0,48
    80002320:	01000d13          	li	s10,16
    80002324:	00878713          	addi	a4,a5,8
    80002328:	0007bc83          	ld	s9,0(a5)
    8000232c:	f6e43c23          	sd	a4,-136(s0)
    80002330:	00000097          	auipc	ra,0x0
    80002334:	9a4080e7          	jalr	-1628(ra) # 80001cd4 <consputc>
    80002338:	07800513          	li	a0,120
    8000233c:	00000097          	auipc	ra,0x0
    80002340:	998080e7          	jalr	-1640(ra) # 80001cd4 <consputc>
    80002344:	00002d97          	auipc	s11,0x2
    80002348:	e34d8d93          	addi	s11,s11,-460 # 80004178 <digits>
    8000234c:	03ccd793          	srli	a5,s9,0x3c
    80002350:	00fd87b3          	add	a5,s11,a5
    80002354:	0007c503          	lbu	a0,0(a5)
    80002358:	fffd0d1b          	addiw	s10,s10,-1
    8000235c:	004c9c93          	slli	s9,s9,0x4
    80002360:	00000097          	auipc	ra,0x0
    80002364:	974080e7          	jalr	-1676(ra) # 80001cd4 <consputc>
    80002368:	fe0d12e3          	bnez	s10,8000234c <__printf+0x494>
    8000236c:	f8dff06f          	j	800022f8 <__printf+0x440>
    80002370:	f7843783          	ld	a5,-136(s0)
    80002374:	0007bc83          	ld	s9,0(a5)
    80002378:	00878793          	addi	a5,a5,8
    8000237c:	f6f43c23          	sd	a5,-136(s0)
    80002380:	000c9a63          	bnez	s9,80002394 <__printf+0x4dc>
    80002384:	1080006f          	j	8000248c <__printf+0x5d4>
    80002388:	001c8c93          	addi	s9,s9,1
    8000238c:	00000097          	auipc	ra,0x0
    80002390:	948080e7          	jalr	-1720(ra) # 80001cd4 <consputc>
    80002394:	000cc503          	lbu	a0,0(s9)
    80002398:	fe0518e3          	bnez	a0,80002388 <__printf+0x4d0>
    8000239c:	f5dff06f          	j	800022f8 <__printf+0x440>
    800023a0:	02500513          	li	a0,37
    800023a4:	00000097          	auipc	ra,0x0
    800023a8:	930080e7          	jalr	-1744(ra) # 80001cd4 <consputc>
    800023ac:	000c8513          	mv	a0,s9
    800023b0:	00000097          	auipc	ra,0x0
    800023b4:	924080e7          	jalr	-1756(ra) # 80001cd4 <consputc>
    800023b8:	f41ff06f          	j	800022f8 <__printf+0x440>
    800023bc:	02500513          	li	a0,37
    800023c0:	00000097          	auipc	ra,0x0
    800023c4:	914080e7          	jalr	-1772(ra) # 80001cd4 <consputc>
    800023c8:	f31ff06f          	j	800022f8 <__printf+0x440>
    800023cc:	00030513          	mv	a0,t1
    800023d0:	00000097          	auipc	ra,0x0
    800023d4:	7bc080e7          	jalr	1980(ra) # 80002b8c <acquire>
    800023d8:	b4dff06f          	j	80001f24 <__printf+0x6c>
    800023dc:	40c0053b          	negw	a0,a2
    800023e0:	00a00713          	li	a4,10
    800023e4:	02e576bb          	remuw	a3,a0,a4
    800023e8:	00002d97          	auipc	s11,0x2
    800023ec:	d90d8d93          	addi	s11,s11,-624 # 80004178 <digits>
    800023f0:	ff700593          	li	a1,-9
    800023f4:	02069693          	slli	a3,a3,0x20
    800023f8:	0206d693          	srli	a3,a3,0x20
    800023fc:	00dd86b3          	add	a3,s11,a3
    80002400:	0006c683          	lbu	a3,0(a3)
    80002404:	02e557bb          	divuw	a5,a0,a4
    80002408:	f8d40023          	sb	a3,-128(s0)
    8000240c:	10b65e63          	bge	a2,a1,80002528 <__printf+0x670>
    80002410:	06300593          	li	a1,99
    80002414:	02e7f6bb          	remuw	a3,a5,a4
    80002418:	02069693          	slli	a3,a3,0x20
    8000241c:	0206d693          	srli	a3,a3,0x20
    80002420:	00dd86b3          	add	a3,s11,a3
    80002424:	0006c683          	lbu	a3,0(a3)
    80002428:	02e7d73b          	divuw	a4,a5,a4
    8000242c:	00200793          	li	a5,2
    80002430:	f8d400a3          	sb	a3,-127(s0)
    80002434:	bca5ece3          	bltu	a1,a0,8000200c <__printf+0x154>
    80002438:	ce5ff06f          	j	8000211c <__printf+0x264>
    8000243c:	40e007bb          	negw	a5,a4
    80002440:	00002d97          	auipc	s11,0x2
    80002444:	d38d8d93          	addi	s11,s11,-712 # 80004178 <digits>
    80002448:	00f7f693          	andi	a3,a5,15
    8000244c:	00dd86b3          	add	a3,s11,a3
    80002450:	0006c583          	lbu	a1,0(a3)
    80002454:	ff100613          	li	a2,-15
    80002458:	0047d69b          	srliw	a3,a5,0x4
    8000245c:	f8b40023          	sb	a1,-128(s0)
    80002460:	0047d59b          	srliw	a1,a5,0x4
    80002464:	0ac75e63          	bge	a4,a2,80002520 <__printf+0x668>
    80002468:	00f6f693          	andi	a3,a3,15
    8000246c:	00dd86b3          	add	a3,s11,a3
    80002470:	0006c603          	lbu	a2,0(a3)
    80002474:	00f00693          	li	a3,15
    80002478:	0087d79b          	srliw	a5,a5,0x8
    8000247c:	f8c400a3          	sb	a2,-127(s0)
    80002480:	d8b6e4e3          	bltu	a3,a1,80002208 <__printf+0x350>
    80002484:	00200793          	li	a5,2
    80002488:	e2dff06f          	j	800022b4 <__printf+0x3fc>
    8000248c:	00002c97          	auipc	s9,0x2
    80002490:	cccc8c93          	addi	s9,s9,-820 # 80004158 <CONSOLE_STATUS+0x148>
    80002494:	02800513          	li	a0,40
    80002498:	ef1ff06f          	j	80002388 <__printf+0x4d0>
    8000249c:	00700793          	li	a5,7
    800024a0:	00600c93          	li	s9,6
    800024a4:	e0dff06f          	j	800022b0 <__printf+0x3f8>
    800024a8:	00700793          	li	a5,7
    800024ac:	00600c93          	li	s9,6
    800024b0:	c69ff06f          	j	80002118 <__printf+0x260>
    800024b4:	00300793          	li	a5,3
    800024b8:	00200c93          	li	s9,2
    800024bc:	c5dff06f          	j	80002118 <__printf+0x260>
    800024c0:	00300793          	li	a5,3
    800024c4:	00200c93          	li	s9,2
    800024c8:	de9ff06f          	j	800022b0 <__printf+0x3f8>
    800024cc:	00400793          	li	a5,4
    800024d0:	00300c93          	li	s9,3
    800024d4:	dddff06f          	j	800022b0 <__printf+0x3f8>
    800024d8:	00400793          	li	a5,4
    800024dc:	00300c93          	li	s9,3
    800024e0:	c39ff06f          	j	80002118 <__printf+0x260>
    800024e4:	00500793          	li	a5,5
    800024e8:	00400c93          	li	s9,4
    800024ec:	c2dff06f          	j	80002118 <__printf+0x260>
    800024f0:	00500793          	li	a5,5
    800024f4:	00400c93          	li	s9,4
    800024f8:	db9ff06f          	j	800022b0 <__printf+0x3f8>
    800024fc:	00600793          	li	a5,6
    80002500:	00500c93          	li	s9,5
    80002504:	dadff06f          	j	800022b0 <__printf+0x3f8>
    80002508:	00600793          	li	a5,6
    8000250c:	00500c93          	li	s9,5
    80002510:	c09ff06f          	j	80002118 <__printf+0x260>
    80002514:	00800793          	li	a5,8
    80002518:	00700c93          	li	s9,7
    8000251c:	bfdff06f          	j	80002118 <__printf+0x260>
    80002520:	00100793          	li	a5,1
    80002524:	d91ff06f          	j	800022b4 <__printf+0x3fc>
    80002528:	00100793          	li	a5,1
    8000252c:	bf1ff06f          	j	8000211c <__printf+0x264>
    80002530:	00900793          	li	a5,9
    80002534:	00800c93          	li	s9,8
    80002538:	be1ff06f          	j	80002118 <__printf+0x260>
    8000253c:	00002517          	auipc	a0,0x2
    80002540:	c2450513          	addi	a0,a0,-988 # 80004160 <CONSOLE_STATUS+0x150>
    80002544:	00000097          	auipc	ra,0x0
    80002548:	918080e7          	jalr	-1768(ra) # 80001e5c <panic>

000000008000254c <printfinit>:
    8000254c:	fe010113          	addi	sp,sp,-32
    80002550:	00813823          	sd	s0,16(sp)
    80002554:	00913423          	sd	s1,8(sp)
    80002558:	00113c23          	sd	ra,24(sp)
    8000255c:	02010413          	addi	s0,sp,32
    80002560:	00003497          	auipc	s1,0x3
    80002564:	fc048493          	addi	s1,s1,-64 # 80005520 <pr>
    80002568:	00048513          	mv	a0,s1
    8000256c:	00002597          	auipc	a1,0x2
    80002570:	c0458593          	addi	a1,a1,-1020 # 80004170 <CONSOLE_STATUS+0x160>
    80002574:	00000097          	auipc	ra,0x0
    80002578:	5f4080e7          	jalr	1524(ra) # 80002b68 <initlock>
    8000257c:	01813083          	ld	ra,24(sp)
    80002580:	01013403          	ld	s0,16(sp)
    80002584:	0004ac23          	sw	zero,24(s1)
    80002588:	00813483          	ld	s1,8(sp)
    8000258c:	02010113          	addi	sp,sp,32
    80002590:	00008067          	ret

0000000080002594 <uartinit>:
    80002594:	ff010113          	addi	sp,sp,-16
    80002598:	00813423          	sd	s0,8(sp)
    8000259c:	01010413          	addi	s0,sp,16
    800025a0:	100007b7          	lui	a5,0x10000
    800025a4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800025a8:	f8000713          	li	a4,-128
    800025ac:	00e781a3          	sb	a4,3(a5)
    800025b0:	00300713          	li	a4,3
    800025b4:	00e78023          	sb	a4,0(a5)
    800025b8:	000780a3          	sb	zero,1(a5)
    800025bc:	00e781a3          	sb	a4,3(a5)
    800025c0:	00700693          	li	a3,7
    800025c4:	00d78123          	sb	a3,2(a5)
    800025c8:	00e780a3          	sb	a4,1(a5)
    800025cc:	00813403          	ld	s0,8(sp)
    800025d0:	01010113          	addi	sp,sp,16
    800025d4:	00008067          	ret

00000000800025d8 <uartputc>:
    800025d8:	00002797          	auipc	a5,0x2
    800025dc:	d007a783          	lw	a5,-768(a5) # 800042d8 <panicked>
    800025e0:	00078463          	beqz	a5,800025e8 <uartputc+0x10>
    800025e4:	0000006f          	j	800025e4 <uartputc+0xc>
    800025e8:	fd010113          	addi	sp,sp,-48
    800025ec:	02813023          	sd	s0,32(sp)
    800025f0:	00913c23          	sd	s1,24(sp)
    800025f4:	01213823          	sd	s2,16(sp)
    800025f8:	01313423          	sd	s3,8(sp)
    800025fc:	02113423          	sd	ra,40(sp)
    80002600:	03010413          	addi	s0,sp,48
    80002604:	00002917          	auipc	s2,0x2
    80002608:	cdc90913          	addi	s2,s2,-804 # 800042e0 <uart_tx_r>
    8000260c:	00093783          	ld	a5,0(s2)
    80002610:	00002497          	auipc	s1,0x2
    80002614:	cd848493          	addi	s1,s1,-808 # 800042e8 <uart_tx_w>
    80002618:	0004b703          	ld	a4,0(s1)
    8000261c:	02078693          	addi	a3,a5,32
    80002620:	00050993          	mv	s3,a0
    80002624:	02e69c63          	bne	a3,a4,8000265c <uartputc+0x84>
    80002628:	00001097          	auipc	ra,0x1
    8000262c:	834080e7          	jalr	-1996(ra) # 80002e5c <push_on>
    80002630:	00093783          	ld	a5,0(s2)
    80002634:	0004b703          	ld	a4,0(s1)
    80002638:	02078793          	addi	a5,a5,32
    8000263c:	00e79463          	bne	a5,a4,80002644 <uartputc+0x6c>
    80002640:	0000006f          	j	80002640 <uartputc+0x68>
    80002644:	00001097          	auipc	ra,0x1
    80002648:	88c080e7          	jalr	-1908(ra) # 80002ed0 <pop_on>
    8000264c:	00093783          	ld	a5,0(s2)
    80002650:	0004b703          	ld	a4,0(s1)
    80002654:	02078693          	addi	a3,a5,32
    80002658:	fce688e3          	beq	a3,a4,80002628 <uartputc+0x50>
    8000265c:	01f77693          	andi	a3,a4,31
    80002660:	00003597          	auipc	a1,0x3
    80002664:	ee058593          	addi	a1,a1,-288 # 80005540 <uart_tx_buf>
    80002668:	00d586b3          	add	a3,a1,a3
    8000266c:	00170713          	addi	a4,a4,1
    80002670:	01368023          	sb	s3,0(a3)
    80002674:	00e4b023          	sd	a4,0(s1)
    80002678:	10000637          	lui	a2,0x10000
    8000267c:	02f71063          	bne	a4,a5,8000269c <uartputc+0xc4>
    80002680:	0340006f          	j	800026b4 <uartputc+0xdc>
    80002684:	00074703          	lbu	a4,0(a4)
    80002688:	00f93023          	sd	a5,0(s2)
    8000268c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002690:	00093783          	ld	a5,0(s2)
    80002694:	0004b703          	ld	a4,0(s1)
    80002698:	00f70e63          	beq	a4,a5,800026b4 <uartputc+0xdc>
    8000269c:	00564683          	lbu	a3,5(a2)
    800026a0:	01f7f713          	andi	a4,a5,31
    800026a4:	00e58733          	add	a4,a1,a4
    800026a8:	0206f693          	andi	a3,a3,32
    800026ac:	00178793          	addi	a5,a5,1
    800026b0:	fc069ae3          	bnez	a3,80002684 <uartputc+0xac>
    800026b4:	02813083          	ld	ra,40(sp)
    800026b8:	02013403          	ld	s0,32(sp)
    800026bc:	01813483          	ld	s1,24(sp)
    800026c0:	01013903          	ld	s2,16(sp)
    800026c4:	00813983          	ld	s3,8(sp)
    800026c8:	03010113          	addi	sp,sp,48
    800026cc:	00008067          	ret

00000000800026d0 <uartputc_sync>:
    800026d0:	ff010113          	addi	sp,sp,-16
    800026d4:	00813423          	sd	s0,8(sp)
    800026d8:	01010413          	addi	s0,sp,16
    800026dc:	00002717          	auipc	a4,0x2
    800026e0:	bfc72703          	lw	a4,-1028(a4) # 800042d8 <panicked>
    800026e4:	02071663          	bnez	a4,80002710 <uartputc_sync+0x40>
    800026e8:	00050793          	mv	a5,a0
    800026ec:	100006b7          	lui	a3,0x10000
    800026f0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800026f4:	02077713          	andi	a4,a4,32
    800026f8:	fe070ce3          	beqz	a4,800026f0 <uartputc_sync+0x20>
    800026fc:	0ff7f793          	andi	a5,a5,255
    80002700:	00f68023          	sb	a5,0(a3)
    80002704:	00813403          	ld	s0,8(sp)
    80002708:	01010113          	addi	sp,sp,16
    8000270c:	00008067          	ret
    80002710:	0000006f          	j	80002710 <uartputc_sync+0x40>

0000000080002714 <uartstart>:
    80002714:	ff010113          	addi	sp,sp,-16
    80002718:	00813423          	sd	s0,8(sp)
    8000271c:	01010413          	addi	s0,sp,16
    80002720:	00002617          	auipc	a2,0x2
    80002724:	bc060613          	addi	a2,a2,-1088 # 800042e0 <uart_tx_r>
    80002728:	00002517          	auipc	a0,0x2
    8000272c:	bc050513          	addi	a0,a0,-1088 # 800042e8 <uart_tx_w>
    80002730:	00063783          	ld	a5,0(a2)
    80002734:	00053703          	ld	a4,0(a0)
    80002738:	04f70263          	beq	a4,a5,8000277c <uartstart+0x68>
    8000273c:	100005b7          	lui	a1,0x10000
    80002740:	00003817          	auipc	a6,0x3
    80002744:	e0080813          	addi	a6,a6,-512 # 80005540 <uart_tx_buf>
    80002748:	01c0006f          	j	80002764 <uartstart+0x50>
    8000274c:	0006c703          	lbu	a4,0(a3)
    80002750:	00f63023          	sd	a5,0(a2)
    80002754:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002758:	00063783          	ld	a5,0(a2)
    8000275c:	00053703          	ld	a4,0(a0)
    80002760:	00f70e63          	beq	a4,a5,8000277c <uartstart+0x68>
    80002764:	01f7f713          	andi	a4,a5,31
    80002768:	00e806b3          	add	a3,a6,a4
    8000276c:	0055c703          	lbu	a4,5(a1)
    80002770:	00178793          	addi	a5,a5,1
    80002774:	02077713          	andi	a4,a4,32
    80002778:	fc071ae3          	bnez	a4,8000274c <uartstart+0x38>
    8000277c:	00813403          	ld	s0,8(sp)
    80002780:	01010113          	addi	sp,sp,16
    80002784:	00008067          	ret

0000000080002788 <uartgetc>:
    80002788:	ff010113          	addi	sp,sp,-16
    8000278c:	00813423          	sd	s0,8(sp)
    80002790:	01010413          	addi	s0,sp,16
    80002794:	10000737          	lui	a4,0x10000
    80002798:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000279c:	0017f793          	andi	a5,a5,1
    800027a0:	00078c63          	beqz	a5,800027b8 <uartgetc+0x30>
    800027a4:	00074503          	lbu	a0,0(a4)
    800027a8:	0ff57513          	andi	a0,a0,255
    800027ac:	00813403          	ld	s0,8(sp)
    800027b0:	01010113          	addi	sp,sp,16
    800027b4:	00008067          	ret
    800027b8:	fff00513          	li	a0,-1
    800027bc:	ff1ff06f          	j	800027ac <uartgetc+0x24>

00000000800027c0 <uartintr>:
    800027c0:	100007b7          	lui	a5,0x10000
    800027c4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800027c8:	0017f793          	andi	a5,a5,1
    800027cc:	0a078463          	beqz	a5,80002874 <uartintr+0xb4>
    800027d0:	fe010113          	addi	sp,sp,-32
    800027d4:	00813823          	sd	s0,16(sp)
    800027d8:	00913423          	sd	s1,8(sp)
    800027dc:	00113c23          	sd	ra,24(sp)
    800027e0:	02010413          	addi	s0,sp,32
    800027e4:	100004b7          	lui	s1,0x10000
    800027e8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800027ec:	0ff57513          	andi	a0,a0,255
    800027f0:	fffff097          	auipc	ra,0xfffff
    800027f4:	534080e7          	jalr	1332(ra) # 80001d24 <consoleintr>
    800027f8:	0054c783          	lbu	a5,5(s1)
    800027fc:	0017f793          	andi	a5,a5,1
    80002800:	fe0794e3          	bnez	a5,800027e8 <uartintr+0x28>
    80002804:	00002617          	auipc	a2,0x2
    80002808:	adc60613          	addi	a2,a2,-1316 # 800042e0 <uart_tx_r>
    8000280c:	00002517          	auipc	a0,0x2
    80002810:	adc50513          	addi	a0,a0,-1316 # 800042e8 <uart_tx_w>
    80002814:	00063783          	ld	a5,0(a2)
    80002818:	00053703          	ld	a4,0(a0)
    8000281c:	04f70263          	beq	a4,a5,80002860 <uartintr+0xa0>
    80002820:	100005b7          	lui	a1,0x10000
    80002824:	00003817          	auipc	a6,0x3
    80002828:	d1c80813          	addi	a6,a6,-740 # 80005540 <uart_tx_buf>
    8000282c:	01c0006f          	j	80002848 <uartintr+0x88>
    80002830:	0006c703          	lbu	a4,0(a3)
    80002834:	00f63023          	sd	a5,0(a2)
    80002838:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000283c:	00063783          	ld	a5,0(a2)
    80002840:	00053703          	ld	a4,0(a0)
    80002844:	00f70e63          	beq	a4,a5,80002860 <uartintr+0xa0>
    80002848:	01f7f713          	andi	a4,a5,31
    8000284c:	00e806b3          	add	a3,a6,a4
    80002850:	0055c703          	lbu	a4,5(a1)
    80002854:	00178793          	addi	a5,a5,1
    80002858:	02077713          	andi	a4,a4,32
    8000285c:	fc071ae3          	bnez	a4,80002830 <uartintr+0x70>
    80002860:	01813083          	ld	ra,24(sp)
    80002864:	01013403          	ld	s0,16(sp)
    80002868:	00813483          	ld	s1,8(sp)
    8000286c:	02010113          	addi	sp,sp,32
    80002870:	00008067          	ret
    80002874:	00002617          	auipc	a2,0x2
    80002878:	a6c60613          	addi	a2,a2,-1428 # 800042e0 <uart_tx_r>
    8000287c:	00002517          	auipc	a0,0x2
    80002880:	a6c50513          	addi	a0,a0,-1428 # 800042e8 <uart_tx_w>
    80002884:	00063783          	ld	a5,0(a2)
    80002888:	00053703          	ld	a4,0(a0)
    8000288c:	04f70263          	beq	a4,a5,800028d0 <uartintr+0x110>
    80002890:	100005b7          	lui	a1,0x10000
    80002894:	00003817          	auipc	a6,0x3
    80002898:	cac80813          	addi	a6,a6,-852 # 80005540 <uart_tx_buf>
    8000289c:	01c0006f          	j	800028b8 <uartintr+0xf8>
    800028a0:	0006c703          	lbu	a4,0(a3)
    800028a4:	00f63023          	sd	a5,0(a2)
    800028a8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800028ac:	00063783          	ld	a5,0(a2)
    800028b0:	00053703          	ld	a4,0(a0)
    800028b4:	02f70063          	beq	a4,a5,800028d4 <uartintr+0x114>
    800028b8:	01f7f713          	andi	a4,a5,31
    800028bc:	00e806b3          	add	a3,a6,a4
    800028c0:	0055c703          	lbu	a4,5(a1)
    800028c4:	00178793          	addi	a5,a5,1
    800028c8:	02077713          	andi	a4,a4,32
    800028cc:	fc071ae3          	bnez	a4,800028a0 <uartintr+0xe0>
    800028d0:	00008067          	ret
    800028d4:	00008067          	ret

00000000800028d8 <kinit>:
    800028d8:	fc010113          	addi	sp,sp,-64
    800028dc:	02913423          	sd	s1,40(sp)
    800028e0:	fffff7b7          	lui	a5,0xfffff
    800028e4:	00004497          	auipc	s1,0x4
    800028e8:	c7b48493          	addi	s1,s1,-901 # 8000655f <end+0xfff>
    800028ec:	02813823          	sd	s0,48(sp)
    800028f0:	01313c23          	sd	s3,24(sp)
    800028f4:	00f4f4b3          	and	s1,s1,a5
    800028f8:	02113c23          	sd	ra,56(sp)
    800028fc:	03213023          	sd	s2,32(sp)
    80002900:	01413823          	sd	s4,16(sp)
    80002904:	01513423          	sd	s5,8(sp)
    80002908:	04010413          	addi	s0,sp,64
    8000290c:	000017b7          	lui	a5,0x1
    80002910:	01100993          	li	s3,17
    80002914:	00f487b3          	add	a5,s1,a5
    80002918:	01b99993          	slli	s3,s3,0x1b
    8000291c:	06f9e063          	bltu	s3,a5,8000297c <kinit+0xa4>
    80002920:	00003a97          	auipc	s5,0x3
    80002924:	c40a8a93          	addi	s5,s5,-960 # 80005560 <end>
    80002928:	0754ec63          	bltu	s1,s5,800029a0 <kinit+0xc8>
    8000292c:	0734fa63          	bgeu	s1,s3,800029a0 <kinit+0xc8>
    80002930:	00088a37          	lui	s4,0x88
    80002934:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002938:	00002917          	auipc	s2,0x2
    8000293c:	9b890913          	addi	s2,s2,-1608 # 800042f0 <kmem>
    80002940:	00ca1a13          	slli	s4,s4,0xc
    80002944:	0140006f          	j	80002958 <kinit+0x80>
    80002948:	000017b7          	lui	a5,0x1
    8000294c:	00f484b3          	add	s1,s1,a5
    80002950:	0554e863          	bltu	s1,s5,800029a0 <kinit+0xc8>
    80002954:	0534f663          	bgeu	s1,s3,800029a0 <kinit+0xc8>
    80002958:	00001637          	lui	a2,0x1
    8000295c:	00100593          	li	a1,1
    80002960:	00048513          	mv	a0,s1
    80002964:	00000097          	auipc	ra,0x0
    80002968:	5e4080e7          	jalr	1508(ra) # 80002f48 <__memset>
    8000296c:	00093783          	ld	a5,0(s2)
    80002970:	00f4b023          	sd	a5,0(s1)
    80002974:	00993023          	sd	s1,0(s2)
    80002978:	fd4498e3          	bne	s1,s4,80002948 <kinit+0x70>
    8000297c:	03813083          	ld	ra,56(sp)
    80002980:	03013403          	ld	s0,48(sp)
    80002984:	02813483          	ld	s1,40(sp)
    80002988:	02013903          	ld	s2,32(sp)
    8000298c:	01813983          	ld	s3,24(sp)
    80002990:	01013a03          	ld	s4,16(sp)
    80002994:	00813a83          	ld	s5,8(sp)
    80002998:	04010113          	addi	sp,sp,64
    8000299c:	00008067          	ret
    800029a0:	00001517          	auipc	a0,0x1
    800029a4:	7f050513          	addi	a0,a0,2032 # 80004190 <digits+0x18>
    800029a8:	fffff097          	auipc	ra,0xfffff
    800029ac:	4b4080e7          	jalr	1204(ra) # 80001e5c <panic>

00000000800029b0 <freerange>:
    800029b0:	fc010113          	addi	sp,sp,-64
    800029b4:	000017b7          	lui	a5,0x1
    800029b8:	02913423          	sd	s1,40(sp)
    800029bc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800029c0:	009504b3          	add	s1,a0,s1
    800029c4:	fffff537          	lui	a0,0xfffff
    800029c8:	02813823          	sd	s0,48(sp)
    800029cc:	02113c23          	sd	ra,56(sp)
    800029d0:	03213023          	sd	s2,32(sp)
    800029d4:	01313c23          	sd	s3,24(sp)
    800029d8:	01413823          	sd	s4,16(sp)
    800029dc:	01513423          	sd	s5,8(sp)
    800029e0:	01613023          	sd	s6,0(sp)
    800029e4:	04010413          	addi	s0,sp,64
    800029e8:	00a4f4b3          	and	s1,s1,a0
    800029ec:	00f487b3          	add	a5,s1,a5
    800029f0:	06f5e463          	bltu	a1,a5,80002a58 <freerange+0xa8>
    800029f4:	00003a97          	auipc	s5,0x3
    800029f8:	b6ca8a93          	addi	s5,s5,-1172 # 80005560 <end>
    800029fc:	0954e263          	bltu	s1,s5,80002a80 <freerange+0xd0>
    80002a00:	01100993          	li	s3,17
    80002a04:	01b99993          	slli	s3,s3,0x1b
    80002a08:	0734fc63          	bgeu	s1,s3,80002a80 <freerange+0xd0>
    80002a0c:	00058a13          	mv	s4,a1
    80002a10:	00002917          	auipc	s2,0x2
    80002a14:	8e090913          	addi	s2,s2,-1824 # 800042f0 <kmem>
    80002a18:	00002b37          	lui	s6,0x2
    80002a1c:	0140006f          	j	80002a30 <freerange+0x80>
    80002a20:	000017b7          	lui	a5,0x1
    80002a24:	00f484b3          	add	s1,s1,a5
    80002a28:	0554ec63          	bltu	s1,s5,80002a80 <freerange+0xd0>
    80002a2c:	0534fa63          	bgeu	s1,s3,80002a80 <freerange+0xd0>
    80002a30:	00001637          	lui	a2,0x1
    80002a34:	00100593          	li	a1,1
    80002a38:	00048513          	mv	a0,s1
    80002a3c:	00000097          	auipc	ra,0x0
    80002a40:	50c080e7          	jalr	1292(ra) # 80002f48 <__memset>
    80002a44:	00093703          	ld	a4,0(s2)
    80002a48:	016487b3          	add	a5,s1,s6
    80002a4c:	00e4b023          	sd	a4,0(s1)
    80002a50:	00993023          	sd	s1,0(s2)
    80002a54:	fcfa76e3          	bgeu	s4,a5,80002a20 <freerange+0x70>
    80002a58:	03813083          	ld	ra,56(sp)
    80002a5c:	03013403          	ld	s0,48(sp)
    80002a60:	02813483          	ld	s1,40(sp)
    80002a64:	02013903          	ld	s2,32(sp)
    80002a68:	01813983          	ld	s3,24(sp)
    80002a6c:	01013a03          	ld	s4,16(sp)
    80002a70:	00813a83          	ld	s5,8(sp)
    80002a74:	00013b03          	ld	s6,0(sp)
    80002a78:	04010113          	addi	sp,sp,64
    80002a7c:	00008067          	ret
    80002a80:	00001517          	auipc	a0,0x1
    80002a84:	71050513          	addi	a0,a0,1808 # 80004190 <digits+0x18>
    80002a88:	fffff097          	auipc	ra,0xfffff
    80002a8c:	3d4080e7          	jalr	980(ra) # 80001e5c <panic>

0000000080002a90 <kfree>:
    80002a90:	fe010113          	addi	sp,sp,-32
    80002a94:	00813823          	sd	s0,16(sp)
    80002a98:	00113c23          	sd	ra,24(sp)
    80002a9c:	00913423          	sd	s1,8(sp)
    80002aa0:	02010413          	addi	s0,sp,32
    80002aa4:	03451793          	slli	a5,a0,0x34
    80002aa8:	04079c63          	bnez	a5,80002b00 <kfree+0x70>
    80002aac:	00003797          	auipc	a5,0x3
    80002ab0:	ab478793          	addi	a5,a5,-1356 # 80005560 <end>
    80002ab4:	00050493          	mv	s1,a0
    80002ab8:	04f56463          	bltu	a0,a5,80002b00 <kfree+0x70>
    80002abc:	01100793          	li	a5,17
    80002ac0:	01b79793          	slli	a5,a5,0x1b
    80002ac4:	02f57e63          	bgeu	a0,a5,80002b00 <kfree+0x70>
    80002ac8:	00001637          	lui	a2,0x1
    80002acc:	00100593          	li	a1,1
    80002ad0:	00000097          	auipc	ra,0x0
    80002ad4:	478080e7          	jalr	1144(ra) # 80002f48 <__memset>
    80002ad8:	00002797          	auipc	a5,0x2
    80002adc:	81878793          	addi	a5,a5,-2024 # 800042f0 <kmem>
    80002ae0:	0007b703          	ld	a4,0(a5)
    80002ae4:	01813083          	ld	ra,24(sp)
    80002ae8:	01013403          	ld	s0,16(sp)
    80002aec:	00e4b023          	sd	a4,0(s1)
    80002af0:	0097b023          	sd	s1,0(a5)
    80002af4:	00813483          	ld	s1,8(sp)
    80002af8:	02010113          	addi	sp,sp,32
    80002afc:	00008067          	ret
    80002b00:	00001517          	auipc	a0,0x1
    80002b04:	69050513          	addi	a0,a0,1680 # 80004190 <digits+0x18>
    80002b08:	fffff097          	auipc	ra,0xfffff
    80002b0c:	354080e7          	jalr	852(ra) # 80001e5c <panic>

0000000080002b10 <kalloc>:
    80002b10:	fe010113          	addi	sp,sp,-32
    80002b14:	00813823          	sd	s0,16(sp)
    80002b18:	00913423          	sd	s1,8(sp)
    80002b1c:	00113c23          	sd	ra,24(sp)
    80002b20:	02010413          	addi	s0,sp,32
    80002b24:	00001797          	auipc	a5,0x1
    80002b28:	7cc78793          	addi	a5,a5,1996 # 800042f0 <kmem>
    80002b2c:	0007b483          	ld	s1,0(a5)
    80002b30:	02048063          	beqz	s1,80002b50 <kalloc+0x40>
    80002b34:	0004b703          	ld	a4,0(s1)
    80002b38:	00001637          	lui	a2,0x1
    80002b3c:	00500593          	li	a1,5
    80002b40:	00048513          	mv	a0,s1
    80002b44:	00e7b023          	sd	a4,0(a5)
    80002b48:	00000097          	auipc	ra,0x0
    80002b4c:	400080e7          	jalr	1024(ra) # 80002f48 <__memset>
    80002b50:	01813083          	ld	ra,24(sp)
    80002b54:	01013403          	ld	s0,16(sp)
    80002b58:	00048513          	mv	a0,s1
    80002b5c:	00813483          	ld	s1,8(sp)
    80002b60:	02010113          	addi	sp,sp,32
    80002b64:	00008067          	ret

0000000080002b68 <initlock>:
    80002b68:	ff010113          	addi	sp,sp,-16
    80002b6c:	00813423          	sd	s0,8(sp)
    80002b70:	01010413          	addi	s0,sp,16
    80002b74:	00813403          	ld	s0,8(sp)
    80002b78:	00b53423          	sd	a1,8(a0)
    80002b7c:	00052023          	sw	zero,0(a0)
    80002b80:	00053823          	sd	zero,16(a0)
    80002b84:	01010113          	addi	sp,sp,16
    80002b88:	00008067          	ret

0000000080002b8c <acquire>:
    80002b8c:	fe010113          	addi	sp,sp,-32
    80002b90:	00813823          	sd	s0,16(sp)
    80002b94:	00913423          	sd	s1,8(sp)
    80002b98:	00113c23          	sd	ra,24(sp)
    80002b9c:	01213023          	sd	s2,0(sp)
    80002ba0:	02010413          	addi	s0,sp,32
    80002ba4:	00050493          	mv	s1,a0
    80002ba8:	10002973          	csrr	s2,sstatus
    80002bac:	100027f3          	csrr	a5,sstatus
    80002bb0:	ffd7f793          	andi	a5,a5,-3
    80002bb4:	10079073          	csrw	sstatus,a5
    80002bb8:	fffff097          	auipc	ra,0xfffff
    80002bbc:	8ec080e7          	jalr	-1812(ra) # 800014a4 <mycpu>
    80002bc0:	07852783          	lw	a5,120(a0)
    80002bc4:	06078e63          	beqz	a5,80002c40 <acquire+0xb4>
    80002bc8:	fffff097          	auipc	ra,0xfffff
    80002bcc:	8dc080e7          	jalr	-1828(ra) # 800014a4 <mycpu>
    80002bd0:	07852783          	lw	a5,120(a0)
    80002bd4:	0004a703          	lw	a4,0(s1)
    80002bd8:	0017879b          	addiw	a5,a5,1
    80002bdc:	06f52c23          	sw	a5,120(a0)
    80002be0:	04071063          	bnez	a4,80002c20 <acquire+0x94>
    80002be4:	00100713          	li	a4,1
    80002be8:	00070793          	mv	a5,a4
    80002bec:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002bf0:	0007879b          	sext.w	a5,a5
    80002bf4:	fe079ae3          	bnez	a5,80002be8 <acquire+0x5c>
    80002bf8:	0ff0000f          	fence
    80002bfc:	fffff097          	auipc	ra,0xfffff
    80002c00:	8a8080e7          	jalr	-1880(ra) # 800014a4 <mycpu>
    80002c04:	01813083          	ld	ra,24(sp)
    80002c08:	01013403          	ld	s0,16(sp)
    80002c0c:	00a4b823          	sd	a0,16(s1)
    80002c10:	00013903          	ld	s2,0(sp)
    80002c14:	00813483          	ld	s1,8(sp)
    80002c18:	02010113          	addi	sp,sp,32
    80002c1c:	00008067          	ret
    80002c20:	0104b903          	ld	s2,16(s1)
    80002c24:	fffff097          	auipc	ra,0xfffff
    80002c28:	880080e7          	jalr	-1920(ra) # 800014a4 <mycpu>
    80002c2c:	faa91ce3          	bne	s2,a0,80002be4 <acquire+0x58>
    80002c30:	00001517          	auipc	a0,0x1
    80002c34:	56850513          	addi	a0,a0,1384 # 80004198 <digits+0x20>
    80002c38:	fffff097          	auipc	ra,0xfffff
    80002c3c:	224080e7          	jalr	548(ra) # 80001e5c <panic>
    80002c40:	00195913          	srli	s2,s2,0x1
    80002c44:	fffff097          	auipc	ra,0xfffff
    80002c48:	860080e7          	jalr	-1952(ra) # 800014a4 <mycpu>
    80002c4c:	00197913          	andi	s2,s2,1
    80002c50:	07252e23          	sw	s2,124(a0)
    80002c54:	f75ff06f          	j	80002bc8 <acquire+0x3c>

0000000080002c58 <release>:
    80002c58:	fe010113          	addi	sp,sp,-32
    80002c5c:	00813823          	sd	s0,16(sp)
    80002c60:	00113c23          	sd	ra,24(sp)
    80002c64:	00913423          	sd	s1,8(sp)
    80002c68:	01213023          	sd	s2,0(sp)
    80002c6c:	02010413          	addi	s0,sp,32
    80002c70:	00052783          	lw	a5,0(a0)
    80002c74:	00079a63          	bnez	a5,80002c88 <release+0x30>
    80002c78:	00001517          	auipc	a0,0x1
    80002c7c:	52850513          	addi	a0,a0,1320 # 800041a0 <digits+0x28>
    80002c80:	fffff097          	auipc	ra,0xfffff
    80002c84:	1dc080e7          	jalr	476(ra) # 80001e5c <panic>
    80002c88:	01053903          	ld	s2,16(a0)
    80002c8c:	00050493          	mv	s1,a0
    80002c90:	fffff097          	auipc	ra,0xfffff
    80002c94:	814080e7          	jalr	-2028(ra) # 800014a4 <mycpu>
    80002c98:	fea910e3          	bne	s2,a0,80002c78 <release+0x20>
    80002c9c:	0004b823          	sd	zero,16(s1)
    80002ca0:	0ff0000f          	fence
    80002ca4:	0f50000f          	fence	iorw,ow
    80002ca8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80002cac:	ffffe097          	auipc	ra,0xffffe
    80002cb0:	7f8080e7          	jalr	2040(ra) # 800014a4 <mycpu>
    80002cb4:	100027f3          	csrr	a5,sstatus
    80002cb8:	0027f793          	andi	a5,a5,2
    80002cbc:	04079a63          	bnez	a5,80002d10 <release+0xb8>
    80002cc0:	07852783          	lw	a5,120(a0)
    80002cc4:	02f05e63          	blez	a5,80002d00 <release+0xa8>
    80002cc8:	fff7871b          	addiw	a4,a5,-1
    80002ccc:	06e52c23          	sw	a4,120(a0)
    80002cd0:	00071c63          	bnez	a4,80002ce8 <release+0x90>
    80002cd4:	07c52783          	lw	a5,124(a0)
    80002cd8:	00078863          	beqz	a5,80002ce8 <release+0x90>
    80002cdc:	100027f3          	csrr	a5,sstatus
    80002ce0:	0027e793          	ori	a5,a5,2
    80002ce4:	10079073          	csrw	sstatus,a5
    80002ce8:	01813083          	ld	ra,24(sp)
    80002cec:	01013403          	ld	s0,16(sp)
    80002cf0:	00813483          	ld	s1,8(sp)
    80002cf4:	00013903          	ld	s2,0(sp)
    80002cf8:	02010113          	addi	sp,sp,32
    80002cfc:	00008067          	ret
    80002d00:	00001517          	auipc	a0,0x1
    80002d04:	4c050513          	addi	a0,a0,1216 # 800041c0 <digits+0x48>
    80002d08:	fffff097          	auipc	ra,0xfffff
    80002d0c:	154080e7          	jalr	340(ra) # 80001e5c <panic>
    80002d10:	00001517          	auipc	a0,0x1
    80002d14:	49850513          	addi	a0,a0,1176 # 800041a8 <digits+0x30>
    80002d18:	fffff097          	auipc	ra,0xfffff
    80002d1c:	144080e7          	jalr	324(ra) # 80001e5c <panic>

0000000080002d20 <holding>:
    80002d20:	00052783          	lw	a5,0(a0)
    80002d24:	00079663          	bnez	a5,80002d30 <holding+0x10>
    80002d28:	00000513          	li	a0,0
    80002d2c:	00008067          	ret
    80002d30:	fe010113          	addi	sp,sp,-32
    80002d34:	00813823          	sd	s0,16(sp)
    80002d38:	00913423          	sd	s1,8(sp)
    80002d3c:	00113c23          	sd	ra,24(sp)
    80002d40:	02010413          	addi	s0,sp,32
    80002d44:	01053483          	ld	s1,16(a0)
    80002d48:	ffffe097          	auipc	ra,0xffffe
    80002d4c:	75c080e7          	jalr	1884(ra) # 800014a4 <mycpu>
    80002d50:	01813083          	ld	ra,24(sp)
    80002d54:	01013403          	ld	s0,16(sp)
    80002d58:	40a48533          	sub	a0,s1,a0
    80002d5c:	00153513          	seqz	a0,a0
    80002d60:	00813483          	ld	s1,8(sp)
    80002d64:	02010113          	addi	sp,sp,32
    80002d68:	00008067          	ret

0000000080002d6c <push_off>:
    80002d6c:	fe010113          	addi	sp,sp,-32
    80002d70:	00813823          	sd	s0,16(sp)
    80002d74:	00113c23          	sd	ra,24(sp)
    80002d78:	00913423          	sd	s1,8(sp)
    80002d7c:	02010413          	addi	s0,sp,32
    80002d80:	100024f3          	csrr	s1,sstatus
    80002d84:	100027f3          	csrr	a5,sstatus
    80002d88:	ffd7f793          	andi	a5,a5,-3
    80002d8c:	10079073          	csrw	sstatus,a5
    80002d90:	ffffe097          	auipc	ra,0xffffe
    80002d94:	714080e7          	jalr	1812(ra) # 800014a4 <mycpu>
    80002d98:	07852783          	lw	a5,120(a0)
    80002d9c:	02078663          	beqz	a5,80002dc8 <push_off+0x5c>
    80002da0:	ffffe097          	auipc	ra,0xffffe
    80002da4:	704080e7          	jalr	1796(ra) # 800014a4 <mycpu>
    80002da8:	07852783          	lw	a5,120(a0)
    80002dac:	01813083          	ld	ra,24(sp)
    80002db0:	01013403          	ld	s0,16(sp)
    80002db4:	0017879b          	addiw	a5,a5,1
    80002db8:	06f52c23          	sw	a5,120(a0)
    80002dbc:	00813483          	ld	s1,8(sp)
    80002dc0:	02010113          	addi	sp,sp,32
    80002dc4:	00008067          	ret
    80002dc8:	0014d493          	srli	s1,s1,0x1
    80002dcc:	ffffe097          	auipc	ra,0xffffe
    80002dd0:	6d8080e7          	jalr	1752(ra) # 800014a4 <mycpu>
    80002dd4:	0014f493          	andi	s1,s1,1
    80002dd8:	06952e23          	sw	s1,124(a0)
    80002ddc:	fc5ff06f          	j	80002da0 <push_off+0x34>

0000000080002de0 <pop_off>:
    80002de0:	ff010113          	addi	sp,sp,-16
    80002de4:	00813023          	sd	s0,0(sp)
    80002de8:	00113423          	sd	ra,8(sp)
    80002dec:	01010413          	addi	s0,sp,16
    80002df0:	ffffe097          	auipc	ra,0xffffe
    80002df4:	6b4080e7          	jalr	1716(ra) # 800014a4 <mycpu>
    80002df8:	100027f3          	csrr	a5,sstatus
    80002dfc:	0027f793          	andi	a5,a5,2
    80002e00:	04079663          	bnez	a5,80002e4c <pop_off+0x6c>
    80002e04:	07852783          	lw	a5,120(a0)
    80002e08:	02f05a63          	blez	a5,80002e3c <pop_off+0x5c>
    80002e0c:	fff7871b          	addiw	a4,a5,-1
    80002e10:	06e52c23          	sw	a4,120(a0)
    80002e14:	00071c63          	bnez	a4,80002e2c <pop_off+0x4c>
    80002e18:	07c52783          	lw	a5,124(a0)
    80002e1c:	00078863          	beqz	a5,80002e2c <pop_off+0x4c>
    80002e20:	100027f3          	csrr	a5,sstatus
    80002e24:	0027e793          	ori	a5,a5,2
    80002e28:	10079073          	csrw	sstatus,a5
    80002e2c:	00813083          	ld	ra,8(sp)
    80002e30:	00013403          	ld	s0,0(sp)
    80002e34:	01010113          	addi	sp,sp,16
    80002e38:	00008067          	ret
    80002e3c:	00001517          	auipc	a0,0x1
    80002e40:	38450513          	addi	a0,a0,900 # 800041c0 <digits+0x48>
    80002e44:	fffff097          	auipc	ra,0xfffff
    80002e48:	018080e7          	jalr	24(ra) # 80001e5c <panic>
    80002e4c:	00001517          	auipc	a0,0x1
    80002e50:	35c50513          	addi	a0,a0,860 # 800041a8 <digits+0x30>
    80002e54:	fffff097          	auipc	ra,0xfffff
    80002e58:	008080e7          	jalr	8(ra) # 80001e5c <panic>

0000000080002e5c <push_on>:
    80002e5c:	fe010113          	addi	sp,sp,-32
    80002e60:	00813823          	sd	s0,16(sp)
    80002e64:	00113c23          	sd	ra,24(sp)
    80002e68:	00913423          	sd	s1,8(sp)
    80002e6c:	02010413          	addi	s0,sp,32
    80002e70:	100024f3          	csrr	s1,sstatus
    80002e74:	100027f3          	csrr	a5,sstatus
    80002e78:	0027e793          	ori	a5,a5,2
    80002e7c:	10079073          	csrw	sstatus,a5
    80002e80:	ffffe097          	auipc	ra,0xffffe
    80002e84:	624080e7          	jalr	1572(ra) # 800014a4 <mycpu>
    80002e88:	07852783          	lw	a5,120(a0)
    80002e8c:	02078663          	beqz	a5,80002eb8 <push_on+0x5c>
    80002e90:	ffffe097          	auipc	ra,0xffffe
    80002e94:	614080e7          	jalr	1556(ra) # 800014a4 <mycpu>
    80002e98:	07852783          	lw	a5,120(a0)
    80002e9c:	01813083          	ld	ra,24(sp)
    80002ea0:	01013403          	ld	s0,16(sp)
    80002ea4:	0017879b          	addiw	a5,a5,1
    80002ea8:	06f52c23          	sw	a5,120(a0)
    80002eac:	00813483          	ld	s1,8(sp)
    80002eb0:	02010113          	addi	sp,sp,32
    80002eb4:	00008067          	ret
    80002eb8:	0014d493          	srli	s1,s1,0x1
    80002ebc:	ffffe097          	auipc	ra,0xffffe
    80002ec0:	5e8080e7          	jalr	1512(ra) # 800014a4 <mycpu>
    80002ec4:	0014f493          	andi	s1,s1,1
    80002ec8:	06952e23          	sw	s1,124(a0)
    80002ecc:	fc5ff06f          	j	80002e90 <push_on+0x34>

0000000080002ed0 <pop_on>:
    80002ed0:	ff010113          	addi	sp,sp,-16
    80002ed4:	00813023          	sd	s0,0(sp)
    80002ed8:	00113423          	sd	ra,8(sp)
    80002edc:	01010413          	addi	s0,sp,16
    80002ee0:	ffffe097          	auipc	ra,0xffffe
    80002ee4:	5c4080e7          	jalr	1476(ra) # 800014a4 <mycpu>
    80002ee8:	100027f3          	csrr	a5,sstatus
    80002eec:	0027f793          	andi	a5,a5,2
    80002ef0:	04078463          	beqz	a5,80002f38 <pop_on+0x68>
    80002ef4:	07852783          	lw	a5,120(a0)
    80002ef8:	02f05863          	blez	a5,80002f28 <pop_on+0x58>
    80002efc:	fff7879b          	addiw	a5,a5,-1
    80002f00:	06f52c23          	sw	a5,120(a0)
    80002f04:	07853783          	ld	a5,120(a0)
    80002f08:	00079863          	bnez	a5,80002f18 <pop_on+0x48>
    80002f0c:	100027f3          	csrr	a5,sstatus
    80002f10:	ffd7f793          	andi	a5,a5,-3
    80002f14:	10079073          	csrw	sstatus,a5
    80002f18:	00813083          	ld	ra,8(sp)
    80002f1c:	00013403          	ld	s0,0(sp)
    80002f20:	01010113          	addi	sp,sp,16
    80002f24:	00008067          	ret
    80002f28:	00001517          	auipc	a0,0x1
    80002f2c:	2c050513          	addi	a0,a0,704 # 800041e8 <digits+0x70>
    80002f30:	fffff097          	auipc	ra,0xfffff
    80002f34:	f2c080e7          	jalr	-212(ra) # 80001e5c <panic>
    80002f38:	00001517          	auipc	a0,0x1
    80002f3c:	29050513          	addi	a0,a0,656 # 800041c8 <digits+0x50>
    80002f40:	fffff097          	auipc	ra,0xfffff
    80002f44:	f1c080e7          	jalr	-228(ra) # 80001e5c <panic>

0000000080002f48 <__memset>:
    80002f48:	ff010113          	addi	sp,sp,-16
    80002f4c:	00813423          	sd	s0,8(sp)
    80002f50:	01010413          	addi	s0,sp,16
    80002f54:	1a060e63          	beqz	a2,80003110 <__memset+0x1c8>
    80002f58:	40a007b3          	neg	a5,a0
    80002f5c:	0077f793          	andi	a5,a5,7
    80002f60:	00778693          	addi	a3,a5,7
    80002f64:	00b00813          	li	a6,11
    80002f68:	0ff5f593          	andi	a1,a1,255
    80002f6c:	fff6071b          	addiw	a4,a2,-1
    80002f70:	1b06e663          	bltu	a3,a6,8000311c <__memset+0x1d4>
    80002f74:	1cd76463          	bltu	a4,a3,8000313c <__memset+0x1f4>
    80002f78:	1a078e63          	beqz	a5,80003134 <__memset+0x1ec>
    80002f7c:	00b50023          	sb	a1,0(a0)
    80002f80:	00100713          	li	a4,1
    80002f84:	1ae78463          	beq	a5,a4,8000312c <__memset+0x1e4>
    80002f88:	00b500a3          	sb	a1,1(a0)
    80002f8c:	00200713          	li	a4,2
    80002f90:	1ae78a63          	beq	a5,a4,80003144 <__memset+0x1fc>
    80002f94:	00b50123          	sb	a1,2(a0)
    80002f98:	00300713          	li	a4,3
    80002f9c:	18e78463          	beq	a5,a4,80003124 <__memset+0x1dc>
    80002fa0:	00b501a3          	sb	a1,3(a0)
    80002fa4:	00400713          	li	a4,4
    80002fa8:	1ae78263          	beq	a5,a4,8000314c <__memset+0x204>
    80002fac:	00b50223          	sb	a1,4(a0)
    80002fb0:	00500713          	li	a4,5
    80002fb4:	1ae78063          	beq	a5,a4,80003154 <__memset+0x20c>
    80002fb8:	00b502a3          	sb	a1,5(a0)
    80002fbc:	00700713          	li	a4,7
    80002fc0:	18e79e63          	bne	a5,a4,8000315c <__memset+0x214>
    80002fc4:	00b50323          	sb	a1,6(a0)
    80002fc8:	00700e93          	li	t4,7
    80002fcc:	00859713          	slli	a4,a1,0x8
    80002fd0:	00e5e733          	or	a4,a1,a4
    80002fd4:	01059e13          	slli	t3,a1,0x10
    80002fd8:	01c76e33          	or	t3,a4,t3
    80002fdc:	01859313          	slli	t1,a1,0x18
    80002fe0:	006e6333          	or	t1,t3,t1
    80002fe4:	02059893          	slli	a7,a1,0x20
    80002fe8:	40f60e3b          	subw	t3,a2,a5
    80002fec:	011368b3          	or	a7,t1,a7
    80002ff0:	02859813          	slli	a6,a1,0x28
    80002ff4:	0108e833          	or	a6,a7,a6
    80002ff8:	03059693          	slli	a3,a1,0x30
    80002ffc:	003e589b          	srliw	a7,t3,0x3
    80003000:	00d866b3          	or	a3,a6,a3
    80003004:	03859713          	slli	a4,a1,0x38
    80003008:	00389813          	slli	a6,a7,0x3
    8000300c:	00f507b3          	add	a5,a0,a5
    80003010:	00e6e733          	or	a4,a3,a4
    80003014:	000e089b          	sext.w	a7,t3
    80003018:	00f806b3          	add	a3,a6,a5
    8000301c:	00e7b023          	sd	a4,0(a5)
    80003020:	00878793          	addi	a5,a5,8
    80003024:	fed79ce3          	bne	a5,a3,8000301c <__memset+0xd4>
    80003028:	ff8e7793          	andi	a5,t3,-8
    8000302c:	0007871b          	sext.w	a4,a5
    80003030:	01d787bb          	addw	a5,a5,t4
    80003034:	0ce88e63          	beq	a7,a4,80003110 <__memset+0x1c8>
    80003038:	00f50733          	add	a4,a0,a5
    8000303c:	00b70023          	sb	a1,0(a4)
    80003040:	0017871b          	addiw	a4,a5,1
    80003044:	0cc77663          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    80003048:	00e50733          	add	a4,a0,a4
    8000304c:	00b70023          	sb	a1,0(a4)
    80003050:	0027871b          	addiw	a4,a5,2
    80003054:	0ac77e63          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    80003058:	00e50733          	add	a4,a0,a4
    8000305c:	00b70023          	sb	a1,0(a4)
    80003060:	0037871b          	addiw	a4,a5,3
    80003064:	0ac77663          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    80003068:	00e50733          	add	a4,a0,a4
    8000306c:	00b70023          	sb	a1,0(a4)
    80003070:	0047871b          	addiw	a4,a5,4
    80003074:	08c77e63          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    80003078:	00e50733          	add	a4,a0,a4
    8000307c:	00b70023          	sb	a1,0(a4)
    80003080:	0057871b          	addiw	a4,a5,5
    80003084:	08c77663          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    80003088:	00e50733          	add	a4,a0,a4
    8000308c:	00b70023          	sb	a1,0(a4)
    80003090:	0067871b          	addiw	a4,a5,6
    80003094:	06c77e63          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    80003098:	00e50733          	add	a4,a0,a4
    8000309c:	00b70023          	sb	a1,0(a4)
    800030a0:	0077871b          	addiw	a4,a5,7
    800030a4:	06c77663          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    800030a8:	00e50733          	add	a4,a0,a4
    800030ac:	00b70023          	sb	a1,0(a4)
    800030b0:	0087871b          	addiw	a4,a5,8
    800030b4:	04c77e63          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    800030b8:	00e50733          	add	a4,a0,a4
    800030bc:	00b70023          	sb	a1,0(a4)
    800030c0:	0097871b          	addiw	a4,a5,9
    800030c4:	04c77663          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    800030c8:	00e50733          	add	a4,a0,a4
    800030cc:	00b70023          	sb	a1,0(a4)
    800030d0:	00a7871b          	addiw	a4,a5,10
    800030d4:	02c77e63          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    800030d8:	00e50733          	add	a4,a0,a4
    800030dc:	00b70023          	sb	a1,0(a4)
    800030e0:	00b7871b          	addiw	a4,a5,11
    800030e4:	02c77663          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    800030e8:	00e50733          	add	a4,a0,a4
    800030ec:	00b70023          	sb	a1,0(a4)
    800030f0:	00c7871b          	addiw	a4,a5,12
    800030f4:	00c77e63          	bgeu	a4,a2,80003110 <__memset+0x1c8>
    800030f8:	00e50733          	add	a4,a0,a4
    800030fc:	00b70023          	sb	a1,0(a4)
    80003100:	00d7879b          	addiw	a5,a5,13
    80003104:	00c7f663          	bgeu	a5,a2,80003110 <__memset+0x1c8>
    80003108:	00f507b3          	add	a5,a0,a5
    8000310c:	00b78023          	sb	a1,0(a5)
    80003110:	00813403          	ld	s0,8(sp)
    80003114:	01010113          	addi	sp,sp,16
    80003118:	00008067          	ret
    8000311c:	00b00693          	li	a3,11
    80003120:	e55ff06f          	j	80002f74 <__memset+0x2c>
    80003124:	00300e93          	li	t4,3
    80003128:	ea5ff06f          	j	80002fcc <__memset+0x84>
    8000312c:	00100e93          	li	t4,1
    80003130:	e9dff06f          	j	80002fcc <__memset+0x84>
    80003134:	00000e93          	li	t4,0
    80003138:	e95ff06f          	j	80002fcc <__memset+0x84>
    8000313c:	00000793          	li	a5,0
    80003140:	ef9ff06f          	j	80003038 <__memset+0xf0>
    80003144:	00200e93          	li	t4,2
    80003148:	e85ff06f          	j	80002fcc <__memset+0x84>
    8000314c:	00400e93          	li	t4,4
    80003150:	e7dff06f          	j	80002fcc <__memset+0x84>
    80003154:	00500e93          	li	t4,5
    80003158:	e75ff06f          	j	80002fcc <__memset+0x84>
    8000315c:	00600e93          	li	t4,6
    80003160:	e6dff06f          	j	80002fcc <__memset+0x84>

0000000080003164 <__memmove>:
    80003164:	ff010113          	addi	sp,sp,-16
    80003168:	00813423          	sd	s0,8(sp)
    8000316c:	01010413          	addi	s0,sp,16
    80003170:	0e060863          	beqz	a2,80003260 <__memmove+0xfc>
    80003174:	fff6069b          	addiw	a3,a2,-1
    80003178:	0006881b          	sext.w	a6,a3
    8000317c:	0ea5e863          	bltu	a1,a0,8000326c <__memmove+0x108>
    80003180:	00758713          	addi	a4,a1,7
    80003184:	00a5e7b3          	or	a5,a1,a0
    80003188:	40a70733          	sub	a4,a4,a0
    8000318c:	0077f793          	andi	a5,a5,7
    80003190:	00f73713          	sltiu	a4,a4,15
    80003194:	00174713          	xori	a4,a4,1
    80003198:	0017b793          	seqz	a5,a5
    8000319c:	00e7f7b3          	and	a5,a5,a4
    800031a0:	10078863          	beqz	a5,800032b0 <__memmove+0x14c>
    800031a4:	00900793          	li	a5,9
    800031a8:	1107f463          	bgeu	a5,a6,800032b0 <__memmove+0x14c>
    800031ac:	0036581b          	srliw	a6,a2,0x3
    800031b0:	fff8081b          	addiw	a6,a6,-1
    800031b4:	02081813          	slli	a6,a6,0x20
    800031b8:	01d85893          	srli	a7,a6,0x1d
    800031bc:	00858813          	addi	a6,a1,8
    800031c0:	00058793          	mv	a5,a1
    800031c4:	00050713          	mv	a4,a0
    800031c8:	01088833          	add	a6,a7,a6
    800031cc:	0007b883          	ld	a7,0(a5)
    800031d0:	00878793          	addi	a5,a5,8
    800031d4:	00870713          	addi	a4,a4,8
    800031d8:	ff173c23          	sd	a7,-8(a4)
    800031dc:	ff0798e3          	bne	a5,a6,800031cc <__memmove+0x68>
    800031e0:	ff867713          	andi	a4,a2,-8
    800031e4:	02071793          	slli	a5,a4,0x20
    800031e8:	0207d793          	srli	a5,a5,0x20
    800031ec:	00f585b3          	add	a1,a1,a5
    800031f0:	40e686bb          	subw	a3,a3,a4
    800031f4:	00f507b3          	add	a5,a0,a5
    800031f8:	06e60463          	beq	a2,a4,80003260 <__memmove+0xfc>
    800031fc:	0005c703          	lbu	a4,0(a1)
    80003200:	00e78023          	sb	a4,0(a5)
    80003204:	04068e63          	beqz	a3,80003260 <__memmove+0xfc>
    80003208:	0015c603          	lbu	a2,1(a1)
    8000320c:	00100713          	li	a4,1
    80003210:	00c780a3          	sb	a2,1(a5)
    80003214:	04e68663          	beq	a3,a4,80003260 <__memmove+0xfc>
    80003218:	0025c603          	lbu	a2,2(a1)
    8000321c:	00200713          	li	a4,2
    80003220:	00c78123          	sb	a2,2(a5)
    80003224:	02e68e63          	beq	a3,a4,80003260 <__memmove+0xfc>
    80003228:	0035c603          	lbu	a2,3(a1)
    8000322c:	00300713          	li	a4,3
    80003230:	00c781a3          	sb	a2,3(a5)
    80003234:	02e68663          	beq	a3,a4,80003260 <__memmove+0xfc>
    80003238:	0045c603          	lbu	a2,4(a1)
    8000323c:	00400713          	li	a4,4
    80003240:	00c78223          	sb	a2,4(a5)
    80003244:	00e68e63          	beq	a3,a4,80003260 <__memmove+0xfc>
    80003248:	0055c603          	lbu	a2,5(a1)
    8000324c:	00500713          	li	a4,5
    80003250:	00c782a3          	sb	a2,5(a5)
    80003254:	00e68663          	beq	a3,a4,80003260 <__memmove+0xfc>
    80003258:	0065c703          	lbu	a4,6(a1)
    8000325c:	00e78323          	sb	a4,6(a5)
    80003260:	00813403          	ld	s0,8(sp)
    80003264:	01010113          	addi	sp,sp,16
    80003268:	00008067          	ret
    8000326c:	02061713          	slli	a4,a2,0x20
    80003270:	02075713          	srli	a4,a4,0x20
    80003274:	00e587b3          	add	a5,a1,a4
    80003278:	f0f574e3          	bgeu	a0,a5,80003180 <__memmove+0x1c>
    8000327c:	02069613          	slli	a2,a3,0x20
    80003280:	02065613          	srli	a2,a2,0x20
    80003284:	fff64613          	not	a2,a2
    80003288:	00e50733          	add	a4,a0,a4
    8000328c:	00c78633          	add	a2,a5,a2
    80003290:	fff7c683          	lbu	a3,-1(a5)
    80003294:	fff78793          	addi	a5,a5,-1
    80003298:	fff70713          	addi	a4,a4,-1
    8000329c:	00d70023          	sb	a3,0(a4)
    800032a0:	fec798e3          	bne	a5,a2,80003290 <__memmove+0x12c>
    800032a4:	00813403          	ld	s0,8(sp)
    800032a8:	01010113          	addi	sp,sp,16
    800032ac:	00008067          	ret
    800032b0:	02069713          	slli	a4,a3,0x20
    800032b4:	02075713          	srli	a4,a4,0x20
    800032b8:	00170713          	addi	a4,a4,1
    800032bc:	00e50733          	add	a4,a0,a4
    800032c0:	00050793          	mv	a5,a0
    800032c4:	0005c683          	lbu	a3,0(a1)
    800032c8:	00178793          	addi	a5,a5,1
    800032cc:	00158593          	addi	a1,a1,1
    800032d0:	fed78fa3          	sb	a3,-1(a5)
    800032d4:	fee798e3          	bne	a5,a4,800032c4 <__memmove+0x160>
    800032d8:	f89ff06f          	j	80003260 <__memmove+0xfc>

00000000800032dc <__putc>:
    800032dc:	fe010113          	addi	sp,sp,-32
    800032e0:	00813823          	sd	s0,16(sp)
    800032e4:	00113c23          	sd	ra,24(sp)
    800032e8:	02010413          	addi	s0,sp,32
    800032ec:	00050793          	mv	a5,a0
    800032f0:	fef40593          	addi	a1,s0,-17
    800032f4:	00100613          	li	a2,1
    800032f8:	00000513          	li	a0,0
    800032fc:	fef407a3          	sb	a5,-17(s0)
    80003300:	fffff097          	auipc	ra,0xfffff
    80003304:	b3c080e7          	jalr	-1220(ra) # 80001e3c <console_write>
    80003308:	01813083          	ld	ra,24(sp)
    8000330c:	01013403          	ld	s0,16(sp)
    80003310:	02010113          	addi	sp,sp,32
    80003314:	00008067          	ret

0000000080003318 <__getc>:
    80003318:	fe010113          	addi	sp,sp,-32
    8000331c:	00813823          	sd	s0,16(sp)
    80003320:	00113c23          	sd	ra,24(sp)
    80003324:	02010413          	addi	s0,sp,32
    80003328:	fe840593          	addi	a1,s0,-24
    8000332c:	00100613          	li	a2,1
    80003330:	00000513          	li	a0,0
    80003334:	fffff097          	auipc	ra,0xfffff
    80003338:	ae8080e7          	jalr	-1304(ra) # 80001e1c <console_read>
    8000333c:	fe844503          	lbu	a0,-24(s0)
    80003340:	01813083          	ld	ra,24(sp)
    80003344:	01013403          	ld	s0,16(sp)
    80003348:	02010113          	addi	sp,sp,32
    8000334c:	00008067          	ret

0000000080003350 <console_handler>:
    80003350:	fe010113          	addi	sp,sp,-32
    80003354:	00813823          	sd	s0,16(sp)
    80003358:	00113c23          	sd	ra,24(sp)
    8000335c:	00913423          	sd	s1,8(sp)
    80003360:	02010413          	addi	s0,sp,32
    80003364:	14202773          	csrr	a4,scause
    80003368:	100027f3          	csrr	a5,sstatus
    8000336c:	0027f793          	andi	a5,a5,2
    80003370:	06079e63          	bnez	a5,800033ec <console_handler+0x9c>
    80003374:	00074c63          	bltz	a4,8000338c <console_handler+0x3c>
    80003378:	01813083          	ld	ra,24(sp)
    8000337c:	01013403          	ld	s0,16(sp)
    80003380:	00813483          	ld	s1,8(sp)
    80003384:	02010113          	addi	sp,sp,32
    80003388:	00008067          	ret
    8000338c:	0ff77713          	andi	a4,a4,255
    80003390:	00900793          	li	a5,9
    80003394:	fef712e3          	bne	a4,a5,80003378 <console_handler+0x28>
    80003398:	ffffe097          	auipc	ra,0xffffe
    8000339c:	6dc080e7          	jalr	1756(ra) # 80001a74 <plic_claim>
    800033a0:	00a00793          	li	a5,10
    800033a4:	00050493          	mv	s1,a0
    800033a8:	02f50c63          	beq	a0,a5,800033e0 <console_handler+0x90>
    800033ac:	fc0506e3          	beqz	a0,80003378 <console_handler+0x28>
    800033b0:	00050593          	mv	a1,a0
    800033b4:	00001517          	auipc	a0,0x1
    800033b8:	d3c50513          	addi	a0,a0,-708 # 800040f0 <CONSOLE_STATUS+0xe0>
    800033bc:	fffff097          	auipc	ra,0xfffff
    800033c0:	afc080e7          	jalr	-1284(ra) # 80001eb8 <__printf>
    800033c4:	01013403          	ld	s0,16(sp)
    800033c8:	01813083          	ld	ra,24(sp)
    800033cc:	00048513          	mv	a0,s1
    800033d0:	00813483          	ld	s1,8(sp)
    800033d4:	02010113          	addi	sp,sp,32
    800033d8:	ffffe317          	auipc	t1,0xffffe
    800033dc:	6d430067          	jr	1748(t1) # 80001aac <plic_complete>
    800033e0:	fffff097          	auipc	ra,0xfffff
    800033e4:	3e0080e7          	jalr	992(ra) # 800027c0 <uartintr>
    800033e8:	fddff06f          	j	800033c4 <console_handler+0x74>
    800033ec:	00001517          	auipc	a0,0x1
    800033f0:	e0450513          	addi	a0,a0,-508 # 800041f0 <digits+0x78>
    800033f4:	fffff097          	auipc	ra,0xfffff
    800033f8:	a68080e7          	jalr	-1432(ra) # 80001e5c <panic>
	...
