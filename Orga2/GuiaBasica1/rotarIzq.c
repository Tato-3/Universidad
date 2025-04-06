#include<stdio.h>
#include<stdint.h>
#include<stdlib.h>

uint32_t* rotarIzqN(uint32_t* array, uint32_t size){
    uint32_t primerElem = array[0];

    for(uint32_t i = 0; i < size - 1; i++){
        array[i] = array[i+1];
    }

    array[size-1] = primerElem;

    return array;
}


uint32_t* rotarIzqNVeces(uint32_t* array, uint32_t size, uint32_t n){
    n = n % size;
    while(n--){
        rotarIzqN(array, size);
    }
    return array;
}


int main(){
    uint32_t n;
    scanf("%u", &n);
    uint32_t* array = malloc(n * sizeof(uint32_t));
    
    for(uint32_t i = 0; i < n; i++){
        uint32_t elem;
        scanf("%u", &elem);
        array[i] = elem;
    }

    rotarIzqNVeces(array, n, 2);

    for(uint32_t i = 0; i < n; i++){
        printf("%u ", array[i]);
    }

    printf("\n");

    free(array);

    return 0;
}