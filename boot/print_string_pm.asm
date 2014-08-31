[bits 32]
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; kirjoittaa nollaan loppuvan merkkijonon, jonka osoite on EBX:ssä
print_string_pm:
	pusha
	mov edx, VIDEO_MEMORY ; asettaa edx osoittamaan video muistin alkuun
	
print_string_pm_loop:
	mov al, [ebx]          ; merkki -> al
	mov ah, WHITE_ON_BLACK ; attribuutit -> ah
	
	cmp al, 0x0f
	je print_string_pm_done
	
	mov [edx], ax          ; tallennetaan attribuuttit
	
	add ebx, 1			   ; siirretään EBX seuraavaan merkkiin
	add edx, 2			   ; siirrytään seuraavaan videomuistikohtaan
	
	jmp print_string_pm_loop
	
print_string_pm_done:
	popa
	ret