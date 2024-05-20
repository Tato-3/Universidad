
## Problema de arbol generador minimo

- Input: un grefo conexo G = (V, E) y una funcion c : E(G) -> $|R$
- Output: un arbol generador T de G que minimice $c_+(T)$ = $\sum$

- AGM: arbol generador minimo
- c: funcion de costos, pesos o benefico

#Observacion Sea G un grafo y c: E(G) -> R. Entonces, T es un AGM de (G, c) sii T es un arbol generador maximo de (G, -c)

*Teorema* Sea T un arbol generador de un grafi G y c: E(G) -> R. Entonces, T es un AGM de (G,c) sii todo camino de T es minimax de (G, c)

->) T es AGM, consideremos v,w $pertenece$ V(T) y P$_t$ el camino entre v y w. Sea xy la arista mas partida en $P_t$. En T - {xy} hay dos componentes V y W tales que v $pertenece$ V y w $pertenece$ W. Si P es un camino entre v y wm entonces G -> P tiene una arista ab tal que a $pertence$ V y b $pertenece$ W. (Observar que ab no esta en E(T)). Luego [T - {xy} U {ab}) = T'] es un arbol generado de G. (n-1 aristas y es conexo). El costo(T) $\leq$ costo(T') = costo(T) + costo(ab) - costo(xy) => costo(xy) $\leq$ costo(ab)

En consecuencia costo_max(P) >= costo(ab) >= costo(xy) = costo_max($P_t$) => $P_t$ es minimax.

<-) Sea T' el AGM de G tal que |E(T') interseccion E(T)| sea maxima. Quiero ver que T = T'. Supongamos que vw pertenece E(T)-E(T'). Sea xy la arista de peso maximo de P para el unico camino P de T' entre v y w. Como vw minimax => costo(vw) $\leq$ costo_max(P) = costo(xy). Luego T'\{xy} U {vw} es un arbol generador de G(aciclico y n-1 aristas) con peso c(T') - c(xy) + c(vw) $\leq$ c(T') => T' \ {xy} U {vw} es un AGM de G'. Pero esto es imposible porque
|E(T'\{xy} U {vw}) interseccion E(T)| >= 1 + |E(T') interseccion E(T)| => T es AGM.


- Arista segura: sus vertices pertenecen a distintos arboles de F
- Arista candidata vw para T, con v perteneciente a V(T): segura y c(vw) $\leq$ c(xy) para toda arista segura xy con x perteneciente a v(T)

### Esquema de computo de un AGM

AGM(G, c):
	Sea F = (V(G), conj_vacio) un bosque generador de G
	Para i = 1.....n-1:
		 Agregar a F una arista candidata de (G, c)


*Teorema* Si G es un grafo conexo y c es una funcion de costos, entonces AGM(G, c) computa un AGM de (G, c)

**Demo**:
Fi = bosque luego de la iesima iteracion, quiero ver que Fi es AGM parcial. Luego Fn-1 es un AgM parcial con n - 1 aristas, entonces es un AGM de G. Claramente F0 es un AGM parcial porque puede extender a cualquier AGM. Para el paso i + 1, supongamos que vw es la arista agregada. Llamemos U a la componente conexa de Fi que contiene a v. Como vw es segura Fi+1 es un bosque generador. Sea T un AGM que extiende a Fi, cuya existencia esta dado por invariante. Si vw pertenece E(T) => Fi+1 es AGM parcial. 

Si vw no pertenece E(T) => el camino P de T entre v y w contiene una arista xy que no esta en Fi porque vw = seguro. De todas las posibilidades existe una con x perteneciente a U e y no perteneciente a U, entonces xy = segura => c(vw) $\leq$ c(xy) porque vw es candidata. Por lo tanto T \ {xy} U {vw} es un AGM de G que extiende a Fi+1 porque xy no pertenece Fi por se seguro.

### Algoritmo Prim

Dado r, construye AGM de (G, c) enraizado en r iterativamente:
- Empezando con T0 = ({r}, con_vacio), en el (i+1)-esimo construye Ti+1 agregando una arista candidata de Ti
Idea: mantener el conjunto S de aristas seguras, en cada paso tomar una de ellas de peso minimo.

Prim(G, c, r):
	Sea T un vector T[r] = r y T[w] = bottom para w perteneciente V(T) - {r}
     Sea S una cola de prioridad por c, conteniendo
     |->  {(r,w) | w pertenece N(r)}
	 Para i = 1 ...., n-1:
		 Sea (v, w) el tope de S.
		 Poner T[w] = v
		 Para cada z pertenece N(w): //notar que v pertenece N(w)
			 Si T[z] = bottom, encolar (w,z) a S
			 Caso contrario, remover (z,w) de S
	 retornar T

Complejidad es O(m log(m)) o O(n²) si hay muchas aristas