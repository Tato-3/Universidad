
*Bactracking* es una tecnica general de diseño  de algoritmos que consiste de extender las soluciones *parciales* $a = (a_1 , ...., a_k), k < n$, agregando un elemento $a_{k+1}$ al final del mismo. Si se detecta que S$_{k+1}$, el conjunto de soluciones que tienen al vector como prefijo, es vacio, se *retrocede* a la solucion anterior.  Esto permite *descartar* configuraciones parciales apenas se determina que no pueden llevar a una solucion.

Cada posible extension de una solucion parcial es explorada haciendo **recursion** sobre la nueva solucion extendida.

Podemos representar visualmente esta exploracion como el recorrido en profundidad de un **arbol**. Frecuentemente es posible aplicar podas al arbol para reducir consideramente el espacio de busqueda. Es decir no hacemos recursion en aquellas opcionees que sabemos que no nos interesan.

Basicamente el codigo de backtraking se trata de si agarrar o no el elemento dependiendo lo que buscamos. En el ejemplo del problema del cd, queremos la maxima cantidad de canciones posibles que quepan en el disco, por lo que hacemos backtracking a todas las canciones, y la funcion matematica seria algo asi:

cd(i, k){ **i es el indice y k la capacidad**
	if(i == N){
		if(k < 0){
			return -INF;
		}else{
			return 0;
		}
	}else{
		return max(CD(i+1,k), CD(i+1, k-p[i])+p[i])
	}
}

Justamente en el return max, estamos viendo de agarrar el maximo entre poner la cancion y no.















