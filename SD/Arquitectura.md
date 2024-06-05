
La *arquitectura de un procesador* es aquello con lo que podemos trabajar cuando escribimos un programa. Son las *intrucciones*, los *registros*, y la forma de acceder a la *memoria*. 


##### Que constituye una arquitectura

- El conjunto de **instrucciones**
- El conjunto de **registros**
- La forma de acceder a la **memoria**


### Lenguaje ensamblador

Los procesadores implementan una arquitectura y necesitar ser acompañados por programas de **compilado, ensamblado y enlazado** que permiten escribir código en alto nivel y conseguir que este se traduzca. Sin esto, solo podríamos programar en lenguaje ensamblador.

|| La suma en RISC V : 

*add*, a , b, c

Donde la primera parte es el tipo de operación llamado mnemonico, los operandos b y c son los operandos de fuente y a es el operando destino, es donde se va a almacenar el resultado de la operacion de b y c.

El lenguaje ensamblador no permite la composicion de opereaciones del modo en que lo hace, por ejemplo si queremos sumar y restar, tendremos que hacerlo en operaciones distintas:

	add t, b, c   // t = b + c
	sub a, t, d   // a = t - d


Los operandos de fuente y destino suelen ser **registros** porque la operaciones logico aritmeticas modifican el estado del procesador segun su semantica, estas modificaciones se tienen que hacer rapidamente ya que constituyen el grueso del computo que ocurre en nuestros procesadores.


#### Register File


![[Pasted image 20240530132418.png]]

RISC V cuenta con 32 registros que suelen ser implementados como un array de memoria estatica de 32 bits con varios puertos.

Los registros pueden ser nombrados por su indice, desde x0 a x31 o su uso habitual.

- El registro zero (x0) almacena siempre el valor 0
- Variables : s0 a s11 y t0 a t6
- Llamadas a funcion: ra y de a0 a a7

En el lenguaje ensamblador contamos con un conjunto fijo de 32 elementos con los que operar. Al traducir un programa de un lenguaje de alto nivel a ensamblador debemos decidir en que registros alamacenar los valores de nuestras variables.

En las intrucciones ensamblador puede haber valores constantes como operandos, los llamamos valores inmediatos, ya que estan en la misma instruccion. El valor puede escribirseen decimal, hexadecimal o binario. Estos valores son de **12 bits y se extiende su signo a 32 bits antes de operar**

>Valores inmediatos de 32 bits

Cuando queramos cargar un constante de 32 bits requiere que hagamos dos operaciones : 
- Primero cargamos los 20 bits masa altos con la instruccion lui(load upper inmediate)
- Segundo cargamos los 12 bits mas bajos con un addi

![[Pasted image 20240530134732.png]]


#### Memoria
La memoria se estructura y accede como si fuera un arreglo de elementos de 32 bits (4 bytes). A comparacion con el acceso a los registros, el acceso a memoria es mas lento, pero nos permite acceder a mucha mas info, que solo tener que operar solo con registros.

En RISC V podemos acceder a la memoria a traves de indices de 32 bits. Pero el indice que apunta a un byte en particular, es decir a los cuatro bytes de la palabra, de modo que entre una palabra de 32 bits y otra, los indices avanzan en 4 unidades.

>Leer y escribir datos

Cuando operamos con la memoria usamos las instrucciones **lw(load word)** para leer una palabra de memoria en un registro y **sw(store word)** 

###### Programas almacenados en memoria
En la memoria del procesador, vamos a almacenar las instrucciones que describen el comportamiento de un programa, cada instruccion ocupa 32 bits (una palabra), por lo cual sus direcciones se incrementan en multiplos de 4.

*Observacion* : En RISC V permite acceder a la memoria con direcciones que refieren al byte menos significativo, a partir cual leer o escribir


| Direccion |       | Instruccione alamacenada |
| --------- | ----- | ------------------------ |
|           | 0x538 | addi s1, s2, 3           |
|           | 0x53C | lw t2, 8(s1)             |
|           | 0x540 | sw s3, 3(t6)             |

**Releer:
El procesador ejecuta el programa almacenando la posicion de
memoria de la instruccion que se esta ejecutando en un
registro de 32 bits conocido como el program counter (PC)**

En el ejemplo de arriba primero carga la instruccion de la posicion 0x538, la ejecutra y luego se incrementa el PC a 0x53C y asi hasta que termine.

#### Usos tipicos de las instrucciones logicas

- **or**: Combinar dos registros que solo tienen asignada la parte alta y baja respectivamente, ej or entre 0xFEED0000 y 0x0000F0CA = 0xFEEDF0CA

- **and**: Nos sirve para limpiar partes de un registro, como preservar la parte baja o alta, ej 0xBABAC0C0 and con 0x0000FFFF = 0x0000C0C0 nos quedamos con la parte baja.

