; kernel_entry.asm
; 没毛病吧？
[bits 32]
[extern kernel_main]

section .text
global start
start:
    cli                         ; Clear interrupts
    cld                         ; Clear direction flag
    xor eax, eax                ; Clear the EAX register
    mov ds, ax                  ; Set DS register to 0
    mov es, ax                  ; Set ES register to 0
    mov fs, ax                  ; Set FS register to 0
    mov gs, ax                  ; Set GS register to 0
    mov ebp, eax                ; Clear the EBP register
    mov esp, 0x90000            ; Set stack pointer (just an example)
    
    call kernel_main            ; Call the kernel main function

hang:
    hlt                         ; Halt the CPU
    jmp hang                    ; Infinite loop to hang
