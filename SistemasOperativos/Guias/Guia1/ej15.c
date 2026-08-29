#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

int main(){
    
    int func_ls_ws[2];
    if(pipe(func_ls_ws) == -1){
        return "Error";
    }

    pid_t ls = fork();

    if(ls < 0){
        return "Error";
    }else if(ls == 0){
        close(func_ls_ws[0]); //Cierro Read
        dup2(func_ls_ws[1], STDOUT_FILENO); //El resultado de ls -al lo muevo al func_ls_ws[1];
        execlp("ls", "ls", "-al", NULL);
        close(func_ls_ws[1]);
        exit(EXIT_SUCCESS);
    }

    pid_t wc = fork();
    if(wc < 0){
            return "Error";
        }else if(wc == 0){
            close(func_ls_ws[1]);
            dup2(func_ls_ws[0], STDIN_FILENO);
            execlp("wc", "wc", "-l", NULL);
            close(func_ls_ws[0]);
            exit(EXIT_SUCCESS);

    }        

    close(func_ls_ws[0]);
    close(func_ls_ws[1]);

    wait(NULL);
    wait(NULL);
    exit(EXIT_SUCCESS);
    return 0;

}