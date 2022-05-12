
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
    8000001c:	3d0010ef          	jal	ra,800013ec <start>

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
    80001010:	02010413          	addi	s0,sp,32
    int velicinaZaglavlja = sizeof(size_t); // meni je ovoliko

    char* niz = (char*)MemoryAllocator::mem_alloc((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 2 - velicinaZaglavlja); // celokupan prostor
    80001014:	00003797          	auipc	a5,0x3
    80001018:	2c47b783          	ld	a5,708(a5) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000101c:	0007b503          	ld	a0,0(a5)
    80001020:	00003797          	auipc	a5,0x3
    80001024:	2a87b783          	ld	a5,680(a5) # 800042c8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001028:	0007b783          	ld	a5,0(a5)
    8000102c:	40f50533          	sub	a0,a0,a5
    80001030:	ffa50513          	addi	a0,a0,-6 # ffa <_entry-0x7ffff006>
    80001034:	00000097          	auipc	ra,0x0
    80001038:	098080e7          	jalr	152(ra) # 800010cc <_ZN15MemoryAllocator9mem_allocEm>
    8000103c:	00050493          	mv	s1,a0
    if(niz == nullptr) {
    80001040:	04050663          	beqz	a0,8000108c <main+0x8c>
        __putc('?');
    }

    int n = 10;
    char* niz2 = (char*)MemoryAllocator::mem_alloc(n*sizeof(char));
    80001044:	00a00513          	li	a0,10
    80001048:	00000097          	auipc	ra,0x0
    8000104c:	084080e7          	jalr	132(ra) # 800010cc <_ZN15MemoryAllocator9mem_allocEm>
    if(niz2 == nullptr) {
    80001050:	04050663          	beqz	a0,8000109c <main+0x9c>
        __putc('k');
    }

    int status = MemoryAllocator::mem_free(niz);
    80001054:	00048513          	mv	a0,s1
    80001058:	00000097          	auipc	ra,0x0
    8000105c:	1e8080e7          	jalr	488(ra) # 80001240 <_ZN15MemoryAllocator8mem_freeEPv>
    if(status) {
    80001060:	04051663          	bnez	a0,800010ac <main+0xac>
        __putc('?');
    }
    niz2 = (char*)MemoryAllocator::mem_alloc(n*sizeof(char));
    80001064:	00a00513          	li	a0,10
    80001068:	00000097          	auipc	ra,0x0
    8000106c:	064080e7          	jalr	100(ra) # 800010cc <_ZN15MemoryAllocator9mem_allocEm>
    if(niz2 == nullptr) {
    80001070:	04050663          	beqz	a0,800010bc <main+0xbc>
        __putc('?');
    }

    return 0;
    80001074:	00000513          	li	a0,0
    80001078:	01813083          	ld	ra,24(sp)
    8000107c:	01013403          	ld	s0,16(sp)
    80001080:	00813483          	ld	s1,8(sp)
    80001084:	02010113          	addi	sp,sp,32
    80001088:	00008067          	ret
        __putc('?');
    8000108c:	03f00513          	li	a0,63
    80001090:	00002097          	auipc	ra,0x2
    80001094:	41c080e7          	jalr	1052(ra) # 800034ac <__putc>
    80001098:	fadff06f          	j	80001044 <main+0x44>
        __putc('k');
    8000109c:	06b00513          	li	a0,107
    800010a0:	00002097          	auipc	ra,0x2
    800010a4:	40c080e7          	jalr	1036(ra) # 800034ac <__putc>
    800010a8:	fadff06f          	j	80001054 <main+0x54>
        __putc('?');
    800010ac:	03f00513          	li	a0,63
    800010b0:	00002097          	auipc	ra,0x2
    800010b4:	3fc080e7          	jalr	1020(ra) # 800034ac <__putc>
    800010b8:	fadff06f          	j	80001064 <main+0x64>
        __putc('?');
    800010bc:	03f00513          	li	a0,63
    800010c0:	00002097          	auipc	ra,0x2
    800010c4:	3ec080e7          	jalr	1004(ra) # 800034ac <__putc>
    800010c8:	fadff06f          	j	80001074 <main+0x74>

00000000800010cc <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    800010cc:	ff010113          	addi	sp,sp,-16
    800010d0:	00813423          	sd	s0,8(sp)
    800010d4:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    800010d8:	00003797          	auipc	a5,0x3
    800010dc:	2487b783          	ld	a5,584(a5) # 80004320 <_ZN15MemoryAllocator4headE>
    800010e0:	02078c63          	beqz	a5,80001118 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 1);
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    800010e4:	00003717          	auipc	a4,0x3
    800010e8:	1f473703          	ld	a4,500(a4) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800010ec:	00073703          	ld	a4,0(a4)
    800010f0:	14e78463          	beq	a5,a4,80001238 <_ZN15MemoryAllocator9mem_allocEm+0x16c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    800010f4:	00850613          	addi	a2,a0,8

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800010f8:	00665813          	srli	a6,a2,0x6
    800010fc:	03f67793          	andi	a5,a2,63
    80001100:	00f037b3          	snez	a5,a5
    80001104:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80001108:	00003517          	auipc	a0,0x3
    8000110c:	21853503          	ld	a0,536(a0) # 80004320 <_ZN15MemoryAllocator4headE>
    80001110:	00000593          	li	a1,0
    80001114:	0ac0006f          	j	800011c0 <_ZN15MemoryAllocator9mem_allocEm+0xf4>
        head = (FreeSegment*)HEAP_START_ADDR;
    80001118:	00003697          	auipc	a3,0x3
    8000111c:	1b06b683          	ld	a3,432(a3) # 800042c8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001120:	0006b783          	ld	a5,0(a3)
    80001124:	00003717          	auipc	a4,0x3
    80001128:	1ef73e23          	sd	a5,508(a4) # 80004320 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    8000112c:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 1);
    80001130:	00003717          	auipc	a4,0x3
    80001134:	1a873703          	ld	a4,424(a4) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001138:	00073703          	ld	a4,0(a4)
    8000113c:	0006b683          	ld	a3,0(a3)
    80001140:	40d70733          	sub	a4,a4,a3
    80001144:	00170713          	addi	a4,a4,1
    80001148:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    8000114c:	0007b823          	sd	zero,16(a5)
    80001150:	fa5ff06f          	j	800010f4 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80001154:	00058e63          	beqz	a1,80001170 <_ZN15MemoryAllocator9mem_allocEm+0xa4>
            if(!prev->next) return;
    80001158:	0105b703          	ld	a4,16(a1)
    8000115c:	04070a63          	beqz	a4,800011b0 <_ZN15MemoryAllocator9mem_allocEm+0xe4>
            prev->next = curr->next;
    80001160:	01073703          	ld	a4,16(a4)
    80001164:	00e5b823          	sd	a4,16(a1)
                allocatedSize = curr->size;
    80001168:	00078813          	mv	a6,a5
    8000116c:	0b80006f          	j	80001224 <_ZN15MemoryAllocator9mem_allocEm+0x158>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001170:	01053703          	ld	a4,16(a0)
    80001174:	00070a63          	beqz	a4,80001188 <_ZN15MemoryAllocator9mem_allocEm+0xbc>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80001178:	00003617          	auipc	a2,0x3
    8000117c:	1ae63423          	sd	a4,424(a2) # 80004320 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001180:	00078813          	mv	a6,a5
    80001184:	0a00006f          	j	80001224 <_ZN15MemoryAllocator9mem_allocEm+0x158>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001188:	00003717          	auipc	a4,0x3
    8000118c:	15073703          	ld	a4,336(a4) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001190:	00073703          	ld	a4,0(a4)
    80001194:	00003617          	auipc	a2,0x3
    80001198:	18e63623          	sd	a4,396(a2) # 80004320 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    8000119c:	00078813          	mv	a6,a5
    800011a0:	0840006f          	j	80001224 <_ZN15MemoryAllocator9mem_allocEm+0x158>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    800011a4:	00003797          	auipc	a5,0x3
    800011a8:	16e7be23          	sd	a4,380(a5) # 80004320 <_ZN15MemoryAllocator4headE>
    800011ac:	0780006f          	j	80001224 <_ZN15MemoryAllocator9mem_allocEm+0x158>
                allocatedSize = curr->size;
    800011b0:	00078813          	mv	a6,a5
    800011b4:	0700006f          	j	80001224 <_ZN15MemoryAllocator9mem_allocEm+0x158>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    800011b8:	00050593          	mv	a1,a0
        curr = curr->next;
    800011bc:	01053503          	ld	a0,16(a0)
    while(curr) {
    800011c0:	06050663          	beqz	a0,8000122c <_ZN15MemoryAllocator9mem_allocEm+0x160>
        size_t freeSegSizeInBlocks = sizeInBlocks(curr->size);
    800011c4:	00853783          	ld	a5,8(a0)
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800011c8:	0067d693          	srli	a3,a5,0x6
    800011cc:	03f7f713          	andi	a4,a5,63
    800011d0:	00e03733          	snez	a4,a4
    800011d4:	00e68733          	add	a4,a3,a4
        void* startOfAllocatedSpace = curr->baseAddr;
    800011d8:	00053683          	ld	a3,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    800011dc:	fcc7eee3          	bltu	a5,a2,800011b8 <_ZN15MemoryAllocator9mem_allocEm+0xec>
    800011e0:	fd076ce3          	bltu	a4,a6,800011b8 <_ZN15MemoryAllocator9mem_allocEm+0xec>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    800011e4:	f6e808e3          	beq	a6,a4,80001154 <_ZN15MemoryAllocator9mem_allocEm+0x88>
    }

    // Vraca velicinu numOfBlocks blokova u bajtovima
    static inline size_t blocksInSize(size_t numOfBlocks) {
        return numOfBlocks * MEM_BLOCK_SIZE;
    800011e8:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    800011ec:	01068733          	add	a4,a3,a6
                size_t newSize = curr->size - allocatedSize;
    800011f0:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    800011f4:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    800011f8:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    800011fc:	01053783          	ld	a5,16(a0)
    80001200:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80001204:	fa0580e3          	beqz	a1,800011a4 <_ZN15MemoryAllocator9mem_allocEm+0xd8>
            if(!prev->next) return;
    80001208:	0105b783          	ld	a5,16(a1)
    8000120c:	00078663          	beqz	a5,80001218 <_ZN15MemoryAllocator9mem_allocEm+0x14c>
            prev->next = curr->next;
    80001210:	0107b783          	ld	a5,16(a5)
    80001214:	00f5b823          	sd	a5,16(a1)
            curr->next = prev->next;
    80001218:	0105b783          	ld	a5,16(a1)
    8000121c:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80001220:	00a5b823          	sd	a0,16(a1)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80001224:	0106b023          	sd	a6,0(a3)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80001228:	00868513          	addi	a0,a3,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    8000122c:	00813403          	ld	s0,8(sp)
    80001230:	01010113          	addi	sp,sp,16
    80001234:	00008067          	ret
        return nullptr;
    80001238:	00000513          	li	a0,0
    8000123c:	ff1ff06f          	j	8000122c <_ZN15MemoryAllocator9mem_allocEm+0x160>

0000000080001240 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80001240:	ff010113          	addi	sp,sp,-16
    80001244:	00813423          	sd	s0,8(sp)
    80001248:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    8000124c:	16050063          	beqz	a0,800013ac <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80001250:	ff850713          	addi	a4,a0,-8
    80001254:	00003797          	auipc	a5,0x3
    80001258:	0747b783          	ld	a5,116(a5) # 800042c8 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000125c:	0007b783          	ld	a5,0(a5)
    80001260:	14f76a63          	bltu	a4,a5,800013b4 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80001264:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 > (char*)HEAP_END_ADDR || memSegment == nullptr
    80001268:	fff58693          	addi	a3,a1,-1
    8000126c:	00d706b3          	add	a3,a4,a3
    80001270:	00003617          	auipc	a2,0x3
    80001274:	06863603          	ld	a2,104(a2) # 800042d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001278:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000127c:	14d66063          	bltu	a2,a3,800013bc <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 > (char*)HEAP_END_ADDR || memSegment == nullptr
    80001280:	14070263          	beqz	a4,800013c4 <_ZN15MemoryAllocator8mem_freeEPv+0x184>
    }

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80001284:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80001288:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000128c:	14079063          	bnez	a5,800013cc <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80001290:	03f00793          	li	a5,63
    80001294:	14b7f063          	bgeu	a5,a1,800013d4 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80001298:	00003797          	auipc	a5,0x3
    8000129c:	0887b783          	ld	a5,136(a5) # 80004320 <_ZN15MemoryAllocator4headE>
    800012a0:	02f60063          	beq	a2,a5,800012c0 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    800012a4:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800012a8:	02078a63          	beqz	a5,800012dc <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    800012ac:	0007b683          	ld	a3,0(a5)
    800012b0:	02e6f663          	bgeu	a3,a4,800012dc <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    800012b4:	00078613          	mv	a2,a5
        curr = curr->next;
    800012b8:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800012bc:	fedff06f          	j	800012a8 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    800012c0:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    800012c4:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    800012c8:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    800012cc:	00003797          	auipc	a5,0x3
    800012d0:	04e7ba23          	sd	a4,84(a5) # 80004320 <_ZN15MemoryAllocator4headE>
        return 0;
    800012d4:	00000513          	li	a0,0
    800012d8:	0480006f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    800012dc:	04060863          	beqz	a2,8000132c <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    800012e0:	00063683          	ld	a3,0(a2)
    800012e4:	00863803          	ld	a6,8(a2)
    800012e8:	010686b3          	add	a3,a3,a6
    800012ec:	08e68a63          	beq	a3,a4,80001380 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    800012f0:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800012f4:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    800012f8:	01063683          	ld	a3,16(a2)
    800012fc:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80001300:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80001304:	0e078063          	beqz	a5,800013e4 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80001308:	0007b583          	ld	a1,0(a5)
    8000130c:	00073683          	ld	a3,0(a4)
    80001310:	00873603          	ld	a2,8(a4)
    80001314:	00c686b3          	add	a3,a3,a2
    80001318:	06d58c63          	beq	a1,a3,80001390 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    8000131c:	00000513          	li	a0,0
}
    80001320:	00813403          	ld	s0,8(sp)
    80001324:	01010113          	addi	sp,sp,16
    80001328:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    8000132c:	0a078863          	beqz	a5,800013dc <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80001330:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001334:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80001338:	00003797          	auipc	a5,0x3
    8000133c:	fe87b783          	ld	a5,-24(a5) # 80004320 <_ZN15MemoryAllocator4headE>
    80001340:	0007b603          	ld	a2,0(a5)
    80001344:	00b706b3          	add	a3,a4,a1
    80001348:	00d60c63          	beq	a2,a3,80001360 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    8000134c:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80001350:	00003797          	auipc	a5,0x3
    80001354:	fce7b823          	sd	a4,-48(a5) # 80004320 <_ZN15MemoryAllocator4headE>
            return 0;
    80001358:	00000513          	li	a0,0
    8000135c:	fc5ff06f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80001360:	0087b783          	ld	a5,8(a5)
    80001364:	00b785b3          	add	a1,a5,a1
    80001368:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    8000136c:	00003797          	auipc	a5,0x3
    80001370:	fb47b783          	ld	a5,-76(a5) # 80004320 <_ZN15MemoryAllocator4headE>
    80001374:	0107b783          	ld	a5,16(a5)
    80001378:	00f53423          	sd	a5,8(a0)
    8000137c:	fd5ff06f          	j	80001350 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80001380:	00b805b3          	add	a1,a6,a1
    80001384:	00b63423          	sd	a1,8(a2)
    80001388:	00060713          	mv	a4,a2
    8000138c:	f79ff06f          	j	80001304 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80001390:	0087b683          	ld	a3,8(a5)
    80001394:	00d60633          	add	a2,a2,a3
    80001398:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    8000139c:	0107b783          	ld	a5,16(a5)
    800013a0:	00f73823          	sd	a5,16(a4)
    return 0;
    800013a4:	00000513          	li	a0,0
    800013a8:	f79ff06f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800013ac:	fff00513          	li	a0,-1
    800013b0:	f71ff06f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800013b4:	fff00513          	li	a0,-1
    800013b8:	f69ff06f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    800013bc:	fff00513          	li	a0,-1
    800013c0:	f61ff06f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800013c4:	fff00513          	li	a0,-1
    800013c8:	f59ff06f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800013cc:	fff00513          	li	a0,-1
    800013d0:	f51ff06f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800013d4:	fff00513          	li	a0,-1
    800013d8:	f49ff06f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    800013dc:	fff00513          	li	a0,-1
    800013e0:	f41ff06f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    800013e4:	00000513          	li	a0,0
    800013e8:	f39ff06f          	j	80001320 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

00000000800013ec <start>:
    800013ec:	ff010113          	addi	sp,sp,-16
    800013f0:	00813423          	sd	s0,8(sp)
    800013f4:	01010413          	addi	s0,sp,16
    800013f8:	300027f3          	csrr	a5,mstatus
    800013fc:	ffffe737          	lui	a4,0xffffe
    80001400:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff927f>
    80001404:	00e7f7b3          	and	a5,a5,a4
    80001408:	00001737          	lui	a4,0x1
    8000140c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001410:	00e7e7b3          	or	a5,a5,a4
    80001414:	30079073          	csrw	mstatus,a5
    80001418:	00000797          	auipc	a5,0x0
    8000141c:	16078793          	addi	a5,a5,352 # 80001578 <system_main>
    80001420:	34179073          	csrw	mepc,a5
    80001424:	00000793          	li	a5,0
    80001428:	18079073          	csrw	satp,a5
    8000142c:	000107b7          	lui	a5,0x10
    80001430:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001434:	30279073          	csrw	medeleg,a5
    80001438:	30379073          	csrw	mideleg,a5
    8000143c:	104027f3          	csrr	a5,sie
    80001440:	2227e793          	ori	a5,a5,546
    80001444:	10479073          	csrw	sie,a5
    80001448:	fff00793          	li	a5,-1
    8000144c:	00a7d793          	srli	a5,a5,0xa
    80001450:	3b079073          	csrw	pmpaddr0,a5
    80001454:	00f00793          	li	a5,15
    80001458:	3a079073          	csrw	pmpcfg0,a5
    8000145c:	f14027f3          	csrr	a5,mhartid
    80001460:	0200c737          	lui	a4,0x200c
    80001464:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001468:	0007869b          	sext.w	a3,a5
    8000146c:	00269713          	slli	a4,a3,0x2
    80001470:	000f4637          	lui	a2,0xf4
    80001474:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001478:	00d70733          	add	a4,a4,a3
    8000147c:	0037979b          	slliw	a5,a5,0x3
    80001480:	020046b7          	lui	a3,0x2004
    80001484:	00d787b3          	add	a5,a5,a3
    80001488:	00c585b3          	add	a1,a1,a2
    8000148c:	00371693          	slli	a3,a4,0x3
    80001490:	00003717          	auipc	a4,0x3
    80001494:	ea070713          	addi	a4,a4,-352 # 80004330 <timer_scratch>
    80001498:	00b7b023          	sd	a1,0(a5)
    8000149c:	00d70733          	add	a4,a4,a3
    800014a0:	00f73c23          	sd	a5,24(a4)
    800014a4:	02c73023          	sd	a2,32(a4)
    800014a8:	34071073          	csrw	mscratch,a4
    800014ac:	00000797          	auipc	a5,0x0
    800014b0:	6e478793          	addi	a5,a5,1764 # 80001b90 <timervec>
    800014b4:	30579073          	csrw	mtvec,a5
    800014b8:	300027f3          	csrr	a5,mstatus
    800014bc:	0087e793          	ori	a5,a5,8
    800014c0:	30079073          	csrw	mstatus,a5
    800014c4:	304027f3          	csrr	a5,mie
    800014c8:	0807e793          	ori	a5,a5,128
    800014cc:	30479073          	csrw	mie,a5
    800014d0:	f14027f3          	csrr	a5,mhartid
    800014d4:	0007879b          	sext.w	a5,a5
    800014d8:	00078213          	mv	tp,a5
    800014dc:	30200073          	mret
    800014e0:	00813403          	ld	s0,8(sp)
    800014e4:	01010113          	addi	sp,sp,16
    800014e8:	00008067          	ret

