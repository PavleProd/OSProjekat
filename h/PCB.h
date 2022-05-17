#ifndef PCB_H
#define PCB_H

#include "../lib/hw.h"
class PCB {
friend class Scheduler;
public:
    bool isFinished() const {
        return finished;
    }
    void setFinished(bool finished_) {
        finished = finished_;
    }

    using proccessMain = void(*)(); // pokazivac na void funkciju bez argumenata

    static PCB* createProccess(proccessMain main);
    static void yield();
    static PCB* running;

private:

    // pokazivac na sledeci proces u listi spremnih procesa (ako nije u listi spremnih nullptr, ako jeste bice garantovano razlicit on nullptr)
    // jer ce poslednji element pokazivati na idle proces(TODO: treba da bude private!!!)
    PCB* nextReady = nullptr;

    struct Context {
        uint64 ra; // (x1) kada menjamo kontekst moramo da sacuvamo dokle je proces stigao sa obradom
        uint64 sp; // (x2) kada menjamo kontekst nazad na proces da bismo skinuli registre sa steka moramo znati sp
    };
    uint64* stack; // stek procesa, na njemu se cuva kontest procesa
    Context context; // kontekst procesa

    proccessMain main; // glavna funkcija koju proces izvrsava
    bool finished;

};


#endif //PCB_H
