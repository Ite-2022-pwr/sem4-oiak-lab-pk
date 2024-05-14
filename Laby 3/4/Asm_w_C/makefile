# Zadanie 4: asm w C
Asm_w_C.out: Asm_w_C.o Asm_w_C.c
	gcc -no-pie -ggdb -o Asm_w_C.out Asm_w_C.c Asm_w_C.o
Asm_w_C.o: Asm_w_C.asm
	nasm -f elf64 -g -F dwarf Asm_w_C.asm -l Asm_w_C.lst