00000000800014ec <timerinit>:
    800014ec:	ff010113          	addi	sp,sp,-16
    800014f0:	00813423          	sd	s0,8(sp)
    800014f4:	01010413          	addi	s0,sp,16
    800014f8:	f14027f3          	csrr	a5,mhartid
    800014fc:	0200c737          	lui	a4,0x200c
    80001500:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001504:	0007869b          	sext.w	a3,a5
    80001508:	00269713          	slli	a4,a3,0x2
    8000150c:	000f4637          	lui	a2,0xf4
    80001510:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001514:	00d70733          	add	a4,a4,a3
    80001518:	0037979b          	slliw	a5,a5,0x3
    8000151c:	020046b7          	lui	a3,0x2004
    80001520:	00d787b3          	add	a5,a5,a3
    80001524:	00c585b3          	add	a1,a1,a2
    80001528:	00371693          	slli	a3,a4,0x3
    8000152c:	00003717          	auipc	a4,0x3
    80001530:	e0470713          	addi	a4,a4,-508 # 80004330 <timer_scratch>
    80001534:	00b7b023          	sd	a1,0(a5)
    80001538:	00d70733          	add	a4,a4,a3
    8000153c:	00f73c23          	sd	a5,24(a4)
    80001540:	02c73023          	sd	a2,32(a4)
    80001544:	34071073          	csrw	mscratch,a4
    80001548:	00000797          	auipc	a5,0x0
    8000154c:	64878793          	addi	a5,a5,1608 # 80001b90 <timervec>
    80001550:	30579073          	csrw	mtvec,a5
    80001554:	300027f3          	csrr	a5,mstatus
    80001558:	0087e793          	ori	a5,a5,8
    8000155c:	30079073          	csrw	mstatus,a5
    80001560:	304027f3          	csrr	a5,mie
    80001564:	0807e793          	ori	a5,a5,128
    80001568:	30479073          	csrw	mie,a5
    8000156c:	00813403          	ld	s0,8(sp)
    80001570:	01010113          	addi	sp,sp,16
    80001574:	00008067          	ret

0000000080001578 <system_main>:
    80001578:	fe010113          	addi	sp,sp,-32
    8000157c:	00813823          	sd	s0,16(sp)
    80001580:	00913423          	sd	s1,8(sp)
    80001584:	00113c23          	sd	ra,24(sp)
    80001588:	02010413          	addi	s0,sp,32
    8000158c:	00000097          	auipc	ra,0x0
    80001590:	0c4080e7          	jalr	196(ra) # 80001650 <cpuid>
    80001594:	00003497          	auipc	s1,0x3
    80001598:	d5c48493          	addi	s1,s1,-676 # 800042f0 <started>
    8000159c:	02050263          	beqz	a0,800015c0 <system_main+0x48>
    800015a0:	0004a783          	lw	a5,0(s1)
    800015a4:	0007879b          	sext.w	a5,a5
    800015a8:	fe078ce3          	beqz	a5,800015a0 <system_main+0x28>
    800015ac:	0ff0000f          	fence
    800015b0:	00003517          	auipc	a0,0x3
    800015b4:	aa050513          	addi	a0,a0,-1376 # 80004050 <CONSOLE_STATUS+0x40>
    800015b8:	00001097          	auipc	ra,0x1
    800015bc:	a74080e7          	jalr	-1420(ra) # 8000202c <panic>
    800015c0:	00001097          	auipc	ra,0x1
    800015c4:	9c8080e7          	jalr	-1592(ra) # 80001f88 <consoleinit>
    800015c8:	00001097          	auipc	ra,0x1
    800015cc:	154080e7          	jalr	340(ra) # 8000271c <printfinit>
    800015d0:	00003517          	auipc	a0,0x3
    800015d4:	b6050513          	addi	a0,a0,-1184 # 80004130 <CONSOLE_STATUS+0x120>
    800015d8:	00001097          	auipc	ra,0x1
    800015dc:	ab0080e7          	jalr	-1360(ra) # 80002088 <__printf>
    800015e0:	00003517          	auipc	a0,0x3
    800015e4:	a4050513          	addi	a0,a0,-1472 # 80004020 <CONSOLE_STATUS+0x10>
    800015e8:	00001097          	auipc	ra,0x1
    800015ec:	aa0080e7          	jalr	-1376(ra) # 80002088 <__printf>
    800015f0:	00003517          	auipc	a0,0x3
    800015f4:	b4050513          	addi	a0,a0,-1216 # 80004130 <CONSOLE_STATUS+0x120>
    800015f8:	00001097          	auipc	ra,0x1
    800015fc:	a90080e7          	jalr	-1392(ra) # 80002088 <__printf>
    80001600:	00001097          	auipc	ra,0x1
    80001604:	4a8080e7          	jalr	1192(ra) # 80002aa8 <kinit>
    80001608:	00000097          	auipc	ra,0x0
    8000160c:	148080e7          	jalr	328(ra) # 80001750 <trapinit>
    80001610:	00000097          	auipc	ra,0x0
    80001614:	16c080e7          	jalr	364(ra) # 8000177c <trapinithart>
    80001618:	00000097          	auipc	ra,0x0
    8000161c:	5b8080e7          	jalr	1464(ra) # 80001bd0 <plicinit>
    80001620:	00000097          	auipc	ra,0x0
    80001624:	5d8080e7          	jalr	1496(ra) # 80001bf8 <plicinithart>
    80001628:	00000097          	auipc	ra,0x0
    8000162c:	078080e7          	jalr	120(ra) # 800016a0 <userinit>
    80001630:	0ff0000f          	fence
    80001634:	00100793          	li	a5,1
    80001638:	00003517          	auipc	a0,0x3
    8000163c:	a0050513          	addi	a0,a0,-1536 # 80004038 <CONSOLE_STATUS+0x28>
    80001640:	00f4a023          	sw	a5,0(s1)
    80001644:	00001097          	auipc	ra,0x1
    80001648:	a44080e7          	jalr	-1468(ra) # 80002088 <__printf>
    8000164c:	0000006f          	j	8000164c <system_main+0xd4>

0000000080001650 <cpuid>:
    80001650:	ff010113          	addi	sp,sp,-16
    80001654:	00813423          	sd	s0,8(sp)
    80001658:	01010413          	addi	s0,sp,16
    8000165c:	00020513          	mv	a0,tp
    80001660:	00813403          	ld	s0,8(sp)
    80001664:	0005051b          	sext.w	a0,a0
    80001668:	01010113          	addi	sp,sp,16
    8000166c:	00008067          	ret

0000000080001670 <mycpu>:
    80001670:	ff010113          	addi	sp,sp,-16
    80001674:	00813423          	sd	s0,8(sp)
    80001678:	01010413          	addi	s0,sp,16
    8000167c:	00020793          	mv	a5,tp
    80001680:	00813403          	ld	s0,8(sp)
    80001684:	0007879b          	sext.w	a5,a5
    80001688:	00779793          	slli	a5,a5,0x7
    8000168c:	00004517          	auipc	a0,0x4
    80001690:	cd450513          	addi	a0,a0,-812 # 80005360 <cpus>
    80001694:	00f50533          	add	a0,a0,a5
    80001698:	01010113          	addi	sp,sp,16
    8000169c:	00008067          	ret

00000000800016a0 <userinit>:
    800016a0:	ff010113          	addi	sp,sp,-16
    800016a4:	00813423          	sd	s0,8(sp)
    800016a8:	01010413          	addi	s0,sp,16
    800016ac:	00813403          	ld	s0,8(sp)
    800016b0:	01010113          	addi	sp,sp,16
    800016b4:	00000317          	auipc	t1,0x0
    800016b8:	94c30067          	jr	-1716(t1) # 80001000 <main>

00000000800016bc <either_copyout>:
    800016bc:	ff010113          	addi	sp,sp,-16
    800016c0:	00813023          	sd	s0,0(sp)
    800016c4:	00113423          	sd	ra,8(sp)
    800016c8:	01010413          	addi	s0,sp,16
    800016cc:	02051663          	bnez	a0,800016f8 <either_copyout+0x3c>
    800016d0:	00058513          	mv	a0,a1
    800016d4:	00060593          	mv	a1,a2
    800016d8:	0006861b          	sext.w	a2,a3
    800016dc:	00002097          	auipc	ra,0x2
    800016e0:	c58080e7          	jalr	-936(ra) # 80003334 <__memmove>
    800016e4:	00813083          	ld	ra,8(sp)
    800016e8:	00013403          	ld	s0,0(sp)
    800016ec:	00000513          	li	a0,0
    800016f0:	01010113          	addi	sp,sp,16
    800016f4:	00008067          	ret
    800016f8:	00003517          	auipc	a0,0x3
    800016fc:	98050513          	addi	a0,a0,-1664 # 80004078 <CONSOLE_STATUS+0x68>
    80001700:	00001097          	auipc	ra,0x1
    80001704:	92c080e7          	jalr	-1748(ra) # 8000202c <panic>

0000000080001708 <either_copyin>:
    80001708:	ff010113          	addi	sp,sp,-16
    8000170c:	00813023          	sd	s0,0(sp)
    80001710:	00113423          	sd	ra,8(sp)
    80001714:	01010413          	addi	s0,sp,16
    80001718:	02059463          	bnez	a1,80001740 <either_copyin+0x38>
    8000171c:	00060593          	mv	a1,a2
    80001720:	0006861b          	sext.w	a2,a3
    80001724:	00002097          	auipc	ra,0x2
    80001728:	c10080e7          	jalr	-1008(ra) # 80003334 <__memmove>
    8000172c:	00813083          	ld	ra,8(sp)
    80001730:	00013403          	ld	s0,0(sp)
    80001734:	00000513          	li	a0,0
    80001738:	01010113          	addi	sp,sp,16
    8000173c:	00008067          	ret
    80001740:	00003517          	auipc	a0,0x3
    80001744:	96050513          	addi	a0,a0,-1696 # 800040a0 <CONSOLE_STATUS+0x90>
    80001748:	00001097          	auipc	ra,0x1
    8000174c:	8e4080e7          	jalr	-1820(ra) # 8000202c <panic>

0000000080001750 <trapinit>:
    80001750:	ff010113          	addi	sp,sp,-16
    80001754:	00813423          	sd	s0,8(sp)
    80001758:	01010413          	addi	s0,sp,16
    8000175c:	00813403          	ld	s0,8(sp)
    80001760:	00003597          	auipc	a1,0x3
    80001764:	96858593          	addi	a1,a1,-1688 # 800040c8 <CONSOLE_STATUS+0xb8>
    80001768:	00004517          	auipc	a0,0x4
    8000176c:	c7850513          	addi	a0,a0,-904 # 800053e0 <tickslock>
    80001770:	01010113          	addi	sp,sp,16
    80001774:	00001317          	auipc	t1,0x1
    80001778:	5c430067          	jr	1476(t1) # 80002d38 <initlock>

000000008000177c <trapinithart>:
    8000177c:	ff010113          	addi	sp,sp,-16
    80001780:	00813423          	sd	s0,8(sp)
    80001784:	01010413          	addi	s0,sp,16
    80001788:	00000797          	auipc	a5,0x0
    8000178c:	2f878793          	addi	a5,a5,760 # 80001a80 <kernelvec>
    80001790:	10579073          	csrw	stvec,a5
    80001794:	00813403          	ld	s0,8(sp)
    80001798:	01010113          	addi	sp,sp,16
    8000179c:	00008067          	ret

00000000800017a0 <usertrap>:
    800017a0:	ff010113          	addi	sp,sp,-16
    800017a4:	00813423          	sd	s0,8(sp)
    800017a8:	01010413          	addi	s0,sp,16
    800017ac:	00813403          	ld	s0,8(sp)
    800017b0:	01010113          	addi	sp,sp,16
    800017b4:	00008067          	ret

00000000800017b8 <usertrapret>:
    800017b8:	ff010113          	addi	sp,sp,-16
    800017bc:	00813423          	sd	s0,8(sp)
    800017c0:	01010413          	addi	s0,sp,16
    800017c4:	00813403          	ld	s0,8(sp)
    800017c8:	01010113          	addi	sp,sp,16
    800017cc:	00008067          	ret

00000000800017d0 <kerneltrap>:
    800017d0:	fe010113          	addi	sp,sp,-32
    800017d4:	00813823          	sd	s0,16(sp)
    800017d8:	00113c23          	sd	ra,24(sp)
    800017dc:	00913423          	sd	s1,8(sp)
    800017e0:	02010413          	addi	s0,sp,32
    800017e4:	142025f3          	csrr	a1,scause
    800017e8:	100027f3          	csrr	a5,sstatus
    800017ec:	0027f793          	andi	a5,a5,2
    800017f0:	10079c63          	bnez	a5,80001908 <kerneltrap+0x138>
    800017f4:	142027f3          	csrr	a5,scause
    800017f8:	0207ce63          	bltz	a5,80001834 <kerneltrap+0x64>
    800017fc:	00003517          	auipc	a0,0x3
    80001800:	91450513          	addi	a0,a0,-1772 # 80004110 <CONSOLE_STATUS+0x100>
    80001804:	00001097          	auipc	ra,0x1
    80001808:	884080e7          	jalr	-1916(ra) # 80002088 <__printf>
    8000180c:	141025f3          	csrr	a1,sepc
    80001810:	14302673          	csrr	a2,stval
    80001814:	00003517          	auipc	a0,0x3
    80001818:	90c50513          	addi	a0,a0,-1780 # 80004120 <CONSOLE_STATUS+0x110>
    8000181c:	00001097          	auipc	ra,0x1
    80001820:	86c080e7          	jalr	-1940(ra) # 80002088 <__printf>
    80001824:	00003517          	auipc	a0,0x3
    80001828:	91450513          	addi	a0,a0,-1772 # 80004138 <CONSOLE_STATUS+0x128>
    8000182c:	00001097          	auipc	ra,0x1
    80001830:	800080e7          	jalr	-2048(ra) # 8000202c <panic>
    80001834:	0ff7f713          	andi	a4,a5,255
    80001838:	00900693          	li	a3,9
    8000183c:	04d70063          	beq	a4,a3,8000187c <kerneltrap+0xac>
    80001840:	fff00713          	li	a4,-1
    80001844:	03f71713          	slli	a4,a4,0x3f
    80001848:	00170713          	addi	a4,a4,1
    8000184c:	fae798e3          	bne	a5,a4,800017fc <kerneltrap+0x2c>
    80001850:	00000097          	auipc	ra,0x0
    80001854:	e00080e7          	jalr	-512(ra) # 80001650 <cpuid>
    80001858:	06050663          	beqz	a0,800018c4 <kerneltrap+0xf4>
    8000185c:	144027f3          	csrr	a5,sip
    80001860:	ffd7f793          	andi	a5,a5,-3
    80001864:	14479073          	csrw	sip,a5
    80001868:	01813083          	ld	ra,24(sp)
    8000186c:	01013403          	ld	s0,16(sp)
    80001870:	00813483          	ld	s1,8(sp)
    80001874:	02010113          	addi	sp,sp,32
    80001878:	00008067          	ret
    8000187c:	00000097          	auipc	ra,0x0
    80001880:	3c8080e7          	jalr	968(ra) # 80001c44 <plic_claim>
    80001884:	00a00793          	li	a5,10
    80001888:	00050493          	mv	s1,a0
    8000188c:	06f50863          	beq	a0,a5,800018fc <kerneltrap+0x12c>
    80001890:	fc050ce3          	beqz	a0,80001868 <kerneltrap+0x98>
    80001894:	00050593          	mv	a1,a0
    80001898:	00003517          	auipc	a0,0x3
    8000189c:	85850513          	addi	a0,a0,-1960 # 800040f0 <CONSOLE_STATUS+0xe0>
    800018a0:	00000097          	auipc	ra,0x0
    800018a4:	7e8080e7          	jalr	2024(ra) # 80002088 <__printf>
    800018a8:	01013403          	ld	s0,16(sp)
    800018ac:	01813083          	ld	ra,24(sp)
    800018b0:	00048513          	mv	a0,s1
    800018b4:	00813483          	ld	s1,8(sp)
    800018b8:	02010113          	addi	sp,sp,32
    800018bc:	00000317          	auipc	t1,0x0
    800018c0:	3c030067          	jr	960(t1) # 80001c7c <plic_complete>
    800018c4:	00004517          	auipc	a0,0x4
    800018c8:	b1c50513          	addi	a0,a0,-1252 # 800053e0 <tickslock>
    800018cc:	00001097          	auipc	ra,0x1
    800018d0:	490080e7          	jalr	1168(ra) # 80002d5c <acquire>
    800018d4:	00003717          	auipc	a4,0x3
    800018d8:	a2070713          	addi	a4,a4,-1504 # 800042f4 <ticks>
    800018dc:	00072783          	lw	a5,0(a4)
    800018e0:	00004517          	auipc	a0,0x4
    800018e4:	b0050513          	addi	a0,a0,-1280 # 800053e0 <tickslock>
    800018e8:	0017879b          	addiw	a5,a5,1
    800018ec:	00f72023          	sw	a5,0(a4)
    800018f0:	00001097          	auipc	ra,0x1
    800018f4:	538080e7          	jalr	1336(ra) # 80002e28 <release>
    800018f8:	f65ff06f          	j	8000185c <kerneltrap+0x8c>
    800018fc:	00001097          	auipc	ra,0x1
    80001900:	094080e7          	jalr	148(ra) # 80002990 <uartintr>
    80001904:	fa5ff06f          	j	800018a8 <kerneltrap+0xd8>
    80001908:	00002517          	auipc	a0,0x2
    8000190c:	7c850513          	addi	a0,a0,1992 # 800040d0 <CONSOLE_STATUS+0xc0>
    80001910:	00000097          	auipc	ra,0x0
    80001914:	71c080e7          	jalr	1820(ra) # 8000202c <panic>

0000000080001918 <clockintr>:
    80001918:	fe010113          	addi	sp,sp,-32
    8000191c:	00813823          	sd	s0,16(sp)
    80001920:	00913423          	sd	s1,8(sp)
    80001924:	00113c23          	sd	ra,24(sp)
    80001928:	02010413          	addi	s0,sp,32
    8000192c:	00004497          	auipc	s1,0x4
    80001930:	ab448493          	addi	s1,s1,-1356 # 800053e0 <tickslock>
    80001934:	00048513          	mv	a0,s1
    80001938:	00001097          	auipc	ra,0x1
    8000193c:	424080e7          	jalr	1060(ra) # 80002d5c <acquire>
    80001940:	00003717          	auipc	a4,0x3
    80001944:	9b470713          	addi	a4,a4,-1612 # 800042f4 <ticks>
    80001948:	00072783          	lw	a5,0(a4)
    8000194c:	01013403          	ld	s0,16(sp)
    80001950:	01813083          	ld	ra,24(sp)
    80001954:	00048513          	mv	a0,s1
    80001958:	0017879b          	addiw	a5,a5,1
    8000195c:	00813483          	ld	s1,8(sp)
    80001960:	00f72023          	sw	a5,0(a4)
    80001964:	02010113          	addi	sp,sp,32
    80001968:	00001317          	auipc	t1,0x1
    8000196c:	4c030067          	jr	1216(t1) # 80002e28 <release>

