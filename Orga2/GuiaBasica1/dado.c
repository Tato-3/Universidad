#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

int main() {
    uint32_t array[6] = {0, 0, 0, 0, 0, 0}; // Cambié el puntero a un array normal
    const uint32_t iterations = 60000000;

    // Inicializar la semilla para rand
    srand(time(NULL));

    // Generar números aleatorios y actualizar el array
    for (uint32_t i = 0; i < iterations; i++) {
        int roll = rand() % 6; // Generar un número entre 0 y 5
        array[roll]++;
    }

    // Imprimir los resultados en millones
    for (int i = 0; i < 6; i++) {
        printf("Dado %d: %.2f millones\n", i + 1, array[i] / 1000000.0);
    }

    return 0;
}