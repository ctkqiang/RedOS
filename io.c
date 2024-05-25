#include "io.h"

unsigned char inb(unsigned short port) 
{
    unsigned char result;
    
    __asm__ volatile("inb %1, %0" : "=a"(result) : "Nd"(port));

    return result;
}

void outb(unsigned short port, unsigned char data) 
{
    __asm__ volatile("outb %0, %1" : : "a"(data), "Nd"(port));
}
