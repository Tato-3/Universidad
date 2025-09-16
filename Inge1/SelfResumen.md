## Self, Randall Smith Resumen

Self no incluye clases ni variables, en cambio, se trabaja con metaforas de prototipos para la creacion de objetos. Mientras en Smalltalk soporta el acceso a variables y pasar mensajes. En Self los objetos acceden a su informacion de estado emviando mensajes hacia "self". Esto resulta en enviar muchos mensajes a "self". (Por esto se llama el lenguaje)

### Principios de diseño en Self

##### Mensjaes en el fondo

La operacion fundamental se Self es pasar mensajes, no hay variables, solo objetos devolviendose a si mismos. Como los objetos de Self acceden al estado mediante el envio de mensajes, esto se vuelve fundamental para Self a diferencia de otros lenguajes con variables.

Por lo que tenemos las distintas caracteristicas:

- Cualquier objeto puede funcionar como una instancia o servir como un repositorio para compartir informacion.

- No hay diferencia entre accceder a una variable y enviar un mensaje.

- No hay estructuras de control, sino que hay clausuras y polimorfismo para controlar estructuras.

- A diferencia de Smalltalk, los objetos y los procedimientos vienen del mismo lugar, de representar procedimientos como prototipos de "activision records". Esto permite a los activision records ser creados de la misma manera que otros objetos, mendiante la clonacion de objetos.

##### La concrecion

Como Self es un lenguaje basado en prototipos, los obejtos son creados por clonacion a prototipos. En Self cualquier objeto puede ser clonado

#### Diferencias entre Self y sistemas en base a clases

<img width="707" height="267" alt="image" src="https://github.com/user-attachments/assets/4d2df446-0f82-4277-96c7-818cc4802259" />

### Prototipos 

En Self todo es un objeto, pero a diferencia de Smalltalk que todo objeto contiene un puntero a su misma clase, en Self los objetos contienen slots con nombres para guardar o bien estados o comportamientos.

Si un objeto recibe un mensaje y no hay un matcheo con el slot, la busqueda continua con el puntero del padre. Asi es como Self implementa la herencia. La herencia en Self permite compartir comportamientos lo que permite el cambio de este en muchos objetos con un solo cambio.

Los prototipos simplifican la relacion entre objetos, por eso solo hay una relacion y es "inhertis from"
Los prototipos son mas concretos que las clases porque son ejemplos de objeton mas que descripciones de un formato. 

### Closures

In SELF, a closure is represented by an object containing an environment link and a method named “value,” “value:,” “value:With:,” and so forth, depending on the number of arguments.



