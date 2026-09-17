1.a-
Proceso1: Supongamos que ejecuta hasta temp = ticket y luego cambia a P2
P2: Ejecuta temp = ticket, suma ticket y retorn temp, luego no entra en el while y entra a funcion_critica(). Aca cambia el scheduler.
P1: Termina de ejecutar obtenerTurno, y tenemos que ambos procesos tienen el mismo turno, por lo que ambos entran a la seccion critica a la vez.


1.b- Una opcion para arreglar esto es usar un semaforo en comun para todos los procesos. Este funciona para que solamente un unico proceso pueda ejecuar la parte de funcion critica, evitando que otro proceso tambien este. Otro opcion es usar funciones atomicas, entonces tendriamos que convertir la funcion obtenerTurno a una funcion atomica, donde todo se ejecuta de una, y asi ningun otro proceso pueda modificar la variable. Ejemplo

mutex = sem(1);	//El primer proceso pasa el semaforo pero luego de pasar lo bloquea

void proc(){
	cosas_no_criticas();
	mutex.wait();
	int miTurno = obtenerTurno();
	mutex.signal();
	while(miTurno != turno);
	mutex.wait();
	terminarTurno();
	mutex.signal();
}
