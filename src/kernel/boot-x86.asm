org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A ; /r/n

;
; Entry point
;
start:
    jmp main

;
; Prints a string to the screen.
; Params:
;   - ds:si points to a string
;
puts:
    ; save registers we will modify
    push si
    push ax

.loop:
    lodsb           ; loads next character in al
    or al, al       ; verify if next character is null
    jz .done

    mov ah, 0x0e    ; call bios interrupt to write to tty
    ; mov bh, 0
    int 0x10
    jmp .loop

.done:
    pop ax
    pop si
    ret

;
; Main function
;
main:
    
    ; setup data segments
    mov ax, 0       ; can't write directly to ds
    mov ds, ax
    mov es, ax

    ; setup stack segment
    mov ss, ax
    mov sp, 0x7C00  ; stack grows downwards from where we are loaded in memory

    ; print hello world
    mov si, msg_hello
    call puts



    hlt



; In case it gets resumed by an interrupt
.halt:
    jmp .halt


msg_hello:  db 'Hello world!', ENDL, 0


; BIOS expects a 2 byte signiate of AA55 at last 2 bytes of the 512 bytes sector
; pad everyting else to 0

times 510-($-$$) db 0
dw 0AA55h
