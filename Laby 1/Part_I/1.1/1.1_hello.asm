; hello.asm
section .data
	msg db		"witaj, swiecie",0
section .bss
section .text
	global main
main:
	mov	rax, 1		; 1 = wypisz
	mov	rdi, 1		; 1 = stdout
	mov	rsi, msg	; lancuch do wyswietlenia
	mov	rdx, 15		; dlugosc lancucha, bez 0
	syscall			; wywolanie funkcji systemu operacyjnego
	mov	rax, 60		; 60 = wyjscie
	mov	rdi, 0		; 0 = wyjsciowy kod sygnalizujacy sukces
	syscall			; zakoncz