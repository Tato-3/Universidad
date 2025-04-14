#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "ABI.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	assert(alternate_sum_4_using_c(8, 2, 5, 1) == 10);

	assert(alternate_sum_4_using_c_alternative(8, 2, 5, 1) == 10);

	assert(alternate_sum_8(8, 2, 5, 1, 8, 2, 5, 1) == 20);

	uint32_t destination;
	product_2_f(&destination ,2, 5.5);
	assert(destination == 10);
	
	return 0;
}
