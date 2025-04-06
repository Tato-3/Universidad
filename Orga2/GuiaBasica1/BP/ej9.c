#include<stdio.h>
#include<stdint.h>

int main(){
    uint32_t mask = 0xE0;
    uint32_t p1;
    uint32_t p2;

    scanf("%d %d", &p1, &p2);

    uint32_t p1_3MS = p1 & mask;
    uint32_t p2_3MS = p2 & mask;

    printf("%s\n", p1_3MS == p2_3MS ? "Son iguales" : "No son iguales");

}