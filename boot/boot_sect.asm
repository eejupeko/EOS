[org 0x7c00]
KERNEL_OFFSET equ 0x1000   ; Muistipaikka, josta ladataan kerneli

	mov [BOOT_DRIVE], dl 

	mov bp, 0x9000	;asetetaan pino kondikseen
	mov sp, bp
	
	mov bx, MSG_REAL_MODE
	call print_string
	
	call load_kernel
	
	call switch_to_pm
jmp $

%include "print_string.asm"
%include "print_string_pm.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"
%include "disk_load.asm"

[bits 16]
load_kernel:
	mov bx, MSG_LOAD_KERNEL
	call print_string
	
	mov bx, KERNEL_OFFSET   ; ladataan kerneli KERNEL_OFFSET:iin
	mov dh,15
	mov dl, [BOOT_DRIVE]
	call disk_load
	
	ret
	
[bits 32]
; tänne hypätään, kun protected mode on alustettu ja vaihdettu käyttöön
BEGIN_PM:

	mov ebx, MSG_PROT_MODE
	call print_string_pm
	
	call KERNEL_OFFSET   ; Hypätään kernelin koodiin.
	jmp $
	
; globaalit muuttujat
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Succesfully switched to 32-bit protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0 

times 510-($-$$) db 0 ;viimeistelyt, jotta tunnistetaan bootsectoriksi
dw 0xaa55