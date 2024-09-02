
Los algoritmos greedy son utilizados para resolver problemas de optmización, por lo que muchos problemas se relacionan a encontrar el máximo y/o mínimo. Un algoritmo greedy siempre hace la mejor decision en el momento. Es decir, realiza una elección locamente optima con el fin de que esta elección nos lleve a una solución globalmente optima. En otras palabras, en cada etapa se toma la decision que parece mejor basándose en la información disponible en ese momento, sin tener en cuenta las consecuencias futuras.

Queremos que el epsilon sea lo mas chico posible, imagen diapo. Se puede tener un algoritmo de complejidad polinomial con ese epsilon aproximado.

Los algoritmos greedy no siempre producen soluciones optimas, en estos casos proporcionan heuristicas sencillas que en general permiten construir soluciones razonables, pero sub-optimas.

Un algoritmo greedy obtiene un solución optima de haber hecho una secuencia de elecciones. Para cada decision el algoritmo decide si es la mejor opción en el momento. 

El proceso para desarrollar un algoritmo greedy es:

- Determinar la subestructura optima del problema
- Desarrollar una solución recursiva
- Mostrar que si hace la elección greedy, entonces solo queda un subproblema
- Probar que es siempre seguro hacer una elección greedy
- Desarrollar un algoritmo recursivo que implementa la estrategia greedy
- Convertir el algoritmo recursivo a uno iterativo

A diferencia de la programación dinámica en la que hacemos una eleccion por cada paso, pero esta suele depender en las soluciones de los subproblemas. En los algoritmos greedys, hacemos una eleccion que parece ser la mejor en el momento, y luego resolvemos resolvemos los subproblemas restantes. 

Por lo que a diferencia de la programacion dinamica, en el cual se resuelve primero los subproblemas antes de hacer la primera eleccion, un algortimo greedy hace la primera eleccion antes de resolver los subproblemas.

