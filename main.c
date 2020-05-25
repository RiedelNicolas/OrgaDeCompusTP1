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
#define COMANDO_INPUT "-i"
#define COMANDO_OUTPUT "-o"

#define IDENTIFICADOR_STDOUT "-"
#define IDENTIFICADOR_STDIN "-"

#define EXITO  0
#define FALLO -1


int mostrar_en_pantalla(char* ruta);


int main(int argc, char** argv){

	FILE* stream_entrada = NULL;
	FILE* stream_salida = NULL;
	int flag_ordenamiento = -1;

	if(argc == 2){
		if( !strcmp(argv[1],COMANDO_AYUDA) ){

			return mostrar_en_pantalla(RUTA_AYUDA);

		}else if( !strcmp(argv[1],COMANDO_VERSION) ){
			return mostrar_en_pantalla(RUTA_VERSION);
		}else{
			perror("Argumento invalido");
			return FALLO;
		}
	}else if(argc == 5 ){ // -i input -o output
		if( (!strcmp(argv[1],COMANDO_INPUT)) && (!strcmp(argv[3],COMANDO_OUTPUT)) ){
			if( !strcmp(argv[2], IDENTIFICADOR_STDIN) ){
				stream_entrada = stdin;
			}else{
				stream_entrada = fopen(argv[2], "r");
				if(stream_entrada ==NULL){
					perror("\nNo se puedo abrir el archivo de entrada");
					return FALLO;
				}
			}
			if( !strcmp(argv[4], IDENTIFICADOR_STDOUT) ){
				stream_salida = stdout;
			}else{
				stream_salida =  fopen(argv[4],"w");
				if(stream_salida == NULL){
					perror("\nNo se puedo abrir el archivo de salida");
					return FALLO;
				}
			}

			flag_ordenamiento = ordenar(stream_entrada, stream_salida);

			if(stream_salida != stdout) fclose(stream_salida);
			if(stream_entrada != stdin ) fclose(stream_entrada);

		}else{
			perror("Formato de argumentos invalido");
			return FALLO;
		}
	}else{
		perror("Cantidad de argumentos invalida");
		return FALLO;
	}

	if(flag_ordenamiento == FALLO){
		return FALLO;
	}

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