- **xor**: Conseguir la negacion logica al aplicar la operacion a -1

>Desplazamientos:  podemos acceder a un byte en particular dentro de una palabra

#### Control del flujo de ejecucion
Como vamos a querer saltear instrucciones o volver a una instruccion anterior en nuestro programa, vamos a modificar el valor del registro PC (program counter) de modo que la proxima instruccion no sea la siguiente en la memoria sino la que se defina en una instruccion especifica.

Las instrucciones de control de flujo van a comparar el valor de los dos primeros operandos, y en funcion del resultado van a reemplazar el valor del PC con el tercer operando.

Las intrucciones son:
- beq(branch if equal): reemplaza el PC, si los dos primeros operandos son iguales
- bne(branch if not equal): reemplaza el PC, si los dos primeros operandos son distintos
- blt(branch if less than): reemplaza el PC, si el primer operando es menor que el segundo
- bge(branch if greather than or equal): reemplaza el PC, si el primer operando es mayor o igual que el segundo

#### Saltos incodicionales
Para actualizar el valor del PC se usan las instrucciones:
- j (jump): actualiza el valor del PC con el operando provisto(inmediato de 20 bits extendidos en signo a 32)
- jal (jump and link): almacena el valor actual del PC en el registro indicado en el primer operando y actualiza el valor del PC con el del segundo operando.

#### Estructura de los arreglos
Los arreglos ubican elementos del mismo tamaño y tipo de forma consecutiva en la memoria del procesador. La forma de acceder es calculando el desplazamiento desde la direccion del comienzo del arreglo hasta la direccion en la que se encuentra el elemento.


#### Llamadas a funcion, argumentos

Vamos a querer implementar la funcionalidad de llamar funciones de otra, primero como parametros de entrada vamos a  tener los argumentos y los de salida valor de retorno.

En RISC V la **funcion llamadora** (la que inicia la llamada) puede usar los registros a0 hasta a7 para enviar argumentos y luego la **funcion llamada** (la que la recibe) utiliza a0 para copiar el valor del retorno.

Cuando invocamos la ejecucion de una funcion la **funcion llamadora** almacena el PC en ra. Para esto tenemos la instruccion **jal ra**, **foo**, donde foo es la **funcion llamada**.

La funcion llamada no tiene que interferir con el estado de la funcion llamadora, por eso tenemos que respetar los valores de los registros guardados (s0 a s11) y el registro de la direccion de retorno (ra), que indica como retornar la ejecucion a la funcion llamadora. Tambien debe mantenerse invariante la porcion de memoria(stack) correspondiente a funcion llamadora.

#### Stack (Pila)

La pila es una parte de la memoria que se utiliza para almacenar informacion temporaria, se usa con el esquema LIFO (Last in First out), como una pila de valores. 

La pila suele comenzar en las direcciones altas de la memoria y va tomando (con cada push) las direcciones inmediatamente mas bajas. (La pila crece hacia abajo)

##### Estado del procesador entre llamadas

Existen reglas de preservacion de estados, para esto podemos usar la pila:

- **Regla para la llamadora**: Antes de llamar debe guardar los valores de los registros temporarios que necesite utilizar al retornar (t0-t6. a0-a7)
- **Regla para la llamada**: Si va a utilizar los registros permanentes (s0-s11, ra) debe guardarlos al comenzar y restaurarlos antes de retornar


#### Pseudoinstrucciones

Algunas intrucciones que usamos en el lenguaje ensamblador no son verdaderamente intrucciones, el compilador se encarga de traducir estas llamadas **pseudoinstruccion**. Estas se usan ya que encapsulan operaciones comunes y convenientes.


## Lenguaje de maquina
Los programas escritos en el leguaje ensamblador no pueden ser ejecutados por el procesador, por esto el codigo fuente es ensamblado para producir el archivo binario cuyos contenidos pueden ser cargados en memoria y ejecutados

#### Intrucciones R
Las instrucciones de tipo R usan dos registros como operandos fuente (rs1, rs2) y uno como operando destino rd. 

![[Pasted image 20240604152528.png]]


![[Pasted image 20240604152656.png]]


#### Instrucciones I
Las instrucciones de tipo I usan un registro como operando fuente (rs1), un inmediato de 12 bits (imm) y uno como operando destino rd. El campo op junto con funct3 determinan el tipo de instruccion codificada

![[Pasted image 20240604152914.png]]


### Mapa de Memoria
El mapa de memoria divide a la memoria princial segun su uso:
![[Pasted image 20240605101822.png#right]]

- La parte mas alta se reserva oara comunicacion de entrada y salida
- En datos dinamicos donde en las direcciones altas esta la pila y en las bajas el heap, la cual permite hacer un pedido de memoria
- En datos globales se guardan variables y constantes globales
- En texto en donde esta el contenido binario de nuestro programa












