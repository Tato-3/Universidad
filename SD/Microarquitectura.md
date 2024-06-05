
Conceptualmente la mircroarquitectura se encuentra entre la arquitectur y la logica combinatoria y secuencial. Implementa el soporte de estado arquitectonico y la logica de control para actualizar el estado segun lo indique la semantica de las instrucciones de la ISA.

La microrquitectura se va a encargar de actualizar el estado de la arquitectura, es decir los registros de proposito general y el PC (program counter). Cuando hablamos de el estado de la arquitectura nos referimos a los elementos de memoria expuestos a la persona que programa el sistema.

**Procesador**: Puede contener elementos de memoria que forman el estado por fuera de la arquitectura, registros o banco de memoria usados para implementar mecanismos o funciones propios de la arquitectura pero que no son expuestos.

### Proceso de Diseño

#### Datapath
Para comenzar con el diseño de un sistema complejo vamos a comenzar presentando y vinculand a los elementos que realizaran transformaciones con los datos, esto lo denominamos como **el camino de datos o datapath**.

#### Unidad de control
Luego vamos a decidir como implementar la unidad que se asegura de coordinar a los elementos del **datapath** para transformar a los datos a partir de la manipulacion de sus señales de control, a esto lo denominamos como **unidad de control**.

### Elementos de memoria


