[bits 16]

switch_to_pm:
	cli		; interruptid pois päältä
	
	lgdt [gdt_descriptor] ; lataa gdt:n
	
	mov eax, cr0
	or eax, 0x1
	mov cr0,eax
	
	jmp CODE_SEG:init_pm    ; pitkä hyppy, jotta cpu pipelinet tyhjenee
	
[bits 32]

init_pm:
	mov ax, DATA_SEG    ; vanhat turhat segmentit viittaamaan gdt:ssä luotuun
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	mov ebp, 0x90000
	mov esp, ebp
	
	call BEGIN_PM