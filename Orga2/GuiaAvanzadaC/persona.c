#include<stdlib.h>
#include<stdio.h>
#include<stdint.h>

typedef struct{
    char* nombre;
    uint32_t edad;

}persona_t;

persona_t* crearPersona(char* nombrePersona, uint32_t edadPersona){
    persona_t* persona = malloc(sizeof(persona_t));
    if(persona == NULL) return NULL;
    persona->nombre = nombrePersona;
    persona->edad = edadPersona;
    return persona;
}

void eliminarPersona(persona_t* persona){
    free(persona);
}

int main(){
    persona_t* persona = crearPersona("Tato", 21);
    if(persona == NULL) return NULL;
    printf("%s %u\n", persona->nombre, persona->edad);
    eliminarPersona(persona);
    return 0;
}