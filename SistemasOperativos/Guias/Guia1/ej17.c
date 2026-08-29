#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include <string.h>

int N;
volatile sig_atomic_t ha_terminado;

// Devuelve un número identificador/secreto basado en el PID del hijo
int dameNumero(int pid) {
    return pid % 100;
}

// Simula el cómputo costoso del nieto durmiendo unos segundos
int calcular(int numero) {
    return numero * 2;       // Operación de ejemplo
}

// Muestra en pantalla el resultado final consolidado por el padre
void informarResultado(int numero, int resultado) {
    printf("[PADRE] Cómputo finalizado -> Número inicial: %d | Resultado: %d\n", numero, resultado);
    fflush(stdout);
}

void handler_termino(){
     ha_terminado = 1;
}

void ejecutarHijo(int i, int pipes[][2]){
    
    int resultado;
    int num_especial;
    signal(SIGUSR1, handler_termino);

    close(pipes[i][1]);
    close(pipes[N+i][0]);

    read(pipes[i][0], &num_especial, sizeof(int));

    int fd_nieto_hijo[2];
    pipe(fd_nieto_hijo);

    pid_t nieto = fork();

    if(nieto == 0){
        close(fd_nieto_hijo[0]);
        close(pipes[N+i][1]);
        close(pipes[i][0]);

        resultado = calcular(num_especial);
        
        write(fd_nieto_hijo[1], &resultado, sizeof(int));
        close(fd_nieto_hijo[1]);

        kill(getppid(), SIGUSR1);
        exit(EXIT_SUCCESS);
    }

    close(fd_nieto_hijo[1]);
    
    while(1){
        char consulta;
        if(read(pipes[i][0], &consulta, sizeof(char)) <= 0) continue;
        char estado_termino = 0;

        if(!ha_terminado){
            write(pipes[N+i][1], &estado_termino, sizeof(char));
        }else{
            read(fd_nieto_hijo[0], &resultado, sizeof(int));
            close(fd_nieto_hijo[0]);

            estado_termino = 1;
            write(pipes[N+i][1], &estado_termino, sizeof(char));
            write(pipes[N+i][1], &num_especial, sizeof(int));
            write(pipes[N+i][1], &resultado, sizeof(int));

            wait(NULL);
            break;
        }
    }

    close(pipes[i][0]);
    close(pipes[N+i][1]);

}
int main(int argc, char* argv[]){
    
    if(argc< 2){
        printf ("Debe ejecutar con la cantidad de hijos como parametro\n");
        return 0; 
    }
    
    N = atoi(argv[1]);
    int pipes[N*2][2];

    for(int i=0; i< N*2; i++){
        pipe(pipes[i]); 
    }
    for(int i=0; i< N; i++){
        int pid = fork(); 
        if(pid==0){
        ejecutarHijo(i,pipes);
        return 0;
        }else{
            int numero = dameNumero(pid);
            write(pipes[i][1], &numero, sizeof(numero)); 
        }
    }
    int cantidadTerminados = 0;
    char hijoTermino[N];
    memset(hijoTermino, 0, sizeof(hijoTermino));

    while(cantidadTerminados < N){
        for(int i=0; i< N; i++){
            if(hijoTermino[i]){continue;}
            char termino = 0;
            write(pipes[i][1], &termino, sizeof(termino));
            read(pipes[N+i][0], &termino, sizeof(termino));
            if(termino){
                int numero;
                int resultado;
                read(pipes[N+i][0], &numero, sizeof(numero));
                read(pipes[N+i][0], &resultado, sizeof(resultado));
                informarResultado(numero, resultado);
                hijoTermino[i] = 1;
                cantidadTerminados++; 
            } 
        } 
    }
    wait(NULL) ;
    return 0; 
}