#define _POSIX_C_SOURCE 199309L 
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>

void seccion_sigprocmask() {
    sigset_t set, oldset;
    sigemptyset(&set);
    sigaddset(&set, SIGCHLD);
    sigprocmask(SIG_BLOCK, &set, &oldset);

    struct sigaction sa;
    sigaction(SIGCHLD, NULL, &sa);

    sigprocmask(SIG_SETMASK, &oldset, NULL);
}

void handler_padre_chld(){
}
void handler_padre_int(){
    seccion_sigprocmask();
}
void handler_hijo_hup(){
}
void handler_hijo_int(){
    // 1. Imprime al recibir la señal del padre
    printf("Dejame pensarlo...\n");
    seccion_sigprocmask();
}
int main(){
    int fd_pipe[2];
    pipe(fd_pipe);
    
    pid_t hijo = fork();
    if(hijo == 0){
        close(fd_pipe[0]);
        pid_t padre = getppid();
        signal(SIGINT, handler_hijo_int);
        signal(SIGHUP, handler_hijo_hup);

        sleep(5);
        
        printf("Ya sé el significado de la vida.\n");
        int msj_temp = 42;
        write(fd_pipe[1], &msj_temp, sizeof(int));
        kill(padre, SIGINT);
        printf("Me voy a mirar crecer las flores desde abajo.\n");
        close(fd_pipe[1]);
        exit(EXIT_SUCCESS);

    }else{

        close(fd_pipe[1]);
        signal(SIGINT, handler_padre_int);

        sigset_t set;
        sigemptyset(&set);
        sigaddset(&set, SIGCHLD);
        sigprocmask(SIG_BLOCK, &set, NULL);

        signal(SIGCHLD, handler_padre_chld);

        sigset_t vacio;
        sigemptyset(&vacio);
        sigprocmask(SIG_SETMASK, &vacio, NULL);

        sleep(1);

        printf("¿Cuál es el significado de la vida?\n");

        kill(hijo, SIGINT);
        
        int msj_temp;
        read(fd_pipe[0], &msj_temp, sizeof(int));
        printf("Mirá vos. El significado de la vida es %d.\n", msj_temp);
        printf("¡Bang Bang, estás liquidado!\n");

        kill(hijo, SIGHUP);

        sleep(10);

        printf("Te voy a buscar en la oscuridad.\n");
        close(fd_pipe[0]);
        exit(EXIT_SUCCESS);
    }
}