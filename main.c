#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "ordenador.h"

#define MAX_PATH 150
#define EOL '\n'
#define MAX_DIGITOS 20



int main(){

	char* linea = NULL;
	FILE* stream_entrada = NULL;
	FILE* stream_salida = NULL;
	int *enteros = NULL;
	int largo_enteros = 0;
	int largo_linea = 0;

	stream_entrada = fopen("tests/entrada.txt", "r");
	stream_salida = fopen("tests/salida.txt", "w");
	ordenar(stream_entrada, stream_salida);
	fclose(stream_entrada);
	fclose(stream_salida);
	return 0;
}

