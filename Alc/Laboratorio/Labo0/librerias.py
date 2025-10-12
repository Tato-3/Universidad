#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np


# In[51]:


#Ejercicio 1

def esCuadrada(A):
    n,m = A.shape
    return n == m

M = np.array([[1 for _ in range(2)] for _ in range(2)])



# In[3]:


#Ejercicio 2

def triangSup(A):
    n = A.shape[0]
    U = A.copy()

    #Eliminacion Gaussiana
    for pivote in range(n):
        for i in range(pivote+1, n):
            m = U[i, pivote] / U[pivote,pivote]
            U[i, pivote:] = U[i, pivote:] - U[pivote, pivote:] * m

    #Me piden sin la diagonal
    for i in range(n):
        U[i,i] = 0
    
    return U

A = np.array([
    [2, 1, 1],
    [4, -6, 0],
    [-2, 7, 2]
])


# In[49]:


#Ejercicio 3

def triangInf(A):

    n = A.shape[0]
    U = A.copy()
    L = np.array([[0 for _ in range(n)] for _ in range(n)])

    #Eliminacion Gaussiana
    for pivote in range(n):
        for i in range(pivote+1, n):
            m = U[i, pivote] / U[pivote,pivote]
            L[i, pivote] = m
            U[i, pivote:] = U[i, pivote:] - U[pivote, pivote:] * m

    #Me piden sin la diagonal
    for i in range(n):
        L[i,i] = 0
    
    return L

A = np.array([
    [2, 1, 1],
    [4, -6, 0],
    [-2, 7, 2]
])


# In[48]:


#Ejercicio 4

def diagonal(A):

    n, m = A.shape
    D = np.array([[0 for _ in range(m)] for _ in range(n)])

    for i in range(min(n,m)):
        D[i,i] = A[i,i]

    return D

A = np.array([
    [2, 1, 1],
    [4, -6, 0],
    [-2, 7, 2]
])



# In[6]:


#Ejercicio 5

def traza(A):

    n, m = A.shape
    res = 0
    
    for i in range(min(n,m)):
        res += A[i,i]
    return res

A = np.array([
    [2, 1, 1],
    [4, -6, 0],
    [-2, 7, 2]
])


# In[7]:


#Ejercicio 6

def traspuesta(A):

    n, m = A.shape
    T = A.copy()

    for i in range(n): 
        for j in range(m):
            T[j,i] = A[i,j]

    return T

A = np.array([
    [1,2,3],
    [4,5,6],
    [7,8,9]
])


# In[8]:


#Ejercicio 7

def esSimetrica(A):

    res = True

    if not(esCuadrada(A)): return False

    AT = traspuesta(A)

    n, m = A.shape

    for i in range(n):
        for j in range(m):
            if A[i,j] != AT[i,j]: 
                res = False
                break

    return res

A = np.array([
    [1,2,3],
    [2,5,6],
    [3,6,9]
])


# In[47]:


#Ejercicio 8

def calcularAx(A,x):
    n, m = len(A), len(A[0])
    p = len(x[0])
    
    b = np.array([[0 for _ in range(p)] for _ in range(n)])
    
    for i in range(n):          
        for j in range(p):      
            for k in range(m): 
                b[i][j] += A[i][k] * x[k][j]
    return b
# In[10]:


#Ejercicio 9

def intercambiarFilas(A, i, j):

    filaTemp = A[i].copy()
    A[i] = A[j]
    A[j] = filaTemp

    return A

A = np.array([
    [1,2,3],
    [2,5,6],
    [3,6,9]
])


# In[11]:


#Ejercicio 10

def sumar_fila_multiplo(A, i, j, s):
    m = A[0].size

    for x in range(m):
        A[i, x] = A[i, x] + A[j, x] * s

    return A

A = np.array([
    [1,2,3],
    [4,5,6],
    [7,8,9]
])


# In[20]:


#Ejercicio 11

def esDiagonalmenteDominante(A):

    if not esCuadrada(A): return False

    n, m = len(A), len(A[0])
    
    for i in range(n):
        filaSinDiagonal = sum(A[i]) - A[i,i]
        if filaSinDiagonal >= A[i,i]: return False

    return True

A = np.array([
    [5,1,1],
    [1,5,1],
    [1,1,5]
])
    


# In[37]:


#Ejercicio 12

def matrizCirculante(v):

    n = len(v)
    A = [v]
    for i in range(n-1):
        copia_v = A[i].copy()
        ultimo = copia_v.pop()
        copia_v = [ultimo]+copia_v
        A.append(copia_v)
    
    A = np.array(A)
    return A    
    


# In[42]:


#Ejercicio 13

def matrizVandermonde(v):
    n = len(v)
    A = []

    for i in range(n):
        vector = []
        for j in range(n):
            numero = v[i]
            vector.append(numero**j)
        A.append(vector)

    A = np.array(A)
    return A
        


# In[52]:


#Ejercicio 14

import matplotlib.pyplot as plt

def numeroAureo(n):
    # matriz de Fibonacci
    A = np.array([[1, 1],
                  [1, 0]])
    # semilla
    v = np.array([1, 1])  

    razones = []

    for k in range(2, n+2):
        # A^(k-1) @ v te da [F_k, F_{k-1}]
        Fk = np.linalg.matrix_power(A, k-1) @ v
        razones.append(Fk[0] / Fk[1])  # F_k / F_{k-1}

    return razones

# Probar y graficar
'''
aprox = numeroAureo(15)
plt.plot(range(2, len(aprox)+2), aprox, marker="o")
plt.axhline((1 + np.sqrt(5))/2, color="r", linestyle="--", label="φ real")
plt.xlabel("k")
plt.ylabel("F_{k+1} / F_k")
plt.title("Aproximación al número áureo")
plt.legend()
plt.show()    
  '''  


# In[55]:


#Ejercicio 15

def fib(n):
    F = [1,1]
    for i in range(2, n+1):
        F.append(F[-1] + F[-2])
    return F

def matrizFibonacci(n):

    F = fib(2*n-2)
    A = []

    for i in range(n):
        vector = []
        for j in range(n):
            vector.append(F[i+j])
        A.append(vector)


    A = np.array(A)
    return A
    
    


# In[57]:


#Ejercicio 16

def matrizHilbert(n):
    A = np.array([[0.0 for _ in range(n)] for _ in range(n)])

    for i in range(n):
        for j in range(n):
            A[i,j] = 1/(i+j+1)

    return A


# In[ ]:


#Ejercicio 17


