# PRIMER EJERCICIO
Me voy a referir a la tarea que llama a la syscall swap como t1 y a la tarea con la que quiere hacer el swap como t2.

## Programar la syscall swap.

Registros que tengo que intercambiar:
    eax
    ecx
    edx
    edi
    esi

Al momento de llamar a swap voy a guardar los valores de estos registros (en caso de que el swap no sea recíproco aún) en una variable global al la que pueda acceder el kernel.

struct_t array_reg[MAX_TASKS] = {0}

struct_t = {
    uint32_t .eax
    uint32_t .ecx
    uint32_t .edx
    uint32_t .edi
    uint32_t .esi
} 

Como es una syscall las tareas deben poder llamarlas entonces tengo que definir una nueva entrada en la IDT de nivel 3. Voy a elegir el 99 como id para esta syscall.

Para hacer en sí el swap primero debo verificar que al momento de que t1 llame a swap, t2 haya llamado anteriormente a swap (y que haya pedido swap con t1). Para guardar esa información defino una variable global a la que pueda acceder el kernel.

uint8 array_swap[MAX_TASKS] = {0}

Inicializo todo el array en 0. Cada indice corresponde al id de una tarea, en su posición correspondiente guardo el id de la tarea con la que quiere hacer swap, si en su posición hay un 0 entonces nunca llamó a swap. 

En idt.c:
```
void idt_init(){
        .
        .
        .
    IDT_ENTRY3(99); <- nueva entrada
        .
        .
        .
}
```

Ahora defino su handler.
En isr.asm:

```
_isr99:
    pushad
    push eax                        <- paso el id de t2
    call hacer_swap
    add esp, 4
    cmp eax, 0  
    je .saltar                        <- si es != 0 entonces es 1 o sea se hizo el swap    
    mov eax, [eax]                  <- para no pisar los nuevos valores con el popad
    mov ecx, [eax + 4]
    mov edx, [eax + 8]
    mov edi, [eax + 12]
    mov esi, [eax + 16]
    mov [esp + offset_EAX], eax
    mov [esp + offset_ECX], exc
    mov [esp + offset_EDX], edx
    mov [esp + offset_EDI], edi
    mov [esp + offset_ESI], esi
    jmp .fin
    
    .saltar:
    call sched_next_task
    mov word[sched_task_selector], ax
    jmp far [sched_task_offset]
    
    .fin:
    popad
    iret
```

```
uint32_t hacer_swap(uint8_t id) {
    uint8_t id_t1 = CURRENT_TASK;
    sched_disable_task(CURRENT_TASK)                ; deshabilito t1
    if (array_swap[id] == id_t1) {                  ; verifico si t2 tambien quiere hacer swap

        uint32_t* valores_reg[5] = {0}              ; aca voy a guardar los valores que tengo que actualizar

        eax_t2 = array_reg[id].eax;                 ; me guardo una copia de los valores de t2
        ecx_t2 = array_reg[id].ecx;
        edx_t2 = array_reg[id].edx;
        edi_t2 = array_reg[id].edi;
        esi_t2 = array_reg[id].esi;

        valores_reg[0] = eax_t2;                    ; guardo los valores 
        valores_reg[1] = ecx_t2;
        valores_reg[2] = edx_t2;
        valores_reg[3] = edi_t2;
        valores_reg[4] = esi_t2;

        tss_t* tss_t1 = &tss_tasks[id_t1];

        eax_t1 = tss_t1->eax;                       ; me guardo una copia de los valores de t1
        ecx_t1 = tss_t1->ecx;
        edx_t1 = tss_t1->edx;
        edi_t1 = tss_t1->edi;
        esi_t1 = tss_t1->esi;

        tss_t* tss_t2 = &tss_taks[id];              ; actualizo t2. t2 está pausada, al momento de ejecutarse va a tener los nuevos valores

        tss_t2->eax = eax_t1;                    
        tss_t2->ecx = ecx_t1;
        tss_t2->edx = edx_t1;
        tss_t2->edi = edi_t1;
        tss_t2->esi = esi_t1;

        limpiar_registros(id)                       ; limpio los valores de t2 que guarde en array_reg
        array_swap[id] = 0;                         ; t2 ya no esta esperando 
        sched_enable_task(id)                       ; habilito t2 para que se ejecute en la siguiente ronda del scheduler
        sched_enable_task(id_t1);                   ; una vez hecho el swap, vuelvo a habilitar t1
        return valores_reg;                  
    } else {
        array_swap[id_t1] = id;                     ; si no es el caso actualizo array_swap
        guardar_registros(id_t1);                   ; guardo los valores de t1 en array_reg para cuando t2 llame para hacer swap
        return 0;                                   ; esto indica que no se hizo al swap, t1 queda deshabilitada y hay que saltar a otra tarea
    }
}
```
```
void guardar_registros(uint8_t id){
    tss_t* tss = &tss_tasks[id];
    array_reg[id].eax = tss->eax;
    array_reg[id].ecx = tss->ecx;
    array_reg[id].edx = tss->edx;
    array_reg[id].edi = tss->edi;
    array_reg[id].esi = tss->esi;
}
```

