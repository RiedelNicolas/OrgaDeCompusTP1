#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "ordenador.h"

#define MAX_PATH 150
#define EOL '\n'
#define MAX_DIGITOS 20

#define COMANDO_AYUDA "-h"
#define COMANDO_VERSION "-V"
#define RUTA_AYUDA "comandos/help.txt"
#define RUTA_VERSION "comandos/version.txt"

#define EXITO  0
#define FALLO -1


int mostrar_en_pantalla(char* ruta);

int main(int argc, char** argv){

	if(argc == 2){
		if( !strcmp(argv[1],COMANDO_AYUDA) ){

			return mostrar_en_pantalla(RUTA_AYUDA);

		}else if( !strcmp(argv[1],COMANDO_VERSION) ){
			return mostrar_en_pantalla(RUTA_VERSION);
		}else{
			perror("Argumento invalido");
			return FALLO;
		}
	}

	FILE* stream_entrada = NULL;
	FILE* stream_salida = NULL;

	stream_entrada = fopen("tests/entrada.txt", "r");
	stream_salida = fopen("tests/salida.txt", "w");

	ordenar(stdin, stdout);
	
	fclose(stream_entrada);
	fclose(stream_salida);
	

	return EXITO;
}

int mostrar_en_pantalla(char * ruta){
	FILE* archivo = fopen(ruta,"r");
	if (archivo == NULL){
		perror("\n no se pudo abrir el archivo \n");
		return FALLO;
	}

	char caracter = 'a';

	while(caracter != EOF){
		caracter = fgetc(archivo);
		if(caracter !=EOF) putc(caracter, stdout);
	}
	
	fclose(archivo);
	return FALLO;
}
