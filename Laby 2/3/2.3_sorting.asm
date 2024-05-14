section .data
    array dq 64, 34, 25, 12, 22, 11, 90         ; tablica do posortowania babelkowo
    array_len dq 7                              ; dlugosc tablicy

section .text
    global main

main:
    call _bubble_sort                           ; rozpoczecie sortowania tablicy

    mov rax, 60                                 ; wyjscie z programu
    mov rdi, 0
    syscall

_bubble_sort:
    mov rsi, array                              ; pierwsza wartosc tablicy
    mov rdi, [array_len]                        ; dlugosc tablicy
    dec rdi                                     ; dlugosc tablicy - 1

    xor rbx, rbx                                ; zerowanie licznika petli zewnetrznej, rbx = i = 0

_outer_loop:
    cmp rbx, rdi                                ; sprawdzenie czy i wynosi (dlugosc tablicy - 1)
    jge _end_outer_loop                         ; jezeli i >= array_len - 1, wyjscie z petli zewnetrznej

    xor rcx, rcx                                ; zerowanie licznika petli wewnetrznej, rcx = j = 0

_inner_loop:
    cmp rcx, rdi                                ; sprawdzenie czy j wynosi (dlugosc tablicy - 1)
    jge _end_inner_loop                         ; jezeli j >= array_len - 1, wyjscie z petli wewnetrznej

    mov rax, qword [rsi + rcx * 8]              ; rax = array[i]
    mov rdx, qword [rsi + rcx * 8 + 8]          ; rdx = array[i + 1]

    cmp rax, rdx                                ; jezeli array[i] <= array[i + 1], zamiana nie jest wymagana
    jle _no_swap                                
                                                ; zamiana array[i] i array[i + 1]
    mov qword [rsi + rcx * 8], rdx
    mov qword [rsi + rcx * 8 + 8], rax

_end_swap:                                      ; zakonczenie zamiany
    inc rcx                                     ; zwiekszenie licznika wewnetrzengo o jeden, j++
    jmp _inner_loop                             ; kontynuacja petli wewnetrznej

_no_swap:                                       
    inc rcx                                     ; zwiekszenie licznika wewnetrzengo o jeden, j++
    jmp _inner_loop                             ; kontynuacja petli wewnetrznej

_end_inner_loop:
    inc rbx                                     ; zwiekszenie licznika zewnetrznego o jeden, i++
    jmp _outer_loop                             ; kontynuacja petli zewnetrznej

_end_outer_loop:                                ; zakonczenie funkcji sortowania
    ret