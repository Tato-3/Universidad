# Clase 5 — Complejidad Computacional

**Profesor:** Santiago Figueira — Departamento de Computación, FCEN, UBA

## Temas de la clase
1. Mini-configuraciones
2. Teorema de Cook-Levin
3. Problemas NP-completos
4. La clase coNP
5. Las clases ExpTime y NExpTime

---

## 1. Mini-configuraciones

### 1.1 La máquina que consideramos

Para simplificar el análisis, trabajamos con una máquina determinística **M = (Σ, Q, δ)** que tiene:
- **Sin cinta de salida** (acepta con el estado `q_sí` y rechaza con `q_no`).
- **Una cinta de entrada** (de solo lectura).
- **Una sola cinta de trabajo**.

> Aclaración: todo lo que se demuestra se puede generalizar a cualquier cantidad de cintas de trabajo, pero se toma una sola para simplificar las notaciones.

### 1.2 Definición de mini-configuración

Consideremos un cómputo `C₀, ..., C_ℓ` de M con entrada `y`. La **mini-configuración en el paso i** es una tupla:

```
z_i = (a_i, b_i, c_i) ∈ Σ × Σ × Q
```

donde:
- **a_i** = símbolo leído por la cabeza de **entrada** en C_i.
- **b_i** = símbolo leído en la **cinta de trabajo** en C_i.
- **c_i** = **estado** de la máquina en C_i.

**Interpretación visual**: la mini-configuración "resume" lo esencial de una configuración completa (toda la cinta de trabajo entera no hace falta, solo el símbolo que se está leyendo en el momento).

**Ejemplo concreto**: supongamos que en la configuración C_i:

```
entrada:  ▷ 0 1 1 0 1 ...
                ▲
trabajo:  ▷ 1 1 1 0 ...
              ▲
estado:   q
```

Entonces la mini-configuración es `z_i = (1, □, q)` (lectura de entrada = 1, lectura de trabajo = □, estado = q).

### 1.3 Máquinas oblivious

Supongamos que además M es **oblivious**: la posición de las cabezas (de entrada y de trabajo) en el cómputo de M(y) se puede calcular en función de `|y|` y del número de paso, **pero de forma independiente de `y`**.

Esto nos da tres funciones **computables en tiempo polinomial**:

- **e(i, n)** = posición de la cabeza de entrada en el paso *i* en el cómputo de M con entrada `0ⁿ`.
- **t(i, n)** = posición de la cabeza de trabajo en el paso *i* en el cómputo de M con entrada `0ⁿ`.
- **prev(i, n)** = máx({ j < i : t(j, n) = t(i, n) } ∪ {0}). Es decir, *prev(i, n)* es el máximo paso *j < i* tal que la posición de la cabeza de trabajo en el paso *j* coincide con la posición en el paso *i*; o 0 si no existe tal *j*.

La función `prev` es la clave para poder "reconstruir" en qué posición de la cinta de trabajo estamos sin necesidad de guardar toda la cinta.

### 1.4 De la mini-configuración del paso i−1 a la del paso i

Sea `z_i` la i-ésima mini-configuración en el cómputo de M con entrada `x`. Tenemos:
- `z₀ = (x(0), □, q₀)` (el estado inicial).
- Para `i > 0`, calculamos `z_i` con:
  1. **El estado y los símbolos leídos en el paso i−1**: esto está en `z_{i-1}`.
  2. **La función de transición δ** de M.
  3. **El contenido de la cinta de entrada** (solo lectura, no cambia durante el cómputo) en la posición `e(i, |x|)`.
  4. **El contenido de la cinta de trabajo** en la posición `prev(i, |x|)`: esto está en `z_{prev(i,|x|)}` junto con δ.

**Ejemplo del paso de i−1 a i:**

```
Ci-1                       Ci
entrada: ▷ 0 1 1 0 1       entrada: ▷ 0 1 1 0 1
                  ▲                     ▲
trabajo: ▷ 1 1 1 0 ...     trabajo: ▷ 1 1 0 0 ...
                 ▲                      ▲
estado: q                  estado: s
z_{i-1} = (1, □, q)        z_i = (□, 1, s)
```

La transición completa está determinada por `z_{i-1}`, `δ`, la entrada en `e(i, |x|)` y el contenido de trabajo en `prev(i, |x|)`.

### 1.5 La función F que representa la evolución en un paso

