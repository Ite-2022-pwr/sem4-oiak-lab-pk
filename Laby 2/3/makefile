# makefile dla sorting.asm 
sorting.out:    sorting.o
    gcc -ggdb -no-pie -o sorting.out sorting.o
sorting.o:  sorting.asm
    nasm -f elf64 -g -F dwarf -l sorting.lst sorting.asm