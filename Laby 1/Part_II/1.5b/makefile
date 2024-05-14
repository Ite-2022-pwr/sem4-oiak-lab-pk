# makefile dla 1.5b.asm 
1.5b: 1.5b.o 
	gcc -o 1.5b 1.5b.o -no-pie 
1.5b.o: 1.5b.asm 
	nasm -f elf64 -g -F dwarf 1.5b.asm -l 1.5b.lst