Cada mini-configuración `z ∈ Σ × Σ × Q` se codifica como una cadena `⟨z⟩ ∈ {0,1}^k`, donde:

```
k = 4 + ⌈log |Q|⌉
```

(k depende solo de M, no de la entrada).

**Codificación de símbolos** de Σ = {0, 1, ▷, □}:
- `00` codifica `0`
- `11` codifica `1`
- `01` codifica `▷`
- `10` codifica `□`

**Codificación de estados** `Q`: cada estado se codifica con una cadena en `{0,1}^⌈log|Q|⌉`; `0...0` codifica `q₀` y `0...1` codifica `q_f` (estado final). Las otras cadenas codifican los demás estados.

Para `i > 0`, definimos la función de evolución en un paso:

```
F : {0,1}^k × {0,1}^k × {0,1}^2 → {0,1}^k
F( ⟨z_{i-1}⟩, ⟨z_{prev(i,|x|)}⟩, ⟨▷x□(e(i,|x|))⟩ ) = ⟨z_i⟩
```

donde los tres argumentos son:
- `⟨z_{i-1}⟩`: la configuración anterior (k variables).
- `⟨z_{prev(i,|x|)}⟩`: información de la cinta de trabajo (k variables).
- `⟨▷x□(e(i,|x|))⟩`: codificación del bit actual leído en la entrada (2 variables).

Y definimos `F(x) = 0^k` para los otros casos (que no nos interesan).

### 1.6 La función F representada en CNF

Teorema (clave): Existe una **fórmula booleana en CNF**

```
φ_F( p̄, q̄, r̄, s̄ )
```

con variables libres:
- `p̄ = p₁,...,p_k` que codifica `⟨z_{i-1}⟩`
- `q̄ = q₁,...,q_k` que codifica `⟨z_{prev(i,|y|)}⟩`
- `r̄ = r₁, r₂` que codifica `⟨▷x□(e(i,|y|))⟩`
- `s̄ = s₁,...,s_k` que codifica `⟨z_i⟩`

tal que para todo `ā, b̄, d̄ ∈ {0,1}^k` y `c̄ ∈ {0,1}^2`:

```
ā b̄ c̄ d̄ ⊨ φ_F(p̄, q̄, r̄, s̄)   ⟺   d̄ = F(ā, b̄, c̄)
```

**Propiedades**:
- Podemos computar `φ_F` a partir de `⟨F⟩` en **tiempo polinomial**.
- `φ_F` tiene tamaño ≤ `(3k+2)·2^(3k+2)`.
- Como k es constante (M fija), **φ_F tiene tamaño constante**.

---

## 2. Teorema de Cook-Levin

### 2.1 SAT es NP-hard

**Teorema:** SAT ∈ **NP-hard**.

**Demostración (esquema completo):**

Fijemos L ∈ NP y veamos que **L ≤_p SAT**.

Como L ∈ NP, existe una máquina determinística M tal que:
- M corre en tiempo t(n), con t un polinomio.
- Existe un polinomio p tal que:
  ```
  x ∈ L ⟺ ∃u ∈ {0,1}^{p(|x|)} M(xu) = 1
  ```

**Primer intento (INCORRECTO):** Definimos F_x(u) = M(xu). Queremos una fórmula φ_x ∈ CNF tal que `u ⊨ φ_x ⟺ F_x(u) = 1`. **Problema**: esa φ_x tendría tamaño **exponencial**: O(p(|x|)·2^{p(|x|)}). ¡No sirve!

**Demostración correcta** (usando mini-configuraciones):

1. Consideramos M **oblivious, sin cinta de salida y con única cinta de trabajo** (se puede suponer por resultados anteriores).
2. Dado x, construimos φ_x ∈ CNF en **tiempo polinomial** tal que `x ∈ L ⟺ φ_x ∈ SAT`. M está fija; x es variable.

**Encadenamiento de equivalencias** (notar n = |x| + p(|x|), m = t(n)):

```
x ∈ L
⟺ ∃u ∈ {0,1}^{p(|x|)} M(xu) = 1
⟺ ∃u ∈ {0,1}^{p(|x|)} y existe un cómputo C₀,...,C_{t(|xu|)} de M
   a partir de la entrada xu tal que el estado en C_{t(|xu|)} es q_sí
⟺ existe una codificación de entrada y ∈ {0,1}^{2n+4} con n = |x|+p(|x|)
   y una secuencia de mini-configuraciones z₀,...,z_m, z_i ∈ {0,1}^k,
   con m = t(n) = t(|x|+p(|x|)), tal que:
```

