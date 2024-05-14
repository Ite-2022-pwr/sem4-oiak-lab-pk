# makefile dla erastotenes.asm 
erastotenes: erastotenes.o 
	gcc -o erastotenes erastotenes.o -no-pie 
erastotenes.o: erastotenes.asm 
	nasm -f elf64 -g -F dwarf erastotenes.asm -l erastotenes.lst