0000000080001970 <devintr>:
    80001970:	142027f3          	csrr	a5,scause
    80001974:	00000513          	li	a0,0
    80001978:	0007c463          	bltz	a5,80001980 <devintr+0x10>
    8000197c:	00008067          	ret
    80001980:	fe010113          	addi	sp,sp,-32
    80001984:	00813823          	sd	s0,16(sp)
    80001988:	00113c23          	sd	ra,24(sp)
    8000198c:	00913423          	sd	s1,8(sp)
    80001990:	02010413          	addi	s0,sp,32
    80001994:	0ff7f713          	andi	a4,a5,255
    80001998:	00900693          	li	a3,9
    8000199c:	04d70c63          	beq	a4,a3,800019f4 <devintr+0x84>
    800019a0:	fff00713          	li	a4,-1
    800019a4:	03f71713          	slli	a4,a4,0x3f
    800019a8:	00170713          	addi	a4,a4,1
    800019ac:	00e78c63          	beq	a5,a4,800019c4 <devintr+0x54>
    800019b0:	01813083          	ld	ra,24(sp)
    800019b4:	01013403          	ld	s0,16(sp)
    800019b8:	00813483          	ld	s1,8(sp)
    800019bc:	02010113          	addi	sp,sp,32
    800019c0:	00008067          	ret
    800019c4:	00000097          	auipc	ra,0x0
    800019c8:	c8c080e7          	jalr	-884(ra) # 80001650 <cpuid>
    800019cc:	06050663          	beqz	a0,80001a38 <devintr+0xc8>
    800019d0:	144027f3          	csrr	a5,sip
    800019d4:	ffd7f793          	andi	a5,a5,-3
    800019d8:	14479073          	csrw	sip,a5
    800019dc:	01813083          	ld	ra,24(sp)
    800019e0:	01013403          	ld	s0,16(sp)
    800019e4:	00813483          	ld	s1,8(sp)
    800019e8:	00200513          	li	a0,2
    800019ec:	02010113          	addi	sp,sp,32
    800019f0:	00008067          	ret
    800019f4:	00000097          	auipc	ra,0x0
    800019f8:	250080e7          	jalr	592(ra) # 80001c44 <plic_claim>
    800019fc:	00a00793          	li	a5,10
    80001a00:	00050493          	mv	s1,a0
    80001a04:	06f50663          	beq	a0,a5,80001a70 <devintr+0x100>
    80001a08:	00100513          	li	a0,1
    80001a0c:	fa0482e3          	beqz	s1,800019b0 <devintr+0x40>
    80001a10:	00048593          	mv	a1,s1
    80001a14:	00002517          	auipc	a0,0x2
    80001a18:	6dc50513          	addi	a0,a0,1756 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001a1c:	00000097          	auipc	ra,0x0
    80001a20:	66c080e7          	jalr	1644(ra) # 80002088 <__printf>
    80001a24:	00048513          	mv	a0,s1
    80001a28:	00000097          	auipc	ra,0x0
    80001a2c:	254080e7          	jalr	596(ra) # 80001c7c <plic_complete>
    80001a30:	00100513          	li	a0,1
    80001a34:	f7dff06f          	j	800019b0 <devintr+0x40>
    80001a38:	00004517          	auipc	a0,0x4
    80001a3c:	9a850513          	addi	a0,a0,-1624 # 800053e0 <tickslock>
    80001a40:	00001097          	auipc	ra,0x1
    80001a44:	31c080e7          	jalr	796(ra) # 80002d5c <acquire>
    80001a48:	00003717          	auipc	a4,0x3
    80001a4c:	8ac70713          	addi	a4,a4,-1876 # 800042f4 <ticks>
    80001a50:	00072783          	lw	a5,0(a4)
    80001a54:	00004517          	auipc	a0,0x4
    80001a58:	98c50513          	addi	a0,a0,-1652 # 800053e0 <tickslock>
    80001a5c:	0017879b          	addiw	a5,a5,1
    80001a60:	00f72023          	sw	a5,0(a4)
    80001a64:	00001097          	auipc	ra,0x1
    80001a68:	3c4080e7          	jalr	964(ra) # 80002e28 <release>
    80001a6c:	f65ff06f          	j	800019d0 <devintr+0x60>
    80001a70:	00001097          	auipc	ra,0x1
    80001a74:	f20080e7          	jalr	-224(ra) # 80002990 <uartintr>
    80001a78:	fadff06f          	j	80001a24 <devintr+0xb4>
    80001a7c:	0000                	unimp
	...

0000000080001a80 <kernelvec>:
    80001a80:	f0010113          	addi	sp,sp,-256
    80001a84:	00113023          	sd	ra,0(sp)
    80001a88:	00213423          	sd	sp,8(sp)
    80001a8c:	00313823          	sd	gp,16(sp)
    80001a90:	00413c23          	sd	tp,24(sp)
    80001a94:	02513023          	sd	t0,32(sp)
    80001a98:	02613423          	sd	t1,40(sp)
    80001a9c:	02713823          	sd	t2,48(sp)
    80001aa0:	02813c23          	sd	s0,56(sp)
    80001aa4:	04913023          	sd	s1,64(sp)
    80001aa8:	04a13423          	sd	a0,72(sp)
    80001aac:	04b13823          	sd	a1,80(sp)
    80001ab0:	04c13c23          	sd	a2,88(sp)
    80001ab4:	06d13023          	sd	a3,96(sp)
    80001ab8:	06e13423          	sd	a4,104(sp)
    80001abc:	06f13823          	sd	a5,112(sp)
    80001ac0:	07013c23          	sd	a6,120(sp)
    80001ac4:	09113023          	sd	a7,128(sp)
    80001ac8:	09213423          	sd	s2,136(sp)
    80001acc:	09313823          	sd	s3,144(sp)
    80001ad0:	09413c23          	sd	s4,152(sp)
    80001ad4:	0b513023          	sd	s5,160(sp)
    80001ad8:	0b613423          	sd	s6,168(sp)
    80001adc:	0b713823          	sd	s7,176(sp)
    80001ae0:	0b813c23          	sd	s8,184(sp)
    80001ae4:	0d913023          	sd	s9,192(sp)
    80001ae8:	0da13423          	sd	s10,200(sp)
    80001aec:	0db13823          	sd	s11,208(sp)
    80001af0:	0dc13c23          	sd	t3,216(sp)
    80001af4:	0fd13023          	sd	t4,224(sp)
    80001af8:	0fe13423          	sd	t5,232(sp)
    80001afc:	0ff13823          	sd	t6,240(sp)
    80001b00:	cd1ff0ef          	jal	ra,800017d0 <kerneltrap>
    80001b04:	00013083          	ld	ra,0(sp)
    80001b08:	00813103          	ld	sp,8(sp)
    80001b0c:	01013183          	ld	gp,16(sp)
    80001b10:	02013283          	ld	t0,32(sp)
    80001b14:	02813303          	ld	t1,40(sp)
    80001b18:	03013383          	ld	t2,48(sp)
    80001b1c:	03813403          	ld	s0,56(sp)
    80001b20:	04013483          	ld	s1,64(sp)
    80001b24:	04813503          	ld	a0,72(sp)
    80001b28:	05013583          	ld	a1,80(sp)
    80001b2c:	05813603          	ld	a2,88(sp)
    80001b30:	06013683          	ld	a3,96(sp)
    80001b34:	06813703          	ld	a4,104(sp)
    80001b38:	07013783          	ld	a5,112(sp)
    80001b3c:	07813803          	ld	a6,120(sp)
    80001b40:	08013883          	ld	a7,128(sp)
    80001b44:	08813903          	ld	s2,136(sp)
    80001b48:	09013983          	ld	s3,144(sp)
    80001b4c:	09813a03          	ld	s4,152(sp)
    80001b50:	0a013a83          	ld	s5,160(sp)
    80001b54:	0a813b03          	ld	s6,168(sp)
    80001b58:	0b013b83          	ld	s7,176(sp)
    80001b5c:	0b813c03          	ld	s8,184(sp)
    80001b60:	0c013c83          	ld	s9,192(sp)
    80001b64:	0c813d03          	ld	s10,200(sp)
    80001b68:	0d013d83          	ld	s11,208(sp)
    80001b6c:	0d813e03          	ld	t3,216(sp)
    80001b70:	0e013e83          	ld	t4,224(sp)
    80001b74:	0e813f03          	ld	t5,232(sp)
    80001b78:	0f013f83          	ld	t6,240(sp)
    80001b7c:	10010113          	addi	sp,sp,256
    80001b80:	10200073          	sret
    80001b84:	00000013          	nop
    80001b88:	00000013          	nop
    80001b8c:	00000013          	nop

0000000080001b90 <timervec>:
    80001b90:	34051573          	csrrw	a0,mscratch,a0
    80001b94:	00b53023          	sd	a1,0(a0)
    80001b98:	00c53423          	sd	a2,8(a0)
    80001b9c:	00d53823          	sd	a3,16(a0)
    80001ba0:	01853583          	ld	a1,24(a0)
    80001ba4:	02053603          	ld	a2,32(a0)
    80001ba8:	0005b683          	ld	a3,0(a1)
    80001bac:	00c686b3          	add	a3,a3,a2
    80001bb0:	00d5b023          	sd	a3,0(a1)
    80001bb4:	00200593          	li	a1,2
    80001bb8:	14459073          	csrw	sip,a1
    80001bbc:	01053683          	ld	a3,16(a0)
    80001bc0:	00853603          	ld	a2,8(a0)
    80001bc4:	00053583          	ld	a1,0(a0)
    80001bc8:	34051573          	csrrw	a0,mscratch,a0
    80001bcc:	30200073          	mret

0000000080001bd0 <plicinit>:
    80001bd0:	ff010113          	addi	sp,sp,-16
    80001bd4:	00813423          	sd	s0,8(sp)
    80001bd8:	01010413          	addi	s0,sp,16
    80001bdc:	00813403          	ld	s0,8(sp)
    80001be0:	0c0007b7          	lui	a5,0xc000
    80001be4:	00100713          	li	a4,1
    80001be8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80001bec:	00e7a223          	sw	a4,4(a5)
    80001bf0:	01010113          	addi	sp,sp,16
    80001bf4:	00008067          	ret

0000000080001bf8 <plicinithart>:
    80001bf8:	ff010113          	addi	sp,sp,-16
    80001bfc:	00813023          	sd	s0,0(sp)
    80001c00:	00113423          	sd	ra,8(sp)
    80001c04:	01010413          	addi	s0,sp,16
    80001c08:	00000097          	auipc	ra,0x0
    80001c0c:	a48080e7          	jalr	-1464(ra) # 80001650 <cpuid>
    80001c10:	0085171b          	slliw	a4,a0,0x8
    80001c14:	0c0027b7          	lui	a5,0xc002
    80001c18:	00e787b3          	add	a5,a5,a4
    80001c1c:	40200713          	li	a4,1026
    80001c20:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001c24:	00813083          	ld	ra,8(sp)
    80001c28:	00013403          	ld	s0,0(sp)
    80001c2c:	00d5151b          	slliw	a0,a0,0xd
    80001c30:	0c2017b7          	lui	a5,0xc201
    80001c34:	00a78533          	add	a0,a5,a0
    80001c38:	00052023          	sw	zero,0(a0)
    80001c3c:	01010113          	addi	sp,sp,16
    80001c40:	00008067          	ret

0000000080001c44 <plic_claim>:
    80001c44:	ff010113          	addi	sp,sp,-16
    80001c48:	00813023          	sd	s0,0(sp)
    80001c4c:	00113423          	sd	ra,8(sp)
    80001c50:	01010413          	addi	s0,sp,16
    80001c54:	00000097          	auipc	ra,0x0
    80001c58:	9fc080e7          	jalr	-1540(ra) # 80001650 <cpuid>
    80001c5c:	00813083          	ld	ra,8(sp)
    80001c60:	00013403          	ld	s0,0(sp)
    80001c64:	00d5151b          	slliw	a0,a0,0xd
    80001c68:	0c2017b7          	lui	a5,0xc201
    80001c6c:	00a78533          	add	a0,a5,a0
    80001c70:	00452503          	lw	a0,4(a0)
    80001c74:	01010113          	addi	sp,sp,16
    80001c78:	00008067          	ret

0000000080001c7c <plic_complete>:
    80001c7c:	fe010113          	addi	sp,sp,-32
    80001c80:	00813823          	sd	s0,16(sp)
    80001c84:	00913423          	sd	s1,8(sp)
    80001c88:	00113c23          	sd	ra,24(sp)
    80001c8c:	02010413          	addi	s0,sp,32
    80001c90:	00050493          	mv	s1,a0
    80001c94:	00000097          	auipc	ra,0x0
    80001c98:	9bc080e7          	jalr	-1604(ra) # 80001650 <cpuid>
    80001c9c:	01813083          	ld	ra,24(sp)
    80001ca0:	01013403          	ld	s0,16(sp)
    80001ca4:	00d5179b          	slliw	a5,a0,0xd
    80001ca8:	0c201737          	lui	a4,0xc201
    80001cac:	00f707b3          	add	a5,a4,a5
    80001cb0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001cb4:	00813483          	ld	s1,8(sp)
    80001cb8:	02010113          	addi	sp,sp,32
    80001cbc:	00008067          	ret

0000000080001cc0 <consolewrite>:
    80001cc0:	fb010113          	addi	sp,sp,-80
    80001cc4:	04813023          	sd	s0,64(sp)
    80001cc8:	04113423          	sd	ra,72(sp)
    80001ccc:	02913c23          	sd	s1,56(sp)
    80001cd0:	03213823          	sd	s2,48(sp)
    80001cd4:	03313423          	sd	s3,40(sp)
    80001cd8:	03413023          	sd	s4,32(sp)
    80001cdc:	01513c23          	sd	s5,24(sp)
    80001ce0:	05010413          	addi	s0,sp,80
    80001ce4:	06c05c63          	blez	a2,80001d5c <consolewrite+0x9c>
    80001ce8:	00060993          	mv	s3,a2
    80001cec:	00050a13          	mv	s4,a0
    80001cf0:	00058493          	mv	s1,a1
    80001cf4:	00000913          	li	s2,0
    80001cf8:	fff00a93          	li	s5,-1
    80001cfc:	01c0006f          	j	80001d18 <consolewrite+0x58>
    80001d00:	fbf44503          	lbu	a0,-65(s0)
    80001d04:	0019091b          	addiw	s2,s2,1
    80001d08:	00148493          	addi	s1,s1,1
    80001d0c:	00001097          	auipc	ra,0x1
    80001d10:	a9c080e7          	jalr	-1380(ra) # 800027a8 <uartputc>
    80001d14:	03298063          	beq	s3,s2,80001d34 <consolewrite+0x74>
    80001d18:	00048613          	mv	a2,s1
    80001d1c:	00100693          	li	a3,1
    80001d20:	000a0593          	mv	a1,s4
    80001d24:	fbf40513          	addi	a0,s0,-65
    80001d28:	00000097          	auipc	ra,0x0
    80001d2c:	9e0080e7          	jalr	-1568(ra) # 80001708 <either_copyin>
    80001d30:	fd5518e3          	bne	a0,s5,80001d00 <consolewrite+0x40>
    80001d34:	04813083          	ld	ra,72(sp)
    80001d38:	04013403          	ld	s0,64(sp)
    80001d3c:	03813483          	ld	s1,56(sp)
    80001d40:	02813983          	ld	s3,40(sp)
    80001d44:	02013a03          	ld	s4,32(sp)
    80001d48:	01813a83          	ld	s5,24(sp)
    80001d4c:	00090513          	mv	a0,s2
    80001d50:	03013903          	ld	s2,48(sp)
    80001d54:	05010113          	addi	sp,sp,80
    80001d58:	00008067          	ret
    80001d5c:	00000913          	li	s2,0
    80001d60:	fd5ff06f          	j	80001d34 <consolewrite+0x74>

0000000080001d64 <consoleread>:
    80001d64:	f9010113          	addi	sp,sp,-112
    80001d68:	06813023          	sd	s0,96(sp)
    80001d6c:	04913c23          	sd	s1,88(sp)
    80001d70:	05213823          	sd	s2,80(sp)
    80001d74:	05313423          	sd	s3,72(sp)
    80001d78:	05413023          	sd	s4,64(sp)
    80001d7c:	03513c23          	sd	s5,56(sp)
    80001d80:	03613823          	sd	s6,48(sp)
    80001d84:	03713423          	sd	s7,40(sp)
    80001d88:	03813023          	sd	s8,32(sp)
    80001d8c:	06113423          	sd	ra,104(sp)
    80001d90:	01913c23          	sd	s9,24(sp)
    80001d94:	07010413          	addi	s0,sp,112
    80001d98:	00060b93          	mv	s7,a2
    80001d9c:	00050913          	mv	s2,a0
    80001da0:	00058c13          	mv	s8,a1
    80001da4:	00060b1b          	sext.w	s6,a2
    80001da8:	00003497          	auipc	s1,0x3
    80001dac:	65048493          	addi	s1,s1,1616 # 800053f8 <cons>
    80001db0:	00400993          	li	s3,4
    80001db4:	fff00a13          	li	s4,-1
    80001db8:	00a00a93          	li	s5,10
    80001dbc:	05705e63          	blez	s7,80001e18 <consoleread+0xb4>
    80001dc0:	09c4a703          	lw	a4,156(s1)
    80001dc4:	0984a783          	lw	a5,152(s1)
    80001dc8:	0007071b          	sext.w	a4,a4
    80001dcc:	08e78463          	beq	a5,a4,80001e54 <consoleread+0xf0>
    80001dd0:	07f7f713          	andi	a4,a5,127
    80001dd4:	00e48733          	add	a4,s1,a4
    80001dd8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001ddc:	0017869b          	addiw	a3,a5,1
    80001de0:	08d4ac23          	sw	a3,152(s1)
    80001de4:	00070c9b          	sext.w	s9,a4
    80001de8:	0b370663          	beq	a4,s3,80001e94 <consoleread+0x130>
    80001dec:	00100693          	li	a3,1
    80001df0:	f9f40613          	addi	a2,s0,-97
    80001df4:	000c0593          	mv	a1,s8
    80001df8:	00090513          	mv	a0,s2
    80001dfc:	f8e40fa3          	sb	a4,-97(s0)
    80001e00:	00000097          	auipc	ra,0x0
    80001e04:	8bc080e7          	jalr	-1860(ra) # 800016bc <either_copyout>
    80001e08:	01450863          	beq	a0,s4,80001e18 <consoleread+0xb4>
    80001e0c:	001c0c13          	addi	s8,s8,1
    80001e10:	fffb8b9b          	addiw	s7,s7,-1
    80001e14:	fb5c94e3          	bne	s9,s5,80001dbc <consoleread+0x58>
    80001e18:	000b851b          	sext.w	a0,s7
    80001e1c:	06813083          	ld	ra,104(sp)
    80001e20:	06013403          	ld	s0,96(sp)
    80001e24:	05813483          	ld	s1,88(sp)
    80001e28:	05013903          	ld	s2,80(sp)
    80001e2c:	04813983          	ld	s3,72(sp)
    80001e30:	04013a03          	ld	s4,64(sp)
    80001e34:	03813a83          	ld	s5,56(sp)
    80001e38:	02813b83          	ld	s7,40(sp)
    80001e3c:	02013c03          	ld	s8,32(sp)
    80001e40:	01813c83          	ld	s9,24(sp)
    80001e44:	40ab053b          	subw	a0,s6,a0
    80001e48:	03013b03          	ld	s6,48(sp)
    80001e4c:	07010113          	addi	sp,sp,112
    80001e50:	00008067          	ret
    80001e54:	00001097          	auipc	ra,0x1
    80001e58:	1d8080e7          	jalr	472(ra) # 8000302c <push_on>
    80001e5c:	0984a703          	lw	a4,152(s1)
    80001e60:	09c4a783          	lw	a5,156(s1)
    80001e64:	0007879b          	sext.w	a5,a5
    80001e68:	fef70ce3          	beq	a4,a5,80001e60 <consoleread+0xfc>
    80001e6c:	00001097          	auipc	ra,0x1
    80001e70:	234080e7          	jalr	564(ra) # 800030a0 <pop_on>
    80001e74:	0984a783          	lw	a5,152(s1)
    80001e78:	07f7f713          	andi	a4,a5,127
    80001e7c:	00e48733          	add	a4,s1,a4
    80001e80:	01874703          	lbu	a4,24(a4)
    80001e84:	0017869b          	addiw	a3,a5,1
    80001e88:	08d4ac23          	sw	a3,152(s1)
    80001e8c:	00070c9b          	sext.w	s9,a4
    80001e90:	f5371ee3          	bne	a4,s3,80001dec <consoleread+0x88>
    80001e94:	000b851b          	sext.w	a0,s7
    80001e98:	f96bf2e3          	bgeu	s7,s6,80001e1c <consoleread+0xb8>
    80001e9c:	08f4ac23          	sw	a5,152(s1)
    80001ea0:	f7dff06f          	j	80001e1c <consoleread+0xb8>

