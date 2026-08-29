#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

/*Inicisio A
int main(){

    int fds_padre_hijo[2];
    int fds_hjo_padre[2];
    int valor = 0;

    pipe(fds_padre_hijo);
    pipe(fds_hjo_padre);

    pid_t hijo = fork();

    if(hijo == 0){
        close(fds_padre_hijo[1]);
        close(fds_hjo_padre[0]);

        while(1){
            read(fds_padre_hijo[0], &valor, sizeof(int));
            valor++;
            write(fds_hjo_padre[1], &valor, sizeof(int));
            printf("Hijo envia a Padre el valor %d\n", valor);
            fflush(stdout);
            sleep(1);
        }
    }else{
        close(fds_padre_hijo[0]);
        close(fds_hjo_padre[1]);

        write(fds_padre_hijo[1], &valor, sizeof(int));
        printf("Padre envia a hijo el valor %d\n", valor);
        fflush(stdout);
        sleep(1);

        while(1){
            read(fds_hjo_padre[0], &valor, sizeof(int));
            valor++;
            write(fds_padre_hijo[1], &valor, sizeof(int));
            printf("Padre envia a Hijo el valor %d\n", valor);
            fflush(stdout);
            sleep(1);
        }
    }

    return 0;
}
*/

int main(){

    int fds_padre_hijo1[2];
    int fds_hijo1_hijo2[2];
    int fds_hjo2_padre[2];
    int valor = 0;

    pipe(fds_padre_hijo1);
    pipe(fds_hijo1_hijo2);
    pipe(fds_hjo2_padre);

    pid_t hijo1 = fork();

    if(hijo1 == 0){

        close(fds_hjo2_padre[0]);
        close(fds_hjo2_padre[1]);
        close(fds_hijo1_hijo2[0]);
        close(fds_padre_hijo1[1]);

        while(1){
            read(fds_padre_hijo1[0], &valor, sizeof(int));
            valor++;
            write(fds_hijo1_hijo2[1], &valor, sizeof(int));
            printf("Hijo_1 envia a Hijo_2 el valor %d\n", valor);
            fflush(stdout);
            sleep(1);
        }
    }else{

        pid_t hijo2 = fork();

        if(hijo2 == 0){
            close(fds_padre_hijo1[0]);
            close(fds_padre_hijo1[1]);
            close(fds_hijo1_hijo2[1]);
            close(fds_hjo2_padre[0]);

            while(1){
                read(fds_hijo1_hijo2[0], &valor, sizeof(int));
                valor++;
                write(fds_hjo2_padre[1], &valor, sizeof(int));
                printf("Hijo_2 envia a Padre el valor %d\n", valor);
                fflush(stdout);
                sleep(1);
            }

        }else{

            close(fds_hijo1_hijo2[0]);
            close(fds_hijo1_hijo2[1]);
            close(fds_padre_hijo1[0]);
            close(fds_hjo2_padre[1]);

            write(fds_padre_hijo1[1], &valor, sizeof(int));
            printf("Padre envia a Hijo_1 el valor %d\n", valor);
            fflush(stdout);
            sleep(1);

            while(1){
                read(fds_hjo2_padre[0], &valor, sizeof(int));
                valor++;
                write(fds_padre_hijo1[1], &valor, sizeof(int));
                printf("Padre envia a Hijo_1 el valor %d\n", valor);
                fflush(stdout);
                sleep(1);
            }
        }
    }

    return 0;
}