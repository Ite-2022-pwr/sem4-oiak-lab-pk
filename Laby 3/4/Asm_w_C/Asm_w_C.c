#include <stdio.h>

extern char string[];           // Deklaracja zmiennej string zdefiniowanej w kodzie assemblerowym
extern int integer;             // Deklaracja zmiennej integer zdefiniowanej w kodzie assemblerowym
extern const float e;           // Deklaracja zmiennej e zdefiniowanej w kodzie assemblerowym

int main(int argc, char *argv[])
{
    printf("int: %d\n", integer);           // Wyświetla wartość zmiennej integer
    printf("string: %s\n", string);         // Wyświetla zawartość zmiennej string jako ciąg znaków
    printf("const: %.2f\n", e);             // Wyświetla wartość zmiennej e z dokładnością do dwóch miejsc po przecinku
    return 0;
}
