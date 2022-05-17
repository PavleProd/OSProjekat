#ifndef PCB_H
#define PCB_H

#include "hw.h"


class PCB {
friend class Scheduler;
public:
    // vraca true ako se proces zavrsio, false ako nije
    bool isFinished() const {
        return finished;
    }
    void setFinished(bool finished_) {
        finished = finished_;
    }

    using processMain = void(*)(); // pokazivac na void funkciju bez argumenata

    static PCB* createProccess(processMain main);
    // Cuva kontekst trenutnog procesa, vrsi promenu tekuceg procesa i vraca kontekst novog procesa
    static void yield();
    static PCB* running; // tekuci proces

    ~PCB();

private:
    PCB(processMain main);

    struct Context {
        size_t ra; // (x1) kada menjamo kontekst moramo da sacuvamo dokle je proces stigao sa obradom
        size_t sp; // (x2) kada menjamo kontekst nazad na proces da bismo skinuli registre sa steka moramo znati sp
    };

    // pokazivac na sledeci proces u listi spremnih procesa (ako nije u listi spremnih nullptr, ako jeste bice garantovano razlicit on nullptr)
    // jer ce poslednji element pokazivati na idle proces
    PCB* nextReady = nullptr;
    size_t* stack; // stek procesa, na njemu se cuva kontest procesa
    Context context; // kontekst procesa
    processMain main; // glavna funkcija koju proces izvrsava
    bool finished; // govori da li se proces zavrsio

    // iz reda spremnih procesa uzima jedan proces i postavlja ga kao tekuci proces
    static void dispatch();

    // Asemblerska funkcija cuva ra(x1) i sp(x2) starog konteksta, a ucitava ra i sp novog konteksta
    static void switchContext(Context* oldContext, Context* newContext);
};


#endif //PCB_H