0000000080001ea4 <consputc>:
    80001ea4:	10000793          	li	a5,256
    80001ea8:	00f50663          	beq	a0,a5,80001eb4 <consputc+0x10>
    80001eac:	00001317          	auipc	t1,0x1
    80001eb0:	9f430067          	jr	-1548(t1) # 800028a0 <uartputc_sync>
    80001eb4:	ff010113          	addi	sp,sp,-16
    80001eb8:	00113423          	sd	ra,8(sp)
    80001ebc:	00813023          	sd	s0,0(sp)
    80001ec0:	01010413          	addi	s0,sp,16
    80001ec4:	00800513          	li	a0,8
    80001ec8:	00001097          	auipc	ra,0x1
    80001ecc:	9d8080e7          	jalr	-1576(ra) # 800028a0 <uartputc_sync>
    80001ed0:	02000513          	li	a0,32
    80001ed4:	00001097          	auipc	ra,0x1
    80001ed8:	9cc080e7          	jalr	-1588(ra) # 800028a0 <uartputc_sync>
    80001edc:	00013403          	ld	s0,0(sp)
    80001ee0:	00813083          	ld	ra,8(sp)
    80001ee4:	00800513          	li	a0,8
    80001ee8:	01010113          	addi	sp,sp,16
    80001eec:	00001317          	auipc	t1,0x1
    80001ef0:	9b430067          	jr	-1612(t1) # 800028a0 <uartputc_sync>

0000000080001ef4 <consoleintr>:
    80001ef4:	fe010113          	addi	sp,sp,-32
    80001ef8:	00813823          	sd	s0,16(sp)
    80001efc:	00913423          	sd	s1,8(sp)
    80001f00:	01213023          	sd	s2,0(sp)
    80001f04:	00113c23          	sd	ra,24(sp)
    80001f08:	02010413          	addi	s0,sp,32
    80001f0c:	00003917          	auipc	s2,0x3
    80001f10:	4ec90913          	addi	s2,s2,1260 # 800053f8 <cons>
    80001f14:	00050493          	mv	s1,a0
    80001f18:	00090513          	mv	a0,s2
    80001f1c:	00001097          	auipc	ra,0x1
    80001f20:	e40080e7          	jalr	-448(ra) # 80002d5c <acquire>
    80001f24:	02048c63          	beqz	s1,80001f5c <consoleintr+0x68>
    80001f28:	0a092783          	lw	a5,160(s2)
    80001f2c:	09892703          	lw	a4,152(s2)
    80001f30:	07f00693          	li	a3,127
    80001f34:	40e7873b          	subw	a4,a5,a4
    80001f38:	02e6e263          	bltu	a3,a4,80001f5c <consoleintr+0x68>
    80001f3c:	00d00713          	li	a4,13
    80001f40:	04e48063          	beq	s1,a4,80001f80 <consoleintr+0x8c>
    80001f44:	07f7f713          	andi	a4,a5,127
    80001f48:	00e90733          	add	a4,s2,a4
    80001f4c:	0017879b          	addiw	a5,a5,1
    80001f50:	0af92023          	sw	a5,160(s2)
    80001f54:	00970c23          	sb	s1,24(a4)
    80001f58:	08f92e23          	sw	a5,156(s2)
    80001f5c:	01013403          	ld	s0,16(sp)
    80001f60:	01813083          	ld	ra,24(sp)
    80001f64:	00813483          	ld	s1,8(sp)
    80001f68:	00013903          	ld	s2,0(sp)
    80001f6c:	00003517          	auipc	a0,0x3
    80001f70:	48c50513          	addi	a0,a0,1164 # 800053f8 <cons>
    80001f74:	02010113          	addi	sp,sp,32
    80001f78:	00001317          	auipc	t1,0x1
    80001f7c:	eb030067          	jr	-336(t1) # 80002e28 <release>
    80001f80:	00a00493          	li	s1,10
    80001f84:	fc1ff06f          	j	80001f44 <consoleintr+0x50>

0000000080001f88 <consoleinit>:
    80001f88:	fe010113          	addi	sp,sp,-32
    80001f8c:	00113c23          	sd	ra,24(sp)
    80001f90:	00813823          	sd	s0,16(sp)
    80001f94:	00913423          	sd	s1,8(sp)
    80001f98:	02010413          	addi	s0,sp,32
    80001f9c:	00003497          	auipc	s1,0x3
    80001fa0:	45c48493          	addi	s1,s1,1116 # 800053f8 <cons>
    80001fa4:	00048513          	mv	a0,s1
    80001fa8:	00002597          	auipc	a1,0x2
    80001fac:	1a058593          	addi	a1,a1,416 # 80004148 <CONSOLE_STATUS+0x138>
    80001fb0:	00001097          	auipc	ra,0x1
    80001fb4:	d88080e7          	jalr	-632(ra) # 80002d38 <initlock>
    80001fb8:	00000097          	auipc	ra,0x0
    80001fbc:	7ac080e7          	jalr	1964(ra) # 80002764 <uartinit>
    80001fc0:	01813083          	ld	ra,24(sp)
    80001fc4:	01013403          	ld	s0,16(sp)
    80001fc8:	00000797          	auipc	a5,0x0
    80001fcc:	d9c78793          	addi	a5,a5,-612 # 80001d64 <consoleread>
    80001fd0:	0af4bc23          	sd	a5,184(s1)
    80001fd4:	00000797          	auipc	a5,0x0
    80001fd8:	cec78793          	addi	a5,a5,-788 # 80001cc0 <consolewrite>
    80001fdc:	0cf4b023          	sd	a5,192(s1)
    80001fe0:	00813483          	ld	s1,8(sp)
    80001fe4:	02010113          	addi	sp,sp,32
    80001fe8:	00008067          	ret

0000000080001fec <console_read>:
    80001fec:	ff010113          	addi	sp,sp,-16
    80001ff0:	00813423          	sd	s0,8(sp)
    80001ff4:	01010413          	addi	s0,sp,16
    80001ff8:	00813403          	ld	s0,8(sp)
    80001ffc:	00003317          	auipc	t1,0x3
    80002000:	4b433303          	ld	t1,1204(t1) # 800054b0 <devsw+0x10>
    80002004:	01010113          	addi	sp,sp,16
    80002008:	00030067          	jr	t1

000000008000200c <console_write>:
    8000200c:	ff010113          	addi	sp,sp,-16
    80002010:	00813423          	sd	s0,8(sp)
    80002014:	01010413          	addi	s0,sp,16
    80002018:	00813403          	ld	s0,8(sp)
    8000201c:	00003317          	auipc	t1,0x3
    80002020:	49c33303          	ld	t1,1180(t1) # 800054b8 <devsw+0x18>
    80002024:	01010113          	addi	sp,sp,16
    80002028:	00030067          	jr	t1

000000008000202c <panic>:
    8000202c:	fe010113          	addi	sp,sp,-32
    80002030:	00113c23          	sd	ra,24(sp)
    80002034:	00813823          	sd	s0,16(sp)
    80002038:	00913423          	sd	s1,8(sp)
    8000203c:	02010413          	addi	s0,sp,32
    80002040:	00050493          	mv	s1,a0
    80002044:	00002517          	auipc	a0,0x2
    80002048:	10c50513          	addi	a0,a0,268 # 80004150 <CONSOLE_STATUS+0x140>
    8000204c:	00003797          	auipc	a5,0x3
    80002050:	5007a623          	sw	zero,1292(a5) # 80005558 <pr+0x18>
    80002054:	00000097          	auipc	ra,0x0
    80002058:	034080e7          	jalr	52(ra) # 80002088 <__printf>
    8000205c:	00048513          	mv	a0,s1
    80002060:	00000097          	auipc	ra,0x0
    80002064:	028080e7          	jalr	40(ra) # 80002088 <__printf>
    80002068:	00002517          	auipc	a0,0x2
    8000206c:	0c850513          	addi	a0,a0,200 # 80004130 <CONSOLE_STATUS+0x120>
    80002070:	00000097          	auipc	ra,0x0
    80002074:	018080e7          	jalr	24(ra) # 80002088 <__printf>
    80002078:	00100793          	li	a5,1
    8000207c:	00002717          	auipc	a4,0x2
    80002080:	26f72e23          	sw	a5,636(a4) # 800042f8 <panicked>
    80002084:	0000006f          	j	80002084 <panic+0x58>

