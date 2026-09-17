typedef struct acta{
	char[8] lu;
	int nota;
}acta;

int main_servidor(){
	int servidor_fd, cliente_fd;
	sturct sockaddr_un direccion;
	socklen_t addrlen = sizeof(direccion);
	direccion.sin_family = AF_UNIX;
	strcpy(direccion.sun_path, "unix_socket");
	unlink(direccion.sun_path);
	servidor_fd = socket(AF_UNIX, SOCK_STREAM, 0);

	cliente_fd = accept(servidor_fd, &direccion, &addrlen);
	//Este se encarga de las notas, mientras el padre se encarga de aceptar docentes
	pid_t pid = fork();
	if(pid == 0){
		close(servidor_fd);
		int codigo;
		recv(cliente, &codigo, sizeof(int));
		Acta acta_actual = crearActa(codigo);
		acta data_acta;
		while(1){
			recv(client, &data_acta, sizeof(data_acta));
			if(data_acta.nota == -1){break;}
			agregarNota(acta_actual, data_acta.lu, data_acta.nota);
		}
		cerrarActa(acta_actual);
		close(cliente_fd);
		exit(EXIT_SUCCESS);
	}
}

int main_docente(){
	struct sockaddr_un servidor;
	servidor.sun_family = AF_UNIX;
	strcpy(servidor.sun_path, "unix_socket");
	int sock = socket(AF_UNIX, SOCK_STREAM, 0);

	connect(sock);
	write(sock, &codigo, sizeof(int));	//Supongo que conozco el codigo
	for(int i = 0; i < k; i++){
		write(sock, &(array_data[i]), sizeof(array_data[i]));
	}
	char lu[8];
	acta invalido = {lu, -1};
	write(sock, &invalida, sizeof(invalido));
	close(sock);
}
