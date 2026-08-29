#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

//Handler para que no mate el proceso
void handler(int sig){}

int main(){

    signal(SIGUSR1, handler);
    char caracter;
    int seguir_corriendo = 1;

    pid_t hijo = fork();

    if(hijo == 0){
        while(seguir_corriendo){
            pid_t padre = getppid();
            pause(); //Espero al padre
            printf("Pong, %d\n", getpid());
            kill(padre, SIGUSR1); //Aviso al padre
        }    
    }else{
        while(seguir_corriendo){
            for(int i = 0; i < 3; i++){
                sleep(1); //Espero al pause del hijo
                printf("Ping, %d\n", getpid());
                kill(hijo, SIGUSR1);        
            }
            pause();
            printf("Desea continuar? [y/n]: ");
            scanf(" %c", &caracter);
            if(caracter != 'y'){
                seguir_corriendo = 0;
                kill(hijo, SIGKILL);
                wait(NULL);
            }
        }    
    }
    exit(EXIT_SUCCESS);
    return 0;
}