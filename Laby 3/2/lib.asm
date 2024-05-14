BITS 64                ; Ustawia tryb bitowy procesora na 64 bity.

section .text          ; Definiuje sekcję kodu.
    global addInt      ; Deklaruje funkcję addInt jako globalną, aby była widoczna z zewnątrz.
    global subFloat    ; Deklaruje funkcję subFloat jako globalną, aby była widoczna z zewnątrz.
    global nwd         ; Deklaruje funkcję nwd jako globalną, aby była widoczna z zewnątrz.
    extern _fun_modulo ; Deklaruje zewnętrzną funkcję _fun_modulo.

addInt:                ; Definicja funkcji addInt.
    push rbp           ; Zapisuje obecny stan rejestru rbp na stosie.
    mov rbp, rsp       ; Ustawia rbp na wartość stosu (tworzy ramkę stosu).

    mov rax, rdi       ; Przenosi pierwszy argument do rax.
    add rax, rsi       ; Dodaje drugi argument do rax.

    leave              ; Czyści ramkę stosu.
    ret                ; Zwraca wynik.

subFloat:              ; Definicja funkcji subFloat.
    push rbp           ; Zapisuje obecny stan rejestru rbp na stosie.
    mov rbp, rsp       ; Ustawia rbp na wartość stosu (tworzy ramkę stosu).

    subss xmm0, xmm1  ; Odejmuje wartości xmm1 od xmm0 (dzięki SSE instrukcji).

    leave              ; Czyści ramkę stosu.
    ret                ; Zwraca wynik.

nwd:                   ; Definicja funkcji nwd.
    cmp rsi, 0         ; Porównuje drugi argument z zerem.
    je _end            ; Jeśli jest zerem, przechodzi do _end.

    jne _calc          ; W przeciwnym razie przechodzi do _calc.

_calc:                 ; Etap obliczeń w funkcji nwd.
    call _fun_modulo   ; Wywołuje funkcję _fun_modulo.
    push rsi           ; Zapisuje drugi argument na stosie.
    mov rsi, rax       ; Przenosi wynik z funkcji modulo do rsi.
    pop rdi            ; Pobiera drugi argument ze stosu.
    jmp nwd            ; Powraca do nwd.

_end:                  ; Obsługuje zakończenie funkcji nwd.
    mov rax, rdi       ; Przenosi pierwszy argument do rax.
    leave              ; Czyści ramkę stosu.
    ret                ; Zwraca wynik.

_fun_modulo:           ; Definicja funkcji _fun_modulo.
    cmp rsi, 0         ; Porównuje drugi argument z zerem.
    je _devide_by_zero ; Jeśli jest zerem, przechodzi do _devide_by_zero.

    xor rdx, rdx       ; Czyści rdx (dzięki instrukcji xor).

    mov rax, rdi       ; Przenosi pierwszy argument do rax.
    div rsi            ; Dzieli rax przez rsi, wynik w rax, reszta w rdx.
    jmp _exit          ; Przechodzi do _exit.

_devide_by_zero:       ; Obsługuje dzielenie przez zero.
    mov rax, 0         ; Ustawia wynik na zero.
    ret                ; Zwraca wynik.

_exit:                 ; Obsługuje zakończenie funkcji _fun_modulo.
    mov rax, rdx       ; Przenosi resztę z dzielenia do rax (wynik funkcji).
    ret                ; Zwraca wynik.
