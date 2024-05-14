# Zadanie 4: C w asm 
C_w_asm.out: C_w_asm.o C_w_asm.c
	gcc -no-pie -ggdb -o C_w_asm.out C_w_asm.c C_w_asm.o
C_w_asm.o: C_w_asm.asm
	nasm -f elf64 -g -F dwarf C_w_asm.asm -l C_w_asm.lst