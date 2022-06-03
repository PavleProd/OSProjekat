#ifndef SYSCALL_C_H
#define SYSCALL_C_H

#include "hw.h"
#include "PCB.h"
#include "SCB.h"

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

//class PCB;
typedef PCB* thread_t;
/*
Pravi nit nad funkcijom start_routine, pozivajući je sa argumentom arg i stavlja je u scheduler
U slučaju uspeha, u *handle upisuje „ručku“ novokreirane niti i vraća 0, a u slučaju neuspeha vraća negativnu vrednost (kôd greške).
„Ručka“ je interni identifikator koji jezgro koristi da bi identifikovalo nit (pokazivac na PCB)
 Funkcija treba da alocira stek i prosledi ga prekidnoj rutini
*/
int thread_create (thread_t* handle, void(*startRoutine)(void*), void* arg);

/*
Pravi nit nad funkcijom start_routine, pozivajući je sa argumentom arg(ne stavlja je u scheduler)
U slučaju uspeha, u *handle upisuje „ručku“ novokreirane niti i vraća 0, a u slučaju neuspeha vraća negativnu vrednost (kôd greške).
„Ručka“ je interni identifikator koji jezgro koristi da bi identifikovalo nit (pokazivac na PCB)
 Funkcija treba da alocira stek i prosledi ga prekidnoj rutini
*/
int thread_create_only (thread_t* handle, void(*startRoutine)(void*), void* arg);
// Gasi tekuću nit. U slučaju neuspeha vraća negativnu vrednost (kod greske)
int thread_exit ();

// Pokrece nit na koju pokazuje rucka handle(stavlja nit u scheduler)
void thread_start(thread_t* handle);

// Potencijalno oduzima procesor tekućoj i daje nekoj drugoj (ili istoj) niti.
void thread_dispatch ();

typedef SCB* sem_t;
/*Kreira semafor sa inicijalnom vrednošću init. U slučaju uspeha, u *handle upisuje ručku novokreiranog semafora i
vraća 0, a u slučaju neuspeha vraća negativnu vrednost (kôd greške). Rucka je pokazivac na SCB(Semaphore Control Block)
*/
int sem_open (sem_t* handle, unsigned init);

/*Operacija wait na semaforu sa datom ručkom. U slučaju uspeha vraća 0, a u slučaju neuspeha, uključujući i slučaj
kada je semafor dealociran dok je pozivajuća nit na njemu čekala, vraća negativnu vrednost (kôd greške).*/
int sem_wait (sem_t id);

/* Operacija signal na semaforu sa datom ručkom. U slučaju
uspeha vraća 0, a u slučaju neuspeha vraća negativnu
vrednost (kôd greške).*/
int sem_signal (sem_t id);

/*Oslobađa semafor sa datom ručkom. Sve niti koje su se
zatekle da čekaju na semaforu se deblokiraju, pri čemu njihov
wait vraća grešku. U slučaju uspeha vraća 0, a u slučaju
neuspeha vraća negativnu vrednost (kôd greške).*/
int sem_close (sem_t handle);

typedef unsigned long time_t;
/*Uspavljuje pozivajuću nit na zadati period u internim
jedinicama vremena (periodama tajmera). U slučaju uspeha
vraća 0, a u slučaju neuspeha vraća negativnu vrednost (kôd greške).
*/
int time_sleep (time_t time);

const int EOF = -1;
/*Učitava jedan znak iz bafera znakova učitanih sa konzole. U
slučaju da je bafer prazan, suspenduje pozivajuću nit dok se
znak ne pojavi. Vraća učitani znak u slučaju uspeha, a
konstantu EOF u slučaju greške.
 */
char getc ();

// Ispisuje dati znak na konzolu.
void putc (char);

#endif //SYSCALL_C_H
