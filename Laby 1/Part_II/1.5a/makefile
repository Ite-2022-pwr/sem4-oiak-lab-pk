# makefile dla 1.5a.asm 
1.5a: 1.5a.o 
	gcc -o 1.5a 1.5a.o -no-pie 
1.5a.o: 1.5a.asm 
	nasm -f elf64 -g -F dwarf 1.5a.asm -l 1.5a.lst
