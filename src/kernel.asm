[BITS 32]

global _start
extern kernel_main

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

    ; Remap the master PIC
    mov al, 00010001b       ; put in init mode.
    out 0x20, al            ; tell master
    
    mov al, 0x20            ; interrupt 0x20 is where master ISR should start, Master IRQ0 should be on INT 0x20
    out 0x21, al

    mov al, 00000001b   
    out 0x21, al
    ; end of reamapping master PIC

    ; Enable interrupts
    sti

    call kernel_main

    jmp $


; make sure asm code aligns properly to prevent issues with C objects
times 512-($-$$) db 0
