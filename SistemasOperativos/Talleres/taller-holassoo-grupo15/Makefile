# Makefile - Taller "Hola SSOO"
#
# Todo se compila y se ejecuta adentro de una VM Linux, no en tu máquina.
# Así el entorno es idéntico para todos (Linux, macOS y Windows con WSL2).
#
# La carpeta del taller se comparte con la VM, así que podés editar los
# archivos con tu editor de siempre y compilar/correr con make.
#
# Arranca con:   make install
# Y después:     make help

# Estándar de compilación de este taller. Va antes del include porque vm.mk
# define su propio default con ?=, y el primero que gana es este. Se sigue
# pudiendo pisar desde la línea de comandos: make CFLAGS=...
CFLAGS ?= -Wall -Wextra -std=c11

# ---------------------------------------------------------------------
# Herramientas compartidas por todos los talleres de la materia (la VM,
# principalmente). Viven en su propio repo y las baja make solo, la primera
# vez.  https://github.com/SSOO-Exactas-2026-2C/taller-tools
TOOLS_REPO ?= https://github.com/SSOO-Exactas-2026-2C/taller-tools.git
TOOLS_REF  ?= main

# Se clona en una carpeta temporal y recién ahí se mueve a tools/, para que un
# Ctrl-C a mitad de la descarga no deje un tools/ incompleto (que después haría
# fallar todos los clones siguientes con "destination path already exists").
#
# Ojo: el resultado se chequea con el exit status del $(shell) y NO con un
# segundo $(wildcard). Make cachea el listado de cada directorio y no lo
# invalida después de un $(shell), así que el wildcard seguiría dando vacío y
# abortaría un clone que en realidad anduvo bien.
ifeq ($(wildcard tools/vm.mk),)
$(info ==> Bajando las herramientas compartidas del taller...)
TOOLS_OK := $(shell rm -rf tools tools.tmp && \
	git clone --quiet --depth 1 --branch $(TOOLS_REF) $(TOOLS_REPO) tools.tmp 1>&2 && \
	mv tools.tmp tools && echo ok)
ifneq ($(TOOLS_OK),ok)
$(error No pude bajar las herramientas del taller desde $(TOOLS_REPO) -- necesitás git y conexión a internet)
endif
endif

include tools/vm.mk

# ---------------------------------------------------------------------

TARGET := par
SRC    := par.c
TESTS  := tests/test_par.py

# A diferencia de los otros talleres, acá "make" pelado compila.
.DEFAULT_GOAL := $(TARGET)

.PHONY: help test clean

help:
	@echo "Taller introductorio - Hola SSOO"
	@echo ""
	$(VM_HELP)
	@echo ""
	@echo "  El taller"
	@echo "    make                      compila tu $(SRC)"
	@echo "    make test                 compila y corre los tests"
	@echo ""
	$(VM_HELP_LIMPIEZA)

# El binario se compila adentro de la VM. Como la carpeta es compartida, el
# .c se lee y el ejecutable aparece del lado del host también.
$(TARGET): $(SRC)
	@$(VM) exec "gcc $(CFLAGS) -o $(TARGET) $(SRC)"
	@echo "compilado: $(TARGET)"

# Ojo: sin $(INTERACTIVO). Acá el código de salida es el resultado de las
# pruebas, que es justo lo que mira el autocorrector.
test: $(TARGET)
	@$(VM) run "python3 $(TESTS) ./$(TARGET)"

clean:
	rm -f $(TARGET)
