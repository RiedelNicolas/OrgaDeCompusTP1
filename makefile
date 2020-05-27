CC = gcc
CFLAGS = -Wall -Werror -I. -g

compile: 
	$(CC) $(CFLAGS) -o tp1 main.c ordenador.c merge_sort.S mymalloc.S 

test:	clear
	./pruebas.sh

