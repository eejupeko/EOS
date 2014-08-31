print_string:
	pusha
	
	string_loop:
		mov al, [bx] ;bx = kirjoitettava viesti. 
		cmp al, 0
		je end_loop
		push bx 	  ;En tiedä säilyttääkö int 0x10 bx sisällön, joten tallennetaan varmuuden vuoksi
		mov ah, 0x0e  ;Tarvitaan seuraavaa varten. Varmuuden vuoksi tehdään joka kierroksella
		int 0x10	  ;BIOS merkin kirjoitus ruutuun 
		pop bx		  
		inc bx
		jmp string_loop
		
	end_loop:
		popa
		ret