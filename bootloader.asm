[org 0x7c00]           ; Origin, the location where BIOS loads the bootloader
bits 16                ; 16-bit real mode

start:
    mov ax, 0x07c0     ; Set up the segment registers
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

    cli                ; Disable interrupts
    cld                ; Clear direction flag

    ; Load kernel
    mov si, kernel_msg
    call print_string

    ; Hang
hang:
    jmp hang

print_string:
    ; Print string pointed by SI
    mov ah, 0x0e
.repeat:
    lodsb              ; Load byte at DS:SI into AL and increment SI
    or al, al          ; Check if zero byte (end of string)
    jz .done
    int 0x10           ; BIOS video interrupt to print character
    jmp .repeat
.done:
    ret

kernel_msg db 'Loading kernel...', 0

times 510-($-$$) db 0  ; Fill the rest of the bootloader with zeros
dw 0xaa55              ; Boot signature
