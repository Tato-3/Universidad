extern sumar_c
extern restar_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_using_c
global alternate_sum_4_using_c_alternative
global alternate_sum_8
global product_2_f
global product_9_f

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parametros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4:
  sub EDI, ESI
  add EDI, EDX
  sub EDI, ECX

  mov EAX, EDI
  ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parametros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4_using_c:
  ;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;strack frame armado
  push R12
  push R13	; preservo no volatiles, al ser 2 la pila queda alineada

  mov R12D, EDX ; guardo los parámetros x3 y x4 ya que están en registros volátiles
  mov R13D, ECX ; y tienen que sobrevivir al llamado a función

  call restar_c 
  ;recibe los parámetros por EDI y ESI, de acuerdo a la convención, y resulta que ya tenemos los valores en esos registros
  
  mov EDI, EAX ;tomamos el resultado del llamado anterior y lo pasamos como primer parámetro
  mov ESI, R12D
  call sumar_c

  mov EDI, EAX
  mov ESI, R13D
  call restar_c

  ;el resultado final ya está en EAX, así que no hay que hacer más nada

  ;epilogo
  pop R13 ;restauramos los registros no volátiles
  pop R12
  pop RBP ;pila desalineada, RBP restaurado, RSP apuntando a la dirección de retorno
  ret


alternate_sum_4_using_c_alternative:
  ;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;strack frame armado
  sub RSP, 16 ; muevo el tope de la pila 8 bytes para guardar x4, y 8 bytes para que quede alineada

  mov [RBP-8], RCX ; guardo x4 en la pila

  push RDX  ;preservo x3 en la pila, desalineandola
  sub RSP, 8 ;alineo
  call restar_c 
  add RSP, 8 ;restauro tope
  pop RDX ;recupero x3
  
  mov EDI, EAX
  mov ESI, EDX
  call sumar_c

  mov EDI, EAX
  mov ESI, [RBP - 8] ;leo x4 de la pila
  call restar_c

  ;el resultado final ya está en EAX, así que no hay que hacer más nada

  ;epilogo
  add RSP, 16 ;restauro tope de pila
  pop RBP ;pila desalineada, RBP restaurado, RSP apuntando a la dirección de retorno
  ret


; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);
; registros y pila: x1[EDI], x2[ESI], x3[EDX], x4[ECX], x5[R8D], x6[R9D], x7[RBP+16], x8[RBP+24]
alternate_sum_8:
	;prologo
  push RBP      ;pila alineada
  mov RBP, RSP  ;stack frame armado

  push R12      ; preservo x5 ya que R8 es volatil
  push R13      ; preservo x6 lo mismo que arriba
  push R14      ; preservo x7
  push R15      ; preservo x8

  mov R12D, R8D;
  mov R13D, R9D;
  mov R14D, [RBP + 16]
  mov R15D, [RBP + 24]
	; COMPLETAR
  call alternate_sum_4  ;En EAX tengo x1 - x2 + x3 - x4

  ;Muevo mis registros guardados para llamar a la funcion
  mov EDI, R12D
  mov ESI, R13D
  mov EDX, R14D
  mov ECX, R15D

  mov R12D, EAX   ;Guardo el resultado de mi primer call

  call alternate_sum_4

  add EAX, R12D ;Mi respuesta

	;epilogo
  pop R15
  pop R14
  pop R13
  pop R12
  pop RBP     ;pila desalineada, RBP restaurado, RSP apuntando a la direcc de return
	ret


; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[RDI], x1[ESI], f1[XMM0]
product_2_f:
    
    cvtss2sd xmm0, xmm0 ; Convierto f1 como double
    cvtsi2sd xmm1, esi ; convierto x1 a Scalar double fp
    mulsd xmm0, xmm1 ; multiplico xmm0 por xmm1
    cvttsd2si eax, xmm0 ; trunco el scalar double a scalar int
    mov [rdi], eax ; guardo en destinantion
    ret
;extern void product_9_f(double * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[esi], f1[xmm0], x2[edx], f2[xmm1], x3[ecx], f3[xmm2], x4[r8d], f4[xmm3]
;	, x5[r9d], f5[xmm4], x6[rbp+16], f6[xmm5], x7[rbp+24], f7[xmm6], x8[rbp+32], f8[xmm7],
;	, x9[rbp+40], f9[rbp+48]
product_9_f:
	;prologo
	push rbp
	mov rbp, rsp

	;convertimos los flotantes de cada registro xmm en doubles
	; COMPLETAR
  cvtss2sd xmm0, xmm0
  cvtss2sd xmm1, xmm1
  cvtss2sd xmm2, xmm2
  cvtss2sd xmm3, xmm3
  cvtss2sd xmm4, xmm4
  cvtss2sd xmm5, xmm5
  cvtss2sd xmm6, xmm6
  cvtss2sd xmm7, xmm7
  cvtss2sd xmm8, [rbp+48]

  ;multiplicamos los doubles en xmm0 <- xmm0 * xmm1, xmmo * xmm2 , ...
  ; COMPLETAR
  mulsd xmm0, xmm1
  mulsd xmm0, xmm2
  mulsd xmm0, xmm3
  mulsd xmm0, xmm4
  mulsd xmm0, xmm5
  mulsd xmm0, xmm6
  mulsd xmm0, xmm7
  mulsd xmm0, xmm8

  ; convertimos los enteros en doubles y los multiplicamos por xmm0.
  ; COMPLETAR
  cvtsi2sd xmm1, esi
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, edx
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, ecx
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, r8d
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, r9d
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp+16]
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp+24]
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp+32]
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp+40]
  mulsd xmm0, xmm1

  movsd [rdi], xmm0
  ; epilogo
	pop rbp
	ret

