void main(){
	pid_t hijo = fork();

	if(hijo == 0){
		int fd[2];
		pipe(fd);
		pid_t nieto = fork();
		if(nieto == 0){
			int desperte = 1;
			close(fd[READ]);
			printf("Soy el mejor nieto");
			sleep(60);
			write(fd[WRITE], &desperte, sizeof(int));
			close(fd[WRITE]);
			while(TRUE){}
		}else{
			int estado;
			close(fd[WRITE]);
			read(fd[READ], &estado, sizeof(int));	//Le da igual el contenido, solo necesita saber que desperto
			close(fd[READ]);
			kill(nieto, SIGKILL);
			waitpid(nieto, NULL, 0);
			exit(EXIT_SUCCESS);
		}
	}
	wait(NULL);
	printf("Mi hijo querido se ha ido");
	exit(EXIT_SUCCESS);
}
