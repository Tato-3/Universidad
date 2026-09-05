#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <stdatomic.h>
#include <unistd.h>
#include <semaphore.h>

sem_t mutex = {1};


atomic_int x = 0;

int main(){
    for(int i=0;i<10;i++){
        sem_wait(&mutex);
        int y=x;
        sem_post(&mutex);

        if(y<=5){
            sem_wait(&mutex);
            x++;
            sem_post(&mutex);
            printf("x=%d\n",x);
        }else{
            sem_wait(&mutex);
            x--;
            sem_post(&mutex);
            printf("x=%d\n",x);
        }
    }

}