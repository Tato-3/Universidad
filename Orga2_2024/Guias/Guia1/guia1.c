#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "guia1.h"

//Ejercicio 1
char *cesar(char *s, uint32_t x){
    size_t length = strlen(s);

    char *res = malloc(length+1);
	for(int i = 0; s[i] != '\0'; i++){
        res[i] = (s[i] + x - 'A') % 26 + 'A';
    }
    res[length] = '\0';

    return res;
}

//Ejercicio 2

int prefijo_de(char *s1, char *s2){
    int res = 0;
    for(int i = 0; s1[i] != '\0' || s2[i] != '\0'; i++){
        if(s1[i] == s2[i]){
            res += 1;
        }else break;
    }
    return res;
}

//Ejercicio 3

void *oficina(cliente_t *clientes, int longitud){
    int num = rand() % longitud;
    int elem = rand() % 4;

    switch (elem){
    case 0:
        return clientes[num].nombre;
        break;
    case 1:
        return clientes[num].apellido;
        break;
    case 2:
        return clientes[num].compra;
        break;
    case 3:
        return clientes[num].dni;
        break;
    }

}
