section .text
    global main

main:
    mov rbx, 0      ; element a, poczatkowo ma 0
    mov rcx, 1      ; element b, poczatkowo ma 1
    mov rdx, 10     ; n - ilosc 
    mov rsi, 2      ; iterator, zaczynamy od 2

_fibonacci:
    cmp rsi, rdx            ; sprawdzenie czy iterator wynosi n
    jg _end_fibonacci       ; jesli iterator > n, konczymy wykobywanie funkcji

    mov rax, rbx            ; rax = rbx = a
    add rax, rcx            ; rax = a + b
     
    mov rbx, rcx            ; a = b
    mov rcx, rax            ; b = a + b

    inc rsi                 ; zwiekszenie licznika
    
    jmp _fibonacci          ; kontynuacja funkcji

_end__fibonacci:
    mov rax, rcx        ; umieszczenie wyniku w rax