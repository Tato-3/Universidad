#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    printf("Listando archivos del directorio:\n");
    system2("ls"); 
    return 0;
}

int system2(const char *arg){
    pid_t hijo = fork();
    if(hijo == 0){
        execl("/bin/sh", "sh", "-c", arg, (char *) NULL);
        return 1;
        exit(EXIT_SUCCESS);
    }
    wait(hijo);
    exit(EXIT_SUCCESS);
    return 0;

}
