#ifndef LIST_H
#define LIST_H

template<typename T>
class List {
private:
    struct Elem {
        T* data;
        Elem* next;
    };

    Elem *begin = nullptr, *end = nullptr;

public:
    List(const List<T> &) = delete;
    List<T> &operator=(const List<T> &) = delete;

    List& addLast(T* data) {

    }
};


#endif //LIST_H
