#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

int main(){

    pid_t julieta = fork();

    if(julieta == 0){
        printf("Soy Julieta \n");
        sleep(1);

        pid_t jeniffer = fork();

        if(jeniffer == 0){
            printf("Soy Jeniffer \n");
            sleep(1);
            exit(EXIT_SUCCESS);
        }else{
            exit(EXIT_SUCCESS);
        }

    }else{
        printf("Soy Juan \n");
        sleep(1);
        wait(NULL);

        pid_t jorge = fork();

        if(jorge == 0){
            printf("Soy Jorge \n");
            sleep(1);
            exit(EXIT_SUCCESS);
        }else{
            exit(EXIT_SUCCESS);
        }
    }

    return 0;
}