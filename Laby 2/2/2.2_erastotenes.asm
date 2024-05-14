section .bss
    array resq 100                      ; zainicjonowanie tablicy o rozmiarze 100 elementow

section .text
    global main

main:
    call _array_fill_loop               ; wywolanie funkcji wypelniajacej tablice jedynkami
    call _erastotenes                   ; wywolanie funkcji erastotenesa

    mov rax, 60                         ; zakonczenie dzialania programu
    mov rdi, 0
    syscall

_array_fill_loop:                       ; rozpoczecie funkcji wypelniania tablicy jedynkami
    mov rsi, array                      ; poczatkowy adres tablicy
    mov rdx, 0                          ; wyzerownie licznika rdx
    mov rcx, 100                        ; rcx - dlugosc tablicy

_fill_loop:
    mov byte [rsi], 1                   ; umieszczenie w miejscu rsi wartosci 1
    inc rsi                             ; przesuniecie miejsca rsi, rsi++

    dec rcx                             ; rcx--, zmniejszenie licznika
    jnz _fill_loop                      ; jesli nie jest zerem to kontynuujemy
    ret

_erastotenes:
    mov rsi, array                      ; poczatek tablicy array
    mov byte [rsi + 0], 0               ; zerowy i pierwszy element ustawiamy na 0, poniewaz nie sa liczbami pierwszymi
    mov byte [rsi + 1], 0
    mov rcx, 2                          ; zaczynamy od 2, ustawienie licznika rcx na 2, licznik petli zewnetrznej

_outer_loop:                            ; petla zewnetrzna
    cmp rcx, 100                        ; sprawdzenie czy przekracza zakres tablicy
    jge _end_erastotenes                ; jesli rcx >= 0 to konczymy wywolywanie funkcji

    mov rax, rcx                        
    imul rax, rcx
    mov rdx, rax                        ; zaczynamy od rdx = rcx * rcx, licznik petli wewnetrznej

_inner_loop:
    cmp rdx, 100                        ; sprawdzenie czy rdx przekroczyl zakres
    jge _end_inner_loop                 ; jesli rcx >= 0 to konczymy wywolywanie funkcji

    mov byte [rsi + rdx], 0             ; ustawienie wartosci konkretnego elementu na zero
    add rdx, rcx                        ; zwiekszenie licznika rdx o wartosc rcx, czyli kolejna wieloktrotnosc rcx
    jmp _inner_loop                     ; kontynuowanie funkcji wewnetrznej

_end_inner_loop:
    inc rcx                             ; zwiekszenie licznika zewnetrznego o jeden
    jmp _outer_loop                     ; kontynuacja petli zewnetrznej

_end_erastotenes:                       ; zakonczenie dzialania funkcji erastotenesa
    ret