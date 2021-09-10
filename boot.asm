ORG 0
BITS 16

_start:
jmp short start 
nop
times 33 db 0
start:
    jmp 0x7c0:step2 ;BIOS parameter block implementation so that the BIOS dosent get corrupted on different machines 

handle_zero:
mov ah,0eh
mov al, 'A'
mov bx, 0x00
int 0x10
iret

handle_one:
mov ah,0eh
mov al, 'V'
mov bx, 0x00
int 0x10
iret 

step2:
    cli ; Clear interrupts 
    mov ax , 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00

    
    sti; Enables Interrupts

    mov ah,2 ; READ SECTOR COMMAND
    mov al, 1 ;     one sector to read  
    mov ch, 0 ; Cyclinder low eight bits 
    mov cl,2; Read sector two
    mov dh, 0; Head Number 
    mov bx, buffer 
    int 0x13
    jc error ; Jumo Cary if JC flag is set 

    mov si , buffer 
    call print 
    jmp $

error:
    mov si,error_message
    call print 
    jmp $

print:
   mov bx, 0
.loop:
   lodsb
   cmp al,0
   je .done
   call print_char
   jmp .loop
.done:
    ret

print_char:
    mov ah, 0eh  
    int 0x10
    ret
error_message: db 'Failed to load sector',0
times 510-($ - $$) db 0
dw 0xAA55 

buffer:


