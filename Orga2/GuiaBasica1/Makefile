CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGETS = hola rotarIzq

all: $(TARGETS)

hola: hola.o
	$(CC) $(CFLAGS) hola.o -o hola

hola.o: hola.c
	$(CC) $(CFLAGS) -c hola.c -o hola.o

rotarIzq: rotarIzq.o
	$(CC) $(CFLAGS) rotarIzq.o -o rotarIzq

rotarIzq.o: rotarIzq.c
	$(CC) $(CFLAGS) -c rotarIzq.c -o rotarIzq.o

clean:
	rm -f *.o $(TARGETS)

.PHONY: all clean