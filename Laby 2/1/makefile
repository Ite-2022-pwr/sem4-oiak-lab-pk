# makefile dla euklides.asm 
euklides: euklides.o 
	gcc -o euklides euklides.o -no-pie 
euklides.o: euklides.asm 
	nasm -f elf64 -g -F dwarf euklides.asm -l euklides.lst