0000000080002088 <__printf>:
    80002088:	f3010113          	addi	sp,sp,-208
    8000208c:	08813023          	sd	s0,128(sp)
    80002090:	07313423          	sd	s3,104(sp)
    80002094:	09010413          	addi	s0,sp,144
    80002098:	05813023          	sd	s8,64(sp)
    8000209c:	08113423          	sd	ra,136(sp)
    800020a0:	06913c23          	sd	s1,120(sp)
    800020a4:	07213823          	sd	s2,112(sp)
    800020a8:	07413023          	sd	s4,96(sp)
    800020ac:	05513c23          	sd	s5,88(sp)
    800020b0:	05613823          	sd	s6,80(sp)
    800020b4:	05713423          	sd	s7,72(sp)
    800020b8:	03913c23          	sd	s9,56(sp)
    800020bc:	03a13823          	sd	s10,48(sp)
    800020c0:	03b13423          	sd	s11,40(sp)
    800020c4:	00003317          	auipc	t1,0x3
    800020c8:	47c30313          	addi	t1,t1,1148 # 80005540 <pr>
    800020cc:	01832c03          	lw	s8,24(t1)
    800020d0:	00b43423          	sd	a1,8(s0)
    800020d4:	00c43823          	sd	a2,16(s0)
    800020d8:	00d43c23          	sd	a3,24(s0)
    800020dc:	02e43023          	sd	a4,32(s0)
    800020e0:	02f43423          	sd	a5,40(s0)
    800020e4:	03043823          	sd	a6,48(s0)
    800020e8:	03143c23          	sd	a7,56(s0)
    800020ec:	00050993          	mv	s3,a0
    800020f0:	4a0c1663          	bnez	s8,8000259c <__printf+0x514>
    800020f4:	60098c63          	beqz	s3,8000270c <__printf+0x684>
    800020f8:	0009c503          	lbu	a0,0(s3)
    800020fc:	00840793          	addi	a5,s0,8
    80002100:	f6f43c23          	sd	a5,-136(s0)
    80002104:	00000493          	li	s1,0
    80002108:	22050063          	beqz	a0,80002328 <__printf+0x2a0>
    8000210c:	00002a37          	lui	s4,0x2
    80002110:	00018ab7          	lui	s5,0x18
    80002114:	000f4b37          	lui	s6,0xf4
    80002118:	00989bb7          	lui	s7,0x989
    8000211c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002120:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002124:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002128:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000212c:	00148c9b          	addiw	s9,s1,1
    80002130:	02500793          	li	a5,37
    80002134:	01998933          	add	s2,s3,s9
    80002138:	38f51263          	bne	a0,a5,800024bc <__printf+0x434>
    8000213c:	00094783          	lbu	a5,0(s2)
    80002140:	00078c9b          	sext.w	s9,a5
    80002144:	1e078263          	beqz	a5,80002328 <__printf+0x2a0>
    80002148:	0024849b          	addiw	s1,s1,2
    8000214c:	07000713          	li	a4,112
    80002150:	00998933          	add	s2,s3,s1
    80002154:	38e78a63          	beq	a5,a4,800024e8 <__printf+0x460>
    80002158:	20f76863          	bltu	a4,a5,80002368 <__printf+0x2e0>
    8000215c:	42a78863          	beq	a5,a0,8000258c <__printf+0x504>
    80002160:	06400713          	li	a4,100
    80002164:	40e79663          	bne	a5,a4,80002570 <__printf+0x4e8>
    80002168:	f7843783          	ld	a5,-136(s0)
    8000216c:	0007a603          	lw	a2,0(a5)
    80002170:	00878793          	addi	a5,a5,8
    80002174:	f6f43c23          	sd	a5,-136(s0)
    80002178:	42064a63          	bltz	a2,800025ac <__printf+0x524>
    8000217c:	00a00713          	li	a4,10
    80002180:	02e677bb          	remuw	a5,a2,a4
    80002184:	00002d97          	auipc	s11,0x2
    80002188:	ff4d8d93          	addi	s11,s11,-12 # 80004178 <digits>
    8000218c:	00900593          	li	a1,9
    80002190:	0006051b          	sext.w	a0,a2
    80002194:	00000c93          	li	s9,0
    80002198:	02079793          	slli	a5,a5,0x20
    8000219c:	0207d793          	srli	a5,a5,0x20
    800021a0:	00fd87b3          	add	a5,s11,a5
    800021a4:	0007c783          	lbu	a5,0(a5)
    800021a8:	02e656bb          	divuw	a3,a2,a4
    800021ac:	f8f40023          	sb	a5,-128(s0)
    800021b0:	14c5d863          	bge	a1,a2,80002300 <__printf+0x278>
    800021b4:	06300593          	li	a1,99
    800021b8:	00100c93          	li	s9,1
    800021bc:	02e6f7bb          	remuw	a5,a3,a4
    800021c0:	02079793          	slli	a5,a5,0x20
    800021c4:	0207d793          	srli	a5,a5,0x20
    800021c8:	00fd87b3          	add	a5,s11,a5
    800021cc:	0007c783          	lbu	a5,0(a5)
    800021d0:	02e6d73b          	divuw	a4,a3,a4
    800021d4:	f8f400a3          	sb	a5,-127(s0)
    800021d8:	12a5f463          	bgeu	a1,a0,80002300 <__printf+0x278>
    800021dc:	00a00693          	li	a3,10
    800021e0:	00900593          	li	a1,9
    800021e4:	02d777bb          	remuw	a5,a4,a3
    800021e8:	02079793          	slli	a5,a5,0x20
    800021ec:	0207d793          	srli	a5,a5,0x20
    800021f0:	00fd87b3          	add	a5,s11,a5
    800021f4:	0007c503          	lbu	a0,0(a5)
    800021f8:	02d757bb          	divuw	a5,a4,a3
    800021fc:	f8a40123          	sb	a0,-126(s0)
    80002200:	48e5f263          	bgeu	a1,a4,80002684 <__printf+0x5fc>
    80002204:	06300513          	li	a0,99
    80002208:	02d7f5bb          	remuw	a1,a5,a3
    8000220c:	02059593          	slli	a1,a1,0x20
    80002210:	0205d593          	srli	a1,a1,0x20
    80002214:	00bd85b3          	add	a1,s11,a1
    80002218:	0005c583          	lbu	a1,0(a1)
    8000221c:	02d7d7bb          	divuw	a5,a5,a3
    80002220:	f8b401a3          	sb	a1,-125(s0)
    80002224:	48e57263          	bgeu	a0,a4,800026a8 <__printf+0x620>
    80002228:	3e700513          	li	a0,999
    8000222c:	02d7f5bb          	remuw	a1,a5,a3
    80002230:	02059593          	slli	a1,a1,0x20
    80002234:	0205d593          	srli	a1,a1,0x20
    80002238:	00bd85b3          	add	a1,s11,a1
    8000223c:	0005c583          	lbu	a1,0(a1)
    80002240:	02d7d7bb          	divuw	a5,a5,a3
    80002244:	f8b40223          	sb	a1,-124(s0)
    80002248:	46e57663          	bgeu	a0,a4,800026b4 <__printf+0x62c>
    8000224c:	02d7f5bb          	remuw	a1,a5,a3
    80002250:	02059593          	slli	a1,a1,0x20
    80002254:	0205d593          	srli	a1,a1,0x20
    80002258:	00bd85b3          	add	a1,s11,a1
    8000225c:	0005c583          	lbu	a1,0(a1)
    80002260:	02d7d7bb          	divuw	a5,a5,a3
    80002264:	f8b402a3          	sb	a1,-123(s0)
    80002268:	46ea7863          	bgeu	s4,a4,800026d8 <__printf+0x650>
    8000226c:	02d7f5bb          	remuw	a1,a5,a3
    80002270:	02059593          	slli	a1,a1,0x20
    80002274:	0205d593          	srli	a1,a1,0x20
    80002278:	00bd85b3          	add	a1,s11,a1
    8000227c:	0005c583          	lbu	a1,0(a1)
    80002280:	02d7d7bb          	divuw	a5,a5,a3
    80002284:	f8b40323          	sb	a1,-122(s0)
    80002288:	3eeaf863          	bgeu	s5,a4,80002678 <__printf+0x5f0>
    8000228c:	02d7f5bb          	remuw	a1,a5,a3
    80002290:	02059593          	slli	a1,a1,0x20
    80002294:	0205d593          	srli	a1,a1,0x20
    80002298:	00bd85b3          	add	a1,s11,a1
    8000229c:	0005c583          	lbu	a1,0(a1)
    800022a0:	02d7d7bb          	divuw	a5,a5,a3
    800022a4:	f8b403a3          	sb	a1,-121(s0)
    800022a8:	42eb7e63          	bgeu	s6,a4,800026e4 <__printf+0x65c>
    800022ac:	02d7f5bb          	remuw	a1,a5,a3
    800022b0:	02059593          	slli	a1,a1,0x20
    800022b4:	0205d593          	srli	a1,a1,0x20
    800022b8:	00bd85b3          	add	a1,s11,a1
    800022bc:	0005c583          	lbu	a1,0(a1)
    800022c0:	02d7d7bb          	divuw	a5,a5,a3
    800022c4:	f8b40423          	sb	a1,-120(s0)
    800022c8:	42ebfc63          	bgeu	s7,a4,80002700 <__printf+0x678>
    800022cc:	02079793          	slli	a5,a5,0x20
    800022d0:	0207d793          	srli	a5,a5,0x20
    800022d4:	00fd8db3          	add	s11,s11,a5
    800022d8:	000dc703          	lbu	a4,0(s11)
    800022dc:	00a00793          	li	a5,10
    800022e0:	00900c93          	li	s9,9
    800022e4:	f8e404a3          	sb	a4,-119(s0)
    800022e8:	00065c63          	bgez	a2,80002300 <__printf+0x278>
    800022ec:	f9040713          	addi	a4,s0,-112
    800022f0:	00f70733          	add	a4,a4,a5
    800022f4:	02d00693          	li	a3,45
    800022f8:	fed70823          	sb	a3,-16(a4)
    800022fc:	00078c93          	mv	s9,a5
    80002300:	f8040793          	addi	a5,s0,-128
    80002304:	01978cb3          	add	s9,a5,s9
    80002308:	f7f40d13          	addi	s10,s0,-129
    8000230c:	000cc503          	lbu	a0,0(s9)
    80002310:	fffc8c93          	addi	s9,s9,-1
    80002314:	00000097          	auipc	ra,0x0
    80002318:	b90080e7          	jalr	-1136(ra) # 80001ea4 <consputc>
    8000231c:	ffac98e3          	bne	s9,s10,8000230c <__printf+0x284>
    80002320:	00094503          	lbu	a0,0(s2)
    80002324:	e00514e3          	bnez	a0,8000212c <__printf+0xa4>
    80002328:	1a0c1663          	bnez	s8,800024d4 <__printf+0x44c>
    8000232c:	08813083          	ld	ra,136(sp)
    80002330:	08013403          	ld	s0,128(sp)
    80002334:	07813483          	ld	s1,120(sp)
    80002338:	07013903          	ld	s2,112(sp)
    8000233c:	06813983          	ld	s3,104(sp)
    80002340:	06013a03          	ld	s4,96(sp)
    80002344:	05813a83          	ld	s5,88(sp)
    80002348:	05013b03          	ld	s6,80(sp)
    8000234c:	04813b83          	ld	s7,72(sp)
    80002350:	04013c03          	ld	s8,64(sp)
    80002354:	03813c83          	ld	s9,56(sp)
    80002358:	03013d03          	ld	s10,48(sp)
    8000235c:	02813d83          	ld	s11,40(sp)
    80002360:	0d010113          	addi	sp,sp,208
    80002364:	00008067          	ret
    80002368:	07300713          	li	a4,115
    8000236c:	1ce78a63          	beq	a5,a4,80002540 <__printf+0x4b8>
    80002370:	07800713          	li	a4,120
    80002374:	1ee79e63          	bne	a5,a4,80002570 <__printf+0x4e8>
    80002378:	f7843783          	ld	a5,-136(s0)
    8000237c:	0007a703          	lw	a4,0(a5)
    80002380:	00878793          	addi	a5,a5,8
    80002384:	f6f43c23          	sd	a5,-136(s0)
    80002388:	28074263          	bltz	a4,8000260c <__printf+0x584>
    8000238c:	00002d97          	auipc	s11,0x2
    80002390:	decd8d93          	addi	s11,s11,-532 # 80004178 <digits>
    80002394:	00f77793          	andi	a5,a4,15
    80002398:	00fd87b3          	add	a5,s11,a5
    8000239c:	0007c683          	lbu	a3,0(a5)
    800023a0:	00f00613          	li	a2,15
    800023a4:	0007079b          	sext.w	a5,a4
    800023a8:	f8d40023          	sb	a3,-128(s0)
    800023ac:	0047559b          	srliw	a1,a4,0x4
    800023b0:	0047569b          	srliw	a3,a4,0x4
    800023b4:	00000c93          	li	s9,0
    800023b8:	0ee65063          	bge	a2,a4,80002498 <__printf+0x410>
    800023bc:	00f6f693          	andi	a3,a3,15
    800023c0:	00dd86b3          	add	a3,s11,a3
    800023c4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800023c8:	0087d79b          	srliw	a5,a5,0x8
    800023cc:	00100c93          	li	s9,1
    800023d0:	f8d400a3          	sb	a3,-127(s0)
    800023d4:	0cb67263          	bgeu	a2,a1,80002498 <__printf+0x410>
    800023d8:	00f7f693          	andi	a3,a5,15
    800023dc:	00dd86b3          	add	a3,s11,a3
    800023e0:	0006c583          	lbu	a1,0(a3)
    800023e4:	00f00613          	li	a2,15
    800023e8:	0047d69b          	srliw	a3,a5,0x4
    800023ec:	f8b40123          	sb	a1,-126(s0)
    800023f0:	0047d593          	srli	a1,a5,0x4
    800023f4:	28f67e63          	bgeu	a2,a5,80002690 <__printf+0x608>
    800023f8:	00f6f693          	andi	a3,a3,15
    800023fc:	00dd86b3          	add	a3,s11,a3
    80002400:	0006c503          	lbu	a0,0(a3)
    80002404:	0087d813          	srli	a6,a5,0x8
    80002408:	0087d69b          	srliw	a3,a5,0x8
    8000240c:	f8a401a3          	sb	a0,-125(s0)
    80002410:	28b67663          	bgeu	a2,a1,8000269c <__printf+0x614>
    80002414:	00f6f693          	andi	a3,a3,15
    80002418:	00dd86b3          	add	a3,s11,a3
    8000241c:	0006c583          	lbu	a1,0(a3)
    80002420:	00c7d513          	srli	a0,a5,0xc
    80002424:	00c7d69b          	srliw	a3,a5,0xc
    80002428:	f8b40223          	sb	a1,-124(s0)
    8000242c:	29067a63          	bgeu	a2,a6,800026c0 <__printf+0x638>
    80002430:	00f6f693          	andi	a3,a3,15
    80002434:	00dd86b3          	add	a3,s11,a3
    80002438:	0006c583          	lbu	a1,0(a3)
    8000243c:	0107d813          	srli	a6,a5,0x10
    80002440:	0107d69b          	srliw	a3,a5,0x10
    80002444:	f8b402a3          	sb	a1,-123(s0)
    80002448:	28a67263          	bgeu	a2,a0,800026cc <__printf+0x644>
    8000244c:	00f6f693          	andi	a3,a3,15
    80002450:	00dd86b3          	add	a3,s11,a3
    80002454:	0006c683          	lbu	a3,0(a3)
    80002458:	0147d79b          	srliw	a5,a5,0x14
    8000245c:	f8d40323          	sb	a3,-122(s0)
    80002460:	21067663          	bgeu	a2,a6,8000266c <__printf+0x5e4>
    80002464:	02079793          	slli	a5,a5,0x20
    80002468:	0207d793          	srli	a5,a5,0x20
    8000246c:	00fd8db3          	add	s11,s11,a5
    80002470:	000dc683          	lbu	a3,0(s11)
    80002474:	00800793          	li	a5,8
    80002478:	00700c93          	li	s9,7
    8000247c:	f8d403a3          	sb	a3,-121(s0)
    80002480:	00075c63          	bgez	a4,80002498 <__printf+0x410>
    80002484:	f9040713          	addi	a4,s0,-112
    80002488:	00f70733          	add	a4,a4,a5
    8000248c:	02d00693          	li	a3,45
    80002490:	fed70823          	sb	a3,-16(a4)
    80002494:	00078c93          	mv	s9,a5
    80002498:	f8040793          	addi	a5,s0,-128
    8000249c:	01978cb3          	add	s9,a5,s9
    800024a0:	f7f40d13          	addi	s10,s0,-129
    800024a4:	000cc503          	lbu	a0,0(s9)
    800024a8:	fffc8c93          	addi	s9,s9,-1
    800024ac:	00000097          	auipc	ra,0x0
    800024b0:	9f8080e7          	jalr	-1544(ra) # 80001ea4 <consputc>
    800024b4:	ff9d18e3          	bne	s10,s9,800024a4 <__printf+0x41c>
    800024b8:	0100006f          	j	800024c8 <__printf+0x440>
    800024bc:	00000097          	auipc	ra,0x0
    800024c0:	9e8080e7          	jalr	-1560(ra) # 80001ea4 <consputc>
    800024c4:	000c8493          	mv	s1,s9
    800024c8:	00094503          	lbu	a0,0(s2)
    800024cc:	c60510e3          	bnez	a0,8000212c <__printf+0xa4>
    800024d0:	e40c0ee3          	beqz	s8,8000232c <__printf+0x2a4>
    800024d4:	00003517          	auipc	a0,0x3
    800024d8:	06c50513          	addi	a0,a0,108 # 80005540 <pr>
    800024dc:	00001097          	auipc	ra,0x1
    800024e0:	94c080e7          	jalr	-1716(ra) # 80002e28 <release>
    800024e4:	e49ff06f          	j	8000232c <__printf+0x2a4>
    800024e8:	f7843783          	ld	a5,-136(s0)
    800024ec:	03000513          	li	a0,48
    800024f0:	01000d13          	li	s10,16
    800024f4:	00878713          	addi	a4,a5,8
    800024f8:	0007bc83          	ld	s9,0(a5)
    800024fc:	f6e43c23          	sd	a4,-136(s0)
    80002500:	00000097          	auipc	ra,0x0
    80002504:	9a4080e7          	jalr	-1628(ra) # 80001ea4 <consputc>
    80002508:	07800513          	li	a0,120
    8000250c:	00000097          	auipc	ra,0x0
    80002510:	998080e7          	jalr	-1640(ra) # 80001ea4 <consputc>
    80002514:	00002d97          	auipc	s11,0x2
    80002518:	c64d8d93          	addi	s11,s11,-924 # 80004178 <digits>
    8000251c:	03ccd793          	srli	a5,s9,0x3c
    80002520:	00fd87b3          	add	a5,s11,a5
    80002524:	0007c503          	lbu	a0,0(a5)
    80002528:	fffd0d1b          	addiw	s10,s10,-1
    8000252c:	004c9c93          	slli	s9,s9,0x4
    80002530:	00000097          	auipc	ra,0x0
    80002534:	974080e7          	jalr	-1676(ra) # 80001ea4 <consputc>
    80002538:	fe0d12e3          	bnez	s10,8000251c <__printf+0x494>
    8000253c:	f8dff06f          	j	800024c8 <__printf+0x440>
    80002540:	f7843783          	ld	a5,-136(s0)
    80002544:	0007bc83          	ld	s9,0(a5)
    80002548:	00878793          	addi	a5,a5,8
    8000254c:	f6f43c23          	sd	a5,-136(s0)
    80002550:	000c9a63          	bnez	s9,80002564 <__printf+0x4dc>
    80002554:	1080006f          	j	8000265c <__printf+0x5d4>
    80002558:	001c8c93          	addi	s9,s9,1
    8000255c:	00000097          	auipc	ra,0x0
    80002560:	948080e7          	jalr	-1720(ra) # 80001ea4 <consputc>
    80002564:	000cc503          	lbu	a0,0(s9)
    80002568:	fe0518e3          	bnez	a0,80002558 <__printf+0x4d0>
    8000256c:	f5dff06f          	j	800024c8 <__printf+0x440>
    80002570:	02500513          	li	a0,37
    80002574:	00000097          	auipc	ra,0x0
    80002578:	930080e7          	jalr	-1744(ra) # 80001ea4 <consputc>
    8000257c:	000c8513          	mv	a0,s9
    80002580:	00000097          	auipc	ra,0x0
    80002584:	924080e7          	jalr	-1756(ra) # 80001ea4 <consputc>
    80002588:	f41ff06f          	j	800024c8 <__printf+0x440>
    8000258c:	02500513          	li	a0,37
    80002590:	00000097          	auipc	ra,0x0
    80002594:	914080e7          	jalr	-1772(ra) # 80001ea4 <consputc>
    80002598:	f31ff06f          	j	800024c8 <__printf+0x440>
    8000259c:	00030513          	mv	a0,t1
    800025a0:	00000097          	auipc	ra,0x0
    800025a4:	7bc080e7          	jalr	1980(ra) # 80002d5c <acquire>
    800025a8:	b4dff06f          	j	800020f4 <__printf+0x6c>
    800025ac:	40c0053b          	negw	a0,a2
    800025b0:	00a00713          	li	a4,10
    800025b4:	02e576bb          	remuw	a3,a0,a4
    800025b8:	00002d97          	auipc	s11,0x2
    800025bc:	bc0d8d93          	addi	s11,s11,-1088 # 80004178 <digits>
    800025c0:	ff700593          	li	a1,-9
    800025c4:	02069693          	slli	a3,a3,0x20
    800025c8:	0206d693          	srli	a3,a3,0x20
    800025cc:	00dd86b3          	add	a3,s11,a3
    800025d0:	0006c683          	lbu	a3,0(a3)
    800025d4:	02e557bb          	divuw	a5,a0,a4
    800025d8:	f8d40023          	sb	a3,-128(s0)
    800025dc:	10b65e63          	bge	a2,a1,800026f8 <__printf+0x670>
    800025e0:	06300593          	li	a1,99
    800025e4:	02e7f6bb          	remuw	a3,a5,a4
    800025e8:	02069693          	slli	a3,a3,0x20
    800025ec:	0206d693          	srli	a3,a3,0x20
    800025f0:	00dd86b3          	add	a3,s11,a3
    800025f4:	0006c683          	lbu	a3,0(a3)
    800025f8:	02e7d73b          	divuw	a4,a5,a4
    800025fc:	00200793          	li	a5,2
    80002600:	f8d400a3          	sb	a3,-127(s0)
    80002604:	bca5ece3          	bltu	a1,a0,800021dc <__printf+0x154>
    80002608:	ce5ff06f          	j	800022ec <__printf+0x264>
    8000260c:	40e007bb          	negw	a5,a4
    80002610:	00002d97          	auipc	s11,0x2
    80002614:	b68d8d93          	addi	s11,s11,-1176 # 80004178 <digits>
    80002618:	00f7f693          	andi	a3,a5,15
    8000261c:	00dd86b3          	add	a3,s11,a3
    80002620:	0006c583          	lbu	a1,0(a3)
    80002624:	ff100613          	li	a2,-15
    80002628:	0047d69b          	srliw	a3,a5,0x4
    8000262c:	f8b40023          	sb	a1,-128(s0)
    80002630:	0047d59b          	srliw	a1,a5,0x4
    80002634:	0ac75e63          	bge	a4,a2,800026f0 <__printf+0x668>
    80002638:	00f6f693          	andi	a3,a3,15
    8000263c:	00dd86b3          	add	a3,s11,a3
    80002640:	0006c603          	lbu	a2,0(a3)
    80002644:	00f00693          	li	a3,15
    80002648:	0087d79b          	srliw	a5,a5,0x8
    8000264c:	f8c400a3          	sb	a2,-127(s0)
    80002650:	d8b6e4e3          	bltu	a3,a1,800023d8 <__printf+0x350>
    80002654:	00200793          	li	a5,2
    80002658:	e2dff06f          	j	80002484 <__printf+0x3fc>
    8000265c:	00002c97          	auipc	s9,0x2
    80002660:	afcc8c93          	addi	s9,s9,-1284 # 80004158 <CONSOLE_STATUS+0x148>
    80002664:	02800513          	li	a0,40
    80002668:	ef1ff06f          	j	80002558 <__printf+0x4d0>
    8000266c:	00700793          	li	a5,7
    80002670:	00600c93          	li	s9,6
    80002674:	e0dff06f          	j	80002480 <__printf+0x3f8>
    80002678:	00700793          	li	a5,7
    8000267c:	00600c93          	li	s9,6
    80002680:	c69ff06f          	j	800022e8 <__printf+0x260>
    80002684:	00300793          	li	a5,3
    80002688:	00200c93          	li	s9,2
    8000268c:	c5dff06f          	j	800022e8 <__printf+0x260>
    80002690:	00300793          	li	a5,3
    80002694:	00200c93          	li	s9,2
    80002698:	de9ff06f          	j	80002480 <__printf+0x3f8>
    8000269c:	00400793          	li	a5,4
    800026a0:	00300c93          	li	s9,3
    800026a4:	dddff06f          	j	80002480 <__printf+0x3f8>
    800026a8:	00400793          	li	a5,4
    800026ac:	00300c93          	li	s9,3
    800026b0:	c39ff06f          	j	800022e8 <__printf+0x260>
    800026b4:	00500793          	li	a5,5
    800026b8:	00400c93          	li	s9,4
    800026bc:	c2dff06f          	j	800022e8 <__printf+0x260>
    800026c0:	00500793          	li	a5,5
    800026c4:	00400c93          	li	s9,4
    800026c8:	db9ff06f          	j	80002480 <__printf+0x3f8>
    800026cc:	00600793          	li	a5,6
    800026d0:	00500c93          	li	s9,5
    800026d4:	dadff06f          	j	80002480 <__printf+0x3f8>
    800026d8:	00600793          	li	a5,6
    800026dc:	00500c93          	li	s9,5
    800026e0:	c09ff06f          	j	800022e8 <__printf+0x260>
    800026e4:	00800793          	li	a5,8
    800026e8:	00700c93          	li	s9,7
    800026ec:	bfdff06f          	j	800022e8 <__printf+0x260>
    800026f0:	00100793          	li	a5,1
    800026f4:	d91ff06f          	j	80002484 <__printf+0x3fc>
    800026f8:	00100793          	li	a5,1
    800026fc:	bf1ff06f          	j	800022ec <__printf+0x264>
    80002700:	00900793          	li	a5,9
    80002704:	00800c93          	li	s9,8
    80002708:	be1ff06f          	j	800022e8 <__printf+0x260>
    8000270c:	00002517          	auipc	a0,0x2
    80002710:	a5450513          	addi	a0,a0,-1452 # 80004160 <CONSOLE_STATUS+0x150>
    80002714:	00000097          	auipc	ra,0x0
    80002718:	918080e7          	jalr	-1768(ra) # 8000202c <panic>

000000008000271c <printfinit>:
    8000271c:	fe010113          	addi	sp,sp,-32
    80002720:	00813823          	sd	s0,16(sp)
    80002724:	00913423          	sd	s1,8(sp)
    80002728:	00113c23          	sd	ra,24(sp)
    8000272c:	02010413          	addi	s0,sp,32
    80002730:	00003497          	auipc	s1,0x3
    80002734:	e1048493          	addi	s1,s1,-496 # 80005540 <pr>
    80002738:	00048513          	mv	a0,s1
    8000273c:	00002597          	auipc	a1,0x2
    80002740:	a3458593          	addi	a1,a1,-1484 # 80004170 <CONSOLE_STATUS+0x160>
    80002744:	00000097          	auipc	ra,0x0
    80002748:	5f4080e7          	jalr	1524(ra) # 80002d38 <initlock>
    8000274c:	01813083          	ld	ra,24(sp)
    80002750:	01013403          	ld	s0,16(sp)
    80002754:	0004ac23          	sw	zero,24(s1)
    80002758:	00813483          	ld	s1,8(sp)
    8000275c:	02010113          	addi	sp,sp,32
    80002760:	00008067          	ret

0000000080002764 <uartinit>:
    80002764:	ff010113          	addi	sp,sp,-16
    80002768:	00813423          	sd	s0,8(sp)
    8000276c:	01010413          	addi	s0,sp,16
    80002770:	100007b7          	lui	a5,0x10000
    80002774:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002778:	f8000713          	li	a4,-128
    8000277c:	00e781a3          	sb	a4,3(a5)
    80002780:	00300713          	li	a4,3
    80002784:	00e78023          	sb	a4,0(a5)
    80002788:	000780a3          	sb	zero,1(a5)
    8000278c:	00e781a3          	sb	a4,3(a5)
    80002790:	00700693          	li	a3,7
    80002794:	00d78123          	sb	a3,2(a5)
    80002798:	00e780a3          	sb	a4,1(a5)
    8000279c:	00813403          	ld	s0,8(sp)
    800027a0:	01010113          	addi	sp,sp,16
    800027a4:	00008067          	ret

