#include "list.h"
#include "type.h"
#include <stddef.h>

list_t* listNew(type_t t) {
    list_t* l = malloc(sizeof(list_t));
    l->type = t; // l->type es equivalente a (*l).type
    l->size = 0;
    l->first = NULL;
    return l;
}
void listAddFirst(list_t* l, void* data) {
    node_t* n = malloc(sizeof(node_t));
    switch(l->type) {
        case TypeFAT32:
        n->data = (void*) copy_fat32((fat32_t*) data);
        break;
        case TypeEXT4:
        n->data = (void*) copy_ext4((ext4_t*) data);
        break;
        case TypeNTFS:
        n->data = (void*) copy_ntfs((ntfs_t*) data);
        break;
    }
    n->next = l->first;
    l->first = n;
    l->size++;
}

//se asume: i < l->size
void* listGetData(list_t* l, uint8_t i){
    node_t* n = l->first;
    for(uint8_t j = 0; j < i; j++)
        n = n->next;
    return n->data;
}
//se asume: i < l->size
void* listGetNext(list_t* l, uint8_t i){
    node_t* n = l->first;
    for(uint8_t j = 0; j < i; j++)
        n = n->next;
    return n->next;
}
//se asume: i < l->size
void* listRemove(list_t* l, uint8_t i){
    node_t* tmp = NULL;
    void* data = NULL;
    if(i == 0){
        data = l->first->data;
        tmp = l->first;
        l->first = l->first->next;
    }else{
        node_t* n = l->first;
        for(uint8_t j = 0; j < i - 1; j++)
            n = n->next;
            data = n->next->data;
            tmp = n->next;
            n->next = n->next->next;
    }
    free(tmp);
    l->size--;
    return data;
}
void listDelete(list_t* l){
    node_t* n = l->first;
    while(n){
        node_t* tmp = n;
        n = n->next;
        switch(l->type) {
            case TypeFAT32:
            rm_fat32((fat32_t*) tmp->data);
            break;
            case TypeEXT4:
            rm_ext4((ext4_t*) tmp->data);
            break;
            case TypeNTFS:
            rm_ntfs((ntfs_t*) tmp->data);
            break;
        }
        free(tmp);
    }
    free(l);
}

void listSwitch2Elems(list_t* l, uint8_t i, uint8_t j){
    if(l->size < 2) return;
    node_t* temp = NULL;

    node_t* prev_i = NULL;
    node_t* node_i = l->first;
    for (uint8_t idx = 0; idx < i; idx++) {
        prev_i = node_i;
        node_i = node_i->next;
    }
    node_t* prev_j = NULL;
    node_t* node_j = l->first;
    for (uint8_t idx = 0; idx < j; idx++) {
        prev_j = node_j;
        node_j = node_j->next;
    }

    if(prev_i) prev_i->next = node_j;
    else l->first = node_j;

    if(prev_j) prev_j->next = node_i;
    else l->first = node_i;

    temp = node_i->next;
    node_i->next = node_j->next;
    node_j->next = temp;

}


fat32_t* new_fat32(){
    fat32_t* fat32_file = malloc(sizeof(fat32_t));
    return fat32_file;
}
ext4_t* new_ext4(){
    ext4_t* ext4_file = malloc(sizeof(ext4_t));
    return ext4_file;
}
ntfs_t* new_ntfs(){
    ntfs_t* ntfs_file = malloc(sizeof(ntfs_t));
    return ntfs_file;
}

fat32_t* copy_fat32(fat32_t* file){
    fat32_t* fat32_copy = new_fat32();
    *fat32_copy = *file;
    return fat32_copy;
}
ext4_t* copy_ext4(ext4_t* file){
    ext4_t* ext4_copy = new_ext4();
    *ext4_copy = *file;
    return ext4_copy;
}
ntfs_t* copy_ntfs(ntfs_t* file){
    ntfs_t* ntfs_copy = new_ntfs();
    *ntfs_copy = *file; 
    return ntfs_copy;
}

void rm_fat32(fat32_t* file){
    if (file) {
        free(file);
    }
}
void rm_ext4(ext4_t* file){
    if (file) {
        free(file);
    }
}
void rm_ntfs(ntfs_t* file){
    if (file) {
        free(file);
    }
}