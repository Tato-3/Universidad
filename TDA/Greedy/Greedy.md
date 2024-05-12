
Los algoritmos greedys son utilizados para resolver problemas de optmizacion. Un algortimo greedy siempre hace la mejor decision en el momento. Es decir, realiza una eleccion locamente optima con el fin de que esta eleccion nos lleve a una solucion globalmente optima. En otras palabras, en cada etapa se toma la decision que parece mejor basandose en la infomacion disponible en ese momento, sin tener en cuenta las consecuencias futuras.

Los algoritmos greedys no siempre producen soluciones optimas, en estos casosm proporcionan heuristicas sencillas que en general permiten construir soluciones razonables, pero sub-optimas.

Un algoritmo greedy obtiene un solucion optima de haber hecho una secuencia de elecciones. Para cada decision el algoritmo decide si es la mejor opcion en el momento. 

El proceso para desarrollar un algortimo greedy es:

- Determinar la subestructura optima del problema
- Desarrollar una solucion recursiva
- Mostrar que si hace la eleccion greedy, entonces solo queda un subproblema
- Probar que es siempre seguro hacer una eleccion greedy
- Desarrollar un algoritmo recursivo que implementa la estrategia greedy
- Convertir el algortimo recursivo a uno iterativo

A diferencia de la programacion dinamica en la que hacemos una eleccion por cada paso, pero esta suele depender en las soluciones de los subproblemas. En los algoritmos greedys, hacemos una eleccion que parece ser la mejor en el momento, y luego resolvemos resolvemos los subproblemas restantes. 

Por lo que a diferencia de la programacion dinamica, en el cual se resuelve primero los subproblemas antes de hacer la primera eleccion, un algortimo greedy hace la primera eleccion antes de resolver los subproblemas.

