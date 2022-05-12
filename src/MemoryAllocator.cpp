#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 1);
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    while(curr) {
        size_t freeSegSizeInBlocks = sizeInBlocks(curr->size);
        size_t allocatedSize;
        void* startOfAllocatedSpace = curr->baseAddr;
        if(freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
                    }
                }
                else {
                    FreeSegment::remove(prev);
                }
            }
            else {
                allocatedSize = blocksInSize(numOfBlocksToAllocate);
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
                size_t newSize = curr->size - allocatedSize;

                FreeSegment* newSeg = (FreeSegment*)newBaseAddr;
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
                }
                else {
                    FreeSegment::remove(prev);
                    FreeSegment::add(prev, curr);
                }
            }

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
        curr = curr->next;
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}

int MemoryAllocator::mem_free(void *memSegment) {
    if((size_t)memSegment - SegmentOffset < (size_t)HEAP_END_ADDR) return BAD_POINTER;

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size > (char*)HEAP_END_ADDR || memSegment == nullptr
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
        return BAD_POINTER;
    }

    FreeSegment* curr = head, *prev = nullptr;
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
        prev = curr;
        curr = curr->next;
    }

    if(prev == nullptr) {
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
            return BAD_POINTER;
        }
        else {
            FreeSegment* newFreeSegment = (FreeSegment*)memSegment;
            newFreeSegment->size = size;
            newFreeSegment->baseAddr = memSegment;

            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
                newFreeSegment->size += head->size;
                newFreeSegment->next = head->next;
            }
            else {
                newFreeSegment->next = head;
            }
            head = newFreeSegment;

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
            newFreeSegment->baseAddr = memSegment;

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
}
