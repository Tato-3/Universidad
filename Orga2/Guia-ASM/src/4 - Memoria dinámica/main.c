#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <malloc.h>
#include "../test-utils.h"
#include "Memoria.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	char* palabra = "Tato 21";
	assert(strLen(palabra) == 7);
	assert(strLen("") == 0);
	assert(strCmp("sar", "23") == -1);
	
	return 0;
}
