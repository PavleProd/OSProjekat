#include "../h/hw.h"
#include "../h/console.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/print.h"
#include "../h/PCB.h"
#include "../h/kernel.h"
#include "../h/syscall_cpp.h"
#include "../h/SCB.h"

class periodicnaNit : public PeriodicThread {
public:
    periodicnaNit(time_t period) : PeriodicThread(period) {}
    void periodicActivation() override {
        static int i = 0;
        printString("Test");
        printInt(i);
        printString("\n");
    }
};


// Kernel inicijalizaccija
void idleProcess() {
    while(true) {}
}
extern "C" void interrupt();
// ------------
int main() {
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    PCB::running = main;
    Scheduler::idleProcess = PCB::createProccess(idleProcess, nullptr);
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    // ----

    periodicnaNit *pNit = new periodicnaNit(10);
    pNit->start();
    time_sleep(10);
    delete pNit;
    return 0;
}