1.a-
int main(){
	int padre_hijo1[2];
	pipe(padre_hijo1);

	pid_t hijo1 = fork();

	if(hijo1 == 0){
		close(padre_hijo1[WRITE]);
		float valor;
		while(read(padre_hijo1[READ], &valor, sizeof(valor)) > 0){
			printf("%f/n", costosa(valor));
		}
		exit(0);
	}else{
		int padre_hijo2[2];
		pipe(padre_hijo2);

		pid_t hijo2 = fork();

		if(hijo2 == 0){
			close(padre_hijo1[READ]);
			close(padre_hijo1[WRITE]);
			close(padre_hijo2[WRITE]);
			float valor;
			while(read(padre_hijo2[READ], &valor, sizeof(valor)) > 0){
				printf("%f/n", aproximada(valor));
			}
			exit(0);
		}else{
			close(padre_hijo1[READ]);
			close(padre_hijo2[READ]);
			float x;
			while(scanf("%f", &x) > 0){
				write(padre_hijo1[WRITE], &x, sizeof(x));
				write(padre_hijo2[WRITE], &x, sizeof(x));
			}
			close(padre_hijo1[WRITE]);
			close(padre_hijo2[WRITE]);
			wait(0);
			wait(0);
			exit(0);
		}
	}
}

1.b-
tmb como en el anterior hacemos, los hacemos globales para los handlers
	hijo1_padre[2];
	hijo2_padre[2];
	En el orden como los otros padre_hijox
void handler_hijo1(int sig){
	float res;
	read(hijo1_padre[READ], &res, sizeof(res));
	printf("%f/n");
}
void handler_hijo2(int sig){
	float res;
	read(hijo2_padre[READ], &res, sizeof(res));
	printf("%f/n");
}

En main instalamos SIGURS1 y SIGURS2:

int main(){
	signal(SIGURS1, handler_hijo1);
	signal(SIGURS2, handler_hijo2);
	// ...
	Pero vamos a cerrar los write de ambos, ya que solo vamos a recibir nosotros y a su vez sacamos los printf de los hijos, y en los hijos van a tener
	write(hijo1_padre[WRITE], &valor, sizeof(valor));
	kill(getppid(), SIGURS1)
	Lo mismo con el hijo2
	Y al final tmb cerramos estos pipes y listo
}
