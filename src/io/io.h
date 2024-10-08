#ifndef __BOBOS_IO_H
#define __BOBOS_IO_H

unsigned char insb(unsigned short port);
unsigned short insw(unsigned short port);

void outb(unsigned short port, unsigned char data);
void outw(unsigned short port, unsigned short data);
//void outl(unsigned short port, unsigned int data);

#endif
