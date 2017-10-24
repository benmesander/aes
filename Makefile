all:
#	nasm -f elf64 -F stabs -g -o io.o io.asm
#	ld io.o -o io
	nasm -f elf64 -F stabs -g -o aes.o aes.asm
	ld aes.o -o aes

