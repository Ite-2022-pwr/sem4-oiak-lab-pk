# makefile dla 1.2_3.asm 
1.2_3: 1.2_3.o 
	gcc -o 1.2_3 1.2_3.o -no-pie 
1.2_3.o: 1.2_3.asm 
	nasm -f elf64 -g -F dwarf 1.2_3.asm -l 1.2_3.lst
