; 2. Pobrać ze standardowego strumienia wejściowego ciąg znaków dowolnej długości, 
;        - potraktować każdy znak jako zapis cyfry szesnastkowej (np. znak 'A' odpowiada wartości 10 dziesiętnie)
;        - skonstruować liczbę w kodzie naturalnym binarnym lub U2. Wynik wypisać na standardowy strumień wyjściowy. 
;        - Zakładamy, że wprowadzane są wyłącznie znaki 'A'­'F' i cyfry.

; * 3. To samo, co w punkcie 2, ale należy dodać kod wykrywający niepoprawne znaki we wczytanym ciągu.


section .bss
    hex_buffer  resb    20              ; bufor dla liczby szesnastkowej
    bin_buffer  resb    64              ; bufor dla liczby binarnej

section .text
    global main

main:
    call    _reading                    ; wywołanie procedury wczytywania liczby
    mov     rdi, hex_buffer             ; przenoszenie adresu hex_buffer do rdi
    call    _hex_to_decimal             ; wywołanie procedury zamiany systemów liczbowych

    call    _writing                    ; wywołanie procedury wypisywania wyniku
    call    _ending                     ; wywołanie procedury zakończenia programu

_reading:
    mov     rax, 0			            ; 0 = reading
    mov     rdi, 0                      ; 0 = stdin
    mov     rsi, hex_buffer             ; przeniesienie adresu hex_buffer do rsi
    mov     rdx, 20                     ; ustawienie długości odczytu na 20 bajtów
    syscall                             ; wywołanie funkcji systemu operacyjnego
    ret                                 ; powrót do miejsca w pamięci sprzed funkcji

_writing:
    mov     rax, 1                      ; 1 = wypisanie
    mov     rdi, 1                      ; 1 = stdout
    mov     rsi, bin_buffer             ; przeniesienie adresu bin_buffer do rsi
    mov     rdx, 64                     ; ustawienie długości zaposu na 64 bajty
    syscall                             ; wywołanie funkcji systemu operacyjnego
    ret                                 ; powrót do miejsca w pamięci sprzed funkcji

_ending:
    mov     rax, 60                     ; 60 = wyjście
    mov     rdi, 0                      ; 0 = wyjściowy kod sygnalizujący sukces
    syscall                             ; zakończenie

_hex_to_decimal:
    xor     rax, rax                    ; wyczyszczenie rax (licznika)
    xor     rbx, rbx                    ; wyczyszczenie rbx (indeksu)
    
_to_decimal:
    movzx   rdx, byte [rdi + rbx]       ; przenoszenie pojedynczego znaku szesnastkowego do rdx
    test    rdx, rdx                    ; testowanie czy rdx jest zerem
    jz      _done_conversion            ; koniec konwersji, jesli tak
    
    cmp     rdx, '0'                    ; porównanie rdx z '0' w kodzie ASCII
    jl      _not_digit                  ; jeśli rdx jest mniejsze niż '0', to nie jest cyfrą
    cmp     rdx, '9'                    ; porównanie rdx z kodem ASCII '9'
    jg      _not_digit                  ; jeśli rdx jest większe niż '9', to nie jest cyfrą
    
    sub     rdx, '0'                    ; konwertuje cyfrę do jej wartości dziesiętnej
    jmp     _continue_loop              ; kontynuowanie pętli
    
_not_digit:
    cmp     rdx, 'A'                    ; porównanie rdx z kodem ASCII 'A'.
    jl      _not_letter                 ; jeśli rdx jest mniejsze niż 'A', to nie jest literą
    cmp     rdx, 'F'                    ; porównanie rdx z kodem ASCII 'F'
    jg      _not_letter                 ; jeśli rdx jest większe niż 'F', to nie jest literą

    sub     rdx, 'A' - 10               ; konwertowanie litery do jej wartości dziesiętnej
    
_continue_loop:
	imul	rax, rax, 16                ; mnożenie rax przez 16
	add	    rax, rdx                    ; dodanie wartość aktualnej cyfry/litery do rax
	inc	    rbx                         ; inkrementowanie indeksu
	jmp	    _to_decimal                 ; powrót do pętli konwersji
    
_not_letter:
    inc 	rbx                         ; inkrementowanie indeksu
    jmp 	_to_decimal                 ; powrót do pętli konwersji
    
_done_conversion:
    mov 	rbx, 2                      ; ustawienie rbx na 2 (dla konwersji na binarny)
    mov	    rsi, bin_buffer             ; przenoszenie adresu bin_buffer do rsi
    add	    rsi, 63                     ; przesunięcie wskaźnika rsi na koniec bufora

_convert_to_binary:
	test	rax, rax                    ; testowamie czy rax jest zerem
	jz	    _done_converting            ; jeśli rax jest zerem, zakończenie kowersji

	xor	    rdx, rdx                    ; wyczyszczenie rdx
	div	    rbx                         ; dzielenie wartości w rax przez 2.
	add	    dl, '0'                     ; dodanie '0' lub '1' do bufora binarnego
	mov	    [rsi], dl                   ; zapisanie wyniku do bufora binarnego
	dec	    rsi                         ; dekrementowanie wskaźnika rsi
	jmp	    _convert_to_binary          ; powrót do konwersji

_done_converting:
	ret                                 ; powrót do miejsca w pamięci sprzed funkcji
