import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


def norma(x, p):
    res = 0
    
    if p == 'inf':
        for xi in x:
            res = max(res, abs(xi))
        return res
    
    for xi in x:
        res += abs(xi ** p)
    res = res ** (1/p)
    
    return res

def normaliza(X, p):
    res = []    
    
    for x in X:
        vector_nuevo = []
        norma_vector = norma(x, p)
        for xi in x:
            vector_nuevo.append(xi / norma_vector)
        res.append(vector_nuevo)    
    return res

def normaMatMC(A,q,p,Np):
    n = A.shape[1]
    
    max_valor = - np.inf
    max_vector = []
    
    for _ in range(Np):
        
        vector = np.random.rand(n)
        
        vector = vector / norma(vector, p)
        
        Ax = A @ vector
        
        valor = norma(Ax, q)
        
        if valor > max_valor:
            max_valor = valor
            max_vector = vector
            
    return max_valor, max_vector

def normaExacta(A, p=[1, 'inf']):
    
    if p == 1:
        return np.max(np.sum(np.abs(A), axis = 0))        

    if p == 'inf':
        return np.max(np.sum(np.abs(A), axis = 1))
    
    else: 
        return None


"""
#GRAFICAMOS EJERCICIO 1
ps = [1, 2, 5, 10, 100, 200]

theta = np.linspace(0, 2*np.pi, 1000)

plt.figure(figsize=(6,6))

for p in ps:
    puntos = [normaliza([[np.cos(t), np.sin(t)]], p)[0] for t in theta]
    xs, ys = zip(*puntos)
    plt.plot(xs, ys, label=f"p={p}")

# Para infinito
puntos_inf = [normaliza([[np.cos(t), np.sin(t)]], 'inf')[0] for t in theta]
xs, ys = zip(*puntos_inf)
plt.plot(xs, ys, label="p=∞", linestyle="--")


plt.gca().set_aspect("equal")
plt.legend()
plt.title("Esferas unitarias en R² según distintas normas p")
plt.show()
"""
I = np.identity(2)
Av = np.array([[0, -1], [1, 0]])
Avi = np.array([[1, 0], [0, 0]])
Avii = np.array([[1, 0], [0, 0]])
Aviii = np.array([[10, 10], [0, 0]])

valor, vector = normaMatMC(Aviii, 2, "inf", 100)

print("Norma estimada:", valor)
print("Vector asociado:", vector)

plt.figure()
plt.axhline(0, color="black", linewidth=0.5)
plt.axvline(0, color="black", linewidth=0.5)

# dibuja el vector como flecha desde (0,0)
plt.quiver(0, 0, vector[0], vector[1], angles="xy", scale_units="xy", scale=1, color="blue")

plt.xlim(-1.2, 1.2)
plt.ylim(-1.2, 1.2)
plt.gca().set_aspect("equal")
plt.title(f"Vector donde se alcanza máx (norma≈{valor:.3f})")
plt.show()


# Tests normaExacta

assert(np.allclose(normaExacta(np.array([[1,-1],[-1,-1]]),1),2))
assert(np.allclose(normaExacta(np.array([[1,-2],[-3,-4]]),1),6))
assert(np.allclose(normaExacta(np.array([[1,-2],[-3,-4]]),'inf'),7))
assert(normaExacta(np.array([[1,-2],[-3,-4]]),2) is None)
assert(normaExacta(np.random.random((10,10)),1)<=10)
assert(normaExacta(np.random.random((4,4)),'inf')<=4)

print("Funciono")