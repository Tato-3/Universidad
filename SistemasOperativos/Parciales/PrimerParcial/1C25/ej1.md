1.a

void main(){
    int array[m];
    int fd_tarea[2];
	int fd_res[2];

	pipe(fd_tarea);
	pipe(fd_res);

	for(int i = 0; i < n; i++){
		if(fork() == 0){
			close(fd_tarea[WRITE]);
			close(fd_res[READ]);
			procesarHijo(fd_tarea, fd_res);
		}
	}

	close(fd_tarea[READ]);
	close(fd_res[WRITE]);
	
	for(int i = 0; i < m; i++){
		write(fd_tarea[WRITE], &i, sizeof(int));
	}
	close(fd_tarea[WRITE]);

	int datos[2];
	
	for(int i = 0; i < m; i++){
		read(fd_res[READ], &datos, sizeof(int[2]));
		array[datos[0]] = datos[1];
	}

	close(fd_res[READ]);

	for(int i = 0; i < n; i++){
		wait(NULL);
	}

	printArray(array);
	exit(EXIT_SUCCESS);
}

void procesarHijo(int fd_tarea[2], int fd_res[2]){
	int indice_tarea;
	int datos[2];
	while(read(fd_tarea[READ], &indice_tarea, sizeof(int)) > 0){
		datos[0] = indice_tarea;
		datos[1] = generarValor(indice_tarea);
		write(fd_res[WRITE], &datos, sizeof(int[2]));
	}
	close(fd_res[WRITE]);
	exit(EXIT_SUCCESS);
}


1.b

La solucion propuesta funciona, esto se debe que en ninguno momento de la ejecucion hay un hijo sin hacer nada. Esto se debe que los hijos o estan esperando leer lo que manda el padre, en el while(read) y sino estan ejecutando lo que esta dentro del while, que seria generar un nuevo valor. Ademas si un hijo termina de generar el valor, este vuelve al while esperando que el padre le mande algo. Si dejan de recibir entonces los hijos terminan.