00000000800027a8 <uartputc>:
    800027a8:	00002797          	auipc	a5,0x2
    800027ac:	b507a783          	lw	a5,-1200(a5) # 800042f8 <panicked>
    800027b0:	00078463          	beqz	a5,800027b8 <uartputc+0x10>
    800027b4:	0000006f          	j	800027b4 <uartputc+0xc>
    800027b8:	fd010113          	addi	sp,sp,-48
    800027bc:	02813023          	sd	s0,32(sp)
    800027c0:	00913c23          	sd	s1,24(sp)
    800027c4:	01213823          	sd	s2,16(sp)
    800027c8:	01313423          	sd	s3,8(sp)
    800027cc:	02113423          	sd	ra,40(sp)
    800027d0:	03010413          	addi	s0,sp,48
    800027d4:	00002917          	auipc	s2,0x2
    800027d8:	b2c90913          	addi	s2,s2,-1236 # 80004300 <uart_tx_r>
    800027dc:	00093783          	ld	a5,0(s2)
    800027e0:	00002497          	auipc	s1,0x2
    800027e4:	b2848493          	addi	s1,s1,-1240 # 80004308 <uart_tx_w>
    800027e8:	0004b703          	ld	a4,0(s1)
    800027ec:	02078693          	addi	a3,a5,32
    800027f0:	00050993          	mv	s3,a0
    800027f4:	02e69c63          	bne	a3,a4,8000282c <uartputc+0x84>
    800027f8:	00001097          	auipc	ra,0x1
    800027fc:	834080e7          	jalr	-1996(ra) # 8000302c <push_on>
    80002800:	00093783          	ld	a5,0(s2)
    80002804:	0004b703          	ld	a4,0(s1)
    80002808:	02078793          	addi	a5,a5,32
    8000280c:	00e79463          	bne	a5,a4,80002814 <uartputc+0x6c>
    80002810:	0000006f          	j	80002810 <uartputc+0x68>
    80002814:	00001097          	auipc	ra,0x1
    80002818:	88c080e7          	jalr	-1908(ra) # 800030a0 <pop_on>
    8000281c:	00093783          	ld	a5,0(s2)
    80002820:	0004b703          	ld	a4,0(s1)
    80002824:	02078693          	addi	a3,a5,32
    80002828:	fce688e3          	beq	a3,a4,800027f8 <uartputc+0x50>
    8000282c:	01f77693          	andi	a3,a4,31
    80002830:	00003597          	auipc	a1,0x3
    80002834:	d3058593          	addi	a1,a1,-720 # 80005560 <uart_tx_buf>
    80002838:	00d586b3          	add	a3,a1,a3
    8000283c:	00170713          	addi	a4,a4,1
    80002840:	01368023          	sb	s3,0(a3)
    80002844:	00e4b023          	sd	a4,0(s1)
    80002848:	10000637          	lui	a2,0x10000
    8000284c:	02f71063          	bne	a4,a5,8000286c <uartputc+0xc4>
    80002850:	0340006f          	j	80002884 <uartputc+0xdc>
    80002854:	00074703          	lbu	a4,0(a4)
    80002858:	00f93023          	sd	a5,0(s2)
    8000285c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002860:	00093783          	ld	a5,0(s2)
    80002864:	0004b703          	ld	a4,0(s1)
    80002868:	00f70e63          	beq	a4,a5,80002884 <uartputc+0xdc>
    8000286c:	00564683          	lbu	a3,5(a2)
    80002870:	01f7f713          	andi	a4,a5,31
    80002874:	00e58733          	add	a4,a1,a4
    80002878:	0206f693          	andi	a3,a3,32
    8000287c:	00178793          	addi	a5,a5,1
    80002880:	fc069ae3          	bnez	a3,80002854 <uartputc+0xac>
    80002884:	02813083          	ld	ra,40(sp)
    80002888:	02013403          	ld	s0,32(sp)
    8000288c:	01813483          	ld	s1,24(sp)
    80002890:	01013903          	ld	s2,16(sp)
    80002894:	00813983          	ld	s3,8(sp)
    80002898:	03010113          	addi	sp,sp,48
    8000289c:	00008067          	ret

00000000800028a0 <uartputc_sync>:
    800028a0:	ff010113          	addi	sp,sp,-16
    800028a4:	00813423          	sd	s0,8(sp)
    800028a8:	01010413          	addi	s0,sp,16
    800028ac:	00002717          	auipc	a4,0x2
    800028b0:	a4c72703          	lw	a4,-1460(a4) # 800042f8 <panicked>
    800028b4:	02071663          	bnez	a4,800028e0 <uartputc_sync+0x40>
    800028b8:	00050793          	mv	a5,a0
    800028bc:	100006b7          	lui	a3,0x10000
    800028c0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800028c4:	02077713          	andi	a4,a4,32
    800028c8:	fe070ce3          	beqz	a4,800028c0 <uartputc_sync+0x20>
    800028cc:	0ff7f793          	andi	a5,a5,255
    800028d0:	00f68023          	sb	a5,0(a3)
    800028d4:	00813403          	ld	s0,8(sp)
    800028d8:	01010113          	addi	sp,sp,16
    800028dc:	00008067          	ret
    800028e0:	0000006f          	j	800028e0 <uartputc_sync+0x40>

00000000800028e4 <uartstart>:
    800028e4:	ff010113          	addi	sp,sp,-16
    800028e8:	00813423          	sd	s0,8(sp)
    800028ec:	01010413          	addi	s0,sp,16
    800028f0:	00002617          	auipc	a2,0x2
    800028f4:	a1060613          	addi	a2,a2,-1520 # 80004300 <uart_tx_r>
    800028f8:	00002517          	auipc	a0,0x2
    800028fc:	a1050513          	addi	a0,a0,-1520 # 80004308 <uart_tx_w>
    80002900:	00063783          	ld	a5,0(a2)
    80002904:	00053703          	ld	a4,0(a0)
    80002908:	04f70263          	beq	a4,a5,8000294c <uartstart+0x68>
    8000290c:	100005b7          	lui	a1,0x10000
    80002910:	00003817          	auipc	a6,0x3
    80002914:	c5080813          	addi	a6,a6,-944 # 80005560 <uart_tx_buf>
    80002918:	01c0006f          	j	80002934 <uartstart+0x50>
    8000291c:	0006c703          	lbu	a4,0(a3)
    80002920:	00f63023          	sd	a5,0(a2)
    80002924:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002928:	00063783          	ld	a5,0(a2)
    8000292c:	00053703          	ld	a4,0(a0)
    80002930:	00f70e63          	beq	a4,a5,8000294c <uartstart+0x68>
    80002934:	01f7f713          	andi	a4,a5,31
    80002938:	00e806b3          	add	a3,a6,a4
    8000293c:	0055c703          	lbu	a4,5(a1)
    80002940:	00178793          	addi	a5,a5,1
    80002944:	02077713          	andi	a4,a4,32
    80002948:	fc071ae3          	bnez	a4,8000291c <uartstart+0x38>
    8000294c:	00813403          	ld	s0,8(sp)
    80002950:	01010113          	addi	sp,sp,16
    80002954:	00008067          	ret

0000000080002958 <uartgetc>:
    80002958:	ff010113          	addi	sp,sp,-16
    8000295c:	00813423          	sd	s0,8(sp)
    80002960:	01010413          	addi	s0,sp,16
    80002964:	10000737          	lui	a4,0x10000
    80002968:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000296c:	0017f793          	andi	a5,a5,1
    80002970:	00078c63          	beqz	a5,80002988 <uartgetc+0x30>
    80002974:	00074503          	lbu	a0,0(a4)
    80002978:	0ff57513          	andi	a0,a0,255
    8000297c:	00813403          	ld	s0,8(sp)
    80002980:	01010113          	addi	sp,sp,16
    80002984:	00008067          	ret
    80002988:	fff00513          	li	a0,-1
    8000298c:	ff1ff06f          	j	8000297c <uartgetc+0x24>

0000000080002990 <uartintr>:
    80002990:	100007b7          	lui	a5,0x10000
    80002994:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002998:	0017f793          	andi	a5,a5,1
    8000299c:	0a078463          	beqz	a5,80002a44 <uartintr+0xb4>
    800029a0:	fe010113          	addi	sp,sp,-32
    800029a4:	00813823          	sd	s0,16(sp)
    800029a8:	00913423          	sd	s1,8(sp)
    800029ac:	00113c23          	sd	ra,24(sp)
    800029b0:	02010413          	addi	s0,sp,32
    800029b4:	100004b7          	lui	s1,0x10000
    800029b8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800029bc:	0ff57513          	andi	a0,a0,255
    800029c0:	fffff097          	auipc	ra,0xfffff
    800029c4:	534080e7          	jalr	1332(ra) # 80001ef4 <consoleintr>
    800029c8:	0054c783          	lbu	a5,5(s1)
    800029cc:	0017f793          	andi	a5,a5,1
    800029d0:	fe0794e3          	bnez	a5,800029b8 <uartintr+0x28>
    800029d4:	00002617          	auipc	a2,0x2
    800029d8:	92c60613          	addi	a2,a2,-1748 # 80004300 <uart_tx_r>
    800029dc:	00002517          	auipc	a0,0x2
    800029e0:	92c50513          	addi	a0,a0,-1748 # 80004308 <uart_tx_w>
    800029e4:	00063783          	ld	a5,0(a2)
    800029e8:	00053703          	ld	a4,0(a0)
    800029ec:	04f70263          	beq	a4,a5,80002a30 <uartintr+0xa0>
    800029f0:	100005b7          	lui	a1,0x10000
    800029f4:	00003817          	auipc	a6,0x3
    800029f8:	b6c80813          	addi	a6,a6,-1172 # 80005560 <uart_tx_buf>
    800029fc:	01c0006f          	j	80002a18 <uartintr+0x88>
    80002a00:	0006c703          	lbu	a4,0(a3)
    80002a04:	00f63023          	sd	a5,0(a2)
    80002a08:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002a0c:	00063783          	ld	a5,0(a2)
    80002a10:	00053703          	ld	a4,0(a0)
    80002a14:	00f70e63          	beq	a4,a5,80002a30 <uartintr+0xa0>
    80002a18:	01f7f713          	andi	a4,a5,31
    80002a1c:	00e806b3          	add	a3,a6,a4
    80002a20:	0055c703          	lbu	a4,5(a1)
    80002a24:	00178793          	addi	a5,a5,1
    80002a28:	02077713          	andi	a4,a4,32
    80002a2c:	fc071ae3          	bnez	a4,80002a00 <uartintr+0x70>
    80002a30:	01813083          	ld	ra,24(sp)
    80002a34:	01013403          	ld	s0,16(sp)
    80002a38:	00813483          	ld	s1,8(sp)
    80002a3c:	02010113          	addi	sp,sp,32
    80002a40:	00008067          	ret
    80002a44:	00002617          	auipc	a2,0x2
    80002a48:	8bc60613          	addi	a2,a2,-1860 # 80004300 <uart_tx_r>
    80002a4c:	00002517          	auipc	a0,0x2
    80002a50:	8bc50513          	addi	a0,a0,-1860 # 80004308 <uart_tx_w>
    80002a54:	00063783          	ld	a5,0(a2)
    80002a58:	00053703          	ld	a4,0(a0)
    80002a5c:	04f70263          	beq	a4,a5,80002aa0 <uartintr+0x110>
    80002a60:	100005b7          	lui	a1,0x10000
    80002a64:	00003817          	auipc	a6,0x3
    80002a68:	afc80813          	addi	a6,a6,-1284 # 80005560 <uart_tx_buf>
    80002a6c:	01c0006f          	j	80002a88 <uartintr+0xf8>
    80002a70:	0006c703          	lbu	a4,0(a3)
    80002a74:	00f63023          	sd	a5,0(a2)
    80002a78:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002a7c:	00063783          	ld	a5,0(a2)
    80002a80:	00053703          	ld	a4,0(a0)
    80002a84:	02f70063          	beq	a4,a5,80002aa4 <uartintr+0x114>
    80002a88:	01f7f713          	andi	a4,a5,31
    80002a8c:	00e806b3          	add	a3,a6,a4
    80002a90:	0055c703          	lbu	a4,5(a1)
    80002a94:	00178793          	addi	a5,a5,1
    80002a98:	02077713          	andi	a4,a4,32
    80002a9c:	fc071ae3          	bnez	a4,80002a70 <uartintr+0xe0>
    80002aa0:	00008067          	ret
    80002aa4:	00008067          	ret

0000000080002aa8 <kinit>:
    80002aa8:	fc010113          	addi	sp,sp,-64
    80002aac:	02913423          	sd	s1,40(sp)
    80002ab0:	fffff7b7          	lui	a5,0xfffff
    80002ab4:	00004497          	auipc	s1,0x4
    80002ab8:	acb48493          	addi	s1,s1,-1333 # 8000657f <end+0xfff>
    80002abc:	02813823          	sd	s0,48(sp)
    80002ac0:	01313c23          	sd	s3,24(sp)
    80002ac4:	00f4f4b3          	and	s1,s1,a5
    80002ac8:	02113c23          	sd	ra,56(sp)
    80002acc:	03213023          	sd	s2,32(sp)
    80002ad0:	01413823          	sd	s4,16(sp)
    80002ad4:	01513423          	sd	s5,8(sp)
    80002ad8:	04010413          	addi	s0,sp,64
    80002adc:	000017b7          	lui	a5,0x1
    80002ae0:	01100993          	li	s3,17
    80002ae4:	00f487b3          	add	a5,s1,a5
    80002ae8:	01b99993          	slli	s3,s3,0x1b
    80002aec:	06f9e063          	bltu	s3,a5,80002b4c <kinit+0xa4>
    80002af0:	00003a97          	auipc	s5,0x3
    80002af4:	a90a8a93          	addi	s5,s5,-1392 # 80005580 <end>
    80002af8:	0754ec63          	bltu	s1,s5,80002b70 <kinit+0xc8>
    80002afc:	0734fa63          	bgeu	s1,s3,80002b70 <kinit+0xc8>
    80002b00:	00088a37          	lui	s4,0x88
    80002b04:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002b08:	00002917          	auipc	s2,0x2
    80002b0c:	80890913          	addi	s2,s2,-2040 # 80004310 <kmem>
    80002b10:	00ca1a13          	slli	s4,s4,0xc
    80002b14:	0140006f          	j	80002b28 <kinit+0x80>
    80002b18:	000017b7          	lui	a5,0x1
    80002b1c:	00f484b3          	add	s1,s1,a5
    80002b20:	0554e863          	bltu	s1,s5,80002b70 <kinit+0xc8>
    80002b24:	0534f663          	bgeu	s1,s3,80002b70 <kinit+0xc8>
    80002b28:	00001637          	lui	a2,0x1
    80002b2c:	00100593          	li	a1,1
    80002b30:	00048513          	mv	a0,s1
    80002b34:	00000097          	auipc	ra,0x0
    80002b38:	5e4080e7          	jalr	1508(ra) # 80003118 <__memset>
    80002b3c:	00093783          	ld	a5,0(s2)
    80002b40:	00f4b023          	sd	a5,0(s1)
    80002b44:	00993023          	sd	s1,0(s2)
    80002b48:	fd4498e3          	bne	s1,s4,80002b18 <kinit+0x70>
    80002b4c:	03813083          	ld	ra,56(sp)
    80002b50:	03013403          	ld	s0,48(sp)
    80002b54:	02813483          	ld	s1,40(sp)
    80002b58:	02013903          	ld	s2,32(sp)
    80002b5c:	01813983          	ld	s3,24(sp)
    80002b60:	01013a03          	ld	s4,16(sp)
    80002b64:	00813a83          	ld	s5,8(sp)
    80002b68:	04010113          	addi	sp,sp,64
    80002b6c:	00008067          	ret
    80002b70:	00001517          	auipc	a0,0x1
    80002b74:	62050513          	addi	a0,a0,1568 # 80004190 <digits+0x18>
    80002b78:	fffff097          	auipc	ra,0xfffff
    80002b7c:	4b4080e7          	jalr	1204(ra) # 8000202c <panic>

0000000080002b80 <freerange>:
    80002b80:	fc010113          	addi	sp,sp,-64
    80002b84:	000017b7          	lui	a5,0x1
    80002b88:	02913423          	sd	s1,40(sp)
    80002b8c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002b90:	009504b3          	add	s1,a0,s1
    80002b94:	fffff537          	lui	a0,0xfffff
    80002b98:	02813823          	sd	s0,48(sp)
    80002b9c:	02113c23          	sd	ra,56(sp)
    80002ba0:	03213023          	sd	s2,32(sp)
    80002ba4:	01313c23          	sd	s3,24(sp)
    80002ba8:	01413823          	sd	s4,16(sp)
    80002bac:	01513423          	sd	s5,8(sp)
    80002bb0:	01613023          	sd	s6,0(sp)
    80002bb4:	04010413          	addi	s0,sp,64
    80002bb8:	00a4f4b3          	and	s1,s1,a0
    80002bbc:	00f487b3          	add	a5,s1,a5
    80002bc0:	06f5e463          	bltu	a1,a5,80002c28 <freerange+0xa8>
    80002bc4:	00003a97          	auipc	s5,0x3
    80002bc8:	9bca8a93          	addi	s5,s5,-1604 # 80005580 <end>
    80002bcc:	0954e263          	bltu	s1,s5,80002c50 <freerange+0xd0>
    80002bd0:	01100993          	li	s3,17
    80002bd4:	01b99993          	slli	s3,s3,0x1b
    80002bd8:	0734fc63          	bgeu	s1,s3,80002c50 <freerange+0xd0>
    80002bdc:	00058a13          	mv	s4,a1
    80002be0:	00001917          	auipc	s2,0x1
    80002be4:	73090913          	addi	s2,s2,1840 # 80004310 <kmem>
    80002be8:	00002b37          	lui	s6,0x2
    80002bec:	0140006f          	j	80002c00 <freerange+0x80>
    80002bf0:	000017b7          	lui	a5,0x1
    80002bf4:	00f484b3          	add	s1,s1,a5
    80002bf8:	0554ec63          	bltu	s1,s5,80002c50 <freerange+0xd0>
    80002bfc:	0534fa63          	bgeu	s1,s3,80002c50 <freerange+0xd0>
    80002c00:	00001637          	lui	a2,0x1
    80002c04:	00100593          	li	a1,1
    80002c08:	00048513          	mv	a0,s1
    80002c0c:	00000097          	auipc	ra,0x0
    80002c10:	50c080e7          	jalr	1292(ra) # 80003118 <__memset>
    80002c14:	00093703          	ld	a4,0(s2)
    80002c18:	016487b3          	add	a5,s1,s6
    80002c1c:	00e4b023          	sd	a4,0(s1)
    80002c20:	00993023          	sd	s1,0(s2)
    80002c24:	fcfa76e3          	bgeu	s4,a5,80002bf0 <freerange+0x70>
    80002c28:	03813083          	ld	ra,56(sp)
    80002c2c:	03013403          	ld	s0,48(sp)
    80002c30:	02813483          	ld	s1,40(sp)
    80002c34:	02013903          	ld	s2,32(sp)
    80002c38:	01813983          	ld	s3,24(sp)
    80002c3c:	01013a03          	ld	s4,16(sp)
    80002c40:	00813a83          	ld	s5,8(sp)
    80002c44:	00013b03          	ld	s6,0(sp)
    80002c48:	04010113          	addi	sp,sp,64
    80002c4c:	00008067          	ret
    80002c50:	00001517          	auipc	a0,0x1
    80002c54:	54050513          	addi	a0,a0,1344 # 80004190 <digits+0x18>
    80002c58:	fffff097          	auipc	ra,0xfffff
    80002c5c:	3d4080e7          	jalr	980(ra) # 8000202c <panic>

