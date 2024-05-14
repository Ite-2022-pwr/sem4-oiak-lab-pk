# makefile dla fibonacci.asm 
fibo.out: fibo.o
    gcc -ggdb -no-pie -o fibo.out fibo.o
fibo.o: fibo.asm
    nasm -f elf64 -g -F dwarf -l fibo.lst fibo.asm