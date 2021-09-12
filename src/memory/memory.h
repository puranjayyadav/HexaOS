#ifndef MEMORY_H
#define MEMORY_H

#include <stddef.h>

void* memset(void* ptr, int c,size_t size); //Memset is used to fill a block of memory with whatever value the iser inputs in it 
// We are making a custom memset function because our OS dosen't have prebuilt function in it
// a void pointer dosent have any type , it can be typecasted into any type during the program execution

#endif