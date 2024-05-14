; 5b. Binarną reprezentację liczby z zadania 5 wypisać na standardowy strumień wyjściowy w postaci ciągu znaków reprezentujących wartość dziesiętną.

section .bss
    dec_input resb 20      ; Bufor na wprowadzoną liczbę dziesiętną
    bin_output resb 64     ; Bufor na wyjściową liczbę binarną
    dec_output resb 20     ; Bufor na wyjściowy ciąg znaków reprezentujących wartość dziesiętną

section .text
    global main            ; Główna funkcja programu

main:
    call _reading          ; Wywołanie podprogramu wczytującego dane

    mov rdi, dec_input     ; Przekazanie adresu bufora wejściowego
    call _dec_to_bin       ; Wywołanie podprogramu konwertującego na binarny
    call _bin_to_dec       ; Wywołanie podprogramu konwertującego na dziesiętny

    mov rsi, dec_output    ; Ustawienie adresu bufora wyjściowego
    call _dec_to_string    ; Konwersja liczby dziesiętnej na ciąg znaków
    call _writing          ; Wywołanie podprogramu wypisującego
    call _ending_program   ; Wywołanie podprogramu kończącego działanie programu

_reading:
    mov rax, 0             ; Numer wywołania systemowego SYS_READ
	mov rdi, 0             ; Deskryptor pliku dla standardowego wejścia
	mov rsi, dec_input     ; Bufor dla wczytywanej liczby dziesiętnej
	mov rdx, 20            ; Maksymalna długość danych wejściowych
	syscall                ; Wywołanie systemowe
    ret                    ; Powrót z podprogramu

_writing:
    mov rax, 1             ; Numer wywołania systemowego SYS_WRITE
    mov rdi, 1             ; Deskryptor pliku dla standardowego wyjścia
    mov rdx, 20            ; Długość bufora
    syscall                ; Wywołanie systemowe
    ret                    ; Powrót z podprogramu

_ending_program:
    mov rax, 60            ; Numer wywołania systemowego SYS_EXIT
    mov rdi, 0             ; Kod wyjścia
    syscall                ; Wywołanie systemowe

_dec_to_bin:
    xor rax, rax           ; Zerowanie wyniku
    xor rcx, rcx           ; Zerowanie licznika
    xor rdx, rdx           ; Zerowanie reprezentacji znaku

_next_decimal:
    movzx rdx, byte [rdi + rcx]  ; Wczytanie znaku do rdx
    cmp rdx, 0                   ; Sprawdzenie końca ciągu
    je _finish_decimal           ; Zakończenie konwersji 

    cmp rdx, '0'                 ; Sprawdzenie, czy znak jest cyfrą
    jl _not_digit                ; Znak nie jest cyfrą
    cmp rdx, '9'
    jg _not_digit

    sub rdx, '0'                 ; Konwersja ASCII na wartość liczbową
    imul rax, rax, 10            ; Przemnożenie wyniku przez 10
    add rax, rdx                 ; Dodanie kolejnej cyfry
    inc rcx                      ; Zwiększenie licznika
    jmp _next_decimal            ; Powtórzenie dla kolejnej cyfry

_not_digit:
    inc rcx                      ; Zwiększenie licznika, pominięcie znaku
    jmp _next_decimal            ; Powtórzenie dla kolejnego znaku

_finish_decimal:
    mov rsi, bin_output          ; Ustawienie adresu bufora wyjściowego
    add rsi, 63                  ; Przesunięcie na koniec bufora

_next_binary:
    cmp rax, 0                   ; Sprawdzenie końca liczby
    je _finish_binary            ; Zakończenie

    mov rdx, 0                   ; Zerowanie reszty z dzielenia
    mov rbx, 2                   ; Podstawa systemu binarnego
    div rbx                      ; Dzielenie przez 2
    add dl, '0'                  ; Konwersja na znak ASCII
    dec rsi                      ; Przesunięcie wskaźnika
    mov [rsi], dl                ; Zapisanie do bufora
    jmp _next_binary             ; Powtórzenie dla kolejnej cyfry

_finish_binary:
    ret                          ; Powrót z podprogramu

_bin_to_dec:
    mov rax, 0                   ; Wyzerowanie wartości wynikowej

_bin_parse_loop:
    cmp byte [rsi], 0            ; Sprawdzenie końca ciągu
    je _dec_done                 ; Zakończenie konwersji

    call _check_char             ; Obsługa znaku
    inc rsi                      ; Przesunięcie do następnego znaku
    jmp _bin_parse_loop          ; Powtórzenie dla kolejnego znaku

_check_char:
    cmp byte [rsi], '0'          ; Sprawdzenie, czy znak to '0'
    je _zero                     ; Jeśli tak, przetwarzaj jako 0
    cmp byte [rsi], '1'          ; Sprawdzenie, czy znak to '1'
    jne _not_binary              ; Jeśli nie, ignoruj
    shl rax, 1                   ; Przesunięcie o 1 bit w lewo
    add rax, 1                   ; Dodanie 1
    ret                          ; Powrót z podprogramu

_zero:
    shl rax, 1                   ; Przesunięcie o 1 bit w lewo
    ret                          ; Powrót z podprogramu

_not_binary:
    ret                          ; Ignorowanie innych znaków niż '0' i '1'

_dec_done:
    ret                          ; Zakończenie podprogramu

_dec_to_string:
    mov rbx, 10                  ; Podstawa systemu dziesiętnego

_dec_parse_loop:
    dec rsi                      ; Przesunięcie w lewo
    test rax, rax                ; Sprawdzenie, czy wyn
    jz _end_dec_loop

    mov rdx, 0                      ; wyzerownie reszty z dzielenia
    div rbx                         ; dzielenie rax / 10, wynik w rax, reszta w rdx
    add dl, '0'                     ; konwersja wartości zyfry na ascii
    mov [rsi], dl                   ; wpisanie reprezentacji do buffera
    jmp _dec_parse_loop             ; kolejna cyfra

_end_dec_loop:
    inc rsi
    ret