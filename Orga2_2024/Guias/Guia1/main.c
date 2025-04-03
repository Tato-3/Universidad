#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>

#include "guia1.h"

int main() {
    // Ejercicio 1
    char* ej1_t1 = cesar("CASA", 3);
    char* ej1_t2 = cesar("CALABAZA", 7);

    assert(strcmp(ej1_t1, "FDVD") == 0);
    assert(strcmp(ej1_t2, "JHSHIHGH") == 0);

    free(ej1_t1);
    free(ej1_t2);

    // Ejercicio 2
    assert(prefijo_de("Astronomia", "Astrologia") == 5);
    assert(prefijo_de("Pinchado", "Pincel") == 4);
    assert(prefijo_de("Boca", "River") == 0);

    // Ejercicio 3
    cliente_t clientes[] = {
        {"Juan", "Perez", 123456789, 987654321},
        {"Maria", "Gomez", 987654321, 123456789},
        {"Luis", "Martinez", 111111111, 222222222}
    };

    int longitud = 3;
    void *resultado = oficina(clientes, longitud);

    printf("Todos los tests han pasado.\n");

    return 0;
}