con las condiciones:

| Condición | Significado |
|-----------|-------------|
| **ψ₁** | "la entrada empieza con x y u es variable" |
| **ψ₂** | "z₀ es la configuración inicial" |
| **ψ₃** | "z_j evoluciona en z_{j+1} para j = 0,...,m−1" |
| **ψ₄** | "z_m es una configuración final de M aceptadora" |

Cada una se expresa con una fórmula `ψ_j` en CNF con una **cantidad polinomial de variables**:
```
ψ_j(p₀,...,p_{2n+3}, q₁⁰,...,q_k⁰, ..., q₁^m,...,q_k^m)
    \____ entrada y ___/  \_ z₀ _/      \__ z_m __/
```

Y tal fórmula se puede **computar en tiempo polinomial a partir de x**.

#### Detalle de ψ₁: la entrada empieza con x y u es variable

El contenido de la cinta se codifica como `┘ ▷ x u □`. Recordar que `00, 11, 01, 10` codifica los símbolos de Σ = {0,1,▷,□}.

- `y(0)y(1) = 01` (marca `▷`).
- `y(2j+2)y(2j+3)` codifica a `x(j)` para `0 ≤ j ≤ |x|−1`.
- `y(2j)y(2j+1)` tienen el mismo valor para `|x|+1 ≤ j ≤ n` (libres, corresponden a u).
- `y(2n+2)y(2n+3) = 10` (marca `□`).

Se expresa con:

```
ψ₁ = ¬p₀ ∧ p₁
   ∧  ⋀  ( p_{2j+2} ∧ p_{2j+3}   si x(j)=1 )   ∧  ⋀  ( ¬p_{2j+2} ∧ ¬p_{2j+3}   si x(j)=0 )
      j=0..|x|-1                                     j=0..|x|-1
   ∧  ⋀  ( p_{2i} ↔ p_{2i+1} )
      i=|x|+1..n
   ∧ p_{2n+2} ∧ ¬p_{2n+3}
```

**Observación**: No se especifican los valores de las variables correspondientes a `u` (quedan libres, justamente eso es lo que logra el cuantificador existencial). `|ψ₁| = O(n)`.

#### Detalle de ψ₂: z₀ es la configuración inicial

Requerimos `z₀ = (x(0), □, q₀)`:

```
ψ₂ = (q₁⁰ ∧ q₂⁰  si x(0)=1)  ∨  (¬q₁⁰ ∧ ¬q₂⁰  si x(0)=0)
   ∧ q₃⁰ ∧ ¬q₄⁰              (el □ en la cinta de trabajo)
   ∧ ⋀_{i=5..k} ¬qᵢ⁰         (q₀ codificado)
```

`|ψ₂| = O(1)` (recuerda que k depende solo de M, y M está fija).

#### Detalle de ψ₃: z_j evoluciona en z_{j+1}

Para `0 < i ≤ m`, la condición `⟨z_i⟩ = F(⟨z_{i-1}⟩, ⟨z_{prev(i,n)}⟩, ⟨▷xu□(e(i,n))⟩)` se expresa con una fórmula en CNF usando φ_F ya analizada:

```
ψ₃ⁱ = φ_F( q₁^{i-1},...,q_k^{i-1},          ← ⟨z_{i-1}⟩
           q₁^{prev(i,n)},...,q_k^{prev(i,n)},  ← ⟨z_{prev(i,n)}⟩
           p_{2e(i,n)}, p_{2e(i,n)+1},       ← ⟨▷xu□(e(i,n))⟩
           q₁^i,...,q_k^i )                  ← ⟨z_i⟩
```

**Nota adicional**: podemos suponer que `e(i, n) ≤ n+1` (la primera celda de la cinta de entrada es la posición 0; M con entrada `▷xu□` no necesita leer más allá del primer blanco después de `▷xu`).

Entonces:

```
ψ₃ = ⋀_{i=1..m} ψ₃ⁱ
```

`|ψ₃| = O(k²·m) = O(t(|x| + p(|x|)))` porque k es constante y m = t(|x|+p(|x|)).

