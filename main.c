#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "ordenador.h"

#define MAX_MENSAJE 150
#define EOL '\n'

#define COMANDO_AYUDA_CORTO "-h"
#define COMANDO_VERSION_CORTO "-V"
#define COMANDO_AYUDA_LARGO "--help"
#define COMANDO_VERSION_LARGO "--version"

#define RUTA_AYUDA "comandos/help.txt"
#define RUTA_VERSION "comandos/version.txt"

#define COMANDO_INPUT_CORTO "-i"
#define COMANDO_OUTPUT_CORTO "-o"
#define COMANDO_INPUT_LARGO "--input"
#define COMANDO_OUTPUT_LARGO "--output"

#define IDENTIFICADOR_STDOUT "-"
#define IDENTIFICADOR_STDIN "-"
#


#define MENSAJE_COMANDO_INVALIDO "\nEl comando usado es invalido, use -h para ayuda"
#define MENSAJE_ORDENAMIENTO_FALLO "\n No se pudo ordenar, el input no tiene el formato requerido"




int mostrar_en_pantalla(char* ruta);
void notificar_problema_ruta(char *ruta);

bool es_comando_ayuda(char* comando);
bool es_comando_version(char* comando);
bool es_comando_input(char* comando);
bool es_comando_output(char* comando);







int main(int argc, char** argv){

	FILE* stream_entrada = NULL;
	FILE* stream_salida = NULL;
	int flag_ordenamiento = -1;

	if(argc == 2){
		if( es_comando_ayuda(argv[1]) ){

			return mostrar_en_pantalla(RUTA_AYUDA);

		}else if( es_comando_version(argv[1]) ){
			return mostrar_en_pantalla(RUTA_VERSION);
		}else{
			perror(MENSAJE_COMANDO_INVALIDO);
			return FALLO;
		}
	}else if(argc == 5 ){ // -i input -o output
		if( es_comando_input(argv[1]) && es_comando_output(argv[3]) ){
			if( !strcmp(argv[2], IDENTIFICADOR_STDIN) ){
				stream_entrada = stdin;
			}else{
				stream_entrada = fopen(argv[2], "r");
				if(stream_entrada ==NULL){
					notificar_problema_ruta(argv[2]);
					return FALLO;
				}
			}
			if( !strcmp(argv[4], IDENTIFICADOR_STDOUT) ){
				stream_salida = stdout;
			}else{
				stream_salida =  fopen(argv[4],"w");
				if(stream_salida == NULL){
					notificar_problema_ruta(argv[4]);
					return FALLO;
				}
			}

			flag_ordenamiento = ordenar(stream_entrada, stream_salida);

			if(stream_salida != stdout) fclose(stream_salida);
			if(stream_entrada != stdin ) fclose(stream_entrada);

		}else{
			perror(MENSAJE_COMANDO_INVALIDO);
			return FALLO;
		}
	}else{
		perror(MENSAJE_COMANDO_INVALIDO);
		return FALLO;
	}

	if(flag_ordenamiento == FALLO){
		perror(MENSAJE_ORDENAMIENTO_FALLO);
		return FALLO;
	}

	return EXITO;
}





bool es_comando_ayuda(char* comando){
	return( !strcmp(comando,COMANDO_AYUDA_LARGO) || !strcmp(comando,COMANDO_AYUDA_CORTO) );
}

bool es_comando_version(char* comando){
	return( !strcmp(comando,COMANDO_VERSION_LARGO) || !strcmp(comando,COMANDO_VERSION_CORTO) );
}

bool es_comando_input(char* comando){
	return( !strcmp(comando,COMANDO_INPUT_LARGO) || !strcmp(comando,COMANDO_INPUT_CORTO) );			

}

bool es_comando_output(char* comando){
	return( !strcmp(comando,COMANDO_OUTPUT_LARGO) || !strcmp(comando,COMANDO_OUTPUT_CORTO) );	
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

void notificar_problema_ruta(char *ruta){
	char mensaje [MAX_MENSAJE];
	strcpy(mensaje,"\nEl archivo en la ruta: ");
	strcat(mensaje,ruta);
	strcat(mensaje,". No se pudo abrir correctamente\0"); //esto lo hago porque perror no recibe parametros.
	perror(mensaje);
}