0000000080002c60 <kfree>:
    80002c60:	fe010113          	addi	sp,sp,-32
    80002c64:	00813823          	sd	s0,16(sp)
    80002c68:	00113c23          	sd	ra,24(sp)
    80002c6c:	00913423          	sd	s1,8(sp)
    80002c70:	02010413          	addi	s0,sp,32
    80002c74:	03451793          	slli	a5,a0,0x34
    80002c78:	04079c63          	bnez	a5,80002cd0 <kfree+0x70>
    80002c7c:	00003797          	auipc	a5,0x3
    80002c80:	90478793          	addi	a5,a5,-1788 # 80005580 <end>
    80002c84:	00050493          	mv	s1,a0
    80002c88:	04f56463          	bltu	a0,a5,80002cd0 <kfree+0x70>
    80002c8c:	01100793          	li	a5,17
    80002c90:	01b79793          	slli	a5,a5,0x1b
    80002c94:	02f57e63          	bgeu	a0,a5,80002cd0 <kfree+0x70>
    80002c98:	00001637          	lui	a2,0x1
    80002c9c:	00100593          	li	a1,1
    80002ca0:	00000097          	auipc	ra,0x0
    80002ca4:	478080e7          	jalr	1144(ra) # 80003118 <__memset>
    80002ca8:	00001797          	auipc	a5,0x1
    80002cac:	66878793          	addi	a5,a5,1640 # 80004310 <kmem>
    80002cb0:	0007b703          	ld	a4,0(a5)
    80002cb4:	01813083          	ld	ra,24(sp)
    80002cb8:	01013403          	ld	s0,16(sp)
    80002cbc:	00e4b023          	sd	a4,0(s1)
    80002cc0:	0097b023          	sd	s1,0(a5)
    80002cc4:	00813483          	ld	s1,8(sp)
    80002cc8:	02010113          	addi	sp,sp,32
    80002ccc:	00008067          	ret
    80002cd0:	00001517          	auipc	a0,0x1
    80002cd4:	4c050513          	addi	a0,a0,1216 # 80004190 <digits+0x18>
    80002cd8:	fffff097          	auipc	ra,0xfffff
    80002cdc:	354080e7          	jalr	852(ra) # 8000202c <panic>

0000000080002ce0 <kalloc>:
    80002ce0:	fe010113          	addi	sp,sp,-32
    80002ce4:	00813823          	sd	s0,16(sp)
    80002ce8:	00913423          	sd	s1,8(sp)
    80002cec:	00113c23          	sd	ra,24(sp)
    80002cf0:	02010413          	addi	s0,sp,32
    80002cf4:	00001797          	auipc	a5,0x1
    80002cf8:	61c78793          	addi	a5,a5,1564 # 80004310 <kmem>
    80002cfc:	0007b483          	ld	s1,0(a5)
    80002d00:	02048063          	beqz	s1,80002d20 <kalloc+0x40>
    80002d04:	0004b703          	ld	a4,0(s1)
    80002d08:	00001637          	lui	a2,0x1
    80002d0c:	00500593          	li	a1,5
    80002d10:	00048513          	mv	a0,s1
    80002d14:	00e7b023          	sd	a4,0(a5)
    80002d18:	00000097          	auipc	ra,0x0
    80002d1c:	400080e7          	jalr	1024(ra) # 80003118 <__memset>
    80002d20:	01813083          	ld	ra,24(sp)
    80002d24:	01013403          	ld	s0,16(sp)
    80002d28:	00048513          	mv	a0,s1
    80002d2c:	00813483          	ld	s1,8(sp)
    80002d30:	02010113          	addi	sp,sp,32
    80002d34:	00008067          	ret

0000000080002d38 <initlock>:
    80002d38:	ff010113          	addi	sp,sp,-16
    80002d3c:	00813423          	sd	s0,8(sp)
    80002d40:	01010413          	addi	s0,sp,16
    80002d44:	00813403          	ld	s0,8(sp)
    80002d48:	00b53423          	sd	a1,8(a0)
    80002d4c:	00052023          	sw	zero,0(a0)
    80002d50:	00053823          	sd	zero,16(a0)
    80002d54:	01010113          	addi	sp,sp,16
    80002d58:	00008067          	ret

0000000080002d5c <acquire>:
    80002d5c:	fe010113          	addi	sp,sp,-32
    80002d60:	00813823          	sd	s0,16(sp)
    80002d64:	00913423          	sd	s1,8(sp)
    80002d68:	00113c23          	sd	ra,24(sp)
    80002d6c:	01213023          	sd	s2,0(sp)
    80002d70:	02010413          	addi	s0,sp,32
    80002d74:	00050493          	mv	s1,a0
    80002d78:	10002973          	csrr	s2,sstatus
    80002d7c:	100027f3          	csrr	a5,sstatus
    80002d80:	ffd7f793          	andi	a5,a5,-3
    80002d84:	10079073          	csrw	sstatus,a5
    80002d88:	fffff097          	auipc	ra,0xfffff
    80002d8c:	8e8080e7          	jalr	-1816(ra) # 80001670 <mycpu>
    80002d90:	07852783          	lw	a5,120(a0)
    80002d94:	06078e63          	beqz	a5,80002e10 <acquire+0xb4>
    80002d98:	fffff097          	auipc	ra,0xfffff
    80002d9c:	8d8080e7          	jalr	-1832(ra) # 80001670 <mycpu>
    80002da0:	07852783          	lw	a5,120(a0)
    80002da4:	0004a703          	lw	a4,0(s1)
    80002da8:	0017879b          	addiw	a5,a5,1
    80002dac:	06f52c23          	sw	a5,120(a0)
    80002db0:	04071063          	bnez	a4,80002df0 <acquire+0x94>
    80002db4:	00100713          	li	a4,1
    80002db8:	00070793          	mv	a5,a4
    80002dbc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002dc0:	0007879b          	sext.w	a5,a5
    80002dc4:	fe079ae3          	bnez	a5,80002db8 <acquire+0x5c>
    80002dc8:	0ff0000f          	fence
    80002dcc:	fffff097          	auipc	ra,0xfffff
    80002dd0:	8a4080e7          	jalr	-1884(ra) # 80001670 <mycpu>
    80002dd4:	01813083          	ld	ra,24(sp)
    80002dd8:	01013403          	ld	s0,16(sp)
    80002ddc:	00a4b823          	sd	a0,16(s1)
    80002de0:	00013903          	ld	s2,0(sp)
    80002de4:	00813483          	ld	s1,8(sp)
    80002de8:	02010113          	addi	sp,sp,32
    80002dec:	00008067          	ret
    80002df0:	0104b903          	ld	s2,16(s1)
    80002df4:	fffff097          	auipc	ra,0xfffff
    80002df8:	87c080e7          	jalr	-1924(ra) # 80001670 <mycpu>
    80002dfc:	faa91ce3          	bne	s2,a0,80002db4 <acquire+0x58>
    80002e00:	00001517          	auipc	a0,0x1
    80002e04:	39850513          	addi	a0,a0,920 # 80004198 <digits+0x20>
    80002e08:	fffff097          	auipc	ra,0xfffff
    80002e0c:	224080e7          	jalr	548(ra) # 8000202c <panic>
    80002e10:	00195913          	srli	s2,s2,0x1
    80002e14:	fffff097          	auipc	ra,0xfffff
    80002e18:	85c080e7          	jalr	-1956(ra) # 80001670 <mycpu>
    80002e1c:	00197913          	andi	s2,s2,1
    80002e20:	07252e23          	sw	s2,124(a0)
    80002e24:	f75ff06f          	j	80002d98 <acquire+0x3c>

0000000080002e28 <release>:
    80002e28:	fe010113          	addi	sp,sp,-32
    80002e2c:	00813823          	sd	s0,16(sp)
    80002e30:	00113c23          	sd	ra,24(sp)
    80002e34:	00913423          	sd	s1,8(sp)
    80002e38:	01213023          	sd	s2,0(sp)
    80002e3c:	02010413          	addi	s0,sp,32
    80002e40:	00052783          	lw	a5,0(a0)
    80002e44:	00079a63          	bnez	a5,80002e58 <release+0x30>
    80002e48:	00001517          	auipc	a0,0x1
    80002e4c:	35850513          	addi	a0,a0,856 # 800041a0 <digits+0x28>
    80002e50:	fffff097          	auipc	ra,0xfffff
    80002e54:	1dc080e7          	jalr	476(ra) # 8000202c <panic>
    80002e58:	01053903          	ld	s2,16(a0)
    80002e5c:	00050493          	mv	s1,a0
    80002e60:	fffff097          	auipc	ra,0xfffff
    80002e64:	810080e7          	jalr	-2032(ra) # 80001670 <mycpu>
    80002e68:	fea910e3          	bne	s2,a0,80002e48 <release+0x20>
    80002e6c:	0004b823          	sd	zero,16(s1)
    80002e70:	0ff0000f          	fence
    80002e74:	0f50000f          	fence	iorw,ow
    80002e78:	0804a02f          	amoswap.w	zero,zero,(s1)
    80002e7c:	ffffe097          	auipc	ra,0xffffe
    80002e80:	7f4080e7          	jalr	2036(ra) # 80001670 <mycpu>
    80002e84:	100027f3          	csrr	a5,sstatus
    80002e88:	0027f793          	andi	a5,a5,2
    80002e8c:	04079a63          	bnez	a5,80002ee0 <release+0xb8>
    80002e90:	07852783          	lw	a5,120(a0)
    80002e94:	02f05e63          	blez	a5,80002ed0 <release+0xa8>
    80002e98:	fff7871b          	addiw	a4,a5,-1
    80002e9c:	06e52c23          	sw	a4,120(a0)
    80002ea0:	00071c63          	bnez	a4,80002eb8 <release+0x90>
    80002ea4:	07c52783          	lw	a5,124(a0)
    80002ea8:	00078863          	beqz	a5,80002eb8 <release+0x90>
    80002eac:	100027f3          	csrr	a5,sstatus
    80002eb0:	0027e793          	ori	a5,a5,2
    80002eb4:	10079073          	csrw	sstatus,a5
    80002eb8:	01813083          	ld	ra,24(sp)
    80002ebc:	01013403          	ld	s0,16(sp)
    80002ec0:	00813483          	ld	s1,8(sp)
    80002ec4:	00013903          	ld	s2,0(sp)
    80002ec8:	02010113          	addi	sp,sp,32
    80002ecc:	00008067          	ret
    80002ed0:	00001517          	auipc	a0,0x1
    80002ed4:	2f050513          	addi	a0,a0,752 # 800041c0 <digits+0x48>
    80002ed8:	fffff097          	auipc	ra,0xfffff
    80002edc:	154080e7          	jalr	340(ra) # 8000202c <panic>
    80002ee0:	00001517          	auipc	a0,0x1
    80002ee4:	2c850513          	addi	a0,a0,712 # 800041a8 <digits+0x30>
    80002ee8:	fffff097          	auipc	ra,0xfffff
    80002eec:	144080e7          	jalr	324(ra) # 8000202c <panic>

0000000080002ef0 <holding>:
    80002ef0:	00052783          	lw	a5,0(a0)
    80002ef4:	00079663          	bnez	a5,80002f00 <holding+0x10>
    80002ef8:	00000513          	li	a0,0
    80002efc:	00008067          	ret
    80002f00:	fe010113          	addi	sp,sp,-32
    80002f04:	00813823          	sd	s0,16(sp)
    80002f08:	00913423          	sd	s1,8(sp)
    80002f0c:	00113c23          	sd	ra,24(sp)
    80002f10:	02010413          	addi	s0,sp,32
    80002f14:	01053483          	ld	s1,16(a0)
    80002f18:	ffffe097          	auipc	ra,0xffffe
    80002f1c:	758080e7          	jalr	1880(ra) # 80001670 <mycpu>
    80002f20:	01813083          	ld	ra,24(sp)
    80002f24:	01013403          	ld	s0,16(sp)
    80002f28:	40a48533          	sub	a0,s1,a0
    80002f2c:	00153513          	seqz	a0,a0
    80002f30:	00813483          	ld	s1,8(sp)
    80002f34:	02010113          	addi	sp,sp,32
    80002f38:	00008067          	ret

0000000080002f3c <push_off>:
    80002f3c:	fe010113          	addi	sp,sp,-32
    80002f40:	00813823          	sd	s0,16(sp)
    80002f44:	00113c23          	sd	ra,24(sp)
    80002f48:	00913423          	sd	s1,8(sp)
    80002f4c:	02010413          	addi	s0,sp,32
    80002f50:	100024f3          	csrr	s1,sstatus
    80002f54:	100027f3          	csrr	a5,sstatus
    80002f58:	ffd7f793          	andi	a5,a5,-3
    80002f5c:	10079073          	csrw	sstatus,a5
    80002f60:	ffffe097          	auipc	ra,0xffffe
    80002f64:	710080e7          	jalr	1808(ra) # 80001670 <mycpu>
    80002f68:	07852783          	lw	a5,120(a0)
    80002f6c:	02078663          	beqz	a5,80002f98 <push_off+0x5c>
    80002f70:	ffffe097          	auipc	ra,0xffffe
    80002f74:	700080e7          	jalr	1792(ra) # 80001670 <mycpu>
    80002f78:	07852783          	lw	a5,120(a0)
    80002f7c:	01813083          	ld	ra,24(sp)
    80002f80:	01013403          	ld	s0,16(sp)
    80002f84:	0017879b          	addiw	a5,a5,1
    80002f88:	06f52c23          	sw	a5,120(a0)
    80002f8c:	00813483          	ld	s1,8(sp)
    80002f90:	02010113          	addi	sp,sp,32
    80002f94:	00008067          	ret
    80002f98:	0014d493          	srli	s1,s1,0x1
    80002f9c:	ffffe097          	auipc	ra,0xffffe
    80002fa0:	6d4080e7          	jalr	1748(ra) # 80001670 <mycpu>
    80002fa4:	0014f493          	andi	s1,s1,1
    80002fa8:	06952e23          	sw	s1,124(a0)
    80002fac:	fc5ff06f          	j	80002f70 <push_off+0x34>

0000000080002fb0 <pop_off>:
    80002fb0:	ff010113          	addi	sp,sp,-16
    80002fb4:	00813023          	sd	s0,0(sp)
    80002fb8:	00113423          	sd	ra,8(sp)
    80002fbc:	01010413          	addi	s0,sp,16
    80002fc0:	ffffe097          	auipc	ra,0xffffe
    80002fc4:	6b0080e7          	jalr	1712(ra) # 80001670 <mycpu>
    80002fc8:	100027f3          	csrr	a5,sstatus
    80002fcc:	0027f793          	andi	a5,a5,2
    80002fd0:	04079663          	bnez	a5,8000301c <pop_off+0x6c>
    80002fd4:	07852783          	lw	a5,120(a0)
    80002fd8:	02f05a63          	blez	a5,8000300c <pop_off+0x5c>
    80002fdc:	fff7871b          	addiw	a4,a5,-1
    80002fe0:	06e52c23          	sw	a4,120(a0)
    80002fe4:	00071c63          	bnez	a4,80002ffc <pop_off+0x4c>
    80002fe8:	07c52783          	lw	a5,124(a0)
    80002fec:	00078863          	beqz	a5,80002ffc <pop_off+0x4c>
    80002ff0:	100027f3          	csrr	a5,sstatus
    80002ff4:	0027e793          	ori	a5,a5,2
    80002ff8:	10079073          	csrw	sstatus,a5
    80002ffc:	00813083          	ld	ra,8(sp)
    80003000:	00013403          	ld	s0,0(sp)
    80003004:	01010113          	addi	sp,sp,16
    80003008:	00008067          	ret
    8000300c:	00001517          	auipc	a0,0x1
    80003010:	1b450513          	addi	a0,a0,436 # 800041c0 <digits+0x48>
    80003014:	fffff097          	auipc	ra,0xfffff
    80003018:	018080e7          	jalr	24(ra) # 8000202c <panic>
    8000301c:	00001517          	auipc	a0,0x1
    80003020:	18c50513          	addi	a0,a0,396 # 800041a8 <digits+0x30>
    80003024:	fffff097          	auipc	ra,0xfffff
    80003028:	008080e7          	jalr	8(ra) # 8000202c <panic>

000000008000302c <push_on>:
    8000302c:	fe010113          	addi	sp,sp,-32
    80003030:	00813823          	sd	s0,16(sp)
    80003034:	00113c23          	sd	ra,24(sp)
    80003038:	00913423          	sd	s1,8(sp)
    8000303c:	02010413          	addi	s0,sp,32
    80003040:	100024f3          	csrr	s1,sstatus
    80003044:	100027f3          	csrr	a5,sstatus
    80003048:	0027e793          	ori	a5,a5,2
    8000304c:	10079073          	csrw	sstatus,a5
    80003050:	ffffe097          	auipc	ra,0xffffe
    80003054:	620080e7          	jalr	1568(ra) # 80001670 <mycpu>
    80003058:	07852783          	lw	a5,120(a0)
    8000305c:	02078663          	beqz	a5,80003088 <push_on+0x5c>
    80003060:	ffffe097          	auipc	ra,0xffffe
    80003064:	610080e7          	jalr	1552(ra) # 80001670 <mycpu>
    80003068:	07852783          	lw	a5,120(a0)
    8000306c:	01813083          	ld	ra,24(sp)
    80003070:	01013403          	ld	s0,16(sp)
    80003074:	0017879b          	addiw	a5,a5,1
    80003078:	06f52c23          	sw	a5,120(a0)
    8000307c:	00813483          	ld	s1,8(sp)
    80003080:	02010113          	addi	sp,sp,32
    80003084:	00008067          	ret
    80003088:	0014d493          	srli	s1,s1,0x1
    8000308c:	ffffe097          	auipc	ra,0xffffe
    80003090:	5e4080e7          	jalr	1508(ra) # 80001670 <mycpu>
    80003094:	0014f493          	andi	s1,s1,1
    80003098:	06952e23          	sw	s1,124(a0)
    8000309c:	fc5ff06f          	j	80003060 <push_on+0x34>

00000000800030a0 <pop_on>:
    800030a0:	ff010113          	addi	sp,sp,-16
    800030a4:	00813023          	sd	s0,0(sp)
    800030a8:	00113423          	sd	ra,8(sp)
    800030ac:	01010413          	addi	s0,sp,16
    800030b0:	ffffe097          	auipc	ra,0xffffe
    800030b4:	5c0080e7          	jalr	1472(ra) # 80001670 <mycpu>
    800030b8:	100027f3          	csrr	a5,sstatus
    800030bc:	0027f793          	andi	a5,a5,2
    800030c0:	04078463          	beqz	a5,80003108 <pop_on+0x68>
    800030c4:	07852783          	lw	a5,120(a0)
    800030c8:	02f05863          	blez	a5,800030f8 <pop_on+0x58>
    800030cc:	fff7879b          	addiw	a5,a5,-1
    800030d0:	06f52c23          	sw	a5,120(a0)
    800030d4:	07853783          	ld	a5,120(a0)
    800030d8:	00079863          	bnez	a5,800030e8 <pop_on+0x48>
    800030dc:	100027f3          	csrr	a5,sstatus
    800030e0:	ffd7f793          	andi	a5,a5,-3
    800030e4:	10079073          	csrw	sstatus,a5
    800030e8:	00813083          	ld	ra,8(sp)
    800030ec:	00013403          	ld	s0,0(sp)
    800030f0:	01010113          	addi	sp,sp,16
    800030f4:	00008067          	ret
    800030f8:	00001517          	auipc	a0,0x1
    800030fc:	0f050513          	addi	a0,a0,240 # 800041e8 <digits+0x70>
    80003100:	fffff097          	auipc	ra,0xfffff
    80003104:	f2c080e7          	jalr	-212(ra) # 8000202c <panic>
    80003108:	00001517          	auipc	a0,0x1
    8000310c:	0c050513          	addi	a0,a0,192 # 800041c8 <digits+0x50>
    80003110:	fffff097          	auipc	ra,0xfffff
    80003114:	f1c080e7          	jalr	-228(ra) # 8000202c <panic>

