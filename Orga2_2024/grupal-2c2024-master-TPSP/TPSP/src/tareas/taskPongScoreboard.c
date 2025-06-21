#include "task_lib.h"

#define WIDTH TASK_VIEWPORT_WIDTH
#define HEIGHT TASK_VIEWPORT_HEIGHT

#define SHARED_SCORE_BASE_VADDR (PAGE_ON_DEMAND_BASE_VADDR + 0xF00)
#define CANT_PONGS 3


void task(void) {
	screen pantalla;
	// ¿Una tarea debe terminar en nuestro sistema?
	while (true) {
	// Completar:
	// - Pueden definir funciones auxiliares para imprimir en pantalla
	// - Pueden usar `task_print`, `task_print_dec`, etc. 
		
		for (int i = 0; i < CANT_PONGS; i++){
			(uint32_t*) datos = (uint32_t*) SHARED_SCORE_BASE_VADDR + (i * sizeof(uint32_t)*2); 
			uint32_t puntaje1 = datos[0];
			uint32_t puntaje2 = datos[1];
			task_print_dec(pantalla, puntaje1, 2, WIDTH / 2 - 3, 0, C_FG_CYAN);
			task_print_dec(pantalla, puntaje2, 2, WIDTH / 2 + 3, 0, C_FG_MAGENTA);
		}
		
		syscall_draw(pantalla);
	}
}
