## Object Recursion, Wolf

Object Recursion, permite que una solicitud se divida varias veces en partes mas pequeñas, que son mas faciles de manejar.

Menciona que tener un objeto (Comparador) para que diga si son objetos son equivalentes es mala idea, ya que el comparador necesitaria conocer los tipos de los objetos, ademas de recorrerlos. Pero estos objetos pueden ser muy complejos ocasionando que crear al comparador sea complicado, creando asi subclases, cuanto mas complejo se vuelve el objeto.

A su vez, cada vez que cambiemos los objetos, tendremos que modificar el comparador. Me olvide mencionar que una idea es separar al objeto en varias partes, y comparar cada parte asi recursivamente.

Una solucion es que los objetos sepa compararse, ya que conoce cuales son sus partes que debe comparar. Este algoritmo de comparación, donde un objeto se compara a sí mismo con otro diciéndole a sus partes que se comparen entre sí sucesivamente es un ejemplo de Object Recursion. Una implementación de un mensaje recursivo envía el mismo mensaje a uno o más de sus objetos relacionados. El mensaje navega por la estructura enlazada hasta alcanzar objetos que simplemente implementan el mensaje y devuelven el resultado.

### Claves

Un sistema que incorpora el patrón Object Recursión tiene las siguientes características:

- Dos clases polimórficas, una de ellas maneja una consulta recursivamente y otra que simplemente maneja la consulta sin recursión.
  
- Un mensaje separado, usualmente en una tercera clase que no es polimórfica con las dos primeras, para iniciar la consulta.

### Aplicabilidad

Usaremos el patrón Object Recursion cuando:

- estamos pasando un mensaje por una estructura enlazada donde el destino final es desconocido.
- estamos enviando un mensaje a todos los nodos que son parte de una estructura enlazada.
- estamos distribuyendo la responsabilidad de un comportamiento a lo largo de una estructura enlazada.

### Estructura

  <img width="770" height="475" alt="image" src="https://github.com/user-attachments/assets/100bfcf0-ff0a-44ac-86ed-28cf90689f3d" />