0000000080003118 <__memset>:
    80003118:	ff010113          	addi	sp,sp,-16
    8000311c:	00813423          	sd	s0,8(sp)
    80003120:	01010413          	addi	s0,sp,16
    80003124:	1a060e63          	beqz	a2,800032e0 <__memset+0x1c8>
    80003128:	40a007b3          	neg	a5,a0
    8000312c:	0077f793          	andi	a5,a5,7
    80003130:	00778693          	addi	a3,a5,7
    80003134:	00b00813          	li	a6,11
    80003138:	0ff5f593          	andi	a1,a1,255
    8000313c:	fff6071b          	addiw	a4,a2,-1
    80003140:	1b06e663          	bltu	a3,a6,800032ec <__memset+0x1d4>
    80003144:	1cd76463          	bltu	a4,a3,8000330c <__memset+0x1f4>
    80003148:	1a078e63          	beqz	a5,80003304 <__memset+0x1ec>
    8000314c:	00b50023          	sb	a1,0(a0)
    80003150:	00100713          	li	a4,1
    80003154:	1ae78463          	beq	a5,a4,800032fc <__memset+0x1e4>
    80003158:	00b500a3          	sb	a1,1(a0)
    8000315c:	00200713          	li	a4,2
    80003160:	1ae78a63          	beq	a5,a4,80003314 <__memset+0x1fc>
    80003164:	00b50123          	sb	a1,2(a0)
    80003168:	00300713          	li	a4,3
    8000316c:	18e78463          	beq	a5,a4,800032f4 <__memset+0x1dc>
    80003170:	00b501a3          	sb	a1,3(a0)
    80003174:	00400713          	li	a4,4
    80003178:	1ae78263          	beq	a5,a4,8000331c <__memset+0x204>
    8000317c:	00b50223          	sb	a1,4(a0)
    80003180:	00500713          	li	a4,5
    80003184:	1ae78063          	beq	a5,a4,80003324 <__memset+0x20c>
    80003188:	00b502a3          	sb	a1,5(a0)
    8000318c:	00700713          	li	a4,7
    80003190:	18e79e63          	bne	a5,a4,8000332c <__memset+0x214>
    80003194:	00b50323          	sb	a1,6(a0)
    80003198:	00700e93          	li	t4,7
    8000319c:	00859713          	slli	a4,a1,0x8
    800031a0:	00e5e733          	or	a4,a1,a4
    800031a4:	01059e13          	slli	t3,a1,0x10
    800031a8:	01c76e33          	or	t3,a4,t3
    800031ac:	01859313          	slli	t1,a1,0x18
    800031b0:	006e6333          	or	t1,t3,t1
    800031b4:	02059893          	slli	a7,a1,0x20
    800031b8:	40f60e3b          	subw	t3,a2,a5
    800031bc:	011368b3          	or	a7,t1,a7
    800031c0:	02859813          	slli	a6,a1,0x28
    800031c4:	0108e833          	or	a6,a7,a6
    800031c8:	03059693          	slli	a3,a1,0x30
    800031cc:	003e589b          	srliw	a7,t3,0x3
    800031d0:	00d866b3          	or	a3,a6,a3
    800031d4:	03859713          	slli	a4,a1,0x38
    800031d8:	00389813          	slli	a6,a7,0x3
    800031dc:	00f507b3          	add	a5,a0,a5
    800031e0:	00e6e733          	or	a4,a3,a4
    800031e4:	000e089b          	sext.w	a7,t3
    800031e8:	00f806b3          	add	a3,a6,a5
    800031ec:	00e7b023          	sd	a4,0(a5)
    800031f0:	00878793          	addi	a5,a5,8
    800031f4:	fed79ce3          	bne	a5,a3,800031ec <__memset+0xd4>
    800031f8:	ff8e7793          	andi	a5,t3,-8
    800031fc:	0007871b          	sext.w	a4,a5
    80003200:	01d787bb          	addw	a5,a5,t4
    80003204:	0ce88e63          	beq	a7,a4,800032e0 <__memset+0x1c8>
    80003208:	00f50733          	add	a4,a0,a5
    8000320c:	00b70023          	sb	a1,0(a4)
    80003210:	0017871b          	addiw	a4,a5,1
    80003214:	0cc77663          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    80003218:	00e50733          	add	a4,a0,a4
    8000321c:	00b70023          	sb	a1,0(a4)
    80003220:	0027871b          	addiw	a4,a5,2
    80003224:	0ac77e63          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    80003228:	00e50733          	add	a4,a0,a4
    8000322c:	00b70023          	sb	a1,0(a4)
    80003230:	0037871b          	addiw	a4,a5,3
    80003234:	0ac77663          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    80003238:	00e50733          	add	a4,a0,a4
    8000323c:	00b70023          	sb	a1,0(a4)
    80003240:	0047871b          	addiw	a4,a5,4
    80003244:	08c77e63          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    80003248:	00e50733          	add	a4,a0,a4
    8000324c:	00b70023          	sb	a1,0(a4)
    80003250:	0057871b          	addiw	a4,a5,5
    80003254:	08c77663          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    80003258:	00e50733          	add	a4,a0,a4
    8000325c:	00b70023          	sb	a1,0(a4)
    80003260:	0067871b          	addiw	a4,a5,6
    80003264:	06c77e63          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    80003268:	00e50733          	add	a4,a0,a4
    8000326c:	00b70023          	sb	a1,0(a4)
    80003270:	0077871b          	addiw	a4,a5,7
    80003274:	06c77663          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    80003278:	00e50733          	add	a4,a0,a4
    8000327c:	00b70023          	sb	a1,0(a4)
    80003280:	0087871b          	addiw	a4,a5,8
    80003284:	04c77e63          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    80003288:	00e50733          	add	a4,a0,a4
    8000328c:	00b70023          	sb	a1,0(a4)
    80003290:	0097871b          	addiw	a4,a5,9
    80003294:	04c77663          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    80003298:	00e50733          	add	a4,a0,a4
    8000329c:	00b70023          	sb	a1,0(a4)
    800032a0:	00a7871b          	addiw	a4,a5,10
    800032a4:	02c77e63          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    800032a8:	00e50733          	add	a4,a0,a4
    800032ac:	00b70023          	sb	a1,0(a4)
    800032b0:	00b7871b          	addiw	a4,a5,11
    800032b4:	02c77663          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    800032b8:	00e50733          	add	a4,a0,a4
    800032bc:	00b70023          	sb	a1,0(a4)
    800032c0:	00c7871b          	addiw	a4,a5,12
    800032c4:	00c77e63          	bgeu	a4,a2,800032e0 <__memset+0x1c8>
    800032c8:	00e50733          	add	a4,a0,a4
    800032cc:	00b70023          	sb	a1,0(a4)
    800032d0:	00d7879b          	addiw	a5,a5,13
    800032d4:	00c7f663          	bgeu	a5,a2,800032e0 <__memset+0x1c8>
    800032d8:	00f507b3          	add	a5,a0,a5
    800032dc:	00b78023          	sb	a1,0(a5)
    800032e0:	00813403          	ld	s0,8(sp)
    800032e4:	01010113          	addi	sp,sp,16
    800032e8:	00008067          	ret
    800032ec:	00b00693          	li	a3,11
    800032f0:	e55ff06f          	j	80003144 <__memset+0x2c>
    800032f4:	00300e93          	li	t4,3
    800032f8:	ea5ff06f          	j	8000319c <__memset+0x84>
    800032fc:	00100e93          	li	t4,1
    80003300:	e9dff06f          	j	8000319c <__memset+0x84>
    80003304:	00000e93          	li	t4,0
    80003308:	e95ff06f          	j	8000319c <__memset+0x84>
    8000330c:	00000793          	li	a5,0
    80003310:	ef9ff06f          	j	80003208 <__memset+0xf0>
    80003314:	00200e93          	li	t4,2
    80003318:	e85ff06f          	j	8000319c <__memset+0x84>
    8000331c:	00400e93          	li	t4,4
    80003320:	e7dff06f          	j	8000319c <__memset+0x84>
    80003324:	00500e93          	li	t4,5
    80003328:	e75ff06f          	j	8000319c <__memset+0x84>
    8000332c:	00600e93          	li	t4,6
    80003330:	e6dff06f          	j	8000319c <__memset+0x84>

0000000080003334 <__memmove>:
    80003334:	ff010113          	addi	sp,sp,-16
    80003338:	00813423          	sd	s0,8(sp)
    8000333c:	01010413          	addi	s0,sp,16
    80003340:	0e060863          	beqz	a2,80003430 <__memmove+0xfc>
    80003344:	fff6069b          	addiw	a3,a2,-1
    80003348:	0006881b          	sext.w	a6,a3
    8000334c:	0ea5e863          	bltu	a1,a0,8000343c <__memmove+0x108>
    80003350:	00758713          	addi	a4,a1,7
    80003354:	00a5e7b3          	or	a5,a1,a0
    80003358:	40a70733          	sub	a4,a4,a0
    8000335c:	0077f793          	andi	a5,a5,7
    80003360:	00f73713          	sltiu	a4,a4,15
    80003364:	00174713          	xori	a4,a4,1
    80003368:	0017b793          	seqz	a5,a5
    8000336c:	00e7f7b3          	and	a5,a5,a4
    80003370:	10078863          	beqz	a5,80003480 <__memmove+0x14c>
    80003374:	00900793          	li	a5,9
    80003378:	1107f463          	bgeu	a5,a6,80003480 <__memmove+0x14c>
    8000337c:	0036581b          	srliw	a6,a2,0x3
    80003380:	fff8081b          	addiw	a6,a6,-1
    80003384:	02081813          	slli	a6,a6,0x20
    80003388:	01d85893          	srli	a7,a6,0x1d
    8000338c:	00858813          	addi	a6,a1,8
    80003390:	00058793          	mv	a5,a1
    80003394:	00050713          	mv	a4,a0
    80003398:	01088833          	add	a6,a7,a6
    8000339c:	0007b883          	ld	a7,0(a5)
    800033a0:	00878793          	addi	a5,a5,8
    800033a4:	00870713          	addi	a4,a4,8
    800033a8:	ff173c23          	sd	a7,-8(a4)
    800033ac:	ff0798e3          	bne	a5,a6,8000339c <__memmove+0x68>
    800033b0:	ff867713          	andi	a4,a2,-8
    800033b4:	02071793          	slli	a5,a4,0x20
    800033b8:	0207d793          	srli	a5,a5,0x20
    800033bc:	00f585b3          	add	a1,a1,a5
    800033c0:	40e686bb          	subw	a3,a3,a4
    800033c4:	00f507b3          	add	a5,a0,a5
    800033c8:	06e60463          	beq	a2,a4,80003430 <__memmove+0xfc>
    800033cc:	0005c703          	lbu	a4,0(a1)
    800033d0:	00e78023          	sb	a4,0(a5)
    800033d4:	04068e63          	beqz	a3,80003430 <__memmove+0xfc>
    800033d8:	0015c603          	lbu	a2,1(a1)
    800033dc:	00100713          	li	a4,1
    800033e0:	00c780a3          	sb	a2,1(a5)
    800033e4:	04e68663          	beq	a3,a4,80003430 <__memmove+0xfc>
    800033e8:	0025c603          	lbu	a2,2(a1)
    800033ec:	00200713          	li	a4,2
    800033f0:	00c78123          	sb	a2,2(a5)
    800033f4:	02e68e63          	beq	a3,a4,80003430 <__memmove+0xfc>
    800033f8:	0035c603          	lbu	a2,3(a1)
    800033fc:	00300713          	li	a4,3
    80003400:	00c781a3          	sb	a2,3(a5)
    80003404:	02e68663          	beq	a3,a4,80003430 <__memmove+0xfc>
    80003408:	0045c603          	lbu	a2,4(a1)
    8000340c:	00400713          	li	a4,4
    80003410:	00c78223          	sb	a2,4(a5)
    80003414:	00e68e63          	beq	a3,a4,80003430 <__memmove+0xfc>
    80003418:	0055c603          	lbu	a2,5(a1)
    8000341c:	00500713          	li	a4,5
    80003420:	00c782a3          	sb	a2,5(a5)
    80003424:	00e68663          	beq	a3,a4,80003430 <__memmove+0xfc>
    80003428:	0065c703          	lbu	a4,6(a1)
    8000342c:	00e78323          	sb	a4,6(a5)
    80003430:	00813403          	ld	s0,8(sp)
    80003434:	01010113          	addi	sp,sp,16
    80003438:	00008067          	ret
    8000343c:	02061713          	slli	a4,a2,0x20
    80003440:	02075713          	srli	a4,a4,0x20
    80003444:	00e587b3          	add	a5,a1,a4
    80003448:	f0f574e3          	bgeu	a0,a5,80003350 <__memmove+0x1c>
    8000344c:	02069613          	slli	a2,a3,0x20
    80003450:	02065613          	srli	a2,a2,0x20
    80003454:	fff64613          	not	a2,a2
    80003458:	00e50733          	add	a4,a0,a4
    8000345c:	00c78633          	add	a2,a5,a2
    80003460:	fff7c683          	lbu	a3,-1(a5)
    80003464:	fff78793          	addi	a5,a5,-1
    80003468:	fff70713          	addi	a4,a4,-1
    8000346c:	00d70023          	sb	a3,0(a4)
    80003470:	fec798e3          	bne	a5,a2,80003460 <__memmove+0x12c>
    80003474:	00813403          	ld	s0,8(sp)
    80003478:	01010113          	addi	sp,sp,16
    8000347c:	00008067          	ret
    80003480:	02069713          	slli	a4,a3,0x20
    80003484:	02075713          	srli	a4,a4,0x20
    80003488:	00170713          	addi	a4,a4,1
    8000348c:	00e50733          	add	a4,a0,a4
    80003490:	00050793          	mv	a5,a0
    80003494:	0005c683          	lbu	a3,0(a1)
    80003498:	00178793          	addi	a5,a5,1
    8000349c:	00158593          	addi	a1,a1,1
    800034a0:	fed78fa3          	sb	a3,-1(a5)
    800034a4:	fee798e3          	bne	a5,a4,80003494 <__memmove+0x160>
    800034a8:	f89ff06f          	j	80003430 <__memmove+0xfc>

00000000800034ac <__putc>:
    800034ac:	fe010113          	addi	sp,sp,-32
    800034b0:	00813823          	sd	s0,16(sp)
    800034b4:	00113c23          	sd	ra,24(sp)
    800034b8:	02010413          	addi	s0,sp,32
    800034bc:	00050793          	mv	a5,a0
    800034c0:	fef40593          	addi	a1,s0,-17
    800034c4:	00100613          	li	a2,1
    800034c8:	00000513          	li	a0,0
    800034cc:	fef407a3          	sb	a5,-17(s0)
    800034d0:	fffff097          	auipc	ra,0xfffff
    800034d4:	b3c080e7          	jalr	-1220(ra) # 8000200c <console_write>
    800034d8:	01813083          	ld	ra,24(sp)
    800034dc:	01013403          	ld	s0,16(sp)
    800034e0:	02010113          	addi	sp,sp,32
    800034e4:	00008067          	ret

00000000800034e8 <__getc>:
    800034e8:	fe010113          	addi	sp,sp,-32
    800034ec:	00813823          	sd	s0,16(sp)
    800034f0:	00113c23          	sd	ra,24(sp)
    800034f4:	02010413          	addi	s0,sp,32
    800034f8:	fe840593          	addi	a1,s0,-24
    800034fc:	00100613          	li	a2,1
    80003500:	00000513          	li	a0,0
    80003504:	fffff097          	auipc	ra,0xfffff
    80003508:	ae8080e7          	jalr	-1304(ra) # 80001fec <console_read>
    8000350c:	fe844503          	lbu	a0,-24(s0)
    80003510:	01813083          	ld	ra,24(sp)
    80003514:	01013403          	ld	s0,16(sp)
    80003518:	02010113          	addi	sp,sp,32
    8000351c:	00008067          	ret

0000000080003520 <console_handler>:
    80003520:	fe010113          	addi	sp,sp,-32
    80003524:	00813823          	sd	s0,16(sp)
    80003528:	00113c23          	sd	ra,24(sp)
    8000352c:	00913423          	sd	s1,8(sp)
    80003530:	02010413          	addi	s0,sp,32
    80003534:	14202773          	csrr	a4,scause
    80003538:	100027f3          	csrr	a5,sstatus
    8000353c:	0027f793          	andi	a5,a5,2
    80003540:	06079e63          	bnez	a5,800035bc <console_handler+0x9c>
    80003544:	00074c63          	bltz	a4,8000355c <console_handler+0x3c>
    80003548:	01813083          	ld	ra,24(sp)
    8000354c:	01013403          	ld	s0,16(sp)
    80003550:	00813483          	ld	s1,8(sp)
    80003554:	02010113          	addi	sp,sp,32
    80003558:	00008067          	ret
    8000355c:	0ff77713          	andi	a4,a4,255
    80003560:	00900793          	li	a5,9
    80003564:	fef712e3          	bne	a4,a5,80003548 <console_handler+0x28>
    80003568:	ffffe097          	auipc	ra,0xffffe
    8000356c:	6dc080e7          	jalr	1756(ra) # 80001c44 <plic_claim>
    80003570:	00a00793          	li	a5,10
    80003574:	00050493          	mv	s1,a0
    80003578:	02f50c63          	beq	a0,a5,800035b0 <console_handler+0x90>
    8000357c:	fc0506e3          	beqz	a0,80003548 <console_handler+0x28>
    80003580:	00050593          	mv	a1,a0
    80003584:	00001517          	auipc	a0,0x1
    80003588:	b6c50513          	addi	a0,a0,-1172 # 800040f0 <CONSOLE_STATUS+0xe0>
    8000358c:	fffff097          	auipc	ra,0xfffff
    80003590:	afc080e7          	jalr	-1284(ra) # 80002088 <__printf>
    80003594:	01013403          	ld	s0,16(sp)
    80003598:	01813083          	ld	ra,24(sp)
    8000359c:	00048513          	mv	a0,s1
    800035a0:	00813483          	ld	s1,8(sp)
    800035a4:	02010113          	addi	sp,sp,32
    800035a8:	ffffe317          	auipc	t1,0xffffe
    800035ac:	6d430067          	jr	1748(t1) # 80001c7c <plic_complete>
    800035b0:	fffff097          	auipc	ra,0xfffff
    800035b4:	3e0080e7          	jalr	992(ra) # 80002990 <uartintr>
    800035b8:	fddff06f          	j	80003594 <console_handler+0x74>
    800035bc:	00001517          	auipc	a0,0x1
    800035c0:	c3450513          	addi	a0,a0,-972 # 800041f0 <digits+0x78>
    800035c4:	fffff097          	auipc	ra,0xfffff
    800035c8:	a68080e7          	jalr	-1432(ra) # 8000202c <panic>
	...