```
void limpiar_registros(uint8_t id){
    array_reg[id].eax = 0;
    array_reg[id].ecx = 0;
    array_reg[id].edx = 0;
    array_reg[id].edi = 0;
    array_reg[id].esi = 0;
}
```


## Implementar swap_now. 


En idt.c:
```
void idt_init(){
        .
        .
        .
    IDT_ENTRY3(100); <- nueva entrada
        .
        .
        .
}
```

Ahora defino su handler.
En isr.asm:

```
_isr100:
    pushad
    push eax                        <- paso el id de t2
    call hacer_swap_now
    add esp, 4  
    cmp eax, 0
    je .saltar         
    mov eax, [eax]                  <- para no pisar los nuevos valores con el popad
    mov ecx, [eax + 4]
    mov edx, [eax + 8]
    mov edi, [eax + 12]
    mov esi, [eax + 16]
    mov [esp + offset_EAX], eax
    mov [esp + offset_ECX], exc
    mov [esp + offset_EDX], edx
    mov [esp + offset_EDI], edi
    mov [esp + offset_ESI], esi
    jmp .fin

    .saltar:
        mov flag_swap, 1                <- la proxima vez que se ejecute se tiene que fijar si t2 solicitó hacer swap
        call sched_next_task            <- si no se hizo el swap se pasa a otra tarea
        mov word[sched_task_selector], ax
        jmp far [sched_task_offset]
    
    .fin:
        popad
        iret
```

```
uint32_t hacer_swap_now(uint8_t id){
    id_t1 = CURRENT_TASK;
    sched_disable_task(CURRENT_TASK);               ; deshabilito t1
    if (array_swap[id] == id_t1) {                  ; verifico si t2 tambien quiere hacer swap

        uint32_t* valores_reg[5] = {0}              ; aca voy a guardar los valores que tengo que actualizar

        valores_reg[0] = array_reg[id].eax;         ; guardo los valores de t2 
        valores_reg[1] = array_reg[id].ecx;
        valores_reg[2] = array_reg[id].edx;
        valores_reg[3] = array_reg[id].edi;
        valores_reg[4] = array_reg[id].esi;

        tss_t* tss_t1 = &tss_tasks[CURRENT_TASK];   

        eax_t1 = tss_t1->eax;                       ; me guardo una copia de los valores de t1
        ecx_t1 = tss_t1->ecx;
        edx_t1 = tss_t1->edx;
        edi_t1 = tss_t1->edi;
        esi_t1 = tss_t1->esi;

        tss_t* tss_t2 = &tss_taks[id];              ; actualizo t2. t2 está pausada, al momento de ejecutarse va a tener los nuevos valores

        tss_t2->eax = eax_t1;                    
        tss_t2->ecx = ecx_t1;
        tss_t2->edx = edx_t1;
        tss_t2->edi = edi_t1;
        tss_t2->esi = esi_t1;

        limpiar_registros(id)                       ; limpio los valores de t2 que guarde en array_reg
        sched_enable_task(id)                       ; habilito t2 para que se ejecute en la siguiente ronda del scheduler
        sched_enable_task(id_t1);                   ; una vez hecho el swap, vuelvo a habilitar t1
        return valores_reg;                         ; devuelvo el array con los valores que voy a intercambiar
        array_swap[id] = 0;                         ; t2 ya no esta esperando     
    } else {
        array_swap[id_t1] = id;                     ; si no es el caso actualizo array_swap
        guardar_registros(id_t1);
        sched_enable_task(id_t1);                   ; habilito t1 para que se ejecute en la proxima ronda del scheduler (de todas formas voy a saltar a otra tarea para que no se siga ejecutando)
        return 0;                                   ; esto indica que no se hizo al swap, hay que saltar a otra tarea
    }
}
```
CURRENT_TASK es la variable definida en el taller (el id de la tarea activa según el scheduler, o sea t1).

