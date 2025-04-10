#include<stdlib.h>
#include<stdio.h>
#include<string.h>

void lowercaseToUppercase(char* word){
    for(int i = 0; i < strlen(word); i++){
        if(word[i] >= 'a' && word[i] <= 'z') {
            word[i] = word[i] - ('a' - 'A');
        }
    }
}


int main(){
    char* word[100];
    scanf("%99s", word);
    lowercaseToUppercase(&word);
    printf("%s\n", word);
    return 0;
}