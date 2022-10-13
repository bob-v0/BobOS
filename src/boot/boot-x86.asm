org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A ; /r/n

;
; FAT12 Header
; 
jmp short start
nop

bdb_oem:                    db 'MSWIN4.1'           ; 8 bytes
bdb_bytes_per_sector:       dw 512
bdb_sectors_per_clustor:    db 1
bdb_reserved_Sectors:       dw 1
bdb_fat_count:              db 2
bdb_dir_entries_count:      dw 0E0h
bdb_total_sectors:          dw 2880                 ; 2880 * 512 = 1.44MB
bdb_media_descriptor_type:  db 0F0h                 ; F0 = 3.5" floppy disk
bdb_sectors_per_fat:        dw 9
bdb_sectors_per_track:      dw 18
bdb_heads:                  dw 2
bdb_hidden_sectors:         dd 0
bdb_large_sector_count:     dd 0

; extended boot record
ebr_drive_number:           db 0                    ; 0x00 floppy, 0x80 hdd which is pretty useless
                            db 0                    ; reserved
ebr_signature:              db 29h
ebr_volume_id:              db 12h, 34h, 56h, 78h   ; serial number, value doens't matter
ebr_volume_label:           db 'BobOS      '        ; 11 bytes space padded
ebr_system_id:              db 'FAT12   '           ; 8 bytes


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


    cli                 ; Disable interrupts so the CPU can't get out of halted state
    hlt



; In case it gets resumed by an interrupt
.halt:
    cli                 ; Disable interrupts so the CPU can't get out of halted state
    hlt
    jmp .halt


msg_hello:  db 'Booting BobOS ...', ENDL, 0


; BIOS expects a 2 byte signiate of AA55 at last 2 bytes of the 512 bytes sector
; pad everyting else to 0

times 510-($-$$) db 0
dw 0AA55h
