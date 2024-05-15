
A los grafos, lo podemos denomiar asi: G = (V, E) donde V es el conjunto de vertices en ese grafo, mientras que E es el conjunto de aristas de ese grafo.

Los grafos puedes ser representados de distintas maneras como listas de aristas, listas de adyacencias y como una matriz de adyacencia.

### Breadth-first search

El BFS es uno de los algortimos mas simples para recorrer un grafo y es el arquetipo para varios algoritmos de grafos importantes, uno de ellos es el algoritmo de Dijkstra.

El BFS lo que hace es que dado un grafo y dos vertices $v$  y $w$ que pertenecen a G siendo uno de partida y el otro al que queremos llegar, recorre primero por todos los vecinos de $v$, luego si ninguno de ellos es $w$ o ya estaba marcado, hacemos lo mismo para los vecinos de $v$ y asi recursivamente hasta encontrar a $w$, luego de esto nos devolvera el camino minimo de v a w.

Como ya habia mencionado antes, lo para seguir el progreso de recorrer los vertices, el algoritmo los marca dependiendo su estado. Es decir si ya fue visitado o todavia no.

Decimos que u es el padre de v, ya que como cada vertice es recorrido una vez, como mucho tiene solo un padre.

### Deapth-first search

A comparacion de BFS en DFS primero recorrermos en profundidad el vecinos de nuestro primer vecino, y cuando llegamos a una hoja retrocedemos visitamos todos los vecinos del padre de esa hoja, y asi recursivamente hasta llegar otra vez a la raiz, e ir recorriendo los otros vecinos de la raiz hasta que lleguemos que marcamos todos.

Como en BFS cada vez que vistiamos un nodo/vertice lo marcamos como visitado y seguimos con los otros.