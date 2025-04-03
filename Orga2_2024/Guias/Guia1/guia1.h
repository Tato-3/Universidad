#ifndef GUIA1_H
#define GUIA1_H
#define NAME_LEN  21

#include <stdio.h> 		//encabezado de funciones de entrada y salida fopen, fclose, fgetc, printf, fprintf ...
#include <stdlib.h>		//biblioteca estándar, atoi, atof, rand, srand, abort, exit, system, NULL, malloc, calloc, realloc...
#include <stdint.h>		//contiene la definición de tipos enteros ligados a tamaños int8_t, int16_t, uint8_t,...
#include <ctype.h>		//contiene funciones relacionadas a caracteres, isdigit, islower, tolower...
#include <string.h>		//contiene las funciones relacionadas a strings, memcmp, strcat, memset, memmove, strlen,strstr...
#include <math.h>		//define funciones matemáticas como cos, sin, abs, sqrt, log...
#include <stdbool.h>	//contiene las definiciones de datos booleanos, true (1), false (0)
#include <unistd.h>		//define constantes y tipos standard, NULL, R_OK, F_OK, STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO...
#include <assert.h>	

typedef struct cliente_str{
    char nombre[NAME_LEN];
    char apellido[NAME_LEN];
    uint64_t compra;
    uint32_t dni;
} cliente_t;

typedef struct __attribute__((__packed__)) packed_cliente_str{
    char nombre[NAME_LEN];
    char apellido[NAME_LEN];
    uint64_t compra;
    uint32_t dni;
}__attribute__((__packed__)) packed_cliente_t;


//Ejercicio 1
char *cesar(char *s, uint32_t x);          // Declaración de la función en C
extern char *cesar_asm(char* s, uint32_t x); // Declaración de la función en ensamblador

//Ejercicio 2
int prefijo_de(char *s1, char *s2);

//Ejercicio 3
void *oficina(cliente_t clientes[], int longitud);

#endif // GUIA1_H


