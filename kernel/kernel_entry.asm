[bits 32]
[extern _start]
call _start
jmp $

;	ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary