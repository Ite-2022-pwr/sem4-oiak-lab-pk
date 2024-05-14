BITS 64                             ; Ustawia tryb bitowy procesora na 64 bity.

section .data                       ; Definiuje sekcję danych.
    extern tab                      ; Deklaruje zewnętrzną zmienną 'tab'.
    printfFormat db "%d ", 0        ; Definiuje format dla funkcji printf.

section .rodata                     ; Definiuje sekcję tylko-do-odczytu danych.
    extern len                      ; Deklaruje zewnętrzną zmienną 'len'.

section .text                       ; Definiuje sekcję kodu.
    global main                     ; Deklaruje główną funkcję programu 'main'.
    extern printf                   ; Deklaruje zewnętrzną funkcję 'printf'.

main:                               ; Początek funkcji 'main'.
    push rbp                        ; Zapisuje obecny stan rejestru rbp na stosie.
    mov rbp, rsp                    ; Ustawia rbp na wartość stosu (tworzy ramkę stosu).

    mov eax, dword [len]            ; Wczytuje wartość zmiennej 'len' do rejestru eax.
    mov r10, rax                    ; Kopiuje wartość len do rejestru r10.
    mov rcx, r10                    ; Kopiuje wartość r10 do rcx (do użycia w pętli).

    mov rax, 1                      ; Ustawia rax na 1 (do użycia w pętli).

_loop:                              ; Rozpoczyna pętlę.
    mov rbx, r10                    ; Kopiuje wartość r10 do rbx (do użycia w pętli).
    sub rbx, rcx                    ; Odejmuje wartość rcx od rbx (do użycia w pętli).

    push rcx                        ; Zapisuje wartość rcx na stosie.
    push r10                        ; Zapisuje wartość r10 na stosie.

    mov esi, dword [tab + rbx * 4]  ; Wczytuje wartość z tablicy 'tab'.
    imul esi                        ; Mnoży wartość rax przez wartość w esi.

    mov rax, 10                     ; Ustawia rax na 10.
    mov rdi, printfFormat           ; Wczytuje format dla funkcji printf.
    mov rax, 0                      ; Ustawia rax na 0 (do użycia w funkcji printf).
    call printf                     ; Wywołuje funkcję printf.

    pop r10                         ; Pobiera wartość r10 ze stosu.
    pop rcx                         ; Pobiera wartość rcx ze stosu.

    loop _loop                      ; Dekrementuje rcx i powtarza pętlę, jeśli rcx nie jest zerem.

    leave                           ; Czyści ramkę stosu.
    ret                             ; Zakończenie funkcji 'main'.
