#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Eliminacion Gausianna
"""
import numpy as np
import sys
import os

sys.path.append(os.path.abspath('../Labo0'))

from librerias import diagonal


def calculaLU(A):
    cant_op = 0
    n=A.shape[0]
    m=A.shape[1]
    
    if m!=n:
        print('Matriz no cuadrada')
        return
    
    ## desde aqui -- CODIGO A COMPLETAR
    
    L = np.eye(n, dtype=float)
    U = A.copy().astype(float)

    # Contadores separados
    sumas = 0
    restas = 0
    mults = 0
    divs = 0

    for pivote in range(n-1):
        if abs(U[pivote, pivote]) < 1e-12:
            return None, None, 0
        
        for i in range(pivote+1, n):
            # División para calcular el multiplicador
            m_factor = U[i, pivote] / U[pivote, pivote]
            divs += 1
            L[i, pivote] = m_factor

            # Eliminación en la fila i
            for j in range(pivote, n):
                U[i, j] = U[i, j] - U[pivote, j] * m_factor
                mults += 1          # U[pivote,j] * m_factor
                restas += 1         # U[i,j] - (producto)

    # Cantidad total de operaciones aritméticas
    cant_op = sumas + restas + mults + divs

    return L, U, cant_op

def res_tri(L, b, inferior=True):
    n, m = L.shape
    x = np.zeros_like(b, dtype=float)
    
    if inferior:
        for i in range(n):
            suma = sum(L[i, j]*x[j] for j in range(i))
            x[i] = (b[i] - suma) / L[i, i]
            
    else:
        for i in reversed(range(n)):
            suma = sum(L[i, j] * x[j] for j in range(i+1, n))
            x[i] = (b[i] - suma) / L[i, i]
    
    return x


def inversa(A):    
        n, _ = A.shape
        L, U, _ = calculaLU(A)
        A_inversa = np.zeros_like(A)
        
        if L is None or U is None: return None
        
        #Verifico la diagonal de U para que no divida por 0
        if np.any(np.abs(np.diag(U)) < 1e-12):
            return None
        
        for i in range(n):
            
            ei = np.zeros(n) #Vector canonico
            ei[i] = 1
            
            Ly = res_tri(L, ei)
            Ux = res_tri(U, Ly, inferior=False)
            
            A_inversa[:, i] = Ux
            
        return A_inversa

def calculaLDV(A):
    
    L, U, nops = calculaLU(A)
    
    n, _ = U.shape
    
    D = diagonal(U)
    
    V = np.zeros_like(U, dtype=float)
    
    for i in range(n):
        for j in range(n):
            if i == j:
                V[i][j] = 1
            if j > i:
                V[i][j] = U[i][j] / U[i][i]
    
    return L, D, V, nops


def esSDP(A, atol=1e-8):
    if not np.allclose(A, A.T, atol=atol):
        return False
    L, D, V, _ = calculaLDV(A)
    return np.all(np.diag(D) > atol)




L0 = np.array([[1,0,0],[1,1,0],[1,1,1]])
D0 = np.diag([1,1,1])
A = L0 @ D0 @ L0.T
assert(esSDP(A))

D0 = np.diag([1,-1,1])
A = L0 @ D0 @ L0.T
assert(not esSDP(A))


D0 = np.diag([1,1,1e-16])
A = L0 @ D0 @ L0.T
assert(not esSDP(A))

L0 = np.array([[1,0,0],[1,1,0],[1,1,1]])
D0 = np.diag([1,1,1])
V0 = np.array([[1,0,0],[1,1,0],[1,1+1e-10,1]]).T
A = L0 @ D0 @ V0
assert(not esSDP(A))

