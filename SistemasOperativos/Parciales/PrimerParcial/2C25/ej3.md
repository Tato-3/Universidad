void main(){
	int padre_hijo[2], hijo_padre[2];
	pipe(padre_hijo);
	pipe(hijo_padre);

	pid_t hijo = fork();

	if(hijo == 0){
		close(padre_hijo[WRITE]);
		close(hijo_padre[READ]);

		char* msj;
		read(padre_hijo[READ], &msj, sizeof(msj));
		
	}else{
		close(padre_hijo[READ]);
		close(hijo_padre[WRITE]);

		char* buffer[1024];
		
		fgets(buffer, sizeof(buffer), stdin);
		write(padre_hijo[WRITE], &buffer, sizeof(buffer));
	}
}
