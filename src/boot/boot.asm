ORG 0x7c00
BITS 16

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start 
_start:
    jmp short start 
    nop
times 33 db 0
start:
    jmp 0:step2 ;BIOS parameter block implementation so that the BIOS dosent get corrupted on different machines 


step2:
    cli ; Clear interrupts 
    mov ax , 0x00
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00
    sti; Enables Interrupts

.load_protected:
    cli
    lgdt[gdt_descriptor]
    mov eax, cr0
    or eax,0x1
    mov cr0,eax
    jmp CODE_SEG:load32
    
; GDT

gdt_start:
gdt_null:
    dd 0x0
    dd 0x0
; offset 0x8
gdt_code:
    dw 0xffff
    dw 0
    db 0
    db 0x9a
    db 11001111b ; High 4 bit flag and the low bit flag
    db 0

;offset 0x10
gdt_data:
    dw 0xffff
    dw 0
    db 0
    db 0x92
    db 11001111b ; High 4 bit flag and the low bit flag
    db 0

gdt_end:
gdt_descriptor:
    dw gdt_end - gdt_start-1
    dd gdt_start
[BITS32]
load32:
    mov eax, 1
    mov ecx, 100
    mov edi, 0x0100000
    call ata_lba_read


times 510-($ - $$) db 0
dw 0xAA55 

