#include "memory.h"

void* memset(void* ptr, int c,size_t size){ //Implementation of the memset function
    char* c_ptr = (char*) ptr; // (char*) - You are typecasting some data type to char-type pointer.

    for(int i=0; i<size;i++){
        c_ptr[i] = (char) c; //
    }
    return ptr ; //returns the pointer
}