## Una técnica simple para manejar el polimorfismo múltiple, Ingalls

### Polimorfismo y mensajes

Las técnicas de programación orientadas a objetos fueron introducidas para sobrepasar la barrera de complejidad del polimorfismo en lenguajes extensibles. Los lenguajes tenian que lidiar con argumentos de varios tipos distintos. Para esto, se probaba cada tipo conocido y despues ejecutar el codigo apropiado para el identificado. Pero esto violaba los principios basicos de la modularidad y era muy complejo.

Con la llegada de los lenguajes de envio de mensajes, se soluciono esto, ya que el proceso de envio de mensajes absorbe la necesidad de verificar la clase del objeto en cuestion. Y los metodos son locales de la clase, no son ni polimorficos ni depende de las otras clases del sistema.

### El Problema

Cuando mas de una variable en una expresion es independiente polimorfica, llevan a los viejos problemas de la programacion procedural. 

Pongo todo el ejemplo del paper:
Utilicemos, como ejemplo, el caso de los objetos gráficos y los distintos tipos de puertos gráficos
donde tales objetos pueden ser representados. Claramente, una variable que contiene el objeto
gráfico frecuentemente será polimórfica, tomando tales valores como rectángulos, óvalos, líneas,
texto, imágenes de mapas de bits u otros objetos gráficos más complejos. Al mismo tiempo, una
variable que contiene un puerto gráfico también podrá tomar valores de distintos tipos concretos,
como un puerto de un monitor, de una impresora, de un monitor remoto, etc. En consecuencia,
tenemos la siguiente interacción polimórfica doble:

<img width="480" height="270" alt="image" src="https://github.com/user-attachments/assets/d6875a11-69ef-4542-be35-3e525b328f2b" />


### Solucion

Para esto necesitamos etender la relacion entre el polimorfismo y el envio de mensajes para reconocer la forma apropiada de abordar el problema. En esencia,cada transmisión de mensaje reduce una variable polimórfica a una monomórfica por el tipo de envío inherente a la búsqueda de mensajes. Casi siempre, el receptor es polimorfico, pero esto no siempre es asi, como en el ejemplo de arriba.

