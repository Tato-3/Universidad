CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGETS = monstruo lowToUppercase persona

all: $(TARGETS)


monstruo: monstruo.o
	$(CC) $(CFLAGS) monstruo.o -o monstruo

monstruo.o: monstruo.c
	$(CC) $(CFLAGS) -c monstruo.c -o monstruo.o

lowToUppercase: lowToUppercase.o
	$(CC) $(CFLAGS) lowToUppercase.o -o lowToUppercase

lowToUppercase.o: lowToUppercase.c
	$(CC) $(CFLAGS) -c lowToUppercase.c -o lowToUppercase.o

persona: persona.o
	$(CC) $(CFLAGS) persona.o -o persona

persona.o: persona.c
	$(CC) $(CFLAGS) -c persona.c -o persona.o

clean:
	rm -f *.o $(TARGETS)

.PHONY: all clean