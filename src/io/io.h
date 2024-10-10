#ifndef __BOBOS_IO_H
#define __BOBOS_IO_H

unsigned char insb(uint16_t port);
unsigned short insw(uint16_t port);

void outb(uint16_t port, uint8_t data);
void outw(uint16_t port, uint8_t data);
//void outl(unsigned short port, unsigned int data);

#endif
