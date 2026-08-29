//Ej2
/*
void Ke_context_switch(PCB* pcb_0, PCB* pcb_1){
    //Guardo los registros del PCB_0
    pcb_0->R0 = R0;
    pcb_0->R1 = R1;
    ...
    pcb_0->R15 = R15;
    pcb_0->PC = PC; //Me guardo el PC de este proceso

    //Actualizo el tiempo
    pcb_0->CPU_TIME += ke_current_user_time();
    ke_reset_current_user_time(); //Reseteo el tiempo para el nuevo proceso
    pcb_0->STAT = KE_READY;

    //Cambio el contexto
    R0 = pcb_1->R0;
    R1 = pcb_1->R1;
    ...
    R15 = pcb_1->R15;

    set_current_process(pcb_1->P_ID);

    PC = pcb_1->PC;

    ret()
}
*/
//Ej5
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(){

    //Soy Abraham
    printf("Soy Abraham\n");
    pid_t pid_homero = fork();

    if(pid_homero == 0){
        printf("  └──Soy Homero\n");

        pid_t pid_bart = fork();
        if(pid_bart == 0){
            printf("    └──Soy Bart\n");
            exit(EXIT_SUCCESS);
        }

        pid_t pid_lisa = fork();
        if(pid_lisa == 0){
            printf("    └──Soy Lisa\n");
            exit(EXIT_SUCCESS);
        }

        pid_t pid_maggie = fork();
        if(pid_maggie == 0){
            printf("    └──Soy Maggie\n");
            exit(EXIT_SUCCESS);
        }

        wait(pid_bart);
        wait(pid_lisa);
        wait(pid_maggie);
        exit(EXIT_SUCCESS);
    }
    
    wait(pid_homero);
    exit(EXIT_SUCCESS);
    return EXIT_SUCCESS;
}
