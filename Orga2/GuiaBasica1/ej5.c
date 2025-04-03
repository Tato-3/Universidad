#include<stdio.h>
#include<stdint.h>

int main(){

    int en_double = 0.1;
    int en_float= 0.1F;

    int doubleAInt = (int) en_double;
    int floatAInt = (int) en_float;

    printf("%d\n, %d\n", doubleAInt, floatAInt);


    return 0;
}