#ifndef CCB_H
#define CCB_H

#include "console.h"

class PCB;
class SCB;
class IOBuffer;
class CCB {
public:
    static SCB *semInput, *semOutput; // ulaz sa konzole, izlaz na konzolu
    static SCB *inputBufferEmpty; // >0 nije prazan <=0 prazan
    static PCB *inputProcces, *outputProcess; // ulazna i izlazna nit

    static IOBuffer inputBuffer; // ulaz sa konzole
    static IOBuffer outputBuffer; // izlaz na konzolu

    static void inputBody(void*);

    static void outputBody(void*);
private:
    CCB() = default;
};


class IOBuffer {
private:
    struct Elem {
        Elem* next;
        char data;
    };

    Elem *head = nullptr, *tail = nullptr;
public:
    void pushBack(char c);

    char peekBack();

    char peekFront();

    char popFront();
};

#endif //CCB_H
