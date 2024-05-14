; 1.1 Pobranie ze standardowego strumienia wejściowego procesu ciąg znaków
;	zamienie wszystkich małych liter na wielkie, 
;	wszystkie wielkich na małe, 
;	zmienienie wielkości co drugiej litery itp.

section .data

section .bss
    msg resb 128 ; bufor do wczytania ciągu znaków

section .text
    global main
    
main:
    	call _reading       	; wywołanie funkcji _reading
    	mov rdi, msg		; ustawienie wskaznika programu na poczatek bufera
    	call _start          	; wywołanie pętli
   	call _printString	; wyswietlenie wyniku	
   	
    	mov rax, 60         	; 60 = wyjście
    	mov rdi, 0          	; 0 = wyjściowy kod sygnalizujący sukces
    	syscall             	; zakończenie


_reading:
    	xor rax, rax        	; 0 = read
    	xor rdi, rdi        	; 0 = stdin
    	mov rsi, msg        	; adres bufora, w którym ma być zapisany ciąg
    	mov rdx, 128        	; długość łańcucha bufora
    	syscall             	; wywołanie funkcji systemu operacyjnego
    	ret                 	; powrót do miejsca w pamięci sprzed funkcji

_printString:
    	mov rax, 1          	; 1 = wypisanie
    	mov rdi, 1          	; 1 = stdout
    	mov rsi, msg		; msg jako zmienna do wyswietlenia
    	mov rdx, rbx        	; długość łańcucha
    	syscall             	; wywołanie funkcji systemu operacyjnego
    	ret                 	; powrót

_start:
	mov rbx, 0		; wyzerowanie licznika

_loop:
    	movzx rsi, byte [rdi + rbx]		; ustawienie wskaznika danych na index iteratora
    	cmp rsi, 0				; sprawdzanie czy lancuch sie skonczyl
    	je _finish				; zakonczenie dzialania petli

_lowercase:
    	cmp rsi, 'a'         			; sprawdzenie czy to mała litera
    	jl _check_uppercase 			; jeśli znak ASCII jest mniejszy, sprawdź czy to duża litera
    	cmp rsi, 'z'         			; sprawdzenie czy to mała litera
    	jg _check_uppercase 			; jeśli znak ASCII jest większy, przejdź do następnej iteracji pętli
    	sub byte [rdi + rbx], 32          	; zmiana małej litery na dużą

_check_uppercase:
    	cmp rsi, 'A'         			; sprawdzenie czy to duża litera
    	jl _next_char         			; jeśli znak ASCII jest mniejszy, przejdź do następnej iteracji pętli
    	cmp rsi, 'Z'         			; sprawdzenie czy to duża litera
    	jg _next_char        			; jeśli znak ASCII jest większy, przejdź do następnej iteracji pętli
    	add byte [rdi + rbx], 32          	; zmiana dużej litery na małą

_next_char:
	inc rbx
	jmp _loop

_finish:
	inc rbx				; zwiekszenie licznika o 1
	mov byte [rdi + rbx], 10		
	mov rax, rbx				; przeniesienie rbx do rax
	ret					; powrot
