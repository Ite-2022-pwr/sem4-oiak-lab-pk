#include <stdio.h>  

extern int addInt(int a, int b);                // Deklaracja zewnętrznej funkcji addInt o dwóch argumentach całkowitych i zwracającej wartość całkowitą.
extern float subFloat(float a, float b);        // Deklaracja zewnętrznej funkcji subFloat o dwóch argumentach zmiennoprzecinkowych i zwracającej wartość zmiennoprzecinkową.
extern int nwd(int a, int b);                   // Deklaracja zewnętrznej funkcji nwd o dwóch argumentach całkowitych i zwracającej wartość całkowitą.

int main(int argc, char *argv[])                // Definicja głównej funkcji programu.
{
    int res1 = addInt(5, 3);                        // Wywołanie funkcji addInt z argumentami 5 i 3, wynik przypisywany do zmiennej res1.
    printf("sum result (int): %d\n", res1);         // Wyświetlenie wyniku funkcji addInt.

    float res2 = subFloat(3.14, 4.20);              // Wywołanie funkcji subFloat z argumentami 3.14 i 4.20, wynik przypisywany do zmiennej res2.
    printf("sub result (float): %.3f\n", res2);     // Wyświetlenie wyniku funkcji subFloat.

    int res3 = nwd(25,5);                           // Wywołanie funkcji nwd z argumentami 25 i 5, wynik przypisywany do zmiennej res3.
    printf("nwd(25, 5): %d\n", res3);               // Wyświetlenie wyniku funkcji nwd.

    return 0;                                       // Zwrócenie wartości 0, co oznacza poprawne zakończenie programu.
}
