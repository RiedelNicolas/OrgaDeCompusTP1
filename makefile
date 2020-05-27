CC = gcc
CFLAGS = -Wall -Werror -I. -g

compile: main.c ordenador.c merge_sort.S mymalloc.S
	$(CC) $(CFLAGS) *.c *.S -o tp1 

run: compile
	clear
	./tp1

test: compile
	clear
	./pruebas.sh

