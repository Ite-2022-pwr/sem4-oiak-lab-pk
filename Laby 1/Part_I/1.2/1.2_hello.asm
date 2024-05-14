; hello.asm
section .data
	
section .bss
	msg 	resb	80		; bufor na wczytany ciag znakow
	
section .text
	global main
main:
	; reading from stdin
	xor	rax, rax		; 0 = read	xor a a => 0, xor a b => 1
	xor	rdi, rdi		; 0 = stdin, pierwszy argument funkcji
	mov	rsi, msg		; adres bufora, ktory ma byc zapisany wczytany ciag
	mov	rdx, 80			; dlugosc lancucha bufora
	syscall

	; writing to stdout
	mov	rax, 1			; 1 = wypisz
	mov	rdi, 1			; 1 = stdout, pierwszu argument funkcji
	mov	rsi, msg		; lancuch do wyswietlenia
	mov	rdx, 80			; dlugosc lancucha
	syscall				; wywolanie funkcji systemu operacyjnego

	mov	rax, 60			; 60 = wyjscie
	mov	rdi, 0			; 0 = wyjsciowy kod sygnalizujacy sukces
	syscall				; zakoncz