Para la parte de borrar el pedido si despues de una ronda del scheduler no se concreta el swap:
Se debe definir un nuevo flag. El flag_swap indica si hay que verificar la espera, si flag_swap = 0, la tarea no está esperando nada, no hay que hacer nada, si flag_swap = 1 entonces al momento de retomar su ejecución hay que verificar el estado de las variables de array_swap y array_reg. Esto por que si t1 estaba esperando, si t2 hubiera pedido swap cuando estaba en ejecución entonces se habria ejecutado normalmente y se habrían seteado sus variables (las de t1) en cero. Este flag se deberia verificar siempre que se reanude la ejecución de una tarea. Cuando en swap_now caemos en la etiqueta .saltar se debe seter el flag_swap en 1, asi cuando se retome la ejecución en la proxima ronda el procesador va a saber si debe fijarse o no (si debe llamar o no a verificar) el estado de la espera. En cualquier caso, al momento de retomar la ejecución una tarea se debe volver a setear el flag_swap en 0 (porque se hizo el swap y ya no esta esperando o porque no se hizo el swap y dejo de esperar), esto se hace al regresar de la función verificar().

```
void verificar(){                       <- entra acá si flag_swap = 1
    id_t1 = CURRENT_TASK                ; en este momento se retomo la ejecución de t1 entonces CURRENT_TASK = id_t1
    id_t2 = array_swap[id_t1];
    if (array_swap[id_t1] == 0){        ; entonces t2 llamo a swap y no hay que hacer nada
        return 0;
    } else {                            ; t2 no pidió hacer swap, hay que borrar el pedido de espera
        array_swap[id_t1] = 0;
        array_reg[id_t1].eax = 0;
        array_reg[id_t1].ecx = 0;
        array_reg[id_t1].edx = 0;
        array_reg[id_t1].edi = 0;
        array_reg[id_t1].esi = 0;
    }
}  
```

# EJERCICIO 2
Modificar la variable en la dirección 0xC001C0DE (dirección virtual). 1 si se realizó el swap, 0 en caso contrario.

Defino variable globlar SWAP_VIRT = 0xC001C0DE.

En swap:
```
_isr99:
    pushad
    push eax                        <- paso el id de t2
    call hacer_swap
    add esp, 4
    cmp eax, 0  
    je .saltar                      <- si es != 0 entonces se hizo el swap  
    mov eax, [eax]                  <- para no pisar los nuevos valores con el popad
    mov ecx, [eax + 4]
    mov edx, [eax + 8]
    mov edi, [eax + 12]
    mov esi, [eax + 16]
    mov [esp + offset_EAX], eax
    mov [esp + offset_ECX], exc
    mov [esp + offset_EDX], edx
    mov [esp + offset_EDI], edi
    mov [esp + offset_ESI], esi
    mov eax, cr3
    push eax
    call setear_uno
    jmp .fin

    .saltar:
        mov eax, cr3
        push eax  
        call setear_cero
        pop eax

        call sched_next_task
        mov word[sched_task_selector], ax
        jmp far [sched_task_offset]
    
    .fin:
        pop eax
        popad
        iret
```

