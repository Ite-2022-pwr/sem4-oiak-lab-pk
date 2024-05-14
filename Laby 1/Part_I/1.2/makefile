# makefile dla 1.2_hello.asm 
1.2_hello: 1.2_hello.o 
	gcc -o 1.2_hello 1.2_hello.o -no-pie 
1.2_hello.o: 1.2_hello.asm 
	nasm -f elf64 -g -F dwarf 1.2_hello.asm -l 1.2_hello.lst
