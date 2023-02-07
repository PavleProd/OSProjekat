#ifndef SLAB_H
#define SLAB_H

#include "hw.h"
typedef struct kmem_cache_s kmem_cache_t;
#define BLOCK_SIZE (4096)

/*inicijalizacija alokatora; prosleđuje se adresa pocetka memorijsko prostora za koji je
alokator zadužen i veličina tog memorijskog prostora izražena u broju blokova;*/
void kmem_init(void *space, int block_num);

/*kreiranje jednog keša; pri kreiranju se zadaje naziv keša, veličina objekta, i opcioni
konstruktor i destruktor objekata; povratna vrednost je pokazivač na ručku keša;*/
kmem_cache_t *kmem_cache_create(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *));

// oslobadja sve slabove koji su slobodni skroz, vraca broj oslobodjenih blokova
int kmem_cache_shrink(kmem_cache_t *cachep);


// alocira jedan objekat iz kesa, ako nema parcijalno popunjenih slabova trazi u praznim i ako nema praznih alocira novi
void *kmem_cache_alloc(kmem_cache_t *cachep);

// dealokacija jednog slota. Slot ima pokazivac na sleb a on pokazivac na kes
void kmem_cache_free(kmem_cache_t *cachep, void *objp);

void *kmalloc(size_t size); // Alloacate one small memory buffer TODO
void kfree(const void *objp); // Deallocate one small memory buffer TODO

// Dealocira sve slotove i slabove i kes
void kmem_cache_destroy(kmem_cache_t *cachep);
// Ispis poruke: ime kesa, velicina objekta, broj slabova, broj slotova po slabu, broj alociranih slotova
void kmem_cache_info(kmem_cache_t *cachep);

// štampanje greške prilikom rada sa kešom; povratna vrednost funkcije je 0 ukoliko
//greške nije bilo, u suprotnom vrednost različita od 0.
int kmem_cache_error(kmem_cache_t *cachep);

#endif // SLAB_H