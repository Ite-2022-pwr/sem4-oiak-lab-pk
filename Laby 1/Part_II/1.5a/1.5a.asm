; 5a. Pobrać ze standardowego strumienia wejściowego ciąg znaków o dowolnej długości, 
;    - potraktować ten ciąg jako zapis dziesiętny pewnej liczby
;    - zapisać wartość tej liczby binarnie w pamięci

section .bss
    decimal_input resb 20      ; Bufor na wprowadzony ciąg dziesiętny
    binary_output resb 64      ; Bufor na wyjściową liczbę binarną

section .text
    global main

main:
    call _reading               ; Wywołanie podprogramu do wczytania danych

    mov rdi, decimal_input      ; Ustawienie rdi na adres ciągu dziesiętnego
    call _dec_to_bin           ; Wywołanie podprogramu do konwersji dziesiętnej na binarną

    call _writing              ; Wywołanie podprogramu do wypisania wyniku binarnego
    call _ending_program       ; Wywołanie podprogramu do zakończenia programu

_reading:
    mov rax, 0                 ; Numer wywołania systemowego dla sys_read (0)
    mov rdi, 0                 ; Deskryptor pliku dla standardowego wejścia (0)
    mov rsi, decimal_input     ; Adres bufora decimal_input
    mov rdx, 20                ; Maksymalna liczba bajtów do odczytu
    syscall                    ; Wywołanie systemowe
    ret

_writing:
    mov rax, 1                 ; Numer wywołania systemowego dla sys_write (1)
    mov rdi, 1                 ; Deskryptor pliku dla standardowego wyjścia (1)
    mov rsi, binary_output     ; Adres bufora z wynikiem binarnym
    mov rdx, 64                ; Maksymalna liczba bajtów do zapisania
    syscall                    ; Wywołanie systemowe
    ret

_ending_program:
    mov rax, 60                ; Numer wywołania systemowego dla sys_exit (60)
    mov rdi, 0                 ; Kod wyjścia (0)
    syscall                    ; Wywołanie systemowe

_dec_to_bin:
    mov rax, 0                 ; Wyzerowanie rax
    mov rcx, 0                 ; Wyzerowanie rcx (licznik cyfr)
    mov rdx, 0                 ; Wyzerowanie rdx (reszta z dzielenia)

_next_digit:
    movzx rdx, byte [rdi + rcx] ; Wczytanie kolejnej cyfry
    cmp rdx, 0
    je _done_conversion        ; Jeśli koniec ciągu, zakończ konwersję

    sub rdx, '0'               ; Konwersja ASCII na wartość liczbową
    imul rax, rax, 10          ; Przesunięcie cyfr dziesiętnych w lewo
    add rax, rdx               ; Dodanie kolejnej cyfry dziesiętnej
    inc rcx                    ; Zwiększenie licznika cyfr
    jmp _next_digit            ; Powtórzenie dla kolejnej cyfry

_done_conversion:
    mov rbx, 2                 ; Podstawa systemu binarnego
    mov rsi, binary_output     ; Adres bufora dla liczby binarnej
    add rsi, 63                ; Przesunięcie wskaźnika na koniec bufora

_convert_to_bin:
    cmp rax, 0                 ; Sprawdzenie, czy rax jest równy 0
    je _done_converting        ; Jeśli tak, zakończ konwersję

    mov rdx, 0                 ; Wyzerowanie rdx
    div rbx                    ; Dzielenie rax przez rbx, wynik w rax, reszta w rdx
    add dl, '0'                ; Dodanie wartości ASCII do reszty
    mov [rsi], dl              ; Zapisanie reszty do bufora
    dec rsi                    ; Przesunięcie wskaźnika w lewo
    jmp _convert_to_bin        ; Powtórzenie procesu konwersji

_done_converting:
    ret
