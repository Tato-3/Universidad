#include<stdio.h>
#include<stdint.h>

int main(){
    char c = 100;
    unsigned char u_c = 250;

    uint8_t n = 21;

    printf("char(%lu): %d \n", sizeof(c), c);
    printf("char(%lu): %d \n", sizeof(u_c), u_c);
    printf("uint8(%lu): %d \n", sizeof(n), n);

    

    return 0;
}