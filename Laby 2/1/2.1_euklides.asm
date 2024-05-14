section .text
    global main

main:
    mov rdi, 64             ; rdi - a 
    mov rsi, 4              ; rsi - b
    jmp _euklides           ; rozpoczecie dzialania funkcji euklides

_euklides:
    cmp rsi, 0              ; sprawdzenie czy b jest rowne 0
    je _end_euklides        ; b == 0 => zakonczenie wykonywania funkcji euklidesa
    jne _calculations       ; b != 0 => wykonanie obliczen
    
_calculations:
    call _modulo            ; wywowalanie funkcji modulo, rdx - reszta z dzielenia
    push rsi                ; umieszczenie b na stosie (b)
    mov rsi, rdx            ; b = reszta z dzielenia
    pop rdi                 ; zabranie b ze stosu, rdi = b
    jmp _euklides           ; kontynuacja funkcji

_modulo:                    ; rdi - a, rsi - b
    cmp rsi, 0              ; sprawdzenie czy b jest rowne 0
    je _devide_by_zero

    xor rdx, rdx            ; zerwoanie reszty z dzielenia
    mov rax, rdi            ; rax = rdi = a
    div rsi                 ; wykonanie dzielenia: wynik w rax, rdx - reszta
    ret

_devide_by_zero:
    mov rax, 0              ; ustawienie wyniku na 0
    ret

_end_euklides:
    mov rax, rdi            ; przeniesienie odpowiedzi (a) do rax

    mov rax, 60             ; zakonczenie dzialania programu
    mov rdi, 0
    syscall 