#### Detalle de ψ₄: z_m es una configuración final aceptadora

Requerimos que `z_m` sea de la forma `(∗, ∗, q_sí)`. Se expresa con una fórmula ψ₄ análoga a ψ₂. `|ψ₄| = O(1)`.

#### Construcción final

```
φ_x = ψ₁ ∧ ψ₂ ∧ ψ₃ ∧ ψ₄
```

**Propiedades**:
- `|φ_x| = O(|x| + t(|x| + p(|x|)))`.
- `φ_x` se construye en **tiempo polinomial** en |x| + p(|x|), o sea en **tiempo polinomial en |x|**.
- **x ∈ L ⟺ φ_x es satisfacible ⟺ φ_x ∈ SAT**.

**Corolario:** SAT ∈ **NP-completo**.

### 2.2 3SAT es NP-completo

Ya vimos que 3SAT es **NP**. Para ver que 3SAT es NP-hard se prueba (queda como **ejercicio**):

```
SAT ≤_p 3SAT
```

**Corolario:** SAT, 3SAT ∈ **NP-completos**.

---

## 3. Problemas NP-completos

Una vez que tenemos el primer problema NP-completo (SAT), se pueden probar otros por **reducción polinomial**. Se presentan varios ejemplos clásicos.

### 3.1 INDSET (Conjunto independiente)

**Problema (versión de decisión):** ¿El grafo G tiene un conjunto independiente de al menos m vértices?

```
INDSET = {⟨G, m⟩ : G tiene un conjunto independiente de tamaño ≥ m}
```

**Proposición:** INDSET ∈ **NP-completo**.

**Demostración comparativa:**
- Ya vimos que INDSET es **NP**.
- Para ver que es NP-hard, probamos **3SAT ≤_p INDSET**.

Supongamos una fórmula en 3CNF con m cláusulas:
```
φ = (l₁₁ ∨ l₁₂ ∨ l₁₃) ∧ (l₂₁ ∨ l₂₂ ∨ l₂₃) ∧ ... ∧ (l_{m1} ∨ l_{m2} ∨ l_{m3})
```
donde los l_{ij} son literales y las variables son x₁,...,x_n.

#### Construcción de G_φ

1. Definimos un grafo G_φ con **3m vértices**: cada vértice corresponde a **cada variable de cada cláusula** (un vértice por literal).
2. Sean z un vértice correspondiente a l_{ij} y z' un vértice correspondiente a l_{i'j'}. Ponemos una arista entre z y z' si:
   - **i = i'** (misma cláusula, es decir, los dos literales están en la misma "triángulo"), o
   - **l_{ij} es la negación de l_{i'j'}** (o viceversa) — literales contradictorios.
3. G_φ es construible en **tiempo polinomial en |φ|**.

#### Ejemplo

```
φ = (¬x₁ ∨ x₂ ∨ x₃) ∧ (x₁ ∨ ¬x₂ ∨ x₃) ∧ (¬x₁ ∨ x₂ ∨ x₄)

          ¬x₁ ── x₂            x₂ ── ¬x₁
           │ \  / │            │ \  / │
           │  \/  │            │  \/  │
           │  /\  │            │  /\  │
           x₃    x₁            x₃     x₄
         (cláusula 1)         (cláusula 2)
```

**Idea de la construcción**: los tres literales de cada cláusula forman un **triángulo** (por la arista "misma cláusula"), y los literales contradictorios están conectados entre cláusulas. Un conjunto independiente de tamaño m debe elegir **exactamente un** literal por cláusula (triángulo), sin elegir literales contradictorios.

#### Demostración de la equivalencia

**(⟹)** Supongamos que v ⊨ φ. Entonces para todo i = 1,...,m tenemos v ⊨ l_{i1} ∨ l_{i2} ∨ l_{i3}, de modo que v ⊨ l_{ij} para algún j. Sea S el conjunto de vértices z₁,...,z_m tal que z_i corresponde a l_{ij} y v ⊨ l_{ij}.

