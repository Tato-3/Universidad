#include "ej1.h"

list_t* listNew(){
  list_t* l = (list_t*) malloc(sizeof(list_t));
  l->first=NULL;
  l->last=NULL;
  return l;
}

void listAddLast(list_t* pList, pago_t* data){
    listElem_t* new_elem= (listElem_t*) malloc(sizeof(listElem_t));
    new_elem->data=data;
    new_elem->next=NULL;
    new_elem->prev=NULL;
    if(pList->first==NULL){
        pList->first=new_elem;
        pList->last=new_elem;
    } else {
        pList->last->next=new_elem;
        new_elem->prev=pList->last;
        pList->last=new_elem;
    }
}


void listDelete(list_t* pList){
    listElem_t* actual= (pList->first);
    listElem_t* next;
    while(actual != NULL){
        next=actual->next;
        free(actual);
        actual=next;
    }
    free(pList);
}

uint8_t contar_pagosDe(list_t* pList, char* usuario, uint8_t tipoDePago){
    uint8_t pagos = 0;
    listElem_t *listaClientes = pList->first;   //Mi lista apunta al primer cliente

    while(listaClientes != NULL){
        pago_t *clienteDatos = listaClientes->data;
        if(strcmp(clienteDatos->cobrador, usuario) == 0){
            if(clienteDatos->aprobado == tipoDePago) pagos++;
        }    
        listaClientes = listaClientes->next;
    }

    return pagos;
}

uint8_t contar_pagos_aprobados(list_t* pList, char* usuario){
    return contar_pagosDe(pList, usuario, 1);
}

uint8_t contar_pagos_rechazados(list_t* pList, char* usuario){
    return contar_pagosDe(pList, usuario, 0);
}

pagoSplitted_t* split_pagos_usuario(list_t* pList, char* usuario){
    uint8_t pagos_aprobados = contar_pagos_aprobados(pList, usuario);
    uint8_t pagos_rechazados = contar_pagos_rechazados(pList, usuario);

    pagoSplitted_t* usuario_pagosSplitted = malloc(sizeof(pagoSplitted_t));

    usuario_pagosSplitted->cant_aprobados = pagos_aprobados;
    usuario_pagosSplitted->cant_rechazados = pagos_rechazados;

    pago_t** aprobados = malloc(pagos_aprobados*sizeof(pago_t*));
    pago_t** rechazados = malloc(pagos_rechazados*sizeof(pago_t*));

    usuario_pagosSplitted->aprobados = aprobados;
    usuario_pagosSplitted->rechazados = rechazados;

    listElem_t* clientes = pList->first;

    uint8_t i = 0;
    uint8_t j = 0;

    while(clientes != NULL){
        pepe*()
        clientes = clientes->next;
    }

    return usuario_pagosSplitted;

}

pepe

    pago_t* cliente_pago = clientes->data;
    if(strcmp(cliente_pago->cobrador, usuario) == 0){
        if(cliente_pago->aprobado){
            usuario_pagosSplitted->aprobados[i++] = cliente_pago;
        }else{
            usuario_pagosSplitted->rechazados[j++] = cliente_pago;
        }
    }
