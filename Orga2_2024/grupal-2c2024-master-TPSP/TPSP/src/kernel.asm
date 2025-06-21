; ** por compatibilidad se omiten tildes **
; ==============================================================================
; TALLER System Programming - Arquitectura y Organizacion de Computadoras - FCEN
; ==============================================================================

%include "print.mac"
    
global start

; COMPLETAR - Agreguen declaraciones extern según vayan necesitando
extern GDT_DESC
extern screen_draw_layout
extern IDT_DESC
extern idt_init
extern pic_reset
extern pic_enable
extern mmu_init_kernel_dir
extern mmu_init_task_dir
extern copy_page
extern tss_init
extern tasks_screen_draw 
extern sched_init
extern tasks_init

; COMPLETAR - Definan correctamente estas constantes cuando las necesiten
%define GDT_IDX_CODE_0 1
%define GDT_IDX_DATA_0 3

%define CS_RING_0_SEL (GDT_IDX_CODE_0 << 3)
%define DS_RING_0_SEL (GDT_IDX_DATA_0 << 3)

%define GDT_IDX_TASK_IDLE 12
%define GDT_IDX_TASK_INITIAL 11

%define DIVISOR 0x1000
BITS 16
;; Saltear seccion de datos
jmp start

;;
;; Seccion de datos.
;; -------------------------------------------------------------------------- ;;
start_rm_msg db     'Iniciando kernel en Modo Real'
start_rm_len equ    $ - start_rm_msg

start_pm_msg db     'Iniciando kernel en Modo Protegido'
start_pm_len equ    $ - start_pm_msg

;;
;; Seccion de código.
;; -------------------------------------------------------------------------- ;;

;; Punto de entrada del kernel.
BITS 16
start:
    cli ; Deshabilitar interrupciones

    ; Cambiar modo de video a 80 X 50
    mov ax, 0003h
    int 10h ; set mode 03h
    xor bx, bx
    mov ax, 1112h
    int 10h ; load 8x8 font

    ; COMPLETAR - Imprimir mensaje de bienvenida - MODO REAL
    ; (revisar las funciones definidas en print.mac y los mensajes se encuentran en la
    ; sección de datos)
    print_text_rm start_rm_msg, start_rm_len, (0x5 << 4), 2, 3
    
    call A20_enable ; Habilitar A20
    ; (revisar las funciones definidas en a20.asm)
    
    ; COMPLETAR - Cargar la GDT
    lgdt [GDT_DESC]

    ; COMPLETAR - Setear el bit PE del registro CR0
    mov eax, cr0
    or eax, 1 ; bit 0 (PE) = 1, el resto queda igual
    mov cr0, eax

    ; COMPLETAR - Saltar a modo protegido (far jump)
    ; (recuerden que un far jmp se especifica como jmp CS_selector:address)
    ; Pueden usar la constante CS_RING_0_SEL definida en este archivo

    jmp CS_RING_0_SEL:modo_protegido ; este salto modifica CS y pasamos a modo protegido

BITS 32
modo_protegido:
    ; COMPLETAR - A partir de aca, todo el codigo se va a ejectutar en modo protegido
    ; Establecer selectores de segmentos DS, ES, GS, FS y SS en el segmento de datos de nivel 0
    ; Pueden usar la constante DS_RING_0_SEL definida en este archivo

    mov ax, DS_RING_0_SEL
    mov ds, ax
    mov es, ax
    mov gs, ax
    mov fs, ax
    mov ss, ax

    ; COMPLETAR - Establecer el tope y la base de la pila
    mov esp, 0x25000 ; tope de la pila
    mov ebp, 0x25000 ; base de la pila

    ; COMPLETAR - Imprimir mensaje de bienvenida - MODO PROTEGIDO
    print_text_pm start_pm_msg, start_pm_len, (0x5 << 4), 0, 0

    ; COMPLETAR - Inicializar pantalla
    call screen_draw_layout
   
    ; Inicializar el directorio de paginas
    call mmu_init_kernel_dir            ; Inicializar KPD y KPT

    ; Cargar directorio de paginas
    mov cr3, eax        ; en eax ya esta la dir del PD

    ; Habilitar paginacion
    mov eax, cr0
    or eax, 0x80000000 ; bit 31 (PG) = 1, el resto queda igual
    mov cr0, eax

    ; El PIT (Programmable Interrupt Timer) corre a 1193182Hz.
    ; Cada iteracion del clock decrementa un contador interno, cuando éste llega
    ; a cero se emite la interrupción. El valor inicial es 0x0 que indica 65536,
    ; es decir 18.206 Hz
    mov ax, DIVISOR
    out 0x40, al
    rol ax, 8
    out 0x40, al

    ; Inicializar tss
    call tss_init
    call tasks_screen_draw 

    ; Cargar tarea inicial
    mov ax, (GDT_IDX_TASK_INITIAL << 3)
    ltr ax

    ; Inicializar el scheduler
    call sched_init

    ; Inicializar las tareas
    call tasks_init

    ; COMPLETAR - Inicializar y cargar la IDT
    call idt_init
    lidt [IDT_DESC]

    ; COMPLETAR - Reiniciar y habilitar el controlador de interrupciones
    call pic_reset
    call pic_enable

    ; COMPLETAR - Habilitar interrupciones
    sti

    ; NOTA: Pueden chequear que las interrupciones funcionen forzando a que se
    ;       dispare alguna excepción (lo más sencillo es usar la instrucción
    ;       `int3`)

    ; Probar Sys_call
    int 88
    int 98

    ; Probar generar una excepción
    ;int 3

    ; Prueba de copy_page

    ; Inicializar el directorio de paginas de la tarea de prueba
    ;mov eax, 0x18000                ; dir donde comienza la tarea
    ;push eax
    ;call mmu_init_task_dir          ; eax tiene la dir del PD de la tarea
    
    ; Cargar directorio de paginas de la tarea
    ;mov cr3, eax
    ;pop eax

    ; Escribir 2 veces en la zona de memoria compartida on-demand 
    ;mov eax, 1
    ;mov [0x07000000], eax           ; escribo en alguna dirección. genera PF
    ;mov eax, 2     
    ;mov [0x07000001], eax           ; escribo en otra dirección (dentro del rango de página). no debería generar PF

    ; Restaurar directorio de paginas del kernel
    ;mov eax, 0x25000                ; dir del PD
    ;mov cr3, eax

    ; Saltar a la primera tarea: Idle
    jmp (GDT_IDX_TASK_IDLE << 3):0

    ; Ciclar infinitamente 
    mov eax, 0xFFFF
    mov ebx, 0xFFFF
    mov ecx, 0xFFFF
    mov edx, 0xFFFF
    jmp $

;; -------------------------------------------------------------------------- ;;

%include "a20.asm"
