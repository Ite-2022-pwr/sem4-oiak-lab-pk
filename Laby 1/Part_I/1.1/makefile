# makefile dla 1.1_hello.asm 
1.1_hello: 1.1_hello.o 
	gcc -o 1.1_hello 1.1_hello.o -no-pie 
1.1_hello.o: 1.1_hello.asm 
	nasm -f elf64 -g -F dwarf 1.1_hello.asm -l 1.1_hello.lst
