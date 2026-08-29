# Sistemas Operativos 
## Taller introductorio

> El taller se compila y se ejecuta adentro de una VM Linux que levanta el
> propio `make`. Si todavía no la preparaste, arrancá por **[VM.md](https://github.com/SSOO-Exactas-2026-2C/taller-tools/blob/main/VM.md)**:
> ahí está el setup (`make install`, `make start-vm`, `make shell`) y los
> comandos generales del entorno.

Taller de arranque para poder practicar con el uso de las herramientas básicas y el Makefile. No busca enseñar ningún concepto de la materia todavía; es SOLAMENTE una prueba de plataforma.

## Objetivo del 'taller'

Implementar una función mínima en C y confirmar que el flujo de entrega y corrección anda:

- completás el `TODO` en `par.c`,
- corrés los tests localmente,
- `pusheas` tu solución

## Qué hay que hacer

1. Abrí `par.c` e implementá la función `es_par(int n)`:
   debe devolver `1` si `n` es par y `0` si es impar.
2. Corré los tests localmente hasta que pasen todos.
3. Hacé `commit` y `push`. El autocorrector va a correr luego `make test` sobre tu entrega.

## Comandos

```sh
make install  # prepara la VM (una sola vez por máquina)
make          # compila el ejecutable adentro de la VM
make test     # compila y corre los tests adentro de la VM
make clean    # borra los archivos generados
make help     # todos los comandos del taller
```

La VM se levanta sola la primera vez que corrés `make` o `make test`; lo único
que hay que hacer a mano es el `make install` inicial.

Si todos los tests pasan, `make test` termina con código `0` y la corrección da ✅.
Con el template sin tocar, algunos tests fallan a propósito: eso confirma que el pipeline detecta correctamente lo que falta.
