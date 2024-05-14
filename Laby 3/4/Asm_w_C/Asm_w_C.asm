BITS 64                     ; Ustawia tryb bitowy procesora na 64 bity.

section .data               ; Definiuje sekcję danych, gdzie będą przechowywane zmienne globalne.
    global string           ; Deklaruje zmienną globalną 'string'.
    global integer          ; Deklaruje zmienną globalną 'integer'.
string db "AlaMaKota", 0    ; Inicjalizuje zmienną 'string' jako ciąg znaków "AlaMaKota" zakończony zerem.
integer dd 26               ; Inicjalizuje zmienną 'integer' jako liczba całkowita 26.

section .rodata             ; Definiuje sekcję read-only (do odczytu) danych.
    global e                ; Deklaruje zmienną globalną 'e'.
e dd 2.72                   ; Inicjalizuje zmienną 'e' jako liczba zmiennoprzecinkowa z podwójną precyzją o wartości 2.72.
