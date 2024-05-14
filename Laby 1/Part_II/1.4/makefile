# makefile dla 1.4.asm 
1.4: 1.4.o 
	gcc -o 1.4 1.4.o -no-pie 
1.4.o: 1.4.asm 
	nasm -f elf64 -g -F dwarf 1.4.asm -l 1.4.lst
