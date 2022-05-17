#ifndef SYSCALL_C_H
#define SYSCALL_C_H

#include "hw.h"

/*
    Alocira (najmanje) size bajtova memorije, zaokruženo i poravnato na blokove veličine MEM_BLOCK_SIZE.
    Svaki alocirani segment ima zaglavlje sa velicinom tog segmenta(vraca se adresa nakon tog zaglavlja)

    Vraća:
    pokazivač na alocirani deo memorije u slučaju uspeha, nullptr u slučaju neuspeha

    Radi se po algoritmu first fit(alociramo prvi segment koji je >= size). Ako je preostao prostor manji od velicine
    jednog bloka, taj preostali prostor se pridruzuje ovom koji smo sad alocirali(jer nema poente da ostane nealociran)
*/
extern void* mem_alloc(size_t size);
/*
    Oslobađa prostor prethodno zauzet pomoću mem_alloc.
    Vraća 0 u slučaju uspeha, BAD_POINTER  flag ako je dostavljen los pokazivac.
    Ako je moguce, spaja dva susedna slobodna segmenta u jedan veci
*/
extern int mem_free (void* memSegment);

#endif //SYSCALL_C_H
