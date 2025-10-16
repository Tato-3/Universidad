## Decorator

Asigna responsabilidades adicionales a un objeto dinamicante, esto permite extender la funcionalidad del objeto.

Al objeto confinante se le denomina decorador. El decorador se ajusta a la interfaz del componente que decora de manera que su presencia es transparente a sus clientes. El decorador reenvía las peticiones al componente y puede realizar acciones adicionales (tales como dibujar un borde) antes o después del reenvío. Dicha transparencia permite anidar decoradores recursivamente, permitiendo así un número ilimitado de responsabilidades añadidas.

### Aplicabilidad

Use el Decorador
- para añadir objetos individuales de forma dinámica y transparente, es decir, sin afectar a otros objetos.
- para responsabilidades que pueden ser retiradas.
- cuando la extensión mediante la herencia no es viable. A veces es posible tener un gran número de extensiones independientes, produciéndose una explosión de subclases para permitir todas las combinaciones. O puede ser que una definición de una clase esté oculta o que no esté disponible para ser heredada.

### Consecuencias

#### Buenas:

- Más flexibilidad que la herencia estática. El patrón Decorador proporciona una manera más flexible de añadir responsabilidades a los objetos. Con los decoradores se pueden añadir y eliminar responsabilidades en tiempo de ejecución simplemente poniéndolas y quitándolas.

- Evita clases cargadas de funciones en la parte de arriba de la jerarquía. El Decorador ofrece un enfoque para añadir responsabilidades que consiste en pagar sólo por aquello que se necesita.

### Malas:

- Un decorador y su componente no son idénticos. Un decorador se comporta como un revestimiento transparente. Pero desde el punto de vista de la identidad de un objeto, un componente decorado no es idéntico al componente en sí.
- Muchos objetos pequeños. Un diseño que usa el patrón Decorator suele dar como resultado sistemas formados por muchos objetos pequeños muy parecidos
