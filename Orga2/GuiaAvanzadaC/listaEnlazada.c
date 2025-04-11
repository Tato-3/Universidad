#include<stdlib.h>
#include<stdio.h>
#include<stddef.h>

typedef struct node_s {
    struct node_s* next;
    int value;
}node_t;

typedef struct list_s{
    node_t* head;
}list_t;

list_t* create_empty_list(){
    list_t* empty_list = malloc(sizeof(list_t));
    empty_list->head = NULL;
    return empty_list;
}

node_t* create_node(int value){
    node_t* node = malloc(sizeof(node_t));
    node->next = NULL;
    node->value = value;
    return node;
}

void append_node(list_t* list, node_t* node){
    if(list == NULL || list->head == NULL){
        list->head = node;
        return;
    }
    node_t* node_list = list->head;

    while(node_list->next != NULL){
        node_list = node_list->next;
    }

    node_list->next = node;

}

void delete_list(list_t* list){
    node_t* current = list->head;
    while(current != NULL){
        node_t* temp = current;
        current = current->next;
        free(temp);
    }
    free(list);
}

void print_list(list_t* list){
    node_t* nodo = list->head;
    while(nodo != NULL){
        printf("%d ", nodo->value);
        nodo = nodo->next;
    }
    printf("\n");
}

int delete_head(list_t* list){
    if(list == NULL) return -1; 
    node_t* node_ToDelete = list->head;
    if(node_ToDelete == NULL) return -1;
    list->head = node_ToDelete->next;
    free(node_ToDelete);
    return 0;
}

void map(list_t* list, int (*function)(int)){
    node_t* actual = list->head;
    while (actual != NULL){
        actual->value = function(actual->value);
        actual = actual->next;
    }
}

void filter(list_t* list, int (*condition)(int)){
    while (list->head != NULL && !condition(list->head->value)) {
        delete_head(list);
    }

    node_t* current = list->head;
    while (current != NULL && current->next != NULL) {
        if (!condition(current->next->value)) {
            node_t* temp = current->next;
            current->next = current->next->next;
            free(temp);
        } else {
            current = current->next;
        }
    }
}

int double_value(int x){
    return 2*x;
}

int even(int x){
    return x % 2 == 0;
}

int main(){

    list_t* lista = create_empty_list();
    for(int i = 0; i < 5; i++){
        node_t* nodo = create_node(i+1);
        append_node(lista, nodo);
    }

    //delete_head(lista);
    //map(lista, &double_value);
    filter(lista, &even);
    print_list(lista);
    delete_list(lista);

    return 0;
}