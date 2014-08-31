[ org 0x7c00 ]
	mov [ BOOT_DRIVE ], dl ; BIOS stores our boot drive in DL , so it ’s
	                       ; best to remember this for later.
						   
	mov bp , 0x8000        ; Here we set our stack safely out of the
	mov sp , bp            ; way , at 0 x8000
	
	mov bx , 0x9000        ; Load 5 sectors to 0 x0000 (ES ):0 x9000 (BX)
	mov dh , 5             ; from the boot disk.
	mov dl , [ BOOT_DRIVE ]
	call disk_load
	
	mov ah, 0x0e
	mov al , [0x9000 ]    
	int 0x10        

						   
	mov al , [0x9000 + 512] 
	int 0x10          
	jmp $

%include "print_string.asm" ; Re - use our print_string function
%include "disk_load.asm"

; Global variables
BOOT_DRIVE : db 0

; Bootsector padding
times 510 -( $ - $$ ) db 0
dw 0xaa55

; We know that BIOS will load only the first 512 - byte sector from the disk ,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers , we can prove to ourselfs that we actually loaded those
; additional two sectors from the disk we booted from.
times 512 db 'A'
times 512 db 'B'