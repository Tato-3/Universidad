#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Estructuras.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	lista_t lista;
	lista_t* lista_ptr = &lista;

	// Inicializar la lista
	lista_ptr->head = NULL;

	// Crear nodos y agregarlos a la lista
	nodo_t nodo1 = { .next = NULL, .categoria = 1, .arreglo = NULL, .longitud = 0 };
	nodo_t nodo2 = { .next = NULL, .categoria = 2, .arreglo = NULL, .longitud = 0 };
	nodo_t nodo3 = { .next = NULL, .categoria = 3, .arreglo = NULL, .longitud = 0 };

	// Enlazar los nodos
	lista_ptr->head = &nodo1;
	nodo1.next = &nodo2;
	nodo2.next = &nodo3;

	// Recorrer e imprimir la lista
	assert(cantidad_total_de_elementos(&lista) == 3);
	
	return 0;
}
