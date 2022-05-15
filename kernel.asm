
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	33013103          	ld	sp,816(sp) # 80004330 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	55c010ef          	jal	ra,80001578 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <_Z12checkNullptrPv>:
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"

void checkNullptr(void* p) {
    static int x = 0;
    if(p == nullptr) {
    80001000:	00050e63          	beqz	a0,8000101c <_Z12checkNullptrPv+0x1c>
        __putc('?');
        __putc('0' + x);
    }
    x++;
    80001004:	00003717          	auipc	a4,0x3
    80001008:	37c70713          	addi	a4,a4,892 # 80004380 <_ZZ12checkNullptrPvE1x>
    8000100c:	00072783          	lw	a5,0(a4)
    80001010:	0017879b          	addiw	a5,a5,1
    80001014:	00f72023          	sw	a5,0(a4)
    80001018:	00008067          	ret
void checkNullptr(void* p) {
    8000101c:	ff010113          	addi	sp,sp,-16
    80001020:	00113423          	sd	ra,8(sp)
    80001024:	00813023          	sd	s0,0(sp)
    80001028:	01010413          	addi	s0,sp,16
        __putc('?');
    8000102c:	03f00513          	li	a0,63
    80001030:	00002097          	auipc	ra,0x2
    80001034:	60c080e7          	jalr	1548(ra) # 8000363c <__putc>
        __putc('0' + x);
    80001038:	00003517          	auipc	a0,0x3
    8000103c:	34852503          	lw	a0,840(a0) # 80004380 <_ZZ12checkNullptrPvE1x>
    80001040:	0305051b          	addiw	a0,a0,48
    80001044:	0ff57513          	andi	a0,a0,255
    80001048:	00002097          	auipc	ra,0x2
    8000104c:	5f4080e7          	jalr	1524(ra) # 8000363c <__putc>
    x++;
    80001050:	00003717          	auipc	a4,0x3
    80001054:	33070713          	addi	a4,a4,816 # 80004380 <_ZZ12checkNullptrPvE1x>
    80001058:	00072783          	lw	a5,0(a4)
    8000105c:	0017879b          	addiw	a5,a5,1
    80001060:	00f72023          	sw	a5,0(a4)
}
    80001064:	00813083          	ld	ra,8(sp)
    80001068:	00013403          	ld	s0,0(sp)
    8000106c:	01010113          	addi	sp,sp,16
    80001070:	00008067          	ret

0000000080001074 <_Z11checkStatusi>:

void checkStatus(int status) {
    static int y = 0;
    if(status) {
    80001074:	00051e63          	bnez	a0,80001090 <_Z11checkStatusi+0x1c>
        __putc('0' + y);
        __putc('?');
    }
    y++;
    80001078:	00003717          	auipc	a4,0x3
    8000107c:	30870713          	addi	a4,a4,776 # 80004380 <_ZZ12checkNullptrPvE1x>
    80001080:	00472783          	lw	a5,4(a4)
    80001084:	0017879b          	addiw	a5,a5,1
    80001088:	00f72223          	sw	a5,4(a4)
    8000108c:	00008067          	ret
void checkStatus(int status) {
    80001090:	ff010113          	addi	sp,sp,-16
    80001094:	00113423          	sd	ra,8(sp)
    80001098:	00813023          	sd	s0,0(sp)
    8000109c:	01010413          	addi	s0,sp,16
        __putc('0' + y);
    800010a0:	00003517          	auipc	a0,0x3
    800010a4:	2e452503          	lw	a0,740(a0) # 80004384 <_ZZ11checkStatusiE1y>
    800010a8:	0305051b          	addiw	a0,a0,48
    800010ac:	0ff57513          	andi	a0,a0,255
    800010b0:	00002097          	auipc	ra,0x2
    800010b4:	58c080e7          	jalr	1420(ra) # 8000363c <__putc>
        __putc('?');
    800010b8:	03f00513          	li	a0,63
    800010bc:	00002097          	auipc	ra,0x2
    800010c0:	580080e7          	jalr	1408(ra) # 8000363c <__putc>
    y++;
    800010c4:	00003717          	auipc	a4,0x3
    800010c8:	2bc70713          	addi	a4,a4,700 # 80004380 <_ZZ12checkNullptrPvE1x>
    800010cc:	00472783          	lw	a5,4(a4)
    800010d0:	0017879b          	addiw	a5,a5,1
    800010d4:	00f72223          	sw	a5,4(a4)
}
    800010d8:	00813083          	ld	ra,8(sp)
    800010dc:	00013403          	ld	s0,0(sp)
    800010e0:	01010113          	addi	sp,sp,16
    800010e4:	00008067          	ret

00000000800010e8 <main>:

int main() {
    800010e8:	fd010113          	addi	sp,sp,-48
    800010ec:	02113423          	sd	ra,40(sp)
    800010f0:	02813023          	sd	s0,32(sp)
    800010f4:	00913c23          	sd	s1,24(sp)
    800010f8:	01213823          	sd	s2,16(sp)
    800010fc:	01313423          	sd	s3,8(sp)
    80001100:	03010413          	addi	s0,sp,48
    int n = 16;
    char** matrix = (char**)MemoryAllocator::mem_alloc(n*sizeof(char*));
    80001104:	08000513          	li	a0,128
    80001108:	00000097          	auipc	ra,0x0
    8000110c:	154080e7          	jalr	340(ra) # 8000125c <_ZN15MemoryAllocator9mem_allocEm>
    80001110:	00050913          	mv	s2,a0
    checkNullptr(matrix);
    80001114:	00000097          	auipc	ra,0x0
    80001118:	eec080e7          	jalr	-276(ra) # 80001000 <_Z12checkNullptrPv>
    for(int i = 0; i < n; i++) {
    8000111c:	00000493          	li	s1,0
    80001120:	00f00793          	li	a5,15
    80001124:	0297c663          	blt	a5,s1,80001150 <main+0x68>
        matrix[i] = (char *) MemoryAllocator::mem_alloc(n * sizeof(char));
    80001128:	00349993          	slli	s3,s1,0x3
    8000112c:	013909b3          	add	s3,s2,s3
    80001130:	01000513          	li	a0,16
    80001134:	00000097          	auipc	ra,0x0
    80001138:	128080e7          	jalr	296(ra) # 8000125c <_ZN15MemoryAllocator9mem_allocEm>
    8000113c:	00a9b023          	sd	a0,0(s3)
        checkNullptr(matrix[i]);
    80001140:	00000097          	auipc	ra,0x0
    80001144:	ec0080e7          	jalr	-320(ra) # 80001000 <_Z12checkNullptrPv>
    for(int i = 0; i < n; i++) {
    80001148:	0014849b          	addiw	s1,s1,1
    8000114c:	fd5ff06f          	j	80001120 <main+0x38>
    }

    for(int i = 0; i < n; i++) {
    80001150:	00000613          	li	a2,0
    80001154:	0080006f          	j	8000115c <main+0x74>
    80001158:	0016061b          	addiw	a2,a2,1
    8000115c:	00f00793          	li	a5,15
    80001160:	02c7ce63          	blt	a5,a2,8000119c <main+0xb4>
        for(int j = 0; j < n; j++) {
    80001164:	00000713          	li	a4,0
    80001168:	00f00793          	li	a5,15
    8000116c:	fee7c6e3          	blt	a5,a4,80001158 <main+0x70>
            matrix[i][j] = (char)('0' + (i+j)%10);
    80001170:	00e607bb          	addw	a5,a2,a4
    80001174:	00a00693          	li	a3,10
    80001178:	02d7e7bb          	remw	a5,a5,a3
    8000117c:	00361693          	slli	a3,a2,0x3
    80001180:	00d906b3          	add	a3,s2,a3
    80001184:	0006b683          	ld	a3,0(a3)
    80001188:	00e686b3          	add	a3,a3,a4
    8000118c:	0307879b          	addiw	a5,a5,48
    80001190:	00f68023          	sb	a5,0(a3)
        for(int j = 0; j < n; j++) {
    80001194:	0017071b          	addiw	a4,a4,1
    80001198:	fd1ff06f          	j	80001168 <main+0x80>
        }
    }

    for(int i = 0; i < n; i++) {
    8000119c:	00000993          	li	s3,0
    800011a0:	0140006f          	j	800011b4 <main+0xcc>
        for(int j = 0; j < n; j++) {
            __putc(matrix[i][j]);
            __putc(' ');
        }
        __putc('\n');
    800011a4:	00a00513          	li	a0,10
    800011a8:	00002097          	auipc	ra,0x2
    800011ac:	494080e7          	jalr	1172(ra) # 8000363c <__putc>
    for(int i = 0; i < n; i++) {
    800011b0:	0019899b          	addiw	s3,s3,1
    800011b4:	00f00793          	li	a5,15
    800011b8:	0537c063          	blt	a5,s3,800011f8 <main+0x110>
        for(int j = 0; j < n; j++) {
    800011bc:	00000493          	li	s1,0
    800011c0:	00f00793          	li	a5,15
    800011c4:	fe97c0e3          	blt	a5,s1,800011a4 <main+0xbc>
            __putc(matrix[i][j]);
    800011c8:	00399793          	slli	a5,s3,0x3
    800011cc:	00f907b3          	add	a5,s2,a5
    800011d0:	0007b783          	ld	a5,0(a5)
    800011d4:	009787b3          	add	a5,a5,s1
    800011d8:	0007c503          	lbu	a0,0(a5)
    800011dc:	00002097          	auipc	ra,0x2
    800011e0:	460080e7          	jalr	1120(ra) # 8000363c <__putc>
            __putc(' ');
    800011e4:	02000513          	li	a0,32
    800011e8:	00002097          	auipc	ra,0x2
    800011ec:	454080e7          	jalr	1108(ra) # 8000363c <__putc>
        for(int j = 0; j < n; j++) {
    800011f0:	0014849b          	addiw	s1,s1,1
    800011f4:	fcdff06f          	j	800011c0 <main+0xd8>
    }


    for(int i = 0; i < n; i++) {
    800011f8:	00000493          	li	s1,0
    800011fc:	00f00793          	li	a5,15
    80001200:	0297c463          	blt	a5,s1,80001228 <main+0x140>
        int status = MemoryAllocator::mem_free(matrix[i]);
    80001204:	00349793          	slli	a5,s1,0x3
    80001208:	00f907b3          	add	a5,s2,a5
    8000120c:	0007b503          	ld	a0,0(a5)
    80001210:	00000097          	auipc	ra,0x0
    80001214:	1bc080e7          	jalr	444(ra) # 800013cc <_ZN15MemoryAllocator8mem_freeEPv>
        checkStatus(status);
    80001218:	00000097          	auipc	ra,0x0
    8000121c:	e5c080e7          	jalr	-420(ra) # 80001074 <_Z11checkStatusi>
    for(int i = 0; i < n; i++) {
    80001220:	0014849b          	addiw	s1,s1,1
    80001224:	fd9ff06f          	j	800011fc <main+0x114>
    }
    int status = MemoryAllocator::mem_free(matrix);
    80001228:	00090513          	mv	a0,s2
    8000122c:	00000097          	auipc	ra,0x0
    80001230:	1a0080e7          	jalr	416(ra) # 800013cc <_ZN15MemoryAllocator8mem_freeEPv>
    checkStatus(status);
    80001234:	00000097          	auipc	ra,0x0
    80001238:	e40080e7          	jalr	-448(ra) # 80001074 <_Z11checkStatusi>

    return 0;
    8000123c:	00000513          	li	a0,0
    80001240:	02813083          	ld	ra,40(sp)
    80001244:	02013403          	ld	s0,32(sp)
    80001248:	01813483          	ld	s1,24(sp)
    8000124c:	01013903          	ld	s2,16(sp)
    80001250:	00813983          	ld	s3,8(sp)
    80001254:	03010113          	addi	sp,sp,48
    80001258:	00008067          	ret

000000008000125c <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    8000125c:	ff010113          	addi	sp,sp,-16
    80001260:	00813423          	sd	s0,8(sp)
    80001264:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80001268:	00003797          	auipc	a5,0x3
    8000126c:	1207b783          	ld	a5,288(a5) # 80004388 <_ZN15MemoryAllocator4headE>
    80001270:	02078c63          	beqz	a5,800012a8 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80001274:	00003717          	auipc	a4,0x3
    80001278:	0c473703          	ld	a4,196(a4) # 80004338 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000127c:	00073703          	ld	a4,0(a4)
    80001280:	14e78263          	beq	a5,a4,800013c4 <_ZN15MemoryAllocator9mem_allocEm+0x168>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80001284:	00850613          	addi	a2,a0,8

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80001288:	00665813          	srli	a6,a2,0x6
    8000128c:	03f67793          	andi	a5,a2,63
    80001290:	00f037b3          	snez	a5,a5
    80001294:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80001298:	00003517          	auipc	a0,0x3
    8000129c:	0f053503          	ld	a0,240(a0) # 80004388 <_ZN15MemoryAllocator4headE>
    800012a0:	00000593          	li	a1,0
    800012a4:	0a80006f          	j	8000134c <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    800012a8:	00003697          	auipc	a3,0x3
    800012ac:	0806b683          	ld	a3,128(a3) # 80004328 <_GLOBAL_OFFSET_TABLE_+0x8>
    800012b0:	0006b783          	ld	a5,0(a3)
    800012b4:	00003717          	auipc	a4,0x3
    800012b8:	0cf73a23          	sd	a5,212(a4) # 80004388 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    800012bc:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    800012c0:	00003717          	auipc	a4,0x3
    800012c4:	07873703          	ld	a4,120(a4) # 80004338 <_GLOBAL_OFFSET_TABLE_+0x18>
    800012c8:	00073703          	ld	a4,0(a4)
    800012cc:	0006b683          	ld	a3,0(a3)
    800012d0:	40d70733          	sub	a4,a4,a3
    800012d4:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    800012d8:	0007b823          	sd	zero,16(a5)
    800012dc:	fa9ff06f          	j	80001284 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    800012e0:	00058e63          	beqz	a1,800012fc <_ZN15MemoryAllocator9mem_allocEm+0xa0>
            if(!prev->next) return;
    800012e4:	0105b703          	ld	a4,16(a1)
    800012e8:	04070a63          	beqz	a4,8000133c <_ZN15MemoryAllocator9mem_allocEm+0xe0>
            prev->next = curr->next;
    800012ec:	01073703          	ld	a4,16(a4)
    800012f0:	00e5b823          	sd	a4,16(a1)
                allocatedSize = curr->size;
    800012f4:	00078813          	mv	a6,a5
    800012f8:	0b80006f          	j	800013b0 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    800012fc:	01053703          	ld	a4,16(a0)
    80001300:	00070a63          	beqz	a4,80001314 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80001304:	00003617          	auipc	a2,0x3
    80001308:	08e63223          	sd	a4,132(a2) # 80004388 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    8000130c:	00078813          	mv	a6,a5
    80001310:	0a00006f          	j	800013b0 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001314:	00003717          	auipc	a4,0x3
    80001318:	02473703          	ld	a4,36(a4) # 80004338 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000131c:	00073703          	ld	a4,0(a4)
    80001320:	00003617          	auipc	a2,0x3
    80001324:	06e63423          	sd	a4,104(a2) # 80004388 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001328:	00078813          	mv	a6,a5
    8000132c:	0840006f          	j	800013b0 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80001330:	00003797          	auipc	a5,0x3
    80001334:	04e7bc23          	sd	a4,88(a5) # 80004388 <_ZN15MemoryAllocator4headE>
    80001338:	0780006f          	j	800013b0 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                allocatedSize = curr->size;
    8000133c:	00078813          	mv	a6,a5
    80001340:	0700006f          	j	800013b0 <_ZN15MemoryAllocator9mem_allocEm+0x154>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80001344:	00050593          	mv	a1,a0
        curr = curr->next;
    80001348:	01053503          	ld	a0,16(a0)
    while(curr) {
    8000134c:	06050663          	beqz	a0,800013b8 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        size_t freeSegSizeInBlocks = sizeInBlocks(curr->size);
    80001350:	00853783          	ld	a5,8(a0)
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80001354:	0067d693          	srli	a3,a5,0x6
    80001358:	03f7f713          	andi	a4,a5,63
    8000135c:	00e03733          	snez	a4,a4
    80001360:	00e68733          	add	a4,a3,a4
        void* startOfAllocatedSpace = curr->baseAddr;
    80001364:	00053683          	ld	a3,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80001368:	fcc7eee3          	bltu	a5,a2,80001344 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    8000136c:	fd076ce3          	bltu	a4,a6,80001344 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001370:	f6e808e3          	beq	a6,a4,800012e0 <_ZN15MemoryAllocator9mem_allocEm+0x84>
    }

    // Vraca velicinu numOfBlocks blokova u bajtovima
    static inline size_t blocksInSize(size_t numOfBlocks) {
        return numOfBlocks * MEM_BLOCK_SIZE;
    80001374:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80001378:	01068733          	add	a4,a3,a6
                size_t newSize = curr->size - allocatedSize;
    8000137c:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80001380:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80001384:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80001388:	01053783          	ld	a5,16(a0)
    8000138c:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80001390:	fa0580e3          	beqz	a1,80001330 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80001394:	0105b783          	ld	a5,16(a1)
    80001398:	00078663          	beqz	a5,800013a4 <_ZN15MemoryAllocator9mem_allocEm+0x148>
            prev->next = curr->next;
    8000139c:	0107b783          	ld	a5,16(a5)
    800013a0:	00f5b823          	sd	a5,16(a1)
            curr->next = prev->next;
    800013a4:	0105b783          	ld	a5,16(a1)
    800013a8:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    800013ac:	00a5b823          	sd	a0,16(a1)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    800013b0:	0106b023          	sd	a6,0(a3)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    800013b4:	00868513          	addi	a0,a3,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    800013b8:	00813403          	ld	s0,8(sp)
    800013bc:	01010113          	addi	sp,sp,16
    800013c0:	00008067          	ret
        return nullptr;
    800013c4:	00000513          	li	a0,0
    800013c8:	ff1ff06f          	j	800013b8 <_ZN15MemoryAllocator9mem_allocEm+0x15c>

00000000800013cc <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800013cc:	ff010113          	addi	sp,sp,-16
    800013d0:	00813423          	sd	s0,8(sp)
    800013d4:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800013d8:	16050063          	beqz	a0,80001538 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    800013dc:	ff850713          	addi	a4,a0,-8
    800013e0:	00003797          	auipc	a5,0x3
    800013e4:	f487b783          	ld	a5,-184(a5) # 80004328 <_GLOBAL_OFFSET_TABLE_+0x8>
    800013e8:	0007b783          	ld	a5,0(a5)
    800013ec:	14f76a63          	bltu	a4,a5,80001540 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    800013f0:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800013f4:	fff58693          	addi	a3,a1,-1
    800013f8:	00d706b3          	add	a3,a4,a3
    800013fc:	00003617          	auipc	a2,0x3
    80001400:	f3c63603          	ld	a2,-196(a2) # 80004338 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001404:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001408:	14c6f063          	bgeu	a3,a2,80001548 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    8000140c:	14070263          	beqz	a4,80001550 <_ZN15MemoryAllocator8mem_freeEPv+0x184>
    }

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80001410:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80001414:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001418:	14079063          	bnez	a5,80001558 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    8000141c:	03f00793          	li	a5,63
    80001420:	14b7f063          	bgeu	a5,a1,80001560 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80001424:	00003797          	auipc	a5,0x3
    80001428:	f647b783          	ld	a5,-156(a5) # 80004388 <_ZN15MemoryAllocator4headE>
    8000142c:	02f60063          	beq	a2,a5,8000144c <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80001430:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001434:	02078a63          	beqz	a5,80001468 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80001438:	0007b683          	ld	a3,0(a5)
    8000143c:	02e6f663          	bgeu	a3,a4,80001468 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80001440:	00078613          	mv	a2,a5
        curr = curr->next;
    80001444:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001448:	fedff06f          	j	80001434 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    8000144c:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80001450:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80001454:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80001458:	00003797          	auipc	a5,0x3
    8000145c:	f2e7b823          	sd	a4,-208(a5) # 80004388 <_ZN15MemoryAllocator4headE>
        return 0;
    80001460:	00000513          	li	a0,0
    80001464:	0480006f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80001468:	04060863          	beqz	a2,800014b8 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    8000146c:	00063683          	ld	a3,0(a2)
    80001470:	00863803          	ld	a6,8(a2)
    80001474:	010686b3          	add	a3,a3,a6
    80001478:	08e68a63          	beq	a3,a4,8000150c <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    8000147c:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001480:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80001484:	01063683          	ld	a3,16(a2)
    80001488:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    8000148c:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80001490:	0e078063          	beqz	a5,80001570 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80001494:	0007b583          	ld	a1,0(a5)
    80001498:	00073683          	ld	a3,0(a4)
    8000149c:	00873603          	ld	a2,8(a4)
    800014a0:	00c686b3          	add	a3,a3,a2
    800014a4:	06d58c63          	beq	a1,a3,8000151c <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    800014a8:	00000513          	li	a0,0
}
    800014ac:	00813403          	ld	s0,8(sp)
    800014b0:	01010113          	addi	sp,sp,16
    800014b4:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    800014b8:	0a078863          	beqz	a5,80001568 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    800014bc:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800014c0:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800014c4:	00003797          	auipc	a5,0x3
    800014c8:	ec47b783          	ld	a5,-316(a5) # 80004388 <_ZN15MemoryAllocator4headE>
    800014cc:	0007b603          	ld	a2,0(a5)
    800014d0:	00b706b3          	add	a3,a4,a1
    800014d4:	00d60c63          	beq	a2,a3,800014ec <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    800014d8:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    800014dc:	00003797          	auipc	a5,0x3
    800014e0:	eae7b623          	sd	a4,-340(a5) # 80004388 <_ZN15MemoryAllocator4headE>
            return 0;
    800014e4:	00000513          	li	a0,0
    800014e8:	fc5ff06f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    800014ec:	0087b783          	ld	a5,8(a5)
    800014f0:	00b785b3          	add	a1,a5,a1
    800014f4:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    800014f8:	00003797          	auipc	a5,0x3
    800014fc:	e907b783          	ld	a5,-368(a5) # 80004388 <_ZN15MemoryAllocator4headE>
    80001500:	0107b783          	ld	a5,16(a5)
    80001504:	00f53423          	sd	a5,8(a0)
    80001508:	fd5ff06f          	j	800014dc <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    8000150c:	00b805b3          	add	a1,a6,a1
    80001510:	00b63423          	sd	a1,8(a2)
    80001514:	00060713          	mv	a4,a2
    80001518:	f79ff06f          	j	80001490 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    8000151c:	0087b683          	ld	a3,8(a5)
    80001520:	00d60633          	add	a2,a2,a3
    80001524:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80001528:	0107b783          	ld	a5,16(a5)
    8000152c:	00f73823          	sd	a5,16(a4)
    return 0;
    80001530:	00000513          	li	a0,0
    80001534:	f79ff06f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001538:	fff00513          	li	a0,-1
    8000153c:	f71ff06f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001540:	fff00513          	li	a0,-1
    80001544:	f69ff06f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80001548:	fff00513          	li	a0,-1
    8000154c:	f61ff06f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001550:	fff00513          	li	a0,-1
    80001554:	f59ff06f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001558:	fff00513          	li	a0,-1
    8000155c:	f51ff06f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001560:	fff00513          	li	a0,-1
    80001564:	f49ff06f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80001568:	fff00513          	li	a0,-1
    8000156c:	f41ff06f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80001570:	00000513          	li	a0,0
    80001574:	f39ff06f          	j	800014ac <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080001578 <start>:
    80001578:	ff010113          	addi	sp,sp,-16
    8000157c:	00813423          	sd	s0,8(sp)
    80001580:	01010413          	addi	s0,sp,16
    80001584:	300027f3          	csrr	a5,mstatus
    80001588:	ffffe737          	lui	a4,0xffffe
    8000158c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff921f>
    80001590:	00e7f7b3          	and	a5,a5,a4
    80001594:	00001737          	lui	a4,0x1
    80001598:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    8000159c:	00e7e7b3          	or	a5,a5,a4
    800015a0:	30079073          	csrw	mstatus,a5
    800015a4:	00000797          	auipc	a5,0x0
    800015a8:	16078793          	addi	a5,a5,352 # 80001704 <system_main>
    800015ac:	34179073          	csrw	mepc,a5
    800015b0:	00000793          	li	a5,0
    800015b4:	18079073          	csrw	satp,a5
    800015b8:	000107b7          	lui	a5,0x10
    800015bc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800015c0:	30279073          	csrw	medeleg,a5
    800015c4:	30379073          	csrw	mideleg,a5
    800015c8:	104027f3          	csrr	a5,sie
    800015cc:	2227e793          	ori	a5,a5,546
    800015d0:	10479073          	csrw	sie,a5
    800015d4:	fff00793          	li	a5,-1
    800015d8:	00a7d793          	srli	a5,a5,0xa
    800015dc:	3b079073          	csrw	pmpaddr0,a5
    800015e0:	00f00793          	li	a5,15
    800015e4:	3a079073          	csrw	pmpcfg0,a5
    800015e8:	f14027f3          	csrr	a5,mhartid
    800015ec:	0200c737          	lui	a4,0x200c
    800015f0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800015f4:	0007869b          	sext.w	a3,a5
    800015f8:	00269713          	slli	a4,a3,0x2
    800015fc:	000f4637          	lui	a2,0xf4
    80001600:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001604:	00d70733          	add	a4,a4,a3
    80001608:	0037979b          	slliw	a5,a5,0x3
    8000160c:	020046b7          	lui	a3,0x2004
    80001610:	00d787b3          	add	a5,a5,a3
    80001614:	00c585b3          	add	a1,a1,a2
    80001618:	00371693          	slli	a3,a4,0x3
    8000161c:	00003717          	auipc	a4,0x3
    80001620:	d7470713          	addi	a4,a4,-652 # 80004390 <timer_scratch>
    80001624:	00b7b023          	sd	a1,0(a5)
    80001628:	00d70733          	add	a4,a4,a3
    8000162c:	00f73c23          	sd	a5,24(a4)
    80001630:	02c73023          	sd	a2,32(a4)
    80001634:	34071073          	csrw	mscratch,a4
    80001638:	00000797          	auipc	a5,0x0
    8000163c:	6e878793          	addi	a5,a5,1768 # 80001d20 <timervec>
    80001640:	30579073          	csrw	mtvec,a5
    80001644:	300027f3          	csrr	a5,mstatus
    80001648:	0087e793          	ori	a5,a5,8
    8000164c:	30079073          	csrw	mstatus,a5
    80001650:	304027f3          	csrr	a5,mie
    80001654:	0807e793          	ori	a5,a5,128
    80001658:	30479073          	csrw	mie,a5
    8000165c:	f14027f3          	csrr	a5,mhartid
    80001660:	0007879b          	sext.w	a5,a5
    80001664:	00078213          	mv	tp,a5
    80001668:	30200073          	mret
    8000166c:	00813403          	ld	s0,8(sp)
    80001670:	01010113          	addi	sp,sp,16
    80001674:	00008067          	ret

0000000080001678 <timerinit>:
    80001678:	ff010113          	addi	sp,sp,-16
    8000167c:	00813423          	sd	s0,8(sp)
    80001680:	01010413          	addi	s0,sp,16
    80001684:	f14027f3          	csrr	a5,mhartid
    80001688:	0200c737          	lui	a4,0x200c
    8000168c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001690:	0007869b          	sext.w	a3,a5
    80001694:	00269713          	slli	a4,a3,0x2
    80001698:	000f4637          	lui	a2,0xf4
    8000169c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800016a0:	00d70733          	add	a4,a4,a3
    800016a4:	0037979b          	slliw	a5,a5,0x3
    800016a8:	020046b7          	lui	a3,0x2004
    800016ac:	00d787b3          	add	a5,a5,a3
    800016b0:	00c585b3          	add	a1,a1,a2
    800016b4:	00371693          	slli	a3,a4,0x3
    800016b8:	00003717          	auipc	a4,0x3
    800016bc:	cd870713          	addi	a4,a4,-808 # 80004390 <timer_scratch>
    800016c0:	00b7b023          	sd	a1,0(a5)
    800016c4:	00d70733          	add	a4,a4,a3
    800016c8:	00f73c23          	sd	a5,24(a4)
    800016cc:	02c73023          	sd	a2,32(a4)
    800016d0:	34071073          	csrw	mscratch,a4
    800016d4:	00000797          	auipc	a5,0x0
    800016d8:	64c78793          	addi	a5,a5,1612 # 80001d20 <timervec>
    800016dc:	30579073          	csrw	mtvec,a5
    800016e0:	300027f3          	csrr	a5,mstatus
    800016e4:	0087e793          	ori	a5,a5,8
    800016e8:	30079073          	csrw	mstatus,a5
    800016ec:	304027f3          	csrr	a5,mie
    800016f0:	0807e793          	ori	a5,a5,128
    800016f4:	30479073          	csrw	mie,a5
    800016f8:	00813403          	ld	s0,8(sp)
    800016fc:	01010113          	addi	sp,sp,16
    80001700:	00008067          	ret

0000000080001704 <system_main>:
    80001704:	fe010113          	addi	sp,sp,-32
    80001708:	00813823          	sd	s0,16(sp)
    8000170c:	00913423          	sd	s1,8(sp)
    80001710:	00113c23          	sd	ra,24(sp)
    80001714:	02010413          	addi	s0,sp,32
    80001718:	00000097          	auipc	ra,0x0
    8000171c:	0c4080e7          	jalr	196(ra) # 800017dc <cpuid>
    80001720:	00003497          	auipc	s1,0x3
    80001724:	c3048493          	addi	s1,s1,-976 # 80004350 <started>
    80001728:	02050263          	beqz	a0,8000174c <system_main+0x48>
    8000172c:	0004a783          	lw	a5,0(s1)
    80001730:	0007879b          	sext.w	a5,a5
    80001734:	fe078ce3          	beqz	a5,8000172c <system_main+0x28>
    80001738:	0ff0000f          	fence
    8000173c:	00003517          	auipc	a0,0x3
    80001740:	91450513          	addi	a0,a0,-1772 # 80004050 <CONSOLE_STATUS+0x40>
    80001744:	00001097          	auipc	ra,0x1
    80001748:	a78080e7          	jalr	-1416(ra) # 800021bc <panic>
    8000174c:	00001097          	auipc	ra,0x1
    80001750:	9cc080e7          	jalr	-1588(ra) # 80002118 <consoleinit>
    80001754:	00001097          	auipc	ra,0x1
    80001758:	158080e7          	jalr	344(ra) # 800028ac <printfinit>
    8000175c:	00003517          	auipc	a0,0x3
    80001760:	9d450513          	addi	a0,a0,-1580 # 80004130 <CONSOLE_STATUS+0x120>
    80001764:	00001097          	auipc	ra,0x1
    80001768:	ab4080e7          	jalr	-1356(ra) # 80002218 <__printf>
    8000176c:	00003517          	auipc	a0,0x3
    80001770:	8b450513          	addi	a0,a0,-1868 # 80004020 <CONSOLE_STATUS+0x10>
    80001774:	00001097          	auipc	ra,0x1
    80001778:	aa4080e7          	jalr	-1372(ra) # 80002218 <__printf>
    8000177c:	00003517          	auipc	a0,0x3
    80001780:	9b450513          	addi	a0,a0,-1612 # 80004130 <CONSOLE_STATUS+0x120>
    80001784:	00001097          	auipc	ra,0x1
    80001788:	a94080e7          	jalr	-1388(ra) # 80002218 <__printf>
    8000178c:	00001097          	auipc	ra,0x1
    80001790:	4ac080e7          	jalr	1196(ra) # 80002c38 <kinit>
    80001794:	00000097          	auipc	ra,0x0
    80001798:	148080e7          	jalr	328(ra) # 800018dc <trapinit>
    8000179c:	00000097          	auipc	ra,0x0
    800017a0:	16c080e7          	jalr	364(ra) # 80001908 <trapinithart>
    800017a4:	00000097          	auipc	ra,0x0
    800017a8:	5bc080e7          	jalr	1468(ra) # 80001d60 <plicinit>
    800017ac:	00000097          	auipc	ra,0x0
    800017b0:	5dc080e7          	jalr	1500(ra) # 80001d88 <plicinithart>
    800017b4:	00000097          	auipc	ra,0x0
    800017b8:	078080e7          	jalr	120(ra) # 8000182c <userinit>
    800017bc:	0ff0000f          	fence
    800017c0:	00100793          	li	a5,1
    800017c4:	00003517          	auipc	a0,0x3
    800017c8:	87450513          	addi	a0,a0,-1932 # 80004038 <CONSOLE_STATUS+0x28>
    800017cc:	00f4a023          	sw	a5,0(s1)
    800017d0:	00001097          	auipc	ra,0x1
    800017d4:	a48080e7          	jalr	-1464(ra) # 80002218 <__printf>
    800017d8:	0000006f          	j	800017d8 <system_main+0xd4>

00000000800017dc <cpuid>:
    800017dc:	ff010113          	addi	sp,sp,-16
    800017e0:	00813423          	sd	s0,8(sp)
    800017e4:	01010413          	addi	s0,sp,16
    800017e8:	00020513          	mv	a0,tp
    800017ec:	00813403          	ld	s0,8(sp)
    800017f0:	0005051b          	sext.w	a0,a0
    800017f4:	01010113          	addi	sp,sp,16
    800017f8:	00008067          	ret

00000000800017fc <mycpu>:
    800017fc:	ff010113          	addi	sp,sp,-16
    80001800:	00813423          	sd	s0,8(sp)
    80001804:	01010413          	addi	s0,sp,16
    80001808:	00020793          	mv	a5,tp
    8000180c:	00813403          	ld	s0,8(sp)
    80001810:	0007879b          	sext.w	a5,a5
    80001814:	00779793          	slli	a5,a5,0x7
    80001818:	00004517          	auipc	a0,0x4
    8000181c:	ba850513          	addi	a0,a0,-1112 # 800053c0 <cpus>
    80001820:	00f50533          	add	a0,a0,a5
    80001824:	01010113          	addi	sp,sp,16
    80001828:	00008067          	ret

000000008000182c <userinit>:
    8000182c:	ff010113          	addi	sp,sp,-16
    80001830:	00813423          	sd	s0,8(sp)
    80001834:	01010413          	addi	s0,sp,16
    80001838:	00813403          	ld	s0,8(sp)
    8000183c:	01010113          	addi	sp,sp,16
    80001840:	00000317          	auipc	t1,0x0
    80001844:	8a830067          	jr	-1880(t1) # 800010e8 <main>

0000000080001848 <either_copyout>:
    80001848:	ff010113          	addi	sp,sp,-16
    8000184c:	00813023          	sd	s0,0(sp)
    80001850:	00113423          	sd	ra,8(sp)
    80001854:	01010413          	addi	s0,sp,16
    80001858:	02051663          	bnez	a0,80001884 <either_copyout+0x3c>
    8000185c:	00058513          	mv	a0,a1
    80001860:	00060593          	mv	a1,a2
    80001864:	0006861b          	sext.w	a2,a3
    80001868:	00002097          	auipc	ra,0x2
    8000186c:	c5c080e7          	jalr	-932(ra) # 800034c4 <__memmove>
    80001870:	00813083          	ld	ra,8(sp)
    80001874:	00013403          	ld	s0,0(sp)
    80001878:	00000513          	li	a0,0
    8000187c:	01010113          	addi	sp,sp,16
    80001880:	00008067          	ret
    80001884:	00002517          	auipc	a0,0x2
    80001888:	7f450513          	addi	a0,a0,2036 # 80004078 <CONSOLE_STATUS+0x68>
    8000188c:	00001097          	auipc	ra,0x1
    80001890:	930080e7          	jalr	-1744(ra) # 800021bc <panic>

0000000080001894 <either_copyin>:
    80001894:	ff010113          	addi	sp,sp,-16
    80001898:	00813023          	sd	s0,0(sp)
    8000189c:	00113423          	sd	ra,8(sp)
    800018a0:	01010413          	addi	s0,sp,16
    800018a4:	02059463          	bnez	a1,800018cc <either_copyin+0x38>
    800018a8:	00060593          	mv	a1,a2
    800018ac:	0006861b          	sext.w	a2,a3
    800018b0:	00002097          	auipc	ra,0x2
    800018b4:	c14080e7          	jalr	-1004(ra) # 800034c4 <__memmove>
    800018b8:	00813083          	ld	ra,8(sp)
    800018bc:	00013403          	ld	s0,0(sp)
    800018c0:	00000513          	li	a0,0
    800018c4:	01010113          	addi	sp,sp,16
    800018c8:	00008067          	ret
    800018cc:	00002517          	auipc	a0,0x2
    800018d0:	7d450513          	addi	a0,a0,2004 # 800040a0 <CONSOLE_STATUS+0x90>
    800018d4:	00001097          	auipc	ra,0x1
    800018d8:	8e8080e7          	jalr	-1816(ra) # 800021bc <panic>

00000000800018dc <trapinit>:
    800018dc:	ff010113          	addi	sp,sp,-16
    800018e0:	00813423          	sd	s0,8(sp)
    800018e4:	01010413          	addi	s0,sp,16
    800018e8:	00813403          	ld	s0,8(sp)
    800018ec:	00002597          	auipc	a1,0x2
    800018f0:	7dc58593          	addi	a1,a1,2012 # 800040c8 <CONSOLE_STATUS+0xb8>
    800018f4:	00004517          	auipc	a0,0x4
    800018f8:	b4c50513          	addi	a0,a0,-1204 # 80005440 <tickslock>
    800018fc:	01010113          	addi	sp,sp,16
    80001900:	00001317          	auipc	t1,0x1
    80001904:	5c830067          	jr	1480(t1) # 80002ec8 <initlock>

0000000080001908 <trapinithart>:
    80001908:	ff010113          	addi	sp,sp,-16
    8000190c:	00813423          	sd	s0,8(sp)
    80001910:	01010413          	addi	s0,sp,16
    80001914:	00000797          	auipc	a5,0x0
    80001918:	2fc78793          	addi	a5,a5,764 # 80001c10 <kernelvec>
    8000191c:	10579073          	csrw	stvec,a5
    80001920:	00813403          	ld	s0,8(sp)
    80001924:	01010113          	addi	sp,sp,16
    80001928:	00008067          	ret

000000008000192c <usertrap>:
    8000192c:	ff010113          	addi	sp,sp,-16
    80001930:	00813423          	sd	s0,8(sp)
    80001934:	01010413          	addi	s0,sp,16
    80001938:	00813403          	ld	s0,8(sp)
    8000193c:	01010113          	addi	sp,sp,16
    80001940:	00008067          	ret

0000000080001944 <usertrapret>:
    80001944:	ff010113          	addi	sp,sp,-16
    80001948:	00813423          	sd	s0,8(sp)
    8000194c:	01010413          	addi	s0,sp,16
    80001950:	00813403          	ld	s0,8(sp)
    80001954:	01010113          	addi	sp,sp,16
    80001958:	00008067          	ret

000000008000195c <kerneltrap>:
    8000195c:	fe010113          	addi	sp,sp,-32
    80001960:	00813823          	sd	s0,16(sp)
    80001964:	00113c23          	sd	ra,24(sp)
    80001968:	00913423          	sd	s1,8(sp)
    8000196c:	02010413          	addi	s0,sp,32
    80001970:	142025f3          	csrr	a1,scause
    80001974:	100027f3          	csrr	a5,sstatus
    80001978:	0027f793          	andi	a5,a5,2
    8000197c:	10079c63          	bnez	a5,80001a94 <kerneltrap+0x138>
    80001980:	142027f3          	csrr	a5,scause
    80001984:	0207ce63          	bltz	a5,800019c0 <kerneltrap+0x64>
    80001988:	00002517          	auipc	a0,0x2
    8000198c:	78850513          	addi	a0,a0,1928 # 80004110 <CONSOLE_STATUS+0x100>
    80001990:	00001097          	auipc	ra,0x1
    80001994:	888080e7          	jalr	-1912(ra) # 80002218 <__printf>
    80001998:	141025f3          	csrr	a1,sepc
    8000199c:	14302673          	csrr	a2,stval
    800019a0:	00002517          	auipc	a0,0x2
    800019a4:	78050513          	addi	a0,a0,1920 # 80004120 <CONSOLE_STATUS+0x110>
    800019a8:	00001097          	auipc	ra,0x1
    800019ac:	870080e7          	jalr	-1936(ra) # 80002218 <__printf>
    800019b0:	00002517          	auipc	a0,0x2
    800019b4:	78850513          	addi	a0,a0,1928 # 80004138 <CONSOLE_STATUS+0x128>
    800019b8:	00001097          	auipc	ra,0x1
    800019bc:	804080e7          	jalr	-2044(ra) # 800021bc <panic>
    800019c0:	0ff7f713          	andi	a4,a5,255
    800019c4:	00900693          	li	a3,9
    800019c8:	04d70063          	beq	a4,a3,80001a08 <kerneltrap+0xac>
    800019cc:	fff00713          	li	a4,-1
    800019d0:	03f71713          	slli	a4,a4,0x3f
    800019d4:	00170713          	addi	a4,a4,1
    800019d8:	fae798e3          	bne	a5,a4,80001988 <kerneltrap+0x2c>
    800019dc:	00000097          	auipc	ra,0x0
    800019e0:	e00080e7          	jalr	-512(ra) # 800017dc <cpuid>
    800019e4:	06050663          	beqz	a0,80001a50 <kerneltrap+0xf4>
    800019e8:	144027f3          	csrr	a5,sip
    800019ec:	ffd7f793          	andi	a5,a5,-3
    800019f0:	14479073          	csrw	sip,a5
    800019f4:	01813083          	ld	ra,24(sp)
    800019f8:	01013403          	ld	s0,16(sp)
    800019fc:	00813483          	ld	s1,8(sp)
    80001a00:	02010113          	addi	sp,sp,32
    80001a04:	00008067          	ret
    80001a08:	00000097          	auipc	ra,0x0
    80001a0c:	3cc080e7          	jalr	972(ra) # 80001dd4 <plic_claim>
    80001a10:	00a00793          	li	a5,10
    80001a14:	00050493          	mv	s1,a0
    80001a18:	06f50863          	beq	a0,a5,80001a88 <kerneltrap+0x12c>
    80001a1c:	fc050ce3          	beqz	a0,800019f4 <kerneltrap+0x98>
    80001a20:	00050593          	mv	a1,a0
    80001a24:	00002517          	auipc	a0,0x2
    80001a28:	6cc50513          	addi	a0,a0,1740 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001a2c:	00000097          	auipc	ra,0x0
    80001a30:	7ec080e7          	jalr	2028(ra) # 80002218 <__printf>
    80001a34:	01013403          	ld	s0,16(sp)
    80001a38:	01813083          	ld	ra,24(sp)
    80001a3c:	00048513          	mv	a0,s1
    80001a40:	00813483          	ld	s1,8(sp)
    80001a44:	02010113          	addi	sp,sp,32
    80001a48:	00000317          	auipc	t1,0x0
    80001a4c:	3c430067          	jr	964(t1) # 80001e0c <plic_complete>
    80001a50:	00004517          	auipc	a0,0x4
    80001a54:	9f050513          	addi	a0,a0,-1552 # 80005440 <tickslock>
    80001a58:	00001097          	auipc	ra,0x1
    80001a5c:	494080e7          	jalr	1172(ra) # 80002eec <acquire>
    80001a60:	00003717          	auipc	a4,0x3
    80001a64:	8f470713          	addi	a4,a4,-1804 # 80004354 <ticks>
    80001a68:	00072783          	lw	a5,0(a4)
    80001a6c:	00004517          	auipc	a0,0x4
    80001a70:	9d450513          	addi	a0,a0,-1580 # 80005440 <tickslock>
    80001a74:	0017879b          	addiw	a5,a5,1
    80001a78:	00f72023          	sw	a5,0(a4)
    80001a7c:	00001097          	auipc	ra,0x1
    80001a80:	53c080e7          	jalr	1340(ra) # 80002fb8 <release>
    80001a84:	f65ff06f          	j	800019e8 <kerneltrap+0x8c>
    80001a88:	00001097          	auipc	ra,0x1
    80001a8c:	098080e7          	jalr	152(ra) # 80002b20 <uartintr>
    80001a90:	fa5ff06f          	j	80001a34 <kerneltrap+0xd8>
    80001a94:	00002517          	auipc	a0,0x2
    80001a98:	63c50513          	addi	a0,a0,1596 # 800040d0 <CONSOLE_STATUS+0xc0>
    80001a9c:	00000097          	auipc	ra,0x0
    80001aa0:	720080e7          	jalr	1824(ra) # 800021bc <panic>

0000000080001aa4 <clockintr>:
    80001aa4:	fe010113          	addi	sp,sp,-32
    80001aa8:	00813823          	sd	s0,16(sp)
    80001aac:	00913423          	sd	s1,8(sp)
    80001ab0:	00113c23          	sd	ra,24(sp)
    80001ab4:	02010413          	addi	s0,sp,32
    80001ab8:	00004497          	auipc	s1,0x4
    80001abc:	98848493          	addi	s1,s1,-1656 # 80005440 <tickslock>
    80001ac0:	00048513          	mv	a0,s1
    80001ac4:	00001097          	auipc	ra,0x1
    80001ac8:	428080e7          	jalr	1064(ra) # 80002eec <acquire>
    80001acc:	00003717          	auipc	a4,0x3
    80001ad0:	88870713          	addi	a4,a4,-1912 # 80004354 <ticks>
    80001ad4:	00072783          	lw	a5,0(a4)
    80001ad8:	01013403          	ld	s0,16(sp)
    80001adc:	01813083          	ld	ra,24(sp)
    80001ae0:	00048513          	mv	a0,s1
    80001ae4:	0017879b          	addiw	a5,a5,1
    80001ae8:	00813483          	ld	s1,8(sp)
    80001aec:	00f72023          	sw	a5,0(a4)
    80001af0:	02010113          	addi	sp,sp,32
    80001af4:	00001317          	auipc	t1,0x1
    80001af8:	4c430067          	jr	1220(t1) # 80002fb8 <release>

0000000080001afc <devintr>:
    80001afc:	142027f3          	csrr	a5,scause
    80001b00:	00000513          	li	a0,0
    80001b04:	0007c463          	bltz	a5,80001b0c <devintr+0x10>
    80001b08:	00008067          	ret
    80001b0c:	fe010113          	addi	sp,sp,-32
    80001b10:	00813823          	sd	s0,16(sp)
    80001b14:	00113c23          	sd	ra,24(sp)
    80001b18:	00913423          	sd	s1,8(sp)
    80001b1c:	02010413          	addi	s0,sp,32
    80001b20:	0ff7f713          	andi	a4,a5,255
    80001b24:	00900693          	li	a3,9
    80001b28:	04d70c63          	beq	a4,a3,80001b80 <devintr+0x84>
    80001b2c:	fff00713          	li	a4,-1
    80001b30:	03f71713          	slli	a4,a4,0x3f
    80001b34:	00170713          	addi	a4,a4,1
    80001b38:	00e78c63          	beq	a5,a4,80001b50 <devintr+0x54>
    80001b3c:	01813083          	ld	ra,24(sp)
    80001b40:	01013403          	ld	s0,16(sp)
    80001b44:	00813483          	ld	s1,8(sp)
    80001b48:	02010113          	addi	sp,sp,32
    80001b4c:	00008067          	ret
    80001b50:	00000097          	auipc	ra,0x0
    80001b54:	c8c080e7          	jalr	-884(ra) # 800017dc <cpuid>
    80001b58:	06050663          	beqz	a0,80001bc4 <devintr+0xc8>
    80001b5c:	144027f3          	csrr	a5,sip
    80001b60:	ffd7f793          	andi	a5,a5,-3
    80001b64:	14479073          	csrw	sip,a5
    80001b68:	01813083          	ld	ra,24(sp)
    80001b6c:	01013403          	ld	s0,16(sp)
    80001b70:	00813483          	ld	s1,8(sp)
    80001b74:	00200513          	li	a0,2
    80001b78:	02010113          	addi	sp,sp,32
    80001b7c:	00008067          	ret
    80001b80:	00000097          	auipc	ra,0x0
    80001b84:	254080e7          	jalr	596(ra) # 80001dd4 <plic_claim>
    80001b88:	00a00793          	li	a5,10
    80001b8c:	00050493          	mv	s1,a0
    80001b90:	06f50663          	beq	a0,a5,80001bfc <devintr+0x100>
    80001b94:	00100513          	li	a0,1
    80001b98:	fa0482e3          	beqz	s1,80001b3c <devintr+0x40>
    80001b9c:	00048593          	mv	a1,s1
    80001ba0:	00002517          	auipc	a0,0x2
    80001ba4:	55050513          	addi	a0,a0,1360 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001ba8:	00000097          	auipc	ra,0x0
    80001bac:	670080e7          	jalr	1648(ra) # 80002218 <__printf>
    80001bb0:	00048513          	mv	a0,s1
    80001bb4:	00000097          	auipc	ra,0x0
    80001bb8:	258080e7          	jalr	600(ra) # 80001e0c <plic_complete>
    80001bbc:	00100513          	li	a0,1
    80001bc0:	f7dff06f          	j	80001b3c <devintr+0x40>
    80001bc4:	00004517          	auipc	a0,0x4
    80001bc8:	87c50513          	addi	a0,a0,-1924 # 80005440 <tickslock>
    80001bcc:	00001097          	auipc	ra,0x1
    80001bd0:	320080e7          	jalr	800(ra) # 80002eec <acquire>
    80001bd4:	00002717          	auipc	a4,0x2
    80001bd8:	78070713          	addi	a4,a4,1920 # 80004354 <ticks>
    80001bdc:	00072783          	lw	a5,0(a4)
    80001be0:	00004517          	auipc	a0,0x4
    80001be4:	86050513          	addi	a0,a0,-1952 # 80005440 <tickslock>
    80001be8:	0017879b          	addiw	a5,a5,1
    80001bec:	00f72023          	sw	a5,0(a4)
    80001bf0:	00001097          	auipc	ra,0x1
    80001bf4:	3c8080e7          	jalr	968(ra) # 80002fb8 <release>
    80001bf8:	f65ff06f          	j	80001b5c <devintr+0x60>
    80001bfc:	00001097          	auipc	ra,0x1
    80001c00:	f24080e7          	jalr	-220(ra) # 80002b20 <uartintr>
    80001c04:	fadff06f          	j	80001bb0 <devintr+0xb4>
	...

0000000080001c10 <kernelvec>:
    80001c10:	f0010113          	addi	sp,sp,-256
    80001c14:	00113023          	sd	ra,0(sp)
    80001c18:	00213423          	sd	sp,8(sp)
    80001c1c:	00313823          	sd	gp,16(sp)
    80001c20:	00413c23          	sd	tp,24(sp)
    80001c24:	02513023          	sd	t0,32(sp)
    80001c28:	02613423          	sd	t1,40(sp)
    80001c2c:	02713823          	sd	t2,48(sp)
    80001c30:	02813c23          	sd	s0,56(sp)
    80001c34:	04913023          	sd	s1,64(sp)
    80001c38:	04a13423          	sd	a0,72(sp)
    80001c3c:	04b13823          	sd	a1,80(sp)
    80001c40:	04c13c23          	sd	a2,88(sp)
    80001c44:	06d13023          	sd	a3,96(sp)
    80001c48:	06e13423          	sd	a4,104(sp)
    80001c4c:	06f13823          	sd	a5,112(sp)
    80001c50:	07013c23          	sd	a6,120(sp)
    80001c54:	09113023          	sd	a7,128(sp)
    80001c58:	09213423          	sd	s2,136(sp)
    80001c5c:	09313823          	sd	s3,144(sp)
    80001c60:	09413c23          	sd	s4,152(sp)
    80001c64:	0b513023          	sd	s5,160(sp)
    80001c68:	0b613423          	sd	s6,168(sp)
    80001c6c:	0b713823          	sd	s7,176(sp)
    80001c70:	0b813c23          	sd	s8,184(sp)
    80001c74:	0d913023          	sd	s9,192(sp)
    80001c78:	0da13423          	sd	s10,200(sp)
    80001c7c:	0db13823          	sd	s11,208(sp)
    80001c80:	0dc13c23          	sd	t3,216(sp)
    80001c84:	0fd13023          	sd	t4,224(sp)
    80001c88:	0fe13423          	sd	t5,232(sp)
    80001c8c:	0ff13823          	sd	t6,240(sp)
    80001c90:	ccdff0ef          	jal	ra,8000195c <kerneltrap>
    80001c94:	00013083          	ld	ra,0(sp)
    80001c98:	00813103          	ld	sp,8(sp)
    80001c9c:	01013183          	ld	gp,16(sp)
    80001ca0:	02013283          	ld	t0,32(sp)
    80001ca4:	02813303          	ld	t1,40(sp)
    80001ca8:	03013383          	ld	t2,48(sp)
    80001cac:	03813403          	ld	s0,56(sp)
    80001cb0:	04013483          	ld	s1,64(sp)
    80001cb4:	04813503          	ld	a0,72(sp)
    80001cb8:	05013583          	ld	a1,80(sp)
    80001cbc:	05813603          	ld	a2,88(sp)
    80001cc0:	06013683          	ld	a3,96(sp)
    80001cc4:	06813703          	ld	a4,104(sp)
    80001cc8:	07013783          	ld	a5,112(sp)
    80001ccc:	07813803          	ld	a6,120(sp)
    80001cd0:	08013883          	ld	a7,128(sp)
    80001cd4:	08813903          	ld	s2,136(sp)
    80001cd8:	09013983          	ld	s3,144(sp)
    80001cdc:	09813a03          	ld	s4,152(sp)
    80001ce0:	0a013a83          	ld	s5,160(sp)
    80001ce4:	0a813b03          	ld	s6,168(sp)
    80001ce8:	0b013b83          	ld	s7,176(sp)
    80001cec:	0b813c03          	ld	s8,184(sp)
    80001cf0:	0c013c83          	ld	s9,192(sp)
    80001cf4:	0c813d03          	ld	s10,200(sp)
    80001cf8:	0d013d83          	ld	s11,208(sp)
    80001cfc:	0d813e03          	ld	t3,216(sp)
    80001d00:	0e013e83          	ld	t4,224(sp)
    80001d04:	0e813f03          	ld	t5,232(sp)
    80001d08:	0f013f83          	ld	t6,240(sp)
    80001d0c:	10010113          	addi	sp,sp,256
    80001d10:	10200073          	sret
    80001d14:	00000013          	nop
    80001d18:	00000013          	nop
    80001d1c:	00000013          	nop

0000000080001d20 <timervec>:
    80001d20:	34051573          	csrrw	a0,mscratch,a0
    80001d24:	00b53023          	sd	a1,0(a0)
    80001d28:	00c53423          	sd	a2,8(a0)
    80001d2c:	00d53823          	sd	a3,16(a0)
    80001d30:	01853583          	ld	a1,24(a0)
    80001d34:	02053603          	ld	a2,32(a0)
    80001d38:	0005b683          	ld	a3,0(a1)
    80001d3c:	00c686b3          	add	a3,a3,a2
    80001d40:	00d5b023          	sd	a3,0(a1)
    80001d44:	00200593          	li	a1,2
    80001d48:	14459073          	csrw	sip,a1
    80001d4c:	01053683          	ld	a3,16(a0)
    80001d50:	00853603          	ld	a2,8(a0)
    80001d54:	00053583          	ld	a1,0(a0)
    80001d58:	34051573          	csrrw	a0,mscratch,a0
    80001d5c:	30200073          	mret

0000000080001d60 <plicinit>:
    80001d60:	ff010113          	addi	sp,sp,-16
    80001d64:	00813423          	sd	s0,8(sp)
    80001d68:	01010413          	addi	s0,sp,16
    80001d6c:	00813403          	ld	s0,8(sp)
    80001d70:	0c0007b7          	lui	a5,0xc000
    80001d74:	00100713          	li	a4,1
    80001d78:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80001d7c:	00e7a223          	sw	a4,4(a5)
    80001d80:	01010113          	addi	sp,sp,16
    80001d84:	00008067          	ret

0000000080001d88 <plicinithart>:
    80001d88:	ff010113          	addi	sp,sp,-16
    80001d8c:	00813023          	sd	s0,0(sp)
    80001d90:	00113423          	sd	ra,8(sp)
    80001d94:	01010413          	addi	s0,sp,16
    80001d98:	00000097          	auipc	ra,0x0
    80001d9c:	a44080e7          	jalr	-1468(ra) # 800017dc <cpuid>
    80001da0:	0085171b          	slliw	a4,a0,0x8
    80001da4:	0c0027b7          	lui	a5,0xc002
    80001da8:	00e787b3          	add	a5,a5,a4
    80001dac:	40200713          	li	a4,1026
    80001db0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001db4:	00813083          	ld	ra,8(sp)
    80001db8:	00013403          	ld	s0,0(sp)
    80001dbc:	00d5151b          	slliw	a0,a0,0xd
    80001dc0:	0c2017b7          	lui	a5,0xc201
    80001dc4:	00a78533          	add	a0,a5,a0
    80001dc8:	00052023          	sw	zero,0(a0)
    80001dcc:	01010113          	addi	sp,sp,16
    80001dd0:	00008067          	ret

0000000080001dd4 <plic_claim>:
    80001dd4:	ff010113          	addi	sp,sp,-16
    80001dd8:	00813023          	sd	s0,0(sp)
    80001ddc:	00113423          	sd	ra,8(sp)
    80001de0:	01010413          	addi	s0,sp,16
    80001de4:	00000097          	auipc	ra,0x0
    80001de8:	9f8080e7          	jalr	-1544(ra) # 800017dc <cpuid>
    80001dec:	00813083          	ld	ra,8(sp)
    80001df0:	00013403          	ld	s0,0(sp)
    80001df4:	00d5151b          	slliw	a0,a0,0xd
    80001df8:	0c2017b7          	lui	a5,0xc201
    80001dfc:	00a78533          	add	a0,a5,a0
    80001e00:	00452503          	lw	a0,4(a0)
    80001e04:	01010113          	addi	sp,sp,16
    80001e08:	00008067          	ret

0000000080001e0c <plic_complete>:
    80001e0c:	fe010113          	addi	sp,sp,-32
    80001e10:	00813823          	sd	s0,16(sp)
    80001e14:	00913423          	sd	s1,8(sp)
    80001e18:	00113c23          	sd	ra,24(sp)
    80001e1c:	02010413          	addi	s0,sp,32
    80001e20:	00050493          	mv	s1,a0
    80001e24:	00000097          	auipc	ra,0x0
    80001e28:	9b8080e7          	jalr	-1608(ra) # 800017dc <cpuid>
    80001e2c:	01813083          	ld	ra,24(sp)
    80001e30:	01013403          	ld	s0,16(sp)
    80001e34:	00d5179b          	slliw	a5,a0,0xd
    80001e38:	0c201737          	lui	a4,0xc201
    80001e3c:	00f707b3          	add	a5,a4,a5
    80001e40:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001e44:	00813483          	ld	s1,8(sp)
    80001e48:	02010113          	addi	sp,sp,32
    80001e4c:	00008067          	ret

0000000080001e50 <consolewrite>:
    80001e50:	fb010113          	addi	sp,sp,-80
    80001e54:	04813023          	sd	s0,64(sp)
    80001e58:	04113423          	sd	ra,72(sp)
    80001e5c:	02913c23          	sd	s1,56(sp)
    80001e60:	03213823          	sd	s2,48(sp)
    80001e64:	03313423          	sd	s3,40(sp)
    80001e68:	03413023          	sd	s4,32(sp)
    80001e6c:	01513c23          	sd	s5,24(sp)
    80001e70:	05010413          	addi	s0,sp,80
    80001e74:	06c05c63          	blez	a2,80001eec <consolewrite+0x9c>
    80001e78:	00060993          	mv	s3,a2
    80001e7c:	00050a13          	mv	s4,a0
    80001e80:	00058493          	mv	s1,a1
    80001e84:	00000913          	li	s2,0
    80001e88:	fff00a93          	li	s5,-1
    80001e8c:	01c0006f          	j	80001ea8 <consolewrite+0x58>
    80001e90:	fbf44503          	lbu	a0,-65(s0)
    80001e94:	0019091b          	addiw	s2,s2,1
    80001e98:	00148493          	addi	s1,s1,1
    80001e9c:	00001097          	auipc	ra,0x1
    80001ea0:	a9c080e7          	jalr	-1380(ra) # 80002938 <uartputc>
    80001ea4:	03298063          	beq	s3,s2,80001ec4 <consolewrite+0x74>
    80001ea8:	00048613          	mv	a2,s1
    80001eac:	00100693          	li	a3,1
    80001eb0:	000a0593          	mv	a1,s4
    80001eb4:	fbf40513          	addi	a0,s0,-65
    80001eb8:	00000097          	auipc	ra,0x0
    80001ebc:	9dc080e7          	jalr	-1572(ra) # 80001894 <either_copyin>
    80001ec0:	fd5518e3          	bne	a0,s5,80001e90 <consolewrite+0x40>
    80001ec4:	04813083          	ld	ra,72(sp)
    80001ec8:	04013403          	ld	s0,64(sp)
    80001ecc:	03813483          	ld	s1,56(sp)
    80001ed0:	02813983          	ld	s3,40(sp)
    80001ed4:	02013a03          	ld	s4,32(sp)
    80001ed8:	01813a83          	ld	s5,24(sp)
    80001edc:	00090513          	mv	a0,s2
    80001ee0:	03013903          	ld	s2,48(sp)
    80001ee4:	05010113          	addi	sp,sp,80
    80001ee8:	00008067          	ret
    80001eec:	00000913          	li	s2,0
    80001ef0:	fd5ff06f          	j	80001ec4 <consolewrite+0x74>

0000000080001ef4 <consoleread>:
    80001ef4:	f9010113          	addi	sp,sp,-112
    80001ef8:	06813023          	sd	s0,96(sp)
    80001efc:	04913c23          	sd	s1,88(sp)
    80001f00:	05213823          	sd	s2,80(sp)
    80001f04:	05313423          	sd	s3,72(sp)
    80001f08:	05413023          	sd	s4,64(sp)
    80001f0c:	03513c23          	sd	s5,56(sp)
    80001f10:	03613823          	sd	s6,48(sp)
    80001f14:	03713423          	sd	s7,40(sp)
    80001f18:	03813023          	sd	s8,32(sp)
    80001f1c:	06113423          	sd	ra,104(sp)
    80001f20:	01913c23          	sd	s9,24(sp)
    80001f24:	07010413          	addi	s0,sp,112
    80001f28:	00060b93          	mv	s7,a2
    80001f2c:	00050913          	mv	s2,a0
    80001f30:	00058c13          	mv	s8,a1
    80001f34:	00060b1b          	sext.w	s6,a2
    80001f38:	00003497          	auipc	s1,0x3
    80001f3c:	52048493          	addi	s1,s1,1312 # 80005458 <cons>
    80001f40:	00400993          	li	s3,4
    80001f44:	fff00a13          	li	s4,-1
    80001f48:	00a00a93          	li	s5,10
    80001f4c:	05705e63          	blez	s7,80001fa8 <consoleread+0xb4>
    80001f50:	09c4a703          	lw	a4,156(s1)
    80001f54:	0984a783          	lw	a5,152(s1)
    80001f58:	0007071b          	sext.w	a4,a4
    80001f5c:	08e78463          	beq	a5,a4,80001fe4 <consoleread+0xf0>
    80001f60:	07f7f713          	andi	a4,a5,127
    80001f64:	00e48733          	add	a4,s1,a4
    80001f68:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001f6c:	0017869b          	addiw	a3,a5,1
    80001f70:	08d4ac23          	sw	a3,152(s1)
    80001f74:	00070c9b          	sext.w	s9,a4
    80001f78:	0b370663          	beq	a4,s3,80002024 <consoleread+0x130>
    80001f7c:	00100693          	li	a3,1
    80001f80:	f9f40613          	addi	a2,s0,-97
    80001f84:	000c0593          	mv	a1,s8
    80001f88:	00090513          	mv	a0,s2
    80001f8c:	f8e40fa3          	sb	a4,-97(s0)
    80001f90:	00000097          	auipc	ra,0x0
    80001f94:	8b8080e7          	jalr	-1864(ra) # 80001848 <either_copyout>
    80001f98:	01450863          	beq	a0,s4,80001fa8 <consoleread+0xb4>
    80001f9c:	001c0c13          	addi	s8,s8,1
    80001fa0:	fffb8b9b          	addiw	s7,s7,-1
    80001fa4:	fb5c94e3          	bne	s9,s5,80001f4c <consoleread+0x58>
    80001fa8:	000b851b          	sext.w	a0,s7
    80001fac:	06813083          	ld	ra,104(sp)
    80001fb0:	06013403          	ld	s0,96(sp)
    80001fb4:	05813483          	ld	s1,88(sp)
    80001fb8:	05013903          	ld	s2,80(sp)
    80001fbc:	04813983          	ld	s3,72(sp)
    80001fc0:	04013a03          	ld	s4,64(sp)
    80001fc4:	03813a83          	ld	s5,56(sp)
    80001fc8:	02813b83          	ld	s7,40(sp)
    80001fcc:	02013c03          	ld	s8,32(sp)
    80001fd0:	01813c83          	ld	s9,24(sp)
    80001fd4:	40ab053b          	subw	a0,s6,a0
    80001fd8:	03013b03          	ld	s6,48(sp)
    80001fdc:	07010113          	addi	sp,sp,112
    80001fe0:	00008067          	ret
    80001fe4:	00001097          	auipc	ra,0x1
    80001fe8:	1d8080e7          	jalr	472(ra) # 800031bc <push_on>
    80001fec:	0984a703          	lw	a4,152(s1)
    80001ff0:	09c4a783          	lw	a5,156(s1)
    80001ff4:	0007879b          	sext.w	a5,a5
    80001ff8:	fef70ce3          	beq	a4,a5,80001ff0 <consoleread+0xfc>
    80001ffc:	00001097          	auipc	ra,0x1
    80002000:	234080e7          	jalr	564(ra) # 80003230 <pop_on>
    80002004:	0984a783          	lw	a5,152(s1)
    80002008:	07f7f713          	andi	a4,a5,127
    8000200c:	00e48733          	add	a4,s1,a4
    80002010:	01874703          	lbu	a4,24(a4)
    80002014:	0017869b          	addiw	a3,a5,1
    80002018:	08d4ac23          	sw	a3,152(s1)
    8000201c:	00070c9b          	sext.w	s9,a4
    80002020:	f5371ee3          	bne	a4,s3,80001f7c <consoleread+0x88>
    80002024:	000b851b          	sext.w	a0,s7
    80002028:	f96bf2e3          	bgeu	s7,s6,80001fac <consoleread+0xb8>
    8000202c:	08f4ac23          	sw	a5,152(s1)
    80002030:	f7dff06f          	j	80001fac <consoleread+0xb8>

0000000080002034 <consputc>:
    80002034:	10000793          	li	a5,256
    80002038:	00f50663          	beq	a0,a5,80002044 <consputc+0x10>
    8000203c:	00001317          	auipc	t1,0x1
    80002040:	9f430067          	jr	-1548(t1) # 80002a30 <uartputc_sync>
    80002044:	ff010113          	addi	sp,sp,-16
    80002048:	00113423          	sd	ra,8(sp)
    8000204c:	00813023          	sd	s0,0(sp)
    80002050:	01010413          	addi	s0,sp,16
    80002054:	00800513          	li	a0,8
    80002058:	00001097          	auipc	ra,0x1
    8000205c:	9d8080e7          	jalr	-1576(ra) # 80002a30 <uartputc_sync>
    80002060:	02000513          	li	a0,32
    80002064:	00001097          	auipc	ra,0x1
    80002068:	9cc080e7          	jalr	-1588(ra) # 80002a30 <uartputc_sync>
    8000206c:	00013403          	ld	s0,0(sp)
    80002070:	00813083          	ld	ra,8(sp)
    80002074:	00800513          	li	a0,8
    80002078:	01010113          	addi	sp,sp,16
    8000207c:	00001317          	auipc	t1,0x1
    80002080:	9b430067          	jr	-1612(t1) # 80002a30 <uartputc_sync>

0000000080002084 <consoleintr>:
    80002084:	fe010113          	addi	sp,sp,-32
    80002088:	00813823          	sd	s0,16(sp)
    8000208c:	00913423          	sd	s1,8(sp)
    80002090:	01213023          	sd	s2,0(sp)
    80002094:	00113c23          	sd	ra,24(sp)
    80002098:	02010413          	addi	s0,sp,32
    8000209c:	00003917          	auipc	s2,0x3
    800020a0:	3bc90913          	addi	s2,s2,956 # 80005458 <cons>
    800020a4:	00050493          	mv	s1,a0
    800020a8:	00090513          	mv	a0,s2
    800020ac:	00001097          	auipc	ra,0x1
    800020b0:	e40080e7          	jalr	-448(ra) # 80002eec <acquire>
    800020b4:	02048c63          	beqz	s1,800020ec <consoleintr+0x68>
    800020b8:	0a092783          	lw	a5,160(s2)
    800020bc:	09892703          	lw	a4,152(s2)
    800020c0:	07f00693          	li	a3,127
    800020c4:	40e7873b          	subw	a4,a5,a4
    800020c8:	02e6e263          	bltu	a3,a4,800020ec <consoleintr+0x68>
    800020cc:	00d00713          	li	a4,13
    800020d0:	04e48063          	beq	s1,a4,80002110 <consoleintr+0x8c>
    800020d4:	07f7f713          	andi	a4,a5,127
    800020d8:	00e90733          	add	a4,s2,a4
    800020dc:	0017879b          	addiw	a5,a5,1
    800020e0:	0af92023          	sw	a5,160(s2)
    800020e4:	00970c23          	sb	s1,24(a4)
    800020e8:	08f92e23          	sw	a5,156(s2)
    800020ec:	01013403          	ld	s0,16(sp)
    800020f0:	01813083          	ld	ra,24(sp)
    800020f4:	00813483          	ld	s1,8(sp)
    800020f8:	00013903          	ld	s2,0(sp)
    800020fc:	00003517          	auipc	a0,0x3
    80002100:	35c50513          	addi	a0,a0,860 # 80005458 <cons>
    80002104:	02010113          	addi	sp,sp,32
    80002108:	00001317          	auipc	t1,0x1
    8000210c:	eb030067          	jr	-336(t1) # 80002fb8 <release>
    80002110:	00a00493          	li	s1,10
    80002114:	fc1ff06f          	j	800020d4 <consoleintr+0x50>

0000000080002118 <consoleinit>:
    80002118:	fe010113          	addi	sp,sp,-32
    8000211c:	00113c23          	sd	ra,24(sp)
    80002120:	00813823          	sd	s0,16(sp)
    80002124:	00913423          	sd	s1,8(sp)
    80002128:	02010413          	addi	s0,sp,32
    8000212c:	00003497          	auipc	s1,0x3
    80002130:	32c48493          	addi	s1,s1,812 # 80005458 <cons>
    80002134:	00048513          	mv	a0,s1
    80002138:	00002597          	auipc	a1,0x2
    8000213c:	01058593          	addi	a1,a1,16 # 80004148 <CONSOLE_STATUS+0x138>
    80002140:	00001097          	auipc	ra,0x1
    80002144:	d88080e7          	jalr	-632(ra) # 80002ec8 <initlock>
    80002148:	00000097          	auipc	ra,0x0
    8000214c:	7ac080e7          	jalr	1964(ra) # 800028f4 <uartinit>
    80002150:	01813083          	ld	ra,24(sp)
    80002154:	01013403          	ld	s0,16(sp)
    80002158:	00000797          	auipc	a5,0x0
    8000215c:	d9c78793          	addi	a5,a5,-612 # 80001ef4 <consoleread>
    80002160:	0af4bc23          	sd	a5,184(s1)
    80002164:	00000797          	auipc	a5,0x0
    80002168:	cec78793          	addi	a5,a5,-788 # 80001e50 <consolewrite>
    8000216c:	0cf4b023          	sd	a5,192(s1)
    80002170:	00813483          	ld	s1,8(sp)
    80002174:	02010113          	addi	sp,sp,32
    80002178:	00008067          	ret

000000008000217c <console_read>:
    8000217c:	ff010113          	addi	sp,sp,-16
    80002180:	00813423          	sd	s0,8(sp)
    80002184:	01010413          	addi	s0,sp,16
    80002188:	00813403          	ld	s0,8(sp)
    8000218c:	00003317          	auipc	t1,0x3
    80002190:	38433303          	ld	t1,900(t1) # 80005510 <devsw+0x10>
    80002194:	01010113          	addi	sp,sp,16
    80002198:	00030067          	jr	t1

000000008000219c <console_write>:
    8000219c:	ff010113          	addi	sp,sp,-16
    800021a0:	00813423          	sd	s0,8(sp)
    800021a4:	01010413          	addi	s0,sp,16
    800021a8:	00813403          	ld	s0,8(sp)
    800021ac:	00003317          	auipc	t1,0x3
    800021b0:	36c33303          	ld	t1,876(t1) # 80005518 <devsw+0x18>
    800021b4:	01010113          	addi	sp,sp,16
    800021b8:	00030067          	jr	t1

00000000800021bc <panic>:
    800021bc:	fe010113          	addi	sp,sp,-32
    800021c0:	00113c23          	sd	ra,24(sp)
    800021c4:	00813823          	sd	s0,16(sp)
    800021c8:	00913423          	sd	s1,8(sp)
    800021cc:	02010413          	addi	s0,sp,32
    800021d0:	00050493          	mv	s1,a0
    800021d4:	00002517          	auipc	a0,0x2
    800021d8:	f7c50513          	addi	a0,a0,-132 # 80004150 <CONSOLE_STATUS+0x140>
    800021dc:	00003797          	auipc	a5,0x3
    800021e0:	3c07ae23          	sw	zero,988(a5) # 800055b8 <pr+0x18>
    800021e4:	00000097          	auipc	ra,0x0
    800021e8:	034080e7          	jalr	52(ra) # 80002218 <__printf>
    800021ec:	00048513          	mv	a0,s1
    800021f0:	00000097          	auipc	ra,0x0
    800021f4:	028080e7          	jalr	40(ra) # 80002218 <__printf>
    800021f8:	00002517          	auipc	a0,0x2
    800021fc:	f3850513          	addi	a0,a0,-200 # 80004130 <CONSOLE_STATUS+0x120>
    80002200:	00000097          	auipc	ra,0x0
    80002204:	018080e7          	jalr	24(ra) # 80002218 <__printf>
    80002208:	00100793          	li	a5,1
    8000220c:	00002717          	auipc	a4,0x2
    80002210:	14f72623          	sw	a5,332(a4) # 80004358 <panicked>
    80002214:	0000006f          	j	80002214 <panic+0x58>

0000000080002218 <__printf>:
    80002218:	f3010113          	addi	sp,sp,-208
    8000221c:	08813023          	sd	s0,128(sp)
    80002220:	07313423          	sd	s3,104(sp)
    80002224:	09010413          	addi	s0,sp,144
    80002228:	05813023          	sd	s8,64(sp)
    8000222c:	08113423          	sd	ra,136(sp)
    80002230:	06913c23          	sd	s1,120(sp)
    80002234:	07213823          	sd	s2,112(sp)
    80002238:	07413023          	sd	s4,96(sp)
    8000223c:	05513c23          	sd	s5,88(sp)
    80002240:	05613823          	sd	s6,80(sp)
    80002244:	05713423          	sd	s7,72(sp)
    80002248:	03913c23          	sd	s9,56(sp)
    8000224c:	03a13823          	sd	s10,48(sp)
    80002250:	03b13423          	sd	s11,40(sp)
    80002254:	00003317          	auipc	t1,0x3
    80002258:	34c30313          	addi	t1,t1,844 # 800055a0 <pr>
    8000225c:	01832c03          	lw	s8,24(t1)
    80002260:	00b43423          	sd	a1,8(s0)
    80002264:	00c43823          	sd	a2,16(s0)
    80002268:	00d43c23          	sd	a3,24(s0)
    8000226c:	02e43023          	sd	a4,32(s0)
    80002270:	02f43423          	sd	a5,40(s0)
    80002274:	03043823          	sd	a6,48(s0)
    80002278:	03143c23          	sd	a7,56(s0)
    8000227c:	00050993          	mv	s3,a0
    80002280:	4a0c1663          	bnez	s8,8000272c <__printf+0x514>
    80002284:	60098c63          	beqz	s3,8000289c <__printf+0x684>
    80002288:	0009c503          	lbu	a0,0(s3)
    8000228c:	00840793          	addi	a5,s0,8
    80002290:	f6f43c23          	sd	a5,-136(s0)
    80002294:	00000493          	li	s1,0
    80002298:	22050063          	beqz	a0,800024b8 <__printf+0x2a0>
    8000229c:	00002a37          	lui	s4,0x2
    800022a0:	00018ab7          	lui	s5,0x18
    800022a4:	000f4b37          	lui	s6,0xf4
    800022a8:	00989bb7          	lui	s7,0x989
    800022ac:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800022b0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800022b4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800022b8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800022bc:	00148c9b          	addiw	s9,s1,1
    800022c0:	02500793          	li	a5,37
    800022c4:	01998933          	add	s2,s3,s9
    800022c8:	38f51263          	bne	a0,a5,8000264c <__printf+0x434>
    800022cc:	00094783          	lbu	a5,0(s2)
    800022d0:	00078c9b          	sext.w	s9,a5
    800022d4:	1e078263          	beqz	a5,800024b8 <__printf+0x2a0>
    800022d8:	0024849b          	addiw	s1,s1,2
    800022dc:	07000713          	li	a4,112
    800022e0:	00998933          	add	s2,s3,s1
    800022e4:	38e78a63          	beq	a5,a4,80002678 <__printf+0x460>
    800022e8:	20f76863          	bltu	a4,a5,800024f8 <__printf+0x2e0>
    800022ec:	42a78863          	beq	a5,a0,8000271c <__printf+0x504>
    800022f0:	06400713          	li	a4,100
    800022f4:	40e79663          	bne	a5,a4,80002700 <__printf+0x4e8>
    800022f8:	f7843783          	ld	a5,-136(s0)
    800022fc:	0007a603          	lw	a2,0(a5)
    80002300:	00878793          	addi	a5,a5,8
    80002304:	f6f43c23          	sd	a5,-136(s0)
    80002308:	42064a63          	bltz	a2,8000273c <__printf+0x524>
    8000230c:	00a00713          	li	a4,10
    80002310:	02e677bb          	remuw	a5,a2,a4
    80002314:	00002d97          	auipc	s11,0x2
    80002318:	e64d8d93          	addi	s11,s11,-412 # 80004178 <digits>
    8000231c:	00900593          	li	a1,9
    80002320:	0006051b          	sext.w	a0,a2
    80002324:	00000c93          	li	s9,0
    80002328:	02079793          	slli	a5,a5,0x20
    8000232c:	0207d793          	srli	a5,a5,0x20
    80002330:	00fd87b3          	add	a5,s11,a5
    80002334:	0007c783          	lbu	a5,0(a5)
    80002338:	02e656bb          	divuw	a3,a2,a4
    8000233c:	f8f40023          	sb	a5,-128(s0)
    80002340:	14c5d863          	bge	a1,a2,80002490 <__printf+0x278>
    80002344:	06300593          	li	a1,99
    80002348:	00100c93          	li	s9,1
    8000234c:	02e6f7bb          	remuw	a5,a3,a4
    80002350:	02079793          	slli	a5,a5,0x20
    80002354:	0207d793          	srli	a5,a5,0x20
    80002358:	00fd87b3          	add	a5,s11,a5
    8000235c:	0007c783          	lbu	a5,0(a5)
    80002360:	02e6d73b          	divuw	a4,a3,a4
    80002364:	f8f400a3          	sb	a5,-127(s0)
    80002368:	12a5f463          	bgeu	a1,a0,80002490 <__printf+0x278>
    8000236c:	00a00693          	li	a3,10
    80002370:	00900593          	li	a1,9
    80002374:	02d777bb          	remuw	a5,a4,a3
    80002378:	02079793          	slli	a5,a5,0x20
    8000237c:	0207d793          	srli	a5,a5,0x20
    80002380:	00fd87b3          	add	a5,s11,a5
    80002384:	0007c503          	lbu	a0,0(a5)
    80002388:	02d757bb          	divuw	a5,a4,a3
    8000238c:	f8a40123          	sb	a0,-126(s0)
    80002390:	48e5f263          	bgeu	a1,a4,80002814 <__printf+0x5fc>
    80002394:	06300513          	li	a0,99
    80002398:	02d7f5bb          	remuw	a1,a5,a3
    8000239c:	02059593          	slli	a1,a1,0x20
    800023a0:	0205d593          	srli	a1,a1,0x20
    800023a4:	00bd85b3          	add	a1,s11,a1
    800023a8:	0005c583          	lbu	a1,0(a1)
    800023ac:	02d7d7bb          	divuw	a5,a5,a3
    800023b0:	f8b401a3          	sb	a1,-125(s0)
    800023b4:	48e57263          	bgeu	a0,a4,80002838 <__printf+0x620>
    800023b8:	3e700513          	li	a0,999
    800023bc:	02d7f5bb          	remuw	a1,a5,a3
    800023c0:	02059593          	slli	a1,a1,0x20
    800023c4:	0205d593          	srli	a1,a1,0x20
    800023c8:	00bd85b3          	add	a1,s11,a1
    800023cc:	0005c583          	lbu	a1,0(a1)
    800023d0:	02d7d7bb          	divuw	a5,a5,a3
    800023d4:	f8b40223          	sb	a1,-124(s0)
    800023d8:	46e57663          	bgeu	a0,a4,80002844 <__printf+0x62c>
    800023dc:	02d7f5bb          	remuw	a1,a5,a3
    800023e0:	02059593          	slli	a1,a1,0x20
    800023e4:	0205d593          	srli	a1,a1,0x20
    800023e8:	00bd85b3          	add	a1,s11,a1
    800023ec:	0005c583          	lbu	a1,0(a1)
    800023f0:	02d7d7bb          	divuw	a5,a5,a3
    800023f4:	f8b402a3          	sb	a1,-123(s0)
    800023f8:	46ea7863          	bgeu	s4,a4,80002868 <__printf+0x650>
    800023fc:	02d7f5bb          	remuw	a1,a5,a3
    80002400:	02059593          	slli	a1,a1,0x20
    80002404:	0205d593          	srli	a1,a1,0x20
    80002408:	00bd85b3          	add	a1,s11,a1
    8000240c:	0005c583          	lbu	a1,0(a1)
    80002410:	02d7d7bb          	divuw	a5,a5,a3
    80002414:	f8b40323          	sb	a1,-122(s0)
    80002418:	3eeaf863          	bgeu	s5,a4,80002808 <__printf+0x5f0>
    8000241c:	02d7f5bb          	remuw	a1,a5,a3
    80002420:	02059593          	slli	a1,a1,0x20
    80002424:	0205d593          	srli	a1,a1,0x20
    80002428:	00bd85b3          	add	a1,s11,a1
    8000242c:	0005c583          	lbu	a1,0(a1)
    80002430:	02d7d7bb          	divuw	a5,a5,a3
    80002434:	f8b403a3          	sb	a1,-121(s0)
    80002438:	42eb7e63          	bgeu	s6,a4,80002874 <__printf+0x65c>
    8000243c:	02d7f5bb          	remuw	a1,a5,a3
    80002440:	02059593          	slli	a1,a1,0x20
    80002444:	0205d593          	srli	a1,a1,0x20
    80002448:	00bd85b3          	add	a1,s11,a1
    8000244c:	0005c583          	lbu	a1,0(a1)
    80002450:	02d7d7bb          	divuw	a5,a5,a3
    80002454:	f8b40423          	sb	a1,-120(s0)
    80002458:	42ebfc63          	bgeu	s7,a4,80002890 <__printf+0x678>
    8000245c:	02079793          	slli	a5,a5,0x20
    80002460:	0207d793          	srli	a5,a5,0x20
    80002464:	00fd8db3          	add	s11,s11,a5
    80002468:	000dc703          	lbu	a4,0(s11)
    8000246c:	00a00793          	li	a5,10
    80002470:	00900c93          	li	s9,9
    80002474:	f8e404a3          	sb	a4,-119(s0)
    80002478:	00065c63          	bgez	a2,80002490 <__printf+0x278>
    8000247c:	f9040713          	addi	a4,s0,-112
    80002480:	00f70733          	add	a4,a4,a5
    80002484:	02d00693          	li	a3,45
    80002488:	fed70823          	sb	a3,-16(a4)
    8000248c:	00078c93          	mv	s9,a5
    80002490:	f8040793          	addi	a5,s0,-128
    80002494:	01978cb3          	add	s9,a5,s9
    80002498:	f7f40d13          	addi	s10,s0,-129
    8000249c:	000cc503          	lbu	a0,0(s9)
    800024a0:	fffc8c93          	addi	s9,s9,-1
    800024a4:	00000097          	auipc	ra,0x0
    800024a8:	b90080e7          	jalr	-1136(ra) # 80002034 <consputc>
    800024ac:	ffac98e3          	bne	s9,s10,8000249c <__printf+0x284>
    800024b0:	00094503          	lbu	a0,0(s2)
    800024b4:	e00514e3          	bnez	a0,800022bc <__printf+0xa4>
    800024b8:	1a0c1663          	bnez	s8,80002664 <__printf+0x44c>
    800024bc:	08813083          	ld	ra,136(sp)
    800024c0:	08013403          	ld	s0,128(sp)
    800024c4:	07813483          	ld	s1,120(sp)
    800024c8:	07013903          	ld	s2,112(sp)
    800024cc:	06813983          	ld	s3,104(sp)
    800024d0:	06013a03          	ld	s4,96(sp)
    800024d4:	05813a83          	ld	s5,88(sp)
    800024d8:	05013b03          	ld	s6,80(sp)
    800024dc:	04813b83          	ld	s7,72(sp)
    800024e0:	04013c03          	ld	s8,64(sp)
    800024e4:	03813c83          	ld	s9,56(sp)
    800024e8:	03013d03          	ld	s10,48(sp)
    800024ec:	02813d83          	ld	s11,40(sp)
    800024f0:	0d010113          	addi	sp,sp,208
    800024f4:	00008067          	ret
    800024f8:	07300713          	li	a4,115
    800024fc:	1ce78a63          	beq	a5,a4,800026d0 <__printf+0x4b8>
    80002500:	07800713          	li	a4,120
    80002504:	1ee79e63          	bne	a5,a4,80002700 <__printf+0x4e8>
    80002508:	f7843783          	ld	a5,-136(s0)
    8000250c:	0007a703          	lw	a4,0(a5)
    80002510:	00878793          	addi	a5,a5,8
    80002514:	f6f43c23          	sd	a5,-136(s0)
    80002518:	28074263          	bltz	a4,8000279c <__printf+0x584>
    8000251c:	00002d97          	auipc	s11,0x2
    80002520:	c5cd8d93          	addi	s11,s11,-932 # 80004178 <digits>
    80002524:	00f77793          	andi	a5,a4,15
    80002528:	00fd87b3          	add	a5,s11,a5
    8000252c:	0007c683          	lbu	a3,0(a5)
    80002530:	00f00613          	li	a2,15
    80002534:	0007079b          	sext.w	a5,a4
    80002538:	f8d40023          	sb	a3,-128(s0)
    8000253c:	0047559b          	srliw	a1,a4,0x4
    80002540:	0047569b          	srliw	a3,a4,0x4
    80002544:	00000c93          	li	s9,0
    80002548:	0ee65063          	bge	a2,a4,80002628 <__printf+0x410>
    8000254c:	00f6f693          	andi	a3,a3,15
    80002550:	00dd86b3          	add	a3,s11,a3
    80002554:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002558:	0087d79b          	srliw	a5,a5,0x8
    8000255c:	00100c93          	li	s9,1
    80002560:	f8d400a3          	sb	a3,-127(s0)
    80002564:	0cb67263          	bgeu	a2,a1,80002628 <__printf+0x410>
    80002568:	00f7f693          	andi	a3,a5,15
    8000256c:	00dd86b3          	add	a3,s11,a3
    80002570:	0006c583          	lbu	a1,0(a3)
    80002574:	00f00613          	li	a2,15
    80002578:	0047d69b          	srliw	a3,a5,0x4
    8000257c:	f8b40123          	sb	a1,-126(s0)
    80002580:	0047d593          	srli	a1,a5,0x4
    80002584:	28f67e63          	bgeu	a2,a5,80002820 <__printf+0x608>
    80002588:	00f6f693          	andi	a3,a3,15
    8000258c:	00dd86b3          	add	a3,s11,a3
    80002590:	0006c503          	lbu	a0,0(a3)
    80002594:	0087d813          	srli	a6,a5,0x8
    80002598:	0087d69b          	srliw	a3,a5,0x8
    8000259c:	f8a401a3          	sb	a0,-125(s0)
    800025a0:	28b67663          	bgeu	a2,a1,8000282c <__printf+0x614>
    800025a4:	00f6f693          	andi	a3,a3,15
    800025a8:	00dd86b3          	add	a3,s11,a3
    800025ac:	0006c583          	lbu	a1,0(a3)
    800025b0:	00c7d513          	srli	a0,a5,0xc
    800025b4:	00c7d69b          	srliw	a3,a5,0xc
    800025b8:	f8b40223          	sb	a1,-124(s0)
    800025bc:	29067a63          	bgeu	a2,a6,80002850 <__printf+0x638>
    800025c0:	00f6f693          	andi	a3,a3,15
    800025c4:	00dd86b3          	add	a3,s11,a3
    800025c8:	0006c583          	lbu	a1,0(a3)
    800025cc:	0107d813          	srli	a6,a5,0x10
    800025d0:	0107d69b          	srliw	a3,a5,0x10
    800025d4:	f8b402a3          	sb	a1,-123(s0)
    800025d8:	28a67263          	bgeu	a2,a0,8000285c <__printf+0x644>
    800025dc:	00f6f693          	andi	a3,a3,15
    800025e0:	00dd86b3          	add	a3,s11,a3
    800025e4:	0006c683          	lbu	a3,0(a3)
    800025e8:	0147d79b          	srliw	a5,a5,0x14
    800025ec:	f8d40323          	sb	a3,-122(s0)
    800025f0:	21067663          	bgeu	a2,a6,800027fc <__printf+0x5e4>
    800025f4:	02079793          	slli	a5,a5,0x20
    800025f8:	0207d793          	srli	a5,a5,0x20
    800025fc:	00fd8db3          	add	s11,s11,a5
    80002600:	000dc683          	lbu	a3,0(s11)
    80002604:	00800793          	li	a5,8
    80002608:	00700c93          	li	s9,7
    8000260c:	f8d403a3          	sb	a3,-121(s0)
    80002610:	00075c63          	bgez	a4,80002628 <__printf+0x410>
    80002614:	f9040713          	addi	a4,s0,-112
    80002618:	00f70733          	add	a4,a4,a5
    8000261c:	02d00693          	li	a3,45
    80002620:	fed70823          	sb	a3,-16(a4)
    80002624:	00078c93          	mv	s9,a5
    80002628:	f8040793          	addi	a5,s0,-128
    8000262c:	01978cb3          	add	s9,a5,s9
    80002630:	f7f40d13          	addi	s10,s0,-129
    80002634:	000cc503          	lbu	a0,0(s9)
    80002638:	fffc8c93          	addi	s9,s9,-1
    8000263c:	00000097          	auipc	ra,0x0
    80002640:	9f8080e7          	jalr	-1544(ra) # 80002034 <consputc>
    80002644:	ff9d18e3          	bne	s10,s9,80002634 <__printf+0x41c>
    80002648:	0100006f          	j	80002658 <__printf+0x440>
    8000264c:	00000097          	auipc	ra,0x0
    80002650:	9e8080e7          	jalr	-1560(ra) # 80002034 <consputc>
    80002654:	000c8493          	mv	s1,s9
    80002658:	00094503          	lbu	a0,0(s2)
    8000265c:	c60510e3          	bnez	a0,800022bc <__printf+0xa4>
    80002660:	e40c0ee3          	beqz	s8,800024bc <__printf+0x2a4>
    80002664:	00003517          	auipc	a0,0x3
    80002668:	f3c50513          	addi	a0,a0,-196 # 800055a0 <pr>
    8000266c:	00001097          	auipc	ra,0x1
    80002670:	94c080e7          	jalr	-1716(ra) # 80002fb8 <release>
    80002674:	e49ff06f          	j	800024bc <__printf+0x2a4>
    80002678:	f7843783          	ld	a5,-136(s0)
    8000267c:	03000513          	li	a0,48
    80002680:	01000d13          	li	s10,16
    80002684:	00878713          	addi	a4,a5,8
    80002688:	0007bc83          	ld	s9,0(a5)
    8000268c:	f6e43c23          	sd	a4,-136(s0)
    80002690:	00000097          	auipc	ra,0x0
    80002694:	9a4080e7          	jalr	-1628(ra) # 80002034 <consputc>
    80002698:	07800513          	li	a0,120
    8000269c:	00000097          	auipc	ra,0x0
    800026a0:	998080e7          	jalr	-1640(ra) # 80002034 <consputc>
    800026a4:	00002d97          	auipc	s11,0x2
    800026a8:	ad4d8d93          	addi	s11,s11,-1324 # 80004178 <digits>
    800026ac:	03ccd793          	srli	a5,s9,0x3c
    800026b0:	00fd87b3          	add	a5,s11,a5
    800026b4:	0007c503          	lbu	a0,0(a5)
    800026b8:	fffd0d1b          	addiw	s10,s10,-1
    800026bc:	004c9c93          	slli	s9,s9,0x4
    800026c0:	00000097          	auipc	ra,0x0
    800026c4:	974080e7          	jalr	-1676(ra) # 80002034 <consputc>
    800026c8:	fe0d12e3          	bnez	s10,800026ac <__printf+0x494>
    800026cc:	f8dff06f          	j	80002658 <__printf+0x440>
    800026d0:	f7843783          	ld	a5,-136(s0)
    800026d4:	0007bc83          	ld	s9,0(a5)
    800026d8:	00878793          	addi	a5,a5,8
    800026dc:	f6f43c23          	sd	a5,-136(s0)
    800026e0:	000c9a63          	bnez	s9,800026f4 <__printf+0x4dc>
    800026e4:	1080006f          	j	800027ec <__printf+0x5d4>
    800026e8:	001c8c93          	addi	s9,s9,1
    800026ec:	00000097          	auipc	ra,0x0
    800026f0:	948080e7          	jalr	-1720(ra) # 80002034 <consputc>
    800026f4:	000cc503          	lbu	a0,0(s9)
    800026f8:	fe0518e3          	bnez	a0,800026e8 <__printf+0x4d0>
    800026fc:	f5dff06f          	j	80002658 <__printf+0x440>
    80002700:	02500513          	li	a0,37
    80002704:	00000097          	auipc	ra,0x0
    80002708:	930080e7          	jalr	-1744(ra) # 80002034 <consputc>
    8000270c:	000c8513          	mv	a0,s9
    80002710:	00000097          	auipc	ra,0x0
    80002714:	924080e7          	jalr	-1756(ra) # 80002034 <consputc>
    80002718:	f41ff06f          	j	80002658 <__printf+0x440>
    8000271c:	02500513          	li	a0,37
    80002720:	00000097          	auipc	ra,0x0
    80002724:	914080e7          	jalr	-1772(ra) # 80002034 <consputc>
    80002728:	f31ff06f          	j	80002658 <__printf+0x440>
    8000272c:	00030513          	mv	a0,t1
    80002730:	00000097          	auipc	ra,0x0
    80002734:	7bc080e7          	jalr	1980(ra) # 80002eec <acquire>
    80002738:	b4dff06f          	j	80002284 <__printf+0x6c>
    8000273c:	40c0053b          	negw	a0,a2
    80002740:	00a00713          	li	a4,10
    80002744:	02e576bb          	remuw	a3,a0,a4
    80002748:	00002d97          	auipc	s11,0x2
    8000274c:	a30d8d93          	addi	s11,s11,-1488 # 80004178 <digits>
    80002750:	ff700593          	li	a1,-9
    80002754:	02069693          	slli	a3,a3,0x20
    80002758:	0206d693          	srli	a3,a3,0x20
    8000275c:	00dd86b3          	add	a3,s11,a3
    80002760:	0006c683          	lbu	a3,0(a3)
    80002764:	02e557bb          	divuw	a5,a0,a4
    80002768:	f8d40023          	sb	a3,-128(s0)
    8000276c:	10b65e63          	bge	a2,a1,80002888 <__printf+0x670>
    80002770:	06300593          	li	a1,99
    80002774:	02e7f6bb          	remuw	a3,a5,a4
    80002778:	02069693          	slli	a3,a3,0x20
    8000277c:	0206d693          	srli	a3,a3,0x20
    80002780:	00dd86b3          	add	a3,s11,a3
    80002784:	0006c683          	lbu	a3,0(a3)
    80002788:	02e7d73b          	divuw	a4,a5,a4
    8000278c:	00200793          	li	a5,2
    80002790:	f8d400a3          	sb	a3,-127(s0)
    80002794:	bca5ece3          	bltu	a1,a0,8000236c <__printf+0x154>
    80002798:	ce5ff06f          	j	8000247c <__printf+0x264>
    8000279c:	40e007bb          	negw	a5,a4
    800027a0:	00002d97          	auipc	s11,0x2
    800027a4:	9d8d8d93          	addi	s11,s11,-1576 # 80004178 <digits>
    800027a8:	00f7f693          	andi	a3,a5,15
    800027ac:	00dd86b3          	add	a3,s11,a3
    800027b0:	0006c583          	lbu	a1,0(a3)
    800027b4:	ff100613          	li	a2,-15
    800027b8:	0047d69b          	srliw	a3,a5,0x4
    800027bc:	f8b40023          	sb	a1,-128(s0)
    800027c0:	0047d59b          	srliw	a1,a5,0x4
    800027c4:	0ac75e63          	bge	a4,a2,80002880 <__printf+0x668>
    800027c8:	00f6f693          	andi	a3,a3,15
    800027cc:	00dd86b3          	add	a3,s11,a3
    800027d0:	0006c603          	lbu	a2,0(a3)
    800027d4:	00f00693          	li	a3,15
    800027d8:	0087d79b          	srliw	a5,a5,0x8
    800027dc:	f8c400a3          	sb	a2,-127(s0)
    800027e0:	d8b6e4e3          	bltu	a3,a1,80002568 <__printf+0x350>
    800027e4:	00200793          	li	a5,2
    800027e8:	e2dff06f          	j	80002614 <__printf+0x3fc>
    800027ec:	00002c97          	auipc	s9,0x2
    800027f0:	96cc8c93          	addi	s9,s9,-1684 # 80004158 <CONSOLE_STATUS+0x148>
    800027f4:	02800513          	li	a0,40
    800027f8:	ef1ff06f          	j	800026e8 <__printf+0x4d0>
    800027fc:	00700793          	li	a5,7
    80002800:	00600c93          	li	s9,6
    80002804:	e0dff06f          	j	80002610 <__printf+0x3f8>
    80002808:	00700793          	li	a5,7
    8000280c:	00600c93          	li	s9,6
    80002810:	c69ff06f          	j	80002478 <__printf+0x260>
    80002814:	00300793          	li	a5,3
    80002818:	00200c93          	li	s9,2
    8000281c:	c5dff06f          	j	80002478 <__printf+0x260>
    80002820:	00300793          	li	a5,3
    80002824:	00200c93          	li	s9,2
    80002828:	de9ff06f          	j	80002610 <__printf+0x3f8>
    8000282c:	00400793          	li	a5,4
    80002830:	00300c93          	li	s9,3
    80002834:	dddff06f          	j	80002610 <__printf+0x3f8>
    80002838:	00400793          	li	a5,4
    8000283c:	00300c93          	li	s9,3
    80002840:	c39ff06f          	j	80002478 <__printf+0x260>
    80002844:	00500793          	li	a5,5
    80002848:	00400c93          	li	s9,4
    8000284c:	c2dff06f          	j	80002478 <__printf+0x260>
    80002850:	00500793          	li	a5,5
    80002854:	00400c93          	li	s9,4
    80002858:	db9ff06f          	j	80002610 <__printf+0x3f8>
    8000285c:	00600793          	li	a5,6
    80002860:	00500c93          	li	s9,5
    80002864:	dadff06f          	j	80002610 <__printf+0x3f8>
    80002868:	00600793          	li	a5,6
    8000286c:	00500c93          	li	s9,5
    80002870:	c09ff06f          	j	80002478 <__printf+0x260>
    80002874:	00800793          	li	a5,8
    80002878:	00700c93          	li	s9,7
    8000287c:	bfdff06f          	j	80002478 <__printf+0x260>
    80002880:	00100793          	li	a5,1
    80002884:	d91ff06f          	j	80002614 <__printf+0x3fc>
    80002888:	00100793          	li	a5,1
    8000288c:	bf1ff06f          	j	8000247c <__printf+0x264>
    80002890:	00900793          	li	a5,9
    80002894:	00800c93          	li	s9,8
    80002898:	be1ff06f          	j	80002478 <__printf+0x260>
    8000289c:	00002517          	auipc	a0,0x2
    800028a0:	8c450513          	addi	a0,a0,-1852 # 80004160 <CONSOLE_STATUS+0x150>
    800028a4:	00000097          	auipc	ra,0x0
    800028a8:	918080e7          	jalr	-1768(ra) # 800021bc <panic>

00000000800028ac <printfinit>:
    800028ac:	fe010113          	addi	sp,sp,-32
    800028b0:	00813823          	sd	s0,16(sp)
    800028b4:	00913423          	sd	s1,8(sp)
    800028b8:	00113c23          	sd	ra,24(sp)
    800028bc:	02010413          	addi	s0,sp,32
    800028c0:	00003497          	auipc	s1,0x3
    800028c4:	ce048493          	addi	s1,s1,-800 # 800055a0 <pr>
    800028c8:	00048513          	mv	a0,s1
    800028cc:	00002597          	auipc	a1,0x2
    800028d0:	8a458593          	addi	a1,a1,-1884 # 80004170 <CONSOLE_STATUS+0x160>
    800028d4:	00000097          	auipc	ra,0x0
    800028d8:	5f4080e7          	jalr	1524(ra) # 80002ec8 <initlock>
    800028dc:	01813083          	ld	ra,24(sp)
    800028e0:	01013403          	ld	s0,16(sp)
    800028e4:	0004ac23          	sw	zero,24(s1)
    800028e8:	00813483          	ld	s1,8(sp)
    800028ec:	02010113          	addi	sp,sp,32
    800028f0:	00008067          	ret

00000000800028f4 <uartinit>:
    800028f4:	ff010113          	addi	sp,sp,-16
    800028f8:	00813423          	sd	s0,8(sp)
    800028fc:	01010413          	addi	s0,sp,16
    80002900:	100007b7          	lui	a5,0x10000
    80002904:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002908:	f8000713          	li	a4,-128
    8000290c:	00e781a3          	sb	a4,3(a5)
    80002910:	00300713          	li	a4,3
    80002914:	00e78023          	sb	a4,0(a5)
    80002918:	000780a3          	sb	zero,1(a5)
    8000291c:	00e781a3          	sb	a4,3(a5)
    80002920:	00700693          	li	a3,7
    80002924:	00d78123          	sb	a3,2(a5)
    80002928:	00e780a3          	sb	a4,1(a5)
    8000292c:	00813403          	ld	s0,8(sp)
    80002930:	01010113          	addi	sp,sp,16
    80002934:	00008067          	ret

0000000080002938 <uartputc>:
    80002938:	00002797          	auipc	a5,0x2
    8000293c:	a207a783          	lw	a5,-1504(a5) # 80004358 <panicked>
    80002940:	00078463          	beqz	a5,80002948 <uartputc+0x10>
    80002944:	0000006f          	j	80002944 <uartputc+0xc>
    80002948:	fd010113          	addi	sp,sp,-48
    8000294c:	02813023          	sd	s0,32(sp)
    80002950:	00913c23          	sd	s1,24(sp)
    80002954:	01213823          	sd	s2,16(sp)
    80002958:	01313423          	sd	s3,8(sp)
    8000295c:	02113423          	sd	ra,40(sp)
    80002960:	03010413          	addi	s0,sp,48
    80002964:	00002917          	auipc	s2,0x2
    80002968:	9fc90913          	addi	s2,s2,-1540 # 80004360 <uart_tx_r>
    8000296c:	00093783          	ld	a5,0(s2)
    80002970:	00002497          	auipc	s1,0x2
    80002974:	9f848493          	addi	s1,s1,-1544 # 80004368 <uart_tx_w>
    80002978:	0004b703          	ld	a4,0(s1)
    8000297c:	02078693          	addi	a3,a5,32
    80002980:	00050993          	mv	s3,a0
    80002984:	02e69c63          	bne	a3,a4,800029bc <uartputc+0x84>
    80002988:	00001097          	auipc	ra,0x1
    8000298c:	834080e7          	jalr	-1996(ra) # 800031bc <push_on>
    80002990:	00093783          	ld	a5,0(s2)
    80002994:	0004b703          	ld	a4,0(s1)
    80002998:	02078793          	addi	a5,a5,32
    8000299c:	00e79463          	bne	a5,a4,800029a4 <uartputc+0x6c>
    800029a0:	0000006f          	j	800029a0 <uartputc+0x68>
    800029a4:	00001097          	auipc	ra,0x1
    800029a8:	88c080e7          	jalr	-1908(ra) # 80003230 <pop_on>
    800029ac:	00093783          	ld	a5,0(s2)
    800029b0:	0004b703          	ld	a4,0(s1)
    800029b4:	02078693          	addi	a3,a5,32
    800029b8:	fce688e3          	beq	a3,a4,80002988 <uartputc+0x50>
    800029bc:	01f77693          	andi	a3,a4,31
    800029c0:	00003597          	auipc	a1,0x3
    800029c4:	c0058593          	addi	a1,a1,-1024 # 800055c0 <uart_tx_buf>
    800029c8:	00d586b3          	add	a3,a1,a3
    800029cc:	00170713          	addi	a4,a4,1
    800029d0:	01368023          	sb	s3,0(a3)
    800029d4:	00e4b023          	sd	a4,0(s1)
    800029d8:	10000637          	lui	a2,0x10000
    800029dc:	02f71063          	bne	a4,a5,800029fc <uartputc+0xc4>
    800029e0:	0340006f          	j	80002a14 <uartputc+0xdc>
    800029e4:	00074703          	lbu	a4,0(a4)
    800029e8:	00f93023          	sd	a5,0(s2)
    800029ec:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800029f0:	00093783          	ld	a5,0(s2)
    800029f4:	0004b703          	ld	a4,0(s1)
    800029f8:	00f70e63          	beq	a4,a5,80002a14 <uartputc+0xdc>
    800029fc:	00564683          	lbu	a3,5(a2)
    80002a00:	01f7f713          	andi	a4,a5,31
    80002a04:	00e58733          	add	a4,a1,a4
    80002a08:	0206f693          	andi	a3,a3,32
    80002a0c:	00178793          	addi	a5,a5,1
    80002a10:	fc069ae3          	bnez	a3,800029e4 <uartputc+0xac>
    80002a14:	02813083          	ld	ra,40(sp)
    80002a18:	02013403          	ld	s0,32(sp)
    80002a1c:	01813483          	ld	s1,24(sp)
    80002a20:	01013903          	ld	s2,16(sp)
    80002a24:	00813983          	ld	s3,8(sp)
    80002a28:	03010113          	addi	sp,sp,48
    80002a2c:	00008067          	ret

0000000080002a30 <uartputc_sync>:
    80002a30:	ff010113          	addi	sp,sp,-16
    80002a34:	00813423          	sd	s0,8(sp)
    80002a38:	01010413          	addi	s0,sp,16
    80002a3c:	00002717          	auipc	a4,0x2
    80002a40:	91c72703          	lw	a4,-1764(a4) # 80004358 <panicked>
    80002a44:	02071663          	bnez	a4,80002a70 <uartputc_sync+0x40>
    80002a48:	00050793          	mv	a5,a0
    80002a4c:	100006b7          	lui	a3,0x10000
    80002a50:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002a54:	02077713          	andi	a4,a4,32
    80002a58:	fe070ce3          	beqz	a4,80002a50 <uartputc_sync+0x20>
    80002a5c:	0ff7f793          	andi	a5,a5,255
    80002a60:	00f68023          	sb	a5,0(a3)
    80002a64:	00813403          	ld	s0,8(sp)
    80002a68:	01010113          	addi	sp,sp,16
    80002a6c:	00008067          	ret
    80002a70:	0000006f          	j	80002a70 <uartputc_sync+0x40>

0000000080002a74 <uartstart>:
    80002a74:	ff010113          	addi	sp,sp,-16
    80002a78:	00813423          	sd	s0,8(sp)
    80002a7c:	01010413          	addi	s0,sp,16
    80002a80:	00002617          	auipc	a2,0x2
    80002a84:	8e060613          	addi	a2,a2,-1824 # 80004360 <uart_tx_r>
    80002a88:	00002517          	auipc	a0,0x2
    80002a8c:	8e050513          	addi	a0,a0,-1824 # 80004368 <uart_tx_w>
    80002a90:	00063783          	ld	a5,0(a2)
    80002a94:	00053703          	ld	a4,0(a0)
    80002a98:	04f70263          	beq	a4,a5,80002adc <uartstart+0x68>
    80002a9c:	100005b7          	lui	a1,0x10000
    80002aa0:	00003817          	auipc	a6,0x3
    80002aa4:	b2080813          	addi	a6,a6,-1248 # 800055c0 <uart_tx_buf>
    80002aa8:	01c0006f          	j	80002ac4 <uartstart+0x50>
    80002aac:	0006c703          	lbu	a4,0(a3)
    80002ab0:	00f63023          	sd	a5,0(a2)
    80002ab4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002ab8:	00063783          	ld	a5,0(a2)
    80002abc:	00053703          	ld	a4,0(a0)
    80002ac0:	00f70e63          	beq	a4,a5,80002adc <uartstart+0x68>
    80002ac4:	01f7f713          	andi	a4,a5,31
    80002ac8:	00e806b3          	add	a3,a6,a4
    80002acc:	0055c703          	lbu	a4,5(a1)
    80002ad0:	00178793          	addi	a5,a5,1
    80002ad4:	02077713          	andi	a4,a4,32
    80002ad8:	fc071ae3          	bnez	a4,80002aac <uartstart+0x38>
    80002adc:	00813403          	ld	s0,8(sp)
    80002ae0:	01010113          	addi	sp,sp,16
    80002ae4:	00008067          	ret

0000000080002ae8 <uartgetc>:
    80002ae8:	ff010113          	addi	sp,sp,-16
    80002aec:	00813423          	sd	s0,8(sp)
    80002af0:	01010413          	addi	s0,sp,16
    80002af4:	10000737          	lui	a4,0x10000
    80002af8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80002afc:	0017f793          	andi	a5,a5,1
    80002b00:	00078c63          	beqz	a5,80002b18 <uartgetc+0x30>
    80002b04:	00074503          	lbu	a0,0(a4)
    80002b08:	0ff57513          	andi	a0,a0,255
    80002b0c:	00813403          	ld	s0,8(sp)
    80002b10:	01010113          	addi	sp,sp,16
    80002b14:	00008067          	ret
    80002b18:	fff00513          	li	a0,-1
    80002b1c:	ff1ff06f          	j	80002b0c <uartgetc+0x24>

0000000080002b20 <uartintr>:
    80002b20:	100007b7          	lui	a5,0x10000
    80002b24:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002b28:	0017f793          	andi	a5,a5,1
    80002b2c:	0a078463          	beqz	a5,80002bd4 <uartintr+0xb4>
    80002b30:	fe010113          	addi	sp,sp,-32
    80002b34:	00813823          	sd	s0,16(sp)
    80002b38:	00913423          	sd	s1,8(sp)
    80002b3c:	00113c23          	sd	ra,24(sp)
    80002b40:	02010413          	addi	s0,sp,32
    80002b44:	100004b7          	lui	s1,0x10000
    80002b48:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002b4c:	0ff57513          	andi	a0,a0,255
    80002b50:	fffff097          	auipc	ra,0xfffff
    80002b54:	534080e7          	jalr	1332(ra) # 80002084 <consoleintr>
    80002b58:	0054c783          	lbu	a5,5(s1)
    80002b5c:	0017f793          	andi	a5,a5,1
    80002b60:	fe0794e3          	bnez	a5,80002b48 <uartintr+0x28>
    80002b64:	00001617          	auipc	a2,0x1
    80002b68:	7fc60613          	addi	a2,a2,2044 # 80004360 <uart_tx_r>
    80002b6c:	00001517          	auipc	a0,0x1
    80002b70:	7fc50513          	addi	a0,a0,2044 # 80004368 <uart_tx_w>
    80002b74:	00063783          	ld	a5,0(a2)
    80002b78:	00053703          	ld	a4,0(a0)
    80002b7c:	04f70263          	beq	a4,a5,80002bc0 <uartintr+0xa0>
    80002b80:	100005b7          	lui	a1,0x10000
    80002b84:	00003817          	auipc	a6,0x3
    80002b88:	a3c80813          	addi	a6,a6,-1476 # 800055c0 <uart_tx_buf>
    80002b8c:	01c0006f          	j	80002ba8 <uartintr+0x88>
    80002b90:	0006c703          	lbu	a4,0(a3)
    80002b94:	00f63023          	sd	a5,0(a2)
    80002b98:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002b9c:	00063783          	ld	a5,0(a2)
    80002ba0:	00053703          	ld	a4,0(a0)
    80002ba4:	00f70e63          	beq	a4,a5,80002bc0 <uartintr+0xa0>
    80002ba8:	01f7f713          	andi	a4,a5,31
    80002bac:	00e806b3          	add	a3,a6,a4
    80002bb0:	0055c703          	lbu	a4,5(a1)
    80002bb4:	00178793          	addi	a5,a5,1
    80002bb8:	02077713          	andi	a4,a4,32
    80002bbc:	fc071ae3          	bnez	a4,80002b90 <uartintr+0x70>
    80002bc0:	01813083          	ld	ra,24(sp)
    80002bc4:	01013403          	ld	s0,16(sp)
    80002bc8:	00813483          	ld	s1,8(sp)
    80002bcc:	02010113          	addi	sp,sp,32
    80002bd0:	00008067          	ret
    80002bd4:	00001617          	auipc	a2,0x1
    80002bd8:	78c60613          	addi	a2,a2,1932 # 80004360 <uart_tx_r>
    80002bdc:	00001517          	auipc	a0,0x1
    80002be0:	78c50513          	addi	a0,a0,1932 # 80004368 <uart_tx_w>
    80002be4:	00063783          	ld	a5,0(a2)
    80002be8:	00053703          	ld	a4,0(a0)
    80002bec:	04f70263          	beq	a4,a5,80002c30 <uartintr+0x110>
    80002bf0:	100005b7          	lui	a1,0x10000
    80002bf4:	00003817          	auipc	a6,0x3
    80002bf8:	9cc80813          	addi	a6,a6,-1588 # 800055c0 <uart_tx_buf>
    80002bfc:	01c0006f          	j	80002c18 <uartintr+0xf8>
    80002c00:	0006c703          	lbu	a4,0(a3)
    80002c04:	00f63023          	sd	a5,0(a2)
    80002c08:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002c0c:	00063783          	ld	a5,0(a2)
    80002c10:	00053703          	ld	a4,0(a0)
    80002c14:	02f70063          	beq	a4,a5,80002c34 <uartintr+0x114>
    80002c18:	01f7f713          	andi	a4,a5,31
    80002c1c:	00e806b3          	add	a3,a6,a4
    80002c20:	0055c703          	lbu	a4,5(a1)
    80002c24:	00178793          	addi	a5,a5,1
    80002c28:	02077713          	andi	a4,a4,32
    80002c2c:	fc071ae3          	bnez	a4,80002c00 <uartintr+0xe0>
    80002c30:	00008067          	ret
    80002c34:	00008067          	ret

0000000080002c38 <kinit>:
    80002c38:	fc010113          	addi	sp,sp,-64
    80002c3c:	02913423          	sd	s1,40(sp)
    80002c40:	fffff7b7          	lui	a5,0xfffff
    80002c44:	00004497          	auipc	s1,0x4
    80002c48:	99b48493          	addi	s1,s1,-1637 # 800065df <end+0xfff>
    80002c4c:	02813823          	sd	s0,48(sp)
    80002c50:	01313c23          	sd	s3,24(sp)
    80002c54:	00f4f4b3          	and	s1,s1,a5
    80002c58:	02113c23          	sd	ra,56(sp)
    80002c5c:	03213023          	sd	s2,32(sp)
    80002c60:	01413823          	sd	s4,16(sp)
    80002c64:	01513423          	sd	s5,8(sp)
    80002c68:	04010413          	addi	s0,sp,64
    80002c6c:	000017b7          	lui	a5,0x1
    80002c70:	01100993          	li	s3,17
    80002c74:	00f487b3          	add	a5,s1,a5
    80002c78:	01b99993          	slli	s3,s3,0x1b
    80002c7c:	06f9e063          	bltu	s3,a5,80002cdc <kinit+0xa4>
    80002c80:	00003a97          	auipc	s5,0x3
    80002c84:	960a8a93          	addi	s5,s5,-1696 # 800055e0 <end>
    80002c88:	0754ec63          	bltu	s1,s5,80002d00 <kinit+0xc8>
    80002c8c:	0734fa63          	bgeu	s1,s3,80002d00 <kinit+0xc8>
    80002c90:	00088a37          	lui	s4,0x88
    80002c94:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002c98:	00001917          	auipc	s2,0x1
    80002c9c:	6d890913          	addi	s2,s2,1752 # 80004370 <kmem>
    80002ca0:	00ca1a13          	slli	s4,s4,0xc
    80002ca4:	0140006f          	j	80002cb8 <kinit+0x80>
    80002ca8:	000017b7          	lui	a5,0x1
    80002cac:	00f484b3          	add	s1,s1,a5
    80002cb0:	0554e863          	bltu	s1,s5,80002d00 <kinit+0xc8>
    80002cb4:	0534f663          	bgeu	s1,s3,80002d00 <kinit+0xc8>
    80002cb8:	00001637          	lui	a2,0x1
    80002cbc:	00100593          	li	a1,1
    80002cc0:	00048513          	mv	a0,s1
    80002cc4:	00000097          	auipc	ra,0x0
    80002cc8:	5e4080e7          	jalr	1508(ra) # 800032a8 <__memset>
    80002ccc:	00093783          	ld	a5,0(s2)
    80002cd0:	00f4b023          	sd	a5,0(s1)
    80002cd4:	00993023          	sd	s1,0(s2)
    80002cd8:	fd4498e3          	bne	s1,s4,80002ca8 <kinit+0x70>
    80002cdc:	03813083          	ld	ra,56(sp)
    80002ce0:	03013403          	ld	s0,48(sp)
    80002ce4:	02813483          	ld	s1,40(sp)
    80002ce8:	02013903          	ld	s2,32(sp)
    80002cec:	01813983          	ld	s3,24(sp)
    80002cf0:	01013a03          	ld	s4,16(sp)
    80002cf4:	00813a83          	ld	s5,8(sp)
    80002cf8:	04010113          	addi	sp,sp,64
    80002cfc:	00008067          	ret
    80002d00:	00001517          	auipc	a0,0x1
    80002d04:	49050513          	addi	a0,a0,1168 # 80004190 <digits+0x18>
    80002d08:	fffff097          	auipc	ra,0xfffff
    80002d0c:	4b4080e7          	jalr	1204(ra) # 800021bc <panic>

0000000080002d10 <freerange>:
    80002d10:	fc010113          	addi	sp,sp,-64
    80002d14:	000017b7          	lui	a5,0x1
    80002d18:	02913423          	sd	s1,40(sp)
    80002d1c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002d20:	009504b3          	add	s1,a0,s1
    80002d24:	fffff537          	lui	a0,0xfffff
    80002d28:	02813823          	sd	s0,48(sp)
    80002d2c:	02113c23          	sd	ra,56(sp)
    80002d30:	03213023          	sd	s2,32(sp)
    80002d34:	01313c23          	sd	s3,24(sp)
    80002d38:	01413823          	sd	s4,16(sp)
    80002d3c:	01513423          	sd	s5,8(sp)
    80002d40:	01613023          	sd	s6,0(sp)
    80002d44:	04010413          	addi	s0,sp,64
    80002d48:	00a4f4b3          	and	s1,s1,a0
    80002d4c:	00f487b3          	add	a5,s1,a5
    80002d50:	06f5e463          	bltu	a1,a5,80002db8 <freerange+0xa8>
    80002d54:	00003a97          	auipc	s5,0x3
    80002d58:	88ca8a93          	addi	s5,s5,-1908 # 800055e0 <end>
    80002d5c:	0954e263          	bltu	s1,s5,80002de0 <freerange+0xd0>
    80002d60:	01100993          	li	s3,17
    80002d64:	01b99993          	slli	s3,s3,0x1b
    80002d68:	0734fc63          	bgeu	s1,s3,80002de0 <freerange+0xd0>
    80002d6c:	00058a13          	mv	s4,a1
    80002d70:	00001917          	auipc	s2,0x1
    80002d74:	60090913          	addi	s2,s2,1536 # 80004370 <kmem>
    80002d78:	00002b37          	lui	s6,0x2
    80002d7c:	0140006f          	j	80002d90 <freerange+0x80>
    80002d80:	000017b7          	lui	a5,0x1
    80002d84:	00f484b3          	add	s1,s1,a5
    80002d88:	0554ec63          	bltu	s1,s5,80002de0 <freerange+0xd0>
    80002d8c:	0534fa63          	bgeu	s1,s3,80002de0 <freerange+0xd0>
    80002d90:	00001637          	lui	a2,0x1
    80002d94:	00100593          	li	a1,1
    80002d98:	00048513          	mv	a0,s1
    80002d9c:	00000097          	auipc	ra,0x0
    80002da0:	50c080e7          	jalr	1292(ra) # 800032a8 <__memset>
    80002da4:	00093703          	ld	a4,0(s2)
    80002da8:	016487b3          	add	a5,s1,s6
    80002dac:	00e4b023          	sd	a4,0(s1)
    80002db0:	00993023          	sd	s1,0(s2)
    80002db4:	fcfa76e3          	bgeu	s4,a5,80002d80 <freerange+0x70>
    80002db8:	03813083          	ld	ra,56(sp)
    80002dbc:	03013403          	ld	s0,48(sp)
    80002dc0:	02813483          	ld	s1,40(sp)
    80002dc4:	02013903          	ld	s2,32(sp)
    80002dc8:	01813983          	ld	s3,24(sp)
    80002dcc:	01013a03          	ld	s4,16(sp)
    80002dd0:	00813a83          	ld	s5,8(sp)
    80002dd4:	00013b03          	ld	s6,0(sp)
    80002dd8:	04010113          	addi	sp,sp,64
    80002ddc:	00008067          	ret
    80002de0:	00001517          	auipc	a0,0x1
    80002de4:	3b050513          	addi	a0,a0,944 # 80004190 <digits+0x18>
    80002de8:	fffff097          	auipc	ra,0xfffff
    80002dec:	3d4080e7          	jalr	980(ra) # 800021bc <panic>

0000000080002df0 <kfree>:
    80002df0:	fe010113          	addi	sp,sp,-32
    80002df4:	00813823          	sd	s0,16(sp)
    80002df8:	00113c23          	sd	ra,24(sp)
    80002dfc:	00913423          	sd	s1,8(sp)
    80002e00:	02010413          	addi	s0,sp,32
    80002e04:	03451793          	slli	a5,a0,0x34
    80002e08:	04079c63          	bnez	a5,80002e60 <kfree+0x70>
    80002e0c:	00002797          	auipc	a5,0x2
    80002e10:	7d478793          	addi	a5,a5,2004 # 800055e0 <end>
    80002e14:	00050493          	mv	s1,a0
    80002e18:	04f56463          	bltu	a0,a5,80002e60 <kfree+0x70>
    80002e1c:	01100793          	li	a5,17
    80002e20:	01b79793          	slli	a5,a5,0x1b
    80002e24:	02f57e63          	bgeu	a0,a5,80002e60 <kfree+0x70>
    80002e28:	00001637          	lui	a2,0x1
    80002e2c:	00100593          	li	a1,1
    80002e30:	00000097          	auipc	ra,0x0
    80002e34:	478080e7          	jalr	1144(ra) # 800032a8 <__memset>
    80002e38:	00001797          	auipc	a5,0x1
    80002e3c:	53878793          	addi	a5,a5,1336 # 80004370 <kmem>
    80002e40:	0007b703          	ld	a4,0(a5)
    80002e44:	01813083          	ld	ra,24(sp)
    80002e48:	01013403          	ld	s0,16(sp)
    80002e4c:	00e4b023          	sd	a4,0(s1)
    80002e50:	0097b023          	sd	s1,0(a5)
    80002e54:	00813483          	ld	s1,8(sp)
    80002e58:	02010113          	addi	sp,sp,32
    80002e5c:	00008067          	ret
    80002e60:	00001517          	auipc	a0,0x1
    80002e64:	33050513          	addi	a0,a0,816 # 80004190 <digits+0x18>
    80002e68:	fffff097          	auipc	ra,0xfffff
    80002e6c:	354080e7          	jalr	852(ra) # 800021bc <panic>

0000000080002e70 <kalloc>:
    80002e70:	fe010113          	addi	sp,sp,-32
    80002e74:	00813823          	sd	s0,16(sp)
    80002e78:	00913423          	sd	s1,8(sp)
    80002e7c:	00113c23          	sd	ra,24(sp)
    80002e80:	02010413          	addi	s0,sp,32
    80002e84:	00001797          	auipc	a5,0x1
    80002e88:	4ec78793          	addi	a5,a5,1260 # 80004370 <kmem>
    80002e8c:	0007b483          	ld	s1,0(a5)
    80002e90:	02048063          	beqz	s1,80002eb0 <kalloc+0x40>
    80002e94:	0004b703          	ld	a4,0(s1)
    80002e98:	00001637          	lui	a2,0x1
    80002e9c:	00500593          	li	a1,5
    80002ea0:	00048513          	mv	a0,s1
    80002ea4:	00e7b023          	sd	a4,0(a5)
    80002ea8:	00000097          	auipc	ra,0x0
    80002eac:	400080e7          	jalr	1024(ra) # 800032a8 <__memset>
    80002eb0:	01813083          	ld	ra,24(sp)
    80002eb4:	01013403          	ld	s0,16(sp)
    80002eb8:	00048513          	mv	a0,s1
    80002ebc:	00813483          	ld	s1,8(sp)
    80002ec0:	02010113          	addi	sp,sp,32
    80002ec4:	00008067          	ret

0000000080002ec8 <initlock>:
    80002ec8:	ff010113          	addi	sp,sp,-16
    80002ecc:	00813423          	sd	s0,8(sp)
    80002ed0:	01010413          	addi	s0,sp,16
    80002ed4:	00813403          	ld	s0,8(sp)
    80002ed8:	00b53423          	sd	a1,8(a0)
    80002edc:	00052023          	sw	zero,0(a0)
    80002ee0:	00053823          	sd	zero,16(a0)
    80002ee4:	01010113          	addi	sp,sp,16
    80002ee8:	00008067          	ret

0000000080002eec <acquire>:
    80002eec:	fe010113          	addi	sp,sp,-32
    80002ef0:	00813823          	sd	s0,16(sp)
    80002ef4:	00913423          	sd	s1,8(sp)
    80002ef8:	00113c23          	sd	ra,24(sp)
    80002efc:	01213023          	sd	s2,0(sp)
    80002f00:	02010413          	addi	s0,sp,32
    80002f04:	00050493          	mv	s1,a0
    80002f08:	10002973          	csrr	s2,sstatus
    80002f0c:	100027f3          	csrr	a5,sstatus
    80002f10:	ffd7f793          	andi	a5,a5,-3
    80002f14:	10079073          	csrw	sstatus,a5
    80002f18:	fffff097          	auipc	ra,0xfffff
    80002f1c:	8e4080e7          	jalr	-1820(ra) # 800017fc <mycpu>
    80002f20:	07852783          	lw	a5,120(a0)
    80002f24:	06078e63          	beqz	a5,80002fa0 <acquire+0xb4>
    80002f28:	fffff097          	auipc	ra,0xfffff
    80002f2c:	8d4080e7          	jalr	-1836(ra) # 800017fc <mycpu>
    80002f30:	07852783          	lw	a5,120(a0)
    80002f34:	0004a703          	lw	a4,0(s1)
    80002f38:	0017879b          	addiw	a5,a5,1
    80002f3c:	06f52c23          	sw	a5,120(a0)
    80002f40:	04071063          	bnez	a4,80002f80 <acquire+0x94>
    80002f44:	00100713          	li	a4,1
    80002f48:	00070793          	mv	a5,a4
    80002f4c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002f50:	0007879b          	sext.w	a5,a5
    80002f54:	fe079ae3          	bnez	a5,80002f48 <acquire+0x5c>
    80002f58:	0ff0000f          	fence
    80002f5c:	fffff097          	auipc	ra,0xfffff
    80002f60:	8a0080e7          	jalr	-1888(ra) # 800017fc <mycpu>
    80002f64:	01813083          	ld	ra,24(sp)
    80002f68:	01013403          	ld	s0,16(sp)
    80002f6c:	00a4b823          	sd	a0,16(s1)
    80002f70:	00013903          	ld	s2,0(sp)
    80002f74:	00813483          	ld	s1,8(sp)
    80002f78:	02010113          	addi	sp,sp,32
    80002f7c:	00008067          	ret
    80002f80:	0104b903          	ld	s2,16(s1)
    80002f84:	fffff097          	auipc	ra,0xfffff
    80002f88:	878080e7          	jalr	-1928(ra) # 800017fc <mycpu>
    80002f8c:	faa91ce3          	bne	s2,a0,80002f44 <acquire+0x58>
    80002f90:	00001517          	auipc	a0,0x1
    80002f94:	20850513          	addi	a0,a0,520 # 80004198 <digits+0x20>
    80002f98:	fffff097          	auipc	ra,0xfffff
    80002f9c:	224080e7          	jalr	548(ra) # 800021bc <panic>
    80002fa0:	00195913          	srli	s2,s2,0x1
    80002fa4:	fffff097          	auipc	ra,0xfffff
    80002fa8:	858080e7          	jalr	-1960(ra) # 800017fc <mycpu>
    80002fac:	00197913          	andi	s2,s2,1
    80002fb0:	07252e23          	sw	s2,124(a0)
    80002fb4:	f75ff06f          	j	80002f28 <acquire+0x3c>

0000000080002fb8 <release>:
    80002fb8:	fe010113          	addi	sp,sp,-32
    80002fbc:	00813823          	sd	s0,16(sp)
    80002fc0:	00113c23          	sd	ra,24(sp)
    80002fc4:	00913423          	sd	s1,8(sp)
    80002fc8:	01213023          	sd	s2,0(sp)
    80002fcc:	02010413          	addi	s0,sp,32
    80002fd0:	00052783          	lw	a5,0(a0)
    80002fd4:	00079a63          	bnez	a5,80002fe8 <release+0x30>
    80002fd8:	00001517          	auipc	a0,0x1
    80002fdc:	1c850513          	addi	a0,a0,456 # 800041a0 <digits+0x28>
    80002fe0:	fffff097          	auipc	ra,0xfffff
    80002fe4:	1dc080e7          	jalr	476(ra) # 800021bc <panic>
    80002fe8:	01053903          	ld	s2,16(a0)
    80002fec:	00050493          	mv	s1,a0
    80002ff0:	fffff097          	auipc	ra,0xfffff
    80002ff4:	80c080e7          	jalr	-2036(ra) # 800017fc <mycpu>
    80002ff8:	fea910e3          	bne	s2,a0,80002fd8 <release+0x20>
    80002ffc:	0004b823          	sd	zero,16(s1)
    80003000:	0ff0000f          	fence
    80003004:	0f50000f          	fence	iorw,ow
    80003008:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000300c:	ffffe097          	auipc	ra,0xffffe
    80003010:	7f0080e7          	jalr	2032(ra) # 800017fc <mycpu>
    80003014:	100027f3          	csrr	a5,sstatus
    80003018:	0027f793          	andi	a5,a5,2
    8000301c:	04079a63          	bnez	a5,80003070 <release+0xb8>
    80003020:	07852783          	lw	a5,120(a0)
    80003024:	02f05e63          	blez	a5,80003060 <release+0xa8>
    80003028:	fff7871b          	addiw	a4,a5,-1
    8000302c:	06e52c23          	sw	a4,120(a0)
    80003030:	00071c63          	bnez	a4,80003048 <release+0x90>
    80003034:	07c52783          	lw	a5,124(a0)
    80003038:	00078863          	beqz	a5,80003048 <release+0x90>
    8000303c:	100027f3          	csrr	a5,sstatus
    80003040:	0027e793          	ori	a5,a5,2
    80003044:	10079073          	csrw	sstatus,a5
    80003048:	01813083          	ld	ra,24(sp)
    8000304c:	01013403          	ld	s0,16(sp)
    80003050:	00813483          	ld	s1,8(sp)
    80003054:	00013903          	ld	s2,0(sp)
    80003058:	02010113          	addi	sp,sp,32
    8000305c:	00008067          	ret
    80003060:	00001517          	auipc	a0,0x1
    80003064:	16050513          	addi	a0,a0,352 # 800041c0 <digits+0x48>
    80003068:	fffff097          	auipc	ra,0xfffff
    8000306c:	154080e7          	jalr	340(ra) # 800021bc <panic>
    80003070:	00001517          	auipc	a0,0x1
    80003074:	13850513          	addi	a0,a0,312 # 800041a8 <digits+0x30>
    80003078:	fffff097          	auipc	ra,0xfffff
    8000307c:	144080e7          	jalr	324(ra) # 800021bc <panic>

0000000080003080 <holding>:
    80003080:	00052783          	lw	a5,0(a0)
    80003084:	00079663          	bnez	a5,80003090 <holding+0x10>
    80003088:	00000513          	li	a0,0
    8000308c:	00008067          	ret
    80003090:	fe010113          	addi	sp,sp,-32
    80003094:	00813823          	sd	s0,16(sp)
    80003098:	00913423          	sd	s1,8(sp)
    8000309c:	00113c23          	sd	ra,24(sp)
    800030a0:	02010413          	addi	s0,sp,32
    800030a4:	01053483          	ld	s1,16(a0)
    800030a8:	ffffe097          	auipc	ra,0xffffe
    800030ac:	754080e7          	jalr	1876(ra) # 800017fc <mycpu>
    800030b0:	01813083          	ld	ra,24(sp)
    800030b4:	01013403          	ld	s0,16(sp)
    800030b8:	40a48533          	sub	a0,s1,a0
    800030bc:	00153513          	seqz	a0,a0
    800030c0:	00813483          	ld	s1,8(sp)
    800030c4:	02010113          	addi	sp,sp,32
    800030c8:	00008067          	ret

00000000800030cc <push_off>:
    800030cc:	fe010113          	addi	sp,sp,-32
    800030d0:	00813823          	sd	s0,16(sp)
    800030d4:	00113c23          	sd	ra,24(sp)
    800030d8:	00913423          	sd	s1,8(sp)
    800030dc:	02010413          	addi	s0,sp,32
    800030e0:	100024f3          	csrr	s1,sstatus
    800030e4:	100027f3          	csrr	a5,sstatus
    800030e8:	ffd7f793          	andi	a5,a5,-3
    800030ec:	10079073          	csrw	sstatus,a5
    800030f0:	ffffe097          	auipc	ra,0xffffe
    800030f4:	70c080e7          	jalr	1804(ra) # 800017fc <mycpu>
    800030f8:	07852783          	lw	a5,120(a0)
    800030fc:	02078663          	beqz	a5,80003128 <push_off+0x5c>
    80003100:	ffffe097          	auipc	ra,0xffffe
    80003104:	6fc080e7          	jalr	1788(ra) # 800017fc <mycpu>
    80003108:	07852783          	lw	a5,120(a0)
    8000310c:	01813083          	ld	ra,24(sp)
    80003110:	01013403          	ld	s0,16(sp)
    80003114:	0017879b          	addiw	a5,a5,1
    80003118:	06f52c23          	sw	a5,120(a0)
    8000311c:	00813483          	ld	s1,8(sp)
    80003120:	02010113          	addi	sp,sp,32
    80003124:	00008067          	ret
    80003128:	0014d493          	srli	s1,s1,0x1
    8000312c:	ffffe097          	auipc	ra,0xffffe
    80003130:	6d0080e7          	jalr	1744(ra) # 800017fc <mycpu>
    80003134:	0014f493          	andi	s1,s1,1
    80003138:	06952e23          	sw	s1,124(a0)
    8000313c:	fc5ff06f          	j	80003100 <push_off+0x34>

0000000080003140 <pop_off>:
    80003140:	ff010113          	addi	sp,sp,-16
    80003144:	00813023          	sd	s0,0(sp)
    80003148:	00113423          	sd	ra,8(sp)
    8000314c:	01010413          	addi	s0,sp,16
    80003150:	ffffe097          	auipc	ra,0xffffe
    80003154:	6ac080e7          	jalr	1708(ra) # 800017fc <mycpu>
    80003158:	100027f3          	csrr	a5,sstatus
    8000315c:	0027f793          	andi	a5,a5,2
    80003160:	04079663          	bnez	a5,800031ac <pop_off+0x6c>
    80003164:	07852783          	lw	a5,120(a0)
    80003168:	02f05a63          	blez	a5,8000319c <pop_off+0x5c>
    8000316c:	fff7871b          	addiw	a4,a5,-1
    80003170:	06e52c23          	sw	a4,120(a0)
    80003174:	00071c63          	bnez	a4,8000318c <pop_off+0x4c>
    80003178:	07c52783          	lw	a5,124(a0)
    8000317c:	00078863          	beqz	a5,8000318c <pop_off+0x4c>
    80003180:	100027f3          	csrr	a5,sstatus
    80003184:	0027e793          	ori	a5,a5,2
    80003188:	10079073          	csrw	sstatus,a5
    8000318c:	00813083          	ld	ra,8(sp)
    80003190:	00013403          	ld	s0,0(sp)
    80003194:	01010113          	addi	sp,sp,16
    80003198:	00008067          	ret
    8000319c:	00001517          	auipc	a0,0x1
    800031a0:	02450513          	addi	a0,a0,36 # 800041c0 <digits+0x48>
    800031a4:	fffff097          	auipc	ra,0xfffff
    800031a8:	018080e7          	jalr	24(ra) # 800021bc <panic>
    800031ac:	00001517          	auipc	a0,0x1
    800031b0:	ffc50513          	addi	a0,a0,-4 # 800041a8 <digits+0x30>
    800031b4:	fffff097          	auipc	ra,0xfffff
    800031b8:	008080e7          	jalr	8(ra) # 800021bc <panic>

00000000800031bc <push_on>:
    800031bc:	fe010113          	addi	sp,sp,-32
    800031c0:	00813823          	sd	s0,16(sp)
    800031c4:	00113c23          	sd	ra,24(sp)
    800031c8:	00913423          	sd	s1,8(sp)
    800031cc:	02010413          	addi	s0,sp,32
    800031d0:	100024f3          	csrr	s1,sstatus
    800031d4:	100027f3          	csrr	a5,sstatus
    800031d8:	0027e793          	ori	a5,a5,2
    800031dc:	10079073          	csrw	sstatus,a5
    800031e0:	ffffe097          	auipc	ra,0xffffe
    800031e4:	61c080e7          	jalr	1564(ra) # 800017fc <mycpu>
    800031e8:	07852783          	lw	a5,120(a0)
    800031ec:	02078663          	beqz	a5,80003218 <push_on+0x5c>
    800031f0:	ffffe097          	auipc	ra,0xffffe
    800031f4:	60c080e7          	jalr	1548(ra) # 800017fc <mycpu>
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
    80003220:	5e0080e7          	jalr	1504(ra) # 800017fc <mycpu>
    80003224:	0014f493          	andi	s1,s1,1
    80003228:	06952e23          	sw	s1,124(a0)
    8000322c:	fc5ff06f          	j	800031f0 <push_on+0x34>

0000000080003230 <pop_on>:
    80003230:	ff010113          	addi	sp,sp,-16
    80003234:	00813023          	sd	s0,0(sp)
    80003238:	00113423          	sd	ra,8(sp)
    8000323c:	01010413          	addi	s0,sp,16
    80003240:	ffffe097          	auipc	ra,0xffffe
    80003244:	5bc080e7          	jalr	1468(ra) # 800017fc <mycpu>
    80003248:	100027f3          	csrr	a5,sstatus
    8000324c:	0027f793          	andi	a5,a5,2
    80003250:	04078463          	beqz	a5,80003298 <pop_on+0x68>
    80003254:	07852783          	lw	a5,120(a0)
    80003258:	02f05863          	blez	a5,80003288 <pop_on+0x58>
    8000325c:	fff7879b          	addiw	a5,a5,-1
    80003260:	06f52c23          	sw	a5,120(a0)
    80003264:	07853783          	ld	a5,120(a0)
    80003268:	00079863          	bnez	a5,80003278 <pop_on+0x48>
    8000326c:	100027f3          	csrr	a5,sstatus
    80003270:	ffd7f793          	andi	a5,a5,-3
    80003274:	10079073          	csrw	sstatus,a5
    80003278:	00813083          	ld	ra,8(sp)
    8000327c:	00013403          	ld	s0,0(sp)
    80003280:	01010113          	addi	sp,sp,16
    80003284:	00008067          	ret
    80003288:	00001517          	auipc	a0,0x1
    8000328c:	f6050513          	addi	a0,a0,-160 # 800041e8 <digits+0x70>
    80003290:	fffff097          	auipc	ra,0xfffff
    80003294:	f2c080e7          	jalr	-212(ra) # 800021bc <panic>
    80003298:	00001517          	auipc	a0,0x1
    8000329c:	f3050513          	addi	a0,a0,-208 # 800041c8 <digits+0x50>
    800032a0:	fffff097          	auipc	ra,0xfffff
    800032a4:	f1c080e7          	jalr	-228(ra) # 800021bc <panic>

00000000800032a8 <__memset>:
    800032a8:	ff010113          	addi	sp,sp,-16
    800032ac:	00813423          	sd	s0,8(sp)
    800032b0:	01010413          	addi	s0,sp,16
    800032b4:	1a060e63          	beqz	a2,80003470 <__memset+0x1c8>
    800032b8:	40a007b3          	neg	a5,a0
    800032bc:	0077f793          	andi	a5,a5,7
    800032c0:	00778693          	addi	a3,a5,7
    800032c4:	00b00813          	li	a6,11
    800032c8:	0ff5f593          	andi	a1,a1,255
    800032cc:	fff6071b          	addiw	a4,a2,-1
    800032d0:	1b06e663          	bltu	a3,a6,8000347c <__memset+0x1d4>
    800032d4:	1cd76463          	bltu	a4,a3,8000349c <__memset+0x1f4>
    800032d8:	1a078e63          	beqz	a5,80003494 <__memset+0x1ec>
    800032dc:	00b50023          	sb	a1,0(a0)
    800032e0:	00100713          	li	a4,1
    800032e4:	1ae78463          	beq	a5,a4,8000348c <__memset+0x1e4>
    800032e8:	00b500a3          	sb	a1,1(a0)
    800032ec:	00200713          	li	a4,2
    800032f0:	1ae78a63          	beq	a5,a4,800034a4 <__memset+0x1fc>
    800032f4:	00b50123          	sb	a1,2(a0)
    800032f8:	00300713          	li	a4,3
    800032fc:	18e78463          	beq	a5,a4,80003484 <__memset+0x1dc>
    80003300:	00b501a3          	sb	a1,3(a0)
    80003304:	00400713          	li	a4,4
    80003308:	1ae78263          	beq	a5,a4,800034ac <__memset+0x204>
    8000330c:	00b50223          	sb	a1,4(a0)
    80003310:	00500713          	li	a4,5
    80003314:	1ae78063          	beq	a5,a4,800034b4 <__memset+0x20c>
    80003318:	00b502a3          	sb	a1,5(a0)
    8000331c:	00700713          	li	a4,7
    80003320:	18e79e63          	bne	a5,a4,800034bc <__memset+0x214>
    80003324:	00b50323          	sb	a1,6(a0)
    80003328:	00700e93          	li	t4,7
    8000332c:	00859713          	slli	a4,a1,0x8
    80003330:	00e5e733          	or	a4,a1,a4
    80003334:	01059e13          	slli	t3,a1,0x10
    80003338:	01c76e33          	or	t3,a4,t3
    8000333c:	01859313          	slli	t1,a1,0x18
    80003340:	006e6333          	or	t1,t3,t1
    80003344:	02059893          	slli	a7,a1,0x20
    80003348:	40f60e3b          	subw	t3,a2,a5
    8000334c:	011368b3          	or	a7,t1,a7
    80003350:	02859813          	slli	a6,a1,0x28
    80003354:	0108e833          	or	a6,a7,a6
    80003358:	03059693          	slli	a3,a1,0x30
    8000335c:	003e589b          	srliw	a7,t3,0x3
    80003360:	00d866b3          	or	a3,a6,a3
    80003364:	03859713          	slli	a4,a1,0x38
    80003368:	00389813          	slli	a6,a7,0x3
    8000336c:	00f507b3          	add	a5,a0,a5
    80003370:	00e6e733          	or	a4,a3,a4
    80003374:	000e089b          	sext.w	a7,t3
    80003378:	00f806b3          	add	a3,a6,a5
    8000337c:	00e7b023          	sd	a4,0(a5)
    80003380:	00878793          	addi	a5,a5,8
    80003384:	fed79ce3          	bne	a5,a3,8000337c <__memset+0xd4>
    80003388:	ff8e7793          	andi	a5,t3,-8
    8000338c:	0007871b          	sext.w	a4,a5
    80003390:	01d787bb          	addw	a5,a5,t4
    80003394:	0ce88e63          	beq	a7,a4,80003470 <__memset+0x1c8>
    80003398:	00f50733          	add	a4,a0,a5
    8000339c:	00b70023          	sb	a1,0(a4)
    800033a0:	0017871b          	addiw	a4,a5,1
    800033a4:	0cc77663          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    800033a8:	00e50733          	add	a4,a0,a4
    800033ac:	00b70023          	sb	a1,0(a4)
    800033b0:	0027871b          	addiw	a4,a5,2
    800033b4:	0ac77e63          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    800033b8:	00e50733          	add	a4,a0,a4
    800033bc:	00b70023          	sb	a1,0(a4)
    800033c0:	0037871b          	addiw	a4,a5,3
    800033c4:	0ac77663          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    800033c8:	00e50733          	add	a4,a0,a4
    800033cc:	00b70023          	sb	a1,0(a4)
    800033d0:	0047871b          	addiw	a4,a5,4
    800033d4:	08c77e63          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    800033d8:	00e50733          	add	a4,a0,a4
    800033dc:	00b70023          	sb	a1,0(a4)
    800033e0:	0057871b          	addiw	a4,a5,5
    800033e4:	08c77663          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    800033e8:	00e50733          	add	a4,a0,a4
    800033ec:	00b70023          	sb	a1,0(a4)
    800033f0:	0067871b          	addiw	a4,a5,6
    800033f4:	06c77e63          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    800033f8:	00e50733          	add	a4,a0,a4
    800033fc:	00b70023          	sb	a1,0(a4)
    80003400:	0077871b          	addiw	a4,a5,7
    80003404:	06c77663          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    80003408:	00e50733          	add	a4,a0,a4
    8000340c:	00b70023          	sb	a1,0(a4)
    80003410:	0087871b          	addiw	a4,a5,8
    80003414:	04c77e63          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    80003418:	00e50733          	add	a4,a0,a4
    8000341c:	00b70023          	sb	a1,0(a4)
    80003420:	0097871b          	addiw	a4,a5,9
    80003424:	04c77663          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    80003428:	00e50733          	add	a4,a0,a4
    8000342c:	00b70023          	sb	a1,0(a4)
    80003430:	00a7871b          	addiw	a4,a5,10
    80003434:	02c77e63          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    80003438:	00e50733          	add	a4,a0,a4
    8000343c:	00b70023          	sb	a1,0(a4)
    80003440:	00b7871b          	addiw	a4,a5,11
    80003444:	02c77663          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    80003448:	00e50733          	add	a4,a0,a4
    8000344c:	00b70023          	sb	a1,0(a4)
    80003450:	00c7871b          	addiw	a4,a5,12
    80003454:	00c77e63          	bgeu	a4,a2,80003470 <__memset+0x1c8>
    80003458:	00e50733          	add	a4,a0,a4
    8000345c:	00b70023          	sb	a1,0(a4)
    80003460:	00d7879b          	addiw	a5,a5,13
    80003464:	00c7f663          	bgeu	a5,a2,80003470 <__memset+0x1c8>
    80003468:	00f507b3          	add	a5,a0,a5
    8000346c:	00b78023          	sb	a1,0(a5)
    80003470:	00813403          	ld	s0,8(sp)
    80003474:	01010113          	addi	sp,sp,16
    80003478:	00008067          	ret
    8000347c:	00b00693          	li	a3,11
    80003480:	e55ff06f          	j	800032d4 <__memset+0x2c>
    80003484:	00300e93          	li	t4,3
    80003488:	ea5ff06f          	j	8000332c <__memset+0x84>
    8000348c:	00100e93          	li	t4,1
    80003490:	e9dff06f          	j	8000332c <__memset+0x84>
    80003494:	00000e93          	li	t4,0
    80003498:	e95ff06f          	j	8000332c <__memset+0x84>
    8000349c:	00000793          	li	a5,0
    800034a0:	ef9ff06f          	j	80003398 <__memset+0xf0>
    800034a4:	00200e93          	li	t4,2
    800034a8:	e85ff06f          	j	8000332c <__memset+0x84>
    800034ac:	00400e93          	li	t4,4
    800034b0:	e7dff06f          	j	8000332c <__memset+0x84>
    800034b4:	00500e93          	li	t4,5
    800034b8:	e75ff06f          	j	8000332c <__memset+0x84>
    800034bc:	00600e93          	li	t4,6
    800034c0:	e6dff06f          	j	8000332c <__memset+0x84>

00000000800034c4 <__memmove>:
    800034c4:	ff010113          	addi	sp,sp,-16
    800034c8:	00813423          	sd	s0,8(sp)
    800034cc:	01010413          	addi	s0,sp,16
    800034d0:	0e060863          	beqz	a2,800035c0 <__memmove+0xfc>
    800034d4:	fff6069b          	addiw	a3,a2,-1
    800034d8:	0006881b          	sext.w	a6,a3
    800034dc:	0ea5e863          	bltu	a1,a0,800035cc <__memmove+0x108>
    800034e0:	00758713          	addi	a4,a1,7
    800034e4:	00a5e7b3          	or	a5,a1,a0
    800034e8:	40a70733          	sub	a4,a4,a0
    800034ec:	0077f793          	andi	a5,a5,7
    800034f0:	00f73713          	sltiu	a4,a4,15
    800034f4:	00174713          	xori	a4,a4,1
    800034f8:	0017b793          	seqz	a5,a5
    800034fc:	00e7f7b3          	and	a5,a5,a4
    80003500:	10078863          	beqz	a5,80003610 <__memmove+0x14c>
    80003504:	00900793          	li	a5,9
    80003508:	1107f463          	bgeu	a5,a6,80003610 <__memmove+0x14c>
    8000350c:	0036581b          	srliw	a6,a2,0x3
    80003510:	fff8081b          	addiw	a6,a6,-1
    80003514:	02081813          	slli	a6,a6,0x20
    80003518:	01d85893          	srli	a7,a6,0x1d
    8000351c:	00858813          	addi	a6,a1,8
    80003520:	00058793          	mv	a5,a1
    80003524:	00050713          	mv	a4,a0
    80003528:	01088833          	add	a6,a7,a6
    8000352c:	0007b883          	ld	a7,0(a5)
    80003530:	00878793          	addi	a5,a5,8
    80003534:	00870713          	addi	a4,a4,8
    80003538:	ff173c23          	sd	a7,-8(a4)
    8000353c:	ff0798e3          	bne	a5,a6,8000352c <__memmove+0x68>
    80003540:	ff867713          	andi	a4,a2,-8
    80003544:	02071793          	slli	a5,a4,0x20
    80003548:	0207d793          	srli	a5,a5,0x20
    8000354c:	00f585b3          	add	a1,a1,a5
    80003550:	40e686bb          	subw	a3,a3,a4
    80003554:	00f507b3          	add	a5,a0,a5
    80003558:	06e60463          	beq	a2,a4,800035c0 <__memmove+0xfc>
    8000355c:	0005c703          	lbu	a4,0(a1)
    80003560:	00e78023          	sb	a4,0(a5)
    80003564:	04068e63          	beqz	a3,800035c0 <__memmove+0xfc>
    80003568:	0015c603          	lbu	a2,1(a1)
    8000356c:	00100713          	li	a4,1
    80003570:	00c780a3          	sb	a2,1(a5)
    80003574:	04e68663          	beq	a3,a4,800035c0 <__memmove+0xfc>
    80003578:	0025c603          	lbu	a2,2(a1)
    8000357c:	00200713          	li	a4,2
    80003580:	00c78123          	sb	a2,2(a5)
    80003584:	02e68e63          	beq	a3,a4,800035c0 <__memmove+0xfc>
    80003588:	0035c603          	lbu	a2,3(a1)
    8000358c:	00300713          	li	a4,3
    80003590:	00c781a3          	sb	a2,3(a5)
    80003594:	02e68663          	beq	a3,a4,800035c0 <__memmove+0xfc>
    80003598:	0045c603          	lbu	a2,4(a1)
    8000359c:	00400713          	li	a4,4
    800035a0:	00c78223          	sb	a2,4(a5)
    800035a4:	00e68e63          	beq	a3,a4,800035c0 <__memmove+0xfc>
    800035a8:	0055c603          	lbu	a2,5(a1)
    800035ac:	00500713          	li	a4,5
    800035b0:	00c782a3          	sb	a2,5(a5)
    800035b4:	00e68663          	beq	a3,a4,800035c0 <__memmove+0xfc>
    800035b8:	0065c703          	lbu	a4,6(a1)
    800035bc:	00e78323          	sb	a4,6(a5)
    800035c0:	00813403          	ld	s0,8(sp)
    800035c4:	01010113          	addi	sp,sp,16
    800035c8:	00008067          	ret
    800035cc:	02061713          	slli	a4,a2,0x20
    800035d0:	02075713          	srli	a4,a4,0x20
    800035d4:	00e587b3          	add	a5,a1,a4
    800035d8:	f0f574e3          	bgeu	a0,a5,800034e0 <__memmove+0x1c>
    800035dc:	02069613          	slli	a2,a3,0x20
    800035e0:	02065613          	srli	a2,a2,0x20
    800035e4:	fff64613          	not	a2,a2
    800035e8:	00e50733          	add	a4,a0,a4
    800035ec:	00c78633          	add	a2,a5,a2
    800035f0:	fff7c683          	lbu	a3,-1(a5)
    800035f4:	fff78793          	addi	a5,a5,-1
    800035f8:	fff70713          	addi	a4,a4,-1
    800035fc:	00d70023          	sb	a3,0(a4)
    80003600:	fec798e3          	bne	a5,a2,800035f0 <__memmove+0x12c>
    80003604:	00813403          	ld	s0,8(sp)
    80003608:	01010113          	addi	sp,sp,16
    8000360c:	00008067          	ret
    80003610:	02069713          	slli	a4,a3,0x20
    80003614:	02075713          	srli	a4,a4,0x20
    80003618:	00170713          	addi	a4,a4,1
    8000361c:	00e50733          	add	a4,a0,a4
    80003620:	00050793          	mv	a5,a0
    80003624:	0005c683          	lbu	a3,0(a1)
    80003628:	00178793          	addi	a5,a5,1
    8000362c:	00158593          	addi	a1,a1,1
    80003630:	fed78fa3          	sb	a3,-1(a5)
    80003634:	fee798e3          	bne	a5,a4,80003624 <__memmove+0x160>
    80003638:	f89ff06f          	j	800035c0 <__memmove+0xfc>

000000008000363c <__putc>:
    8000363c:	fe010113          	addi	sp,sp,-32
    80003640:	00813823          	sd	s0,16(sp)
    80003644:	00113c23          	sd	ra,24(sp)
    80003648:	02010413          	addi	s0,sp,32
    8000364c:	00050793          	mv	a5,a0
    80003650:	fef40593          	addi	a1,s0,-17
    80003654:	00100613          	li	a2,1
    80003658:	00000513          	li	a0,0
    8000365c:	fef407a3          	sb	a5,-17(s0)
    80003660:	fffff097          	auipc	ra,0xfffff
    80003664:	b3c080e7          	jalr	-1220(ra) # 8000219c <console_write>
    80003668:	01813083          	ld	ra,24(sp)
    8000366c:	01013403          	ld	s0,16(sp)
    80003670:	02010113          	addi	sp,sp,32
    80003674:	00008067          	ret

0000000080003678 <__getc>:
    80003678:	fe010113          	addi	sp,sp,-32
    8000367c:	00813823          	sd	s0,16(sp)
    80003680:	00113c23          	sd	ra,24(sp)
    80003684:	02010413          	addi	s0,sp,32
    80003688:	fe840593          	addi	a1,s0,-24
    8000368c:	00100613          	li	a2,1
    80003690:	00000513          	li	a0,0
    80003694:	fffff097          	auipc	ra,0xfffff
    80003698:	ae8080e7          	jalr	-1304(ra) # 8000217c <console_read>
    8000369c:	fe844503          	lbu	a0,-24(s0)
    800036a0:	01813083          	ld	ra,24(sp)
    800036a4:	01013403          	ld	s0,16(sp)
    800036a8:	02010113          	addi	sp,sp,32
    800036ac:	00008067          	ret

00000000800036b0 <console_handler>:
    800036b0:	fe010113          	addi	sp,sp,-32
    800036b4:	00813823          	sd	s0,16(sp)
    800036b8:	00113c23          	sd	ra,24(sp)
    800036bc:	00913423          	sd	s1,8(sp)
    800036c0:	02010413          	addi	s0,sp,32
    800036c4:	14202773          	csrr	a4,scause
    800036c8:	100027f3          	csrr	a5,sstatus
    800036cc:	0027f793          	andi	a5,a5,2
    800036d0:	06079e63          	bnez	a5,8000374c <console_handler+0x9c>
    800036d4:	00074c63          	bltz	a4,800036ec <console_handler+0x3c>
    800036d8:	01813083          	ld	ra,24(sp)
    800036dc:	01013403          	ld	s0,16(sp)
    800036e0:	00813483          	ld	s1,8(sp)
    800036e4:	02010113          	addi	sp,sp,32
    800036e8:	00008067          	ret
    800036ec:	0ff77713          	andi	a4,a4,255
    800036f0:	00900793          	li	a5,9
    800036f4:	fef712e3          	bne	a4,a5,800036d8 <console_handler+0x28>
    800036f8:	ffffe097          	auipc	ra,0xffffe
    800036fc:	6dc080e7          	jalr	1756(ra) # 80001dd4 <plic_claim>
    80003700:	00a00793          	li	a5,10
    80003704:	00050493          	mv	s1,a0
    80003708:	02f50c63          	beq	a0,a5,80003740 <console_handler+0x90>
    8000370c:	fc0506e3          	beqz	a0,800036d8 <console_handler+0x28>
    80003710:	00050593          	mv	a1,a0
    80003714:	00001517          	auipc	a0,0x1
    80003718:	9dc50513          	addi	a0,a0,-1572 # 800040f0 <CONSOLE_STATUS+0xe0>
    8000371c:	fffff097          	auipc	ra,0xfffff
    80003720:	afc080e7          	jalr	-1284(ra) # 80002218 <__printf>
    80003724:	01013403          	ld	s0,16(sp)
    80003728:	01813083          	ld	ra,24(sp)
    8000372c:	00048513          	mv	a0,s1
    80003730:	00813483          	ld	s1,8(sp)
    80003734:	02010113          	addi	sp,sp,32
    80003738:	ffffe317          	auipc	t1,0xffffe
    8000373c:	6d430067          	jr	1748(t1) # 80001e0c <plic_complete>
    80003740:	fffff097          	auipc	ra,0xfffff
    80003744:	3e0080e7          	jalr	992(ra) # 80002b20 <uartintr>
    80003748:	fddff06f          	j	80003724 <console_handler+0x74>
    8000374c:	00001517          	auipc	a0,0x1
    80003750:	aa450513          	addi	a0,a0,-1372 # 800041f0 <digits+0x78>
    80003754:	fffff097          	auipc	ra,0xfffff
    80003758:	a68080e7          	jalr	-1432(ra) # 800021bc <panic>
	...
