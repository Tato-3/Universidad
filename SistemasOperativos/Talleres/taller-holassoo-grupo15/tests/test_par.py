#!/usr/bin/env python3
"""Tests del taller "Hola SSOO".

Corre adentro de la VM, lo lanza `make test`. Se le pasa el ejecutable a probar:

    python3 tests/test_par.py ./par

Cada caso ejecuta el programa con un argumento y compara su salida estándar
contra la esperada. Sale con código != 0 si falla alguno, que es lo que el
autocorrector necesita para darse cuenta.
"""

import subprocess
import sys

# (argumento, salida esperada)
CASOS = [
    ("4", "par"),
    ("7", "impar"),
    ("0", "par"),
    ("10", "par"),
    ("3", "impar"),
]

# Un programa bien resuelto termina al toque. Si se cuelga, lo cortamos y lo
# damos por fallado, así `make test` no queda esperando para siempre.
TIMEOUT = 10


def correr(binario, argumento):
    """Devuelve la salida del programa, o None si se colgó."""
    try:
        resultado = subprocess.run(
            [binario, argumento],
            capture_output=True,
            text=True,
            timeout=TIMEOUT,
        )
    except subprocess.TimeoutExpired:
        return None
    return resultado.stdout.strip()


def main():
    if len(sys.argv) != 2:
        print(f"uso: {sys.argv[0]} <ejecutable>", file=sys.stderr)
        return 2

    binario = sys.argv[1]
    fallos = 0

    print("== Corriendo tests ==")
    for argumento, esperado in CASOS:
        obtenido = correr(binario, argumento)
        if obtenido == esperado:
            print(f"  OK    es_par({argumento}) -> {obtenido}")
        elif obtenido is None:
            print(f"  FALLA es_par({argumento}) -> no terminó en {TIMEOUT}s")
            fallos += 1
        else:
            print(
                f"  FALLA es_par({argumento}) -> "
                f"esperaba '{esperado}', obtuve '{obtenido}'"
            )
            fallos += 1

    print("=====================")
    if fallos == 0:
        print("Todos los tests pasaron.")
        return 0

    print(f"{fallos} test(s) fallaron.")
    return 1


if __name__ == "__main__":
    sys.exit(main())
