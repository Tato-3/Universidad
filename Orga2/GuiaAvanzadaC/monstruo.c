#include<stdlib.h>
#include<stdio.h>

typedef struct{
    char* nombre;
    int vida;
    double ataque;
    double defensa;

} monstruo_t;

monstruo_t monstruos[4]= {
    [0] = {"Goblin", 20, 5, 5},
    [1] = {"Orco", 60, 15, 20},
    [2] = {"Esqueleto", 25, 10, 5},
    [3] = {"Demonio", 40, 20, 10},
};

void imprimir_monstruos(){
    for(int i = 0; i < 4; i++){
        printf("%s, %d, %f, %f\n", monstruos[i].nombre, monstruos[i].vida, monstruos[i].ataque, monstruos[i].defensa);
    }
}
void evolution(monstruo_t* monster){
    monster->ataque += 10;
    monster->defensa += 10;
}

int main(){
    imprimir_monstruos();
    evolution(&monstruos[0]);
    imprimir_monstruos();

    return 0;
}