**S es independiente**: si existiera arista entre z_i y z_{i'} sería porque (1) i = i' o (2) z_i corresponde a l_{ij}, z_{i'} corresponde a l_{i'j'} y l_{ij} es la negación de l_{i'j'} (o viceversa). Ninguna de las dos puede pasar (en (2) porque una misma valuación no puede satisfacer un literal y su negación a la vez).

**(⟸)** Si S es un conjunto independiente en G_φ con m vértices, tenemos **exactamente un vértice en cada triángulo** (como hay m cláusulas y un conjunto independiente no puede tomar dos del mismo triángulo). Para cada z ∈ S:
- si z corresponde a x_i, definimos v(x_i) = 1.
- si z corresponde a ¬x_i, definimos v(x_i) = 0.

Para todas las otras variables x para las que no está definido v, definimos v(x) de forma arbitraria. **v está bien definida porque S es independiente** (no hay literales contradictorios elegidos) y además **v ⊨ φ**.

### 3.2 CAMHAM (Camino hamiltoniano)

**Definición**: Un camino hamiltoniano en un grafo dirigido G es un **camino que visita todos los vértices de G exactamente una vez**.

```
CAMHAM = {⟨G⟩ : G tiene un camino hamiltoniano}
```

**Proposición:** CAMHAM ∈ **NP-completo**.

### 3.3 TSP (Problema del viajante de comercio)

Dadas n ciudades, representamos la distancia entre cada par por una matriz M de n×n.

```
TSP = {⟨M, k⟩ : hay una ruta de distancia ≤ k que visita todas
                las ciudades de G exactamente una vez y al finalizar
                vuelve a la ciudad de origen}
```

**Proposición:** TSP ∈ **NP-completo**.

**Ejemplo/intuición**: Un representante comercial debe visitar n ciudades partiendo y volviendo a su ciudad, minimizando la distancia total. La versión de decisión pregunta si existe un recorrido (un ciclo hamiltoniano en el grafo pesado) de costo total a lo sumo k.

### 3.4 KNAPSACK (Problema de la mochila)

Representamos una lista de n ítems con su (valor, peso) mediante:
```
M = [(v₁, p₁), (v₂, p₂), ..., (v_n, p_n)]
```

```
KNAPSACK = {⟨M, v, p⟩ : existe un conjunto de ítems con valor
                        total ≥ v y peso ≤ p}
```

**Proposición:** KNAPSACK ∈ **NP-completo**.

**Ejemplo/intuición**: Dada una mochila con capacidad de peso p, queremos seleccionar ítems de modo de maximizar el valor total sin exceder el peso. La versión de decisión pregunta si se puede obtener valor ≥ v con peso ≤ p.

---

## 4. La clase coNP

### 4.1 Introducción: problemas C-completos y C-hard (en general)

La noción de NP-hard y NP-completo se aplica a **otras clases de complejidad**:

Si C es una clase de complejidad:
- **L es C-hard** si `L' ≤_p L` para **todo** L' ∈ C.
- **L es C-completo** si **L ∈ C** y **L es C-hard**.

> Son nociones de completitud y hardness **para la reducción ≤_p**. Más adelante veremos clases para las que no tiene sentido usar ≤_p y se necesitan reducciones más débiles.

### 4.2 Notación coC (complemento)

**Notación de complemento**: `L̄ = {0,1}* \ L` es el complemento de L.

Si C es una clase de complejidad, definimos:

```
coC = { L : L̄ ∈ C }
```

### 4.3 La clase coNP

```
coNP = { L : L̄ ∈ NP }
```

Es decir, coNP es la clase de lenguajes L tal que existe un polinomio p : ℕ → ℕ y una máquina determinística M tal que:
- M corre en **tiempo polinomial**.
- para todo x:
  ```
  x ∈ L ⟺ para todo u ∈ {0,1}^{p(|x|)} M(⟨x,u⟩) = 1
  ```

**Intuición**: En NP, la condición es "**existe** un certificado que verifica" (∃). En coNP, la condición es "**para todo** certificado la verificación es cierta" (∀). Estamos "intercambiando" el cuantificador: coNP captura lenguajes cuyo complemento está en NP.

Visto de otra forma: si NP "adivina" un testigo y verifica (∃), coNP es la clase cuyo complemento se comporta así. Por ejemplo, "no esto es una fórmula satisfacible / no hay testigo" corresponde a problemas de tautología.

### 4.4 Relación de coNP con P y NP

**Ejercicio:** P ⊆ NP ∩ coNP.
*(Demostración intuitiva: si L ∈ P, entonces L̄ ∈ P (las máquinas determinísticas se pueden "complementar" invirtiendo aceptar/rechazar), por lo que L ∈ NP y L̄ ∈ NP, o sea L ∈ coNP.)*

**Ejercicio:** Si P = NP entonces **NP = coNP**.

**Forma de pensarlo**: La jerarquía esperada suele dibujarse como:

```
        NP
       ╱  ╲
    P        coNP          (con NP y coNP "colgando" de P,
       ╲  ╱                   y no se sabe si coinciden)
       coNP
```

Pero no se sabe si NP = coNP. Lo que sí se sabe es que si P = NP, automáticamente NP = coNP.

### 4.5 Ejemplo: problema coNP-completo (Tautología)

```
TAUT = {⟨φ⟩ : φ es una tautología}
```

**Observación**: φ en CNF es **insatisfacible** ⟺ ¬φ es una **tautología**:

```
⟨φ⟩ ∉ SAT ⟺ ⟨¬φ⟩ ∈ TAUT
```

**Ejercicio:** TAUT ∈ **coNP-completo**.

**Intuición**: verificar que una fórmula es tautología requiere chequearla en **todas** las asignaciones (∀). Ese "para todo" es lo que la coloca en coNP (el complemento, SAT, está en NP).

Nota mental útil: **SAT ∈ NP-completo** y **TAUT ∈ coNP-completo** son "espejos". Si NP ≠ coNP, entonces SAT y TAUT no pertenecen a la misma clase.

---

## 5. Las clases ExpTime y NExpTime

### 5.1 Definición

```
ExpTime   = ⋃_{c>0} DTime(2^{n^c})
NExpTime  = ⋃_{c>0} NDTime(2^{n^c})
```

Son los análogos de **P** y **NP** pero con **tiempo exponencial** en lugar de polinomial.

### 5.2 Cadena de inclusiones

```
P  ⊆  NP  ⊆  ExpTime  ⊆  NExpTime
```

**Ejercicio:** NP ⊆ ExpTime.
*(Demostración intuitiva: una máquina determinística puede simular todas las ramas del no-determinismo en tiempo exponencial, que es lo que necesita el "recorrido de árbol de cómputo".)*

### 5.3 Diagrama general de las clases

```
        NExpTime
        /      \
   ExpTime      coNExpTime
      |            |
      NP          coNP
       \          /
       P (intersección)
```

(Esquemáticamente: P ⊆ NP ⊆ ExpTime y P ⊆ coNP ⊆ coNExpTime; las relaciones verticales no se sabe si son estrictas.)

### 5.4 Teorema clave: si P = NP entonces ExpTime = NExpTime

**Teorema:** Si **P = NP** entonces **ExpTime = NExpTime**.

**Demostración completa:**

Supongamos **P = NP**. Tomemos L ∈ **NExpTime**, es decir L ∈ NDTime(2^{n^c}) para algún c. Entonces existe una máquina no-determinística N que decide L en tiempo `c·2^{n^c}`.

Consideremos el lenguaje "con relleno":

```
L_pad = { ⟨x, 1^{2^{|x|^c}}⟩ : x ∈ L }
```

Es decir, rellenamos cada entrada x con una cantidad exponencial (respecto de |x|) de unos, de modo que ahora el *tamaño* de la entrada domina.

**Paso 1: L_pad ∈ NP.**

Definimos una máquina no-determinística N' tal que dada la entrada y hace:
1. Si no existe z tal que `y = ⟨z, 1^{2^{|z|^c}}⟩`, **rechazar**.
2. Si sí, entonces y es de la forma `⟨z, 1^{2^{|z|^c}}⟩`:
   - simular N con entrada z por `c·2^{|z|^c}` pasos.
   - devolver la salida de esta simulación.

**N' corre en tiempo polinomial (en |y|)** porque el relleno `1^{2^{|z|^c}}` es tan grande que domina polinomialmente la simulación exponencial. Por lo tanto `L_pad ∈ NP`, y por la hipótesis **P = NP**, concluimos `L_pad ∈ P`.

**Paso 2: L ∈ ExpTime.**

Como `L_pad ∈ P`, existe una máquina determinística M_pad (polinomial) que decide L_pad. Definimos una máquina determinística M que, dada la entrada x:
1. Computa `y = ⟨x, 1^{2^{|x|^c}}⟩`  (esto toma tiempo O(2^{|x|^c})).
2. Decide si `y ∈ L_pad` (lo cual es equivalente a `x ∈ L`) usando M_pad (esto es polinomial en |y|).

**Cuerpo del análisis de tiempo:**
- `|y| ≈ 2^{|x|^c}`, y M_pad corre en tiempo polinomial en |y|, digamos `|y|^d ≈ 2^{d·|x|^c}`.
- El paso 1 ya toma `O(2^{|x|^c})`.

Así, M corre en tiempo `O(2^{d·|x|^c})`, es decir en `O(2^{|x|^{c+d}})`.

Entonces `L ∈ DTime(2^{n^{c+d}}) ⊆ ExpTime`.

**Conclusión**: como L era arbitrario en NExpTime, se tiene **NExpTime ⊆ ExpTime**. Como la otra inclusión (ExpTime ⊆ NExpTime) es trivial, obtenemos **ExpTime = NExpTime**.

### 5.5 Idea profunda (por qué funciona)

El "truco del relleno" (*padding*) es lo que hace funcionar la demostración: al agregar una cantidad enorme de símbolos de relleno, "convertimos" el tiempo exponencial (original) en tiempo polinomial *con respecto a la nueva entrada alargada*. Así, el problema pertenece a una clase más baja (NP → P por hipótesis), y al "quitar" el relleno, el tiempo vuelve a ser exponencial pero esto muestra que el problema original era en realidad determinístico-exponencial.

Este mismo truco de padding es general: si una clase colapsa (P = NP), entonces también colapsan las clases exponenciales correspondientes (ExpTime = NExpTime).

---

## 6. P vs NP

### 6.1 La pregunta abierta

**¿P = NP o P ⊊ NP?** Es una **pregunta abierta** (uno de los problemas del milenio del Clay Institute, con premio de $1,000,000).

### 6.2 Interpretaciones

**¿Reconocer la corrección de una solución es esencialmente más fácil que generarla?**

**¿En algunos casos lo mejor que podemos hacer es usar fuerza bruta para llegar a la solución?**

**Ejemplo introspectivo**: dado un sistema axiomático S (= axiomas + reglas de inferencia), el lenguaje

```
{ ⟨φ, 1ⁿ⟩ : φ tiene una demostración en S de longitud ≤ n }
```

es **NP**. Pero **verificar** que una secuencia de pasos es una demostración es **P**.

Esto ilustra la intuición central de la pregunta: "encontrar" una demostración (NP, podría requerir fuerza bruta) vs. "verificar" que lo dado es correcto (P).

---

## Resumen rápido (cheatsheet)

| Concepto | Resumen |
|----------|---------|
| **Mini-configuración** | z_i = (a_i, b_i, c_i): símbolo de entrada, símbolo de trabajo, estado |
| **Máquina oblivious** | Posición de cabezas computable solo con \|x\| y el paso (independiente de y) |
| **Función F** | F(⟨z_{i-1}⟩, ⟨z_{prev}⟩, ⟨entrada(i)⟩) = ⟨z_i⟩; representable en CNF (tamaño constante) |
| **Cook-Levin** | SAT ∈ NP-completo. Se reduce todo L ∈ NP a SAT vía mini-configuraciones: φ_x = ψ₁∧ψ₂∧ψ₃∧ψ₄ |
| **3SAT** | SAT ≤_p 3SAT ⟹ 3SAT NP-completo |
| **NP-completos clásicos** | INDSET, CAMHAM, TSP, KNAPSACK (cadenas de reducción desde 3SAT/SAT) |
| **C-completo / C-hard** | Definición general válida para cualquier clase C con ≤_p |
| **coC** | coC = { L : L̄ ∈ C } |
| **coNP** | Lenguajes con verificación "para todo u" (∀) en lugar de "existe u" (∃) |
| **P ⊆ NP ∩ coNP** | Ejercicio |
| **P = NP ⟹ NP = coNP** | Ejercicio |
| **TAUT** | coNP-completo (espejo de SAT) |
| **ExpTime / NExpTime** | ⋃ DTime(2^{n^c}) / ⋃ NDTime(2^{n^c}) — análogos exponenciales de P/NP |
| **P ⊆ NP ⊆ ExpTime ⊆ NExpTime** | Ejercicio (NP ⊆ ExpTime) |
| **P = NP ⟹ ExpTime = NExpTime** | Vía truco de padding (L_pad) |
| **P vs NP** | Pregunta abierta; reconocer ≠ generar soluciones |