En swap_now:
```
_isr100:
    pushad
    push eax                        <- paso el id de t2
    call hacer_swap_now
    add esp, 4  
    cmp eax, 0
    je .saltar    
    mov eax, [eax]                  <- para no pisar los nuevos valores con el popad
    mov ecx, [eax + 4] 
    mov edx, [eax + 8]
    mov edi, [eax + 12]
    mov esi, [eax + 16]
    mov [esp + offset_EAX], eax     <- uso los offsets definidos en el taller
    mov [esp + offset_ECX], exc
    mov [esp + offset_EDX], edx
    mov [esp + offset_EDI], edi
    mov [esp + offset_ESI], esi
    mov eax, cr3
    push eax
    call setear_uno
    pop eax
    jmp .fin

    .saltar:
        mov flag_swap, 1
        mov eax, cr3
        push eax
        call setear_cero
        pop eax

        call sched_next_task            <- si no se hizo el swap se pasa a otra tarea
        mov word[sched_task_selector], ax
        jmp far [sched_task_offset]

    .fin:          
        popad
        iret
```

```
void setear_cero(uint32_t cr3){
    uint32_t resultado = 0;                       
    uint32_t offset = VIRT_PAGE_OFFSET(SWAP_VIRT);
    pag_tmp = mmu_next_free_user_page();                                                          
    mmu_map_page(cr3, SWAP_VIRT, pag_tmp, (MMU_U | MMU_P | MMU_W));             // mapeo la dirección virtual para que pueda modificar la variable
    page_tmp = page_tmp + offset                                                // para que apunte a la variable y no al inicio de la página    
    uint32_t* tmp = (uint32_t*) page_tmp;                                       // tmp apunta a la dirección 
    tmp = resultado;                                                            // modifico la variable
    mmu_unmap_page(cr3, SWAP_VIRT);                                             // una vez actualizado el valor desmapeo la pagina
}
```

```
void setear_uno(uint32_t cr3){
    uint32_t resultado = 1;                   
    uint32_t offset = VIRT_PAGE_OFFSET(SWAP_VIRT);
    pag_tmp = mmu_next_free_user_page();                                                          
    mmu_map_page(cr3, SWAP_VIRT, pag_tmp, (MMU_U | MMU_P | MMU_W));             // mapeo la dirección virtual para que pueda modificar la variable
    page_tmp = page_tmp + offset                                                // para que apunte a la variable y no al inicio de la página    
    uint32_t* tmp = (uint32_t*) page_tmp;                                       // tmp apunta a la dirección 
    tmp = resultado;                                                            // modifico la variable
    mmu_unmap_page(cr3, SWAP_VIRT);                                             // una vez actualizado el valor desmapeo la pagina
}
```

Necesito mappear la dirección virtual en el sistema de paginación de la tarea para poder modificar la variable. Para no ir gastanto paginas agarro la siguiente disponible, la mappeo, escribo el valor, y la desmapeo otra vez. En las dos syscall dependiendo del resultado de hacer_swap/hacer_swap_now (o sea dependiendo de si se hizo el swap en ese momento o no) se llama a setear_uno o setear_cero. No sabía de que tamaño era la variable asi que asumi que es de 32 bits.

# CORRECCIONES

1.a
Regular


El intercambio no debe realizarse con los valores almacenados en las TSS, ya que los registros que mantiene son los del contexto de nivel 0, al ser desalojada la tarea. Además, la tarea actual tiene los registros en la TSS con valores completamente distintos. Hay que buscar los valores de los registros en la pila de nivel 0 de cada tarea. Se ve que en guardar_registros se acceden directamente los registros de la tss.

1.b
Regular
Eso no se ejecuta nunca.
        return valores_reg;                         ; devuelvo el array con los valores que voy a intercambiar
        array_swap[id] = 0;                         ; t2 ya no esta esperando
Y esto donde está definido?
mov flag_swap, 1                <- la proxima vez que se ejecute se tiene que fijar si t2 solicitó hacer swap
¿Cómo se qué tarea activó el flag_swap?

Dónde se llama a verificar?

2
Bien-

Falta chequear que la dirección CODE esté mapeada en la tarea destino.


