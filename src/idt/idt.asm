section .asm

global idt_load
idt_load:
    push ebp
    mov ebp, esp

    mov ebx, [ebp+8] ; References to the first argument passed to this function
    lidt [ebx]
    pop ebp
    ret