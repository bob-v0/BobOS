#include <stdint.h>
#include <stddef.h>

#include "kernel.h"
#include "idt.h"
#include "io/io.h"

void     term_clear();
uint16_t term_make_char(char c, char color);
void     term_put_char(int h, int w, char c, char color);

size_t strlen(const char* str);

// todo:
// - move terminal to term module
// - make term size independant?

uint16_t* video_mem = (uint16_t*)0xB8000;
char term_fg_color = 2;
int term_pos_x = 0;
int term_pos_y = 0;


// Terminal functions
void term_clear()
{
    for(uint16_t h=0; h < VGA_HEIGHT; h++)
    {
        for(uint16_t w=0; w < VGA_WIDTH; w++)
        {
            video_mem[(h * VGA_WIDTH) + w] = term_make_char(' ', 0);
        }
    }

    term_pos_x = 0;
    term_pos_y = 0;
}


uint16_t term_make_char(char c, char color)
{
    return (term_fg_color << 8 | c);
}


void term_putchar(int h, int w, char c, char color)
{
    video_mem[h * VGA_WIDTH + w] = term_fg_color << 8 | c;
}


void term_print_string(const char* message)
{
    const char* p = message;
    while(*p != '\0')
    {

        if(*p == '\n')
        {
            term_pos_y++;
            term_pos_x = 0;
            p++;
            continue;
        }

        if(term_pos_x >= VGA_WIDTH)
        {
            term_pos_x = 0;
            term_pos_y++;
        }

        video_mem[term_pos_y * VGA_WIDTH + term_pos_x] = (term_fg_color << 8) | (char)*p;

        term_pos_x++;
        p++;
    }
}


/*
 * strlen method
 */
size_t strlen(const char* str)
{
    size_t len = 0;
    while(str[len] != '\0')
    {
        len++;
    }

    return len;
}


void kernel_main()
{
    term_clear();


    term_print_string("BobOS v0.0.1\n\nReady?\n\0");

    term_putchar(VGA_HEIGHT-1, VGA_WIDTH-1, '*', 15);

    term_print_string("Dang it!\0");

    idt_init();

    outb(0x60, 0xFF);

    term_putchar(10, 0, 'A', 5);
}


