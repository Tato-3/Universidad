
La programación dinámica, como dividir y conquistar, resuelve el problema combinando las soluciones de los sub-problemas.

Esta se aplica cuando los problemas se *superponen*, es decir cuando un algoritmo recursivo revisita el mismo problema repetidamente. Con esta estrategia lo que hacemos es cuando resolvemos un sub-problema lo guardamos en una tabla. Ahorrándonos el tiempo de re-computar la misma respuesta.

La programación dinámica es típico de problemas de optimiazacion, estos problemas tienen muchas posibles soluciones  y por lo que queremos la solución con el optimo valor. 

Secuencia de pasos es decir cuando los sub-problemas comparten sub-sub-problemas para desarrollar un algoritmo de programación dinámica:

   - Caracterizar la estructura de una solución optima
   - Recursivamente definir el valor de una posible solución optima
   - Computar el valor de una solución optima, tipicamente en bottom-up
   - Construir una solución optima de información computable

Ejemplo de programación dinámica : [[Rod cutting]]

Cuando hablamos de programacion dinamica tenemos que entender el conjunto de subproblemas envueltos y como los subproblemas dependen de otros.

Podemos pensar el grafo de arriba como una reduccion de un arbol recursiovo del metodo **top-down**, con todos los nodos para el mismo subproblema coalizados dentro de un solo vertice y todas las aristas directas del padre al hijo.

En el metodo **bottom-up** consideramos los vertices de un grafo del subproblea en un orden talque resuelve los subproblemas $y$ adyacentes hacia un subproblema $x$ dado, antes de que x sea resuelto. 

En un algoritmo bottom-up consideramos que los vertices del grafo del subproblema estan en un orden topologico.


## Subestructura optima

El primer paso para resolver un problema de optimizacion usando programacion dinamica es caracterizar la estructura optima de la solucion. Cuando el problema muestra posibles subestructuras, eso nos da una pista que debemos aplicar programacion dinamica.

La programacion dinamica construye una solucion optima para el problema a partir de soluciones optimas a subproblemas, a su vez vamos a encontrar un cierto patron en los problemas de programacion dinamica:

- Los problemas suelen consistir en hacer desiciones, como el corte en la vara.
- Suponemos que para un problema dado, nos dan la opcion que conduce a una solucion optima
- Dado esta eleccion, determinar que subproblemas surgen y como caracterizar mejor el espacio resultante de subproblemas
- Con la tecnica **cortar y pegar** podemos demostrar que las soluciones optimas a los subproblemas dentro de una solucion optima tambien deben ser optimas.

Lo que buscamos es tener el espacio mas simple posible, y luego expandirlo si es necesario

