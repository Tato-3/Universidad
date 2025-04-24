
global strArrayNew
global strArrayGetSize
global strArrayAddLast
global strArraySwap
global strArrayDelete

extern malloc
extern free
extern strClone
extern strDelete

;########### SECCION DE DATOS
section .data

%define SIZE_OFFSET 0
%define CAPACITY_OFFSET 1
%define DATA_OFFSET 8

;########### SECCION DE TEXTO (PROGRAMA)
section .text

; str_array_t* strArrayNew(uint8_t capacity)
strArrayNew:
    push rbp
    mov rbp, rsp

    mov sil, dil              ; guardar capacity
    mov rdi, 16
    call malloc               ; malloc struct
    mov rbx, rax              ; guardar puntero a struct

    mov byte [rbx + SIZE_OFFSET], 0
    mov byte [rbx + CAPACITY_OFFSET], sil

    ; malloc para data (char**)
    movzx rdi, sil            ; convertir a 64 bits
    imul rdi, rdi, 8
    call malloc
    mov [rbx + DATA_OFFSET], rax

    mov rax, rbx              ; devolver puntero
    pop rbp
    ret


; uint8_t  strArrayGetSize(str_array_t* a)
strArrayGetSize:
    push rbp
    mov rbp, rsp

    mov al, byte [rdi+SIZE_OFFSET]

    pop rbp
    ret
; void  strArrayAddLast(str_array_t* a, char* data)
strArrayAddLast:
    push rbp
    mov rbp, rsp

    ;Me fijo mi capacidad y el size
    mov dl, byte [rdi + SIZE_OFFSET]
    mov cl, byte [rdi + CAPACITY_OFFSET]
    sub cl, dl
    cmp cl, 0   ;Si cl es 0 entonces esta lleno
    je .fin

    ;Incremento el size
    add byte [rdi + SIZE_OFFSET], 1   ;Agrego algo mas
    ;Clono el string
    mov rdx, rdi    ;En rdx es tmb puntero a mi struct
    mov rdi, rsi
    call strClone
    mov rsi, rax    ;En rsi tengo la copia del string
    ;Guardo mi nuevo string
    movzx rcx, byte [rdi + SIZE_OFFSET] ; obtener índice actual
    mov rbx, qword [rdi + DATA_OFFSET]
    mov [rbx + rcx*8], rax              ; guardar string clonado
    add byte [rdi + SIZE_OFFSET], 1     ; ahora sí, actualizás size             ; guardamos el nuevo string

    .fin:
        pop rbp
        ret

; void  strArraySwap(str_array_t* a, uint8_t i, uint8_t j)
strArraySwap:
    push rbp
    mov rbp, rsp
    ;En Rcx tengo el array de strings
    mov rcx, qword [rdi + DATA_OFFSET]
    ;Para luego usar como indice
    movzx rsi, dil      ; rsi = i
    movzx rdx, dl       ; rdx = j
    ;Copio el contenido del i-esimo en r8 y j-esimo en r9
    mov r8, qword [rcx + rsi*8]
    mov r9, qword [rcx + rdx*8]
    ;Los cambio
    mov qword [rcx+rsi*8], r9
    mov qword [rcx+rdx*8], r8

    pop rbp
    ret

; void  strArrayDelete(str_array_t* a)
strArrayDelete:

    push rbp
    mov rbp, rsp

    ;Guardo en RSI el array de strings
    mov rsi, qword [rdi+DATA_OFFSET]
    ;Guardo en R8 la cant de strings
    movzx r8, byte [rdi + SIZE_OFFSET]    
    ;Guardo el puntero dado
    mov rcx, rdi
    ;movzx rdx, dl
    xor rdx, rdx ;rdx = 0
    .loop:
        mov rdi, qword [rsi+rdx*8]
        call strDelete
        inc rdx    
        
        cmp rdx, r8
        jne .loop
    ;Free al puntero de mi arreglo de strings
    mov rdi, rsi
    call free
    ;Free al puntero de mi estructura
    mov rdi, rcx
    call free

    pop rbp
    ret