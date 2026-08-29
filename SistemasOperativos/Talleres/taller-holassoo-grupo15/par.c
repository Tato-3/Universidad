#include <stdio.h>
#include <stdlib.h>

/*
 * es_par: indica si un número entero es par.
 *
 *   n -> el número a evaluar.
 *
 * Devuelve:
 *   1 si n es par,
 *   0 si n es impar.
 *
 * TODO: Implementar esta función.
 */
int es_par(int n) {
    if(mod(n,2) == 0){
        return 1;
    }else{
        return 0;
    }    
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <numero>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);

    if (es_par(n)) {
        printf("par\n");
    } else {
        printf("impar\n");
    }

    return 0;
}
