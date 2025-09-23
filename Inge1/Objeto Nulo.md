## Objeto Nulo, Bobby Wolf

### Intencion

Lo usamos para que tenga la misma interfaz de un objeto, pero que no haga nada. Este Objeto Nulo encapsula la implementacion de no hacer nada.

### Motivacion

Cuando los objetos tienen controladores y estos le mandan constantemente mensajes a los objetos, esperan algo, pero en a veces tenemos casos que no queremos que haga nada. Pero no podemos dejar que el controlador sea *nil*, ya que esto traeria problemas al enviar mensajes como *nl*. *Nil* no podria responder los mensajees del controlador.

La solucion es usar una subclase del Controlador llamado NoControlador, este implementaria todo la logica del Controloador pero no haria nada. Es decir responde todo mensaje del Controlador, pero no haciendo nada. Esta sublclase seria un clase abstracta, ya que como dijimos, conserva la interfaz pero no hace nada.

## Usos

- un objeto requiere de un colaborador. Este colaborador no es introducido por el patrón, sino que éste utiliza una colaboración que ya existía.
  
- instancias tienen algunos colaboradores que no hacen nada.
 
- se quiere que los clientes puedan ignorar la diferencia entre tratar con un colaborador que tiene comportamiento y uno que no hace nada. De esta forma, el cliente no tiene que verificar explícitamente si es nil u otro valor especial.

- se quiere la posibilidad de reutilizar el comportamiento de “no hacer nada”, para que varios clientes que lo necesiten puedan funcionar de la misma manera consistentemente.
  
- todo comportamiento que pueda necesitar ser el comportamiento de no hacer nada está encapsulado dentro de la clase del colaborador. Si parte del comportamiento de esta clase es el de no hacer nada, la mayoría o todo el comportamiento será de ese mismo tipo.
