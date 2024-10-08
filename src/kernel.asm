[BITS 32]

global _start
extern kernel_start
extern problem

CODE_SEG equ 0x08
DATA_SEG equ 0x10

_start: ; start of entering 32bit mode
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x00200000
    mov esp, ebp

    ; Enable the A20 line
    in al, 0x92
    or al, 2
    out 0x92, al


    call kernel_start

    call problem

    jmp $

problem:
    mov eax, 0
    div eax


; make sure asm code aligns properly to prevent issues with C objects
times 512-($-$$) db 0
