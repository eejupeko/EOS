C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
OBJ = ${C_SOURCES:.c=.o}

# $^ is substituted with all of the target’s dependancy files
# $< is the first dependancy and $@ is the target file

all: os-image

run: all
	bochs
	
os-image: boot/boot_sect.bin kernel.bin
	copy /b boot\boot_sect.bin+kernel.bin os-image
	
kernel.bin:  kernel/kernel_entry.o ${OBJ}
	ld -T NUL -o kernel.tmp -Ttext 0x1000 $^
	objcopy -O binary -j .text kernel.tmp kernel.bin
	
%.o : %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@
	
%.o : %.asm
	nasm $< -f elf -o $@

boot/boot_sect.bin: 
	nasm boot/boot_sect.asm -f bin -I './boot/' -o boot/boot_sect.bin
	
#%.bin : %.asm
#	nasm $< -f bin -I '../../16bit/' -o $@
	
rmv:
	del "kernel\*.o"
	del "boot\*.bin"
	del "drivers\*.o"
	del "*.bin"
	del "*.dis"
	del "*.o"
	del os-image
	del kernel.tmp
	

