; 4. Pobrać ze standardowego strumienia wejściowego ciąg bajtów o zadanej długości
;        - wyprowadzić na standardowy strumień wyjściowy ciąg znaków reprezentujący szesnastkowy zapis wartości tej liczby.

section .bss
    binary_input resb 64    ; Bufor na wczytany ciąg znaków
    hex_output resb 20      ; Bufor na zapisaną liczbę heksadecymalną

section .text
    global _main

_main:
    call _reading           ; Wywołuje procedurę wczytującą.

    mov rax, 0              ; Zeruje wartość rax (wartość dziesiętna).

_parse_loop:
    cmp byte [rsi], 0       ; Porównuje aktualny bajt z 0 (czy koniec ciągu).
    je _end_parse           ; Jeśli koniec, przejdź do _end_parse.

    call _process_char      ; Wywołuje procedurę przetwarzającą znak.

    inc rsi                 ; Inkrementuje wskaźnik rsi.
    jmp _parse_loop         ; Powrót do pętli parsowania.

_reading:
    mov rax, 0              ; Wypełnia rax 0 (kod syscallu dla odczytu).
    mov rdi, 0              ; Ustawia rdi na standardowe wejście.
    mov rsi, binary_input   ; Przenosi adres bufora binary_input do rsi.
    mov rdx, 64             ; Ustawia maksymalną długość ciągu na 64 bajty.
    syscall                 ; Wywołuje systemowy syscall do odczytu.
    ret                     ; Powrót.

_writing:
    mov rax, 1              ; Wypełnia rax 1 (kod syscallu dla zapisu).
    mov rdi, 1              ; Ustawia rdi na standardowe wyjście.
    mov rdx, 20             ; Ustawia długość ciągu szesnastkowego na 20 bajtów.
    syscall                 ; Wywołuje systemowy syscall do zapisu.
    ret                     ; Powrót.

_ending_program:
    mov rax, 60             ; Wypełnia rax 60 (kod syscallu dla wyjścia).
    xor rdi, rdi            ; Ustawia rdi na kod zakończenia 0.
    syscall                 ; Wywołuje systemowy syscall do zakończenia programu.

_end_parse:
    mov rsi, hex_output     ; Przenosi adres bufora hex_output do rsi.
    call _int_to_hex        ; Wywołuje procedurę konwertującą na szesnastkowy.

    call _writing           ; Wywołuje procedurę wypisywania.
    call _ending_program    ; Wywołuje procedurę zakończenia programu.

_process_char:
    cmp byte [rsi], '0'     ; Porównuje aktualny znak z '0'.
    je _zero                ; Jeśli '0', przejdź do _zero.
    cmp byte [rsi], '1'     ; Porównuje aktualny znak z '1'.
    jne _not_binary         ; Jeśli nie '1', przejdź do _not_binary.

    shl rax, 1              ; Przesuwa wartość w lewo o 1 bit.
    add rax, 1              ; Dodaje 1, jeśli bit to '1'.
    ret                     ; Powrót.

_zero:
    shl rax, 1              ; Przesuwa wartość w lewo o 1 bit.
    ret                     ; Powrót.

_not_binary:
    ret                     ; Powrót.

_int_to_hex:
    mov rbx, 16             ; Ustawia rbx na 16 (podstawa systemu szesnastkowego).

_reverse_loop:
    dec rsi                 ; Dekrementuje wskaźnik rsi (przesuwa na koniec bufora).
    test rax, rax           ; Sprawdza, czy rax wynosi 0.
    jz _end_reverse         ; Jeśli tak, zakończ odwracanie.

    mov rdx, 0              ; Wypełnia rdx 0.
    div rbx                 ; Dzieli wartość w rax przez 16, wynik w rax, reszta w rdx.
    add dl, '0'             ; Konwertuje resztę na znak ASCII.
    cmp dl, '9'             ; Sprawdza, czy reszta to cyfra (0-9).
    jbe _store_digit        ; Jeśli tak, zapisuje bezpośrednio.
    add dl, 7               ; Jeśli nie, dodaje 7, aby uzyskać litery A-F.

_store_digit:
    mov [rsi], dl           ; Zapisuje znak do bufora.
    jmp _reverse_loop       ; Powrót do pętli odwracania.

_end_reverse:
    inc rsi                 ; Inkrementuje wskaźnik rsi (przesuwa na początek bufora).
    ret                     ; Powrót.
