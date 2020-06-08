#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <getopt.h>

#include "ordenador.h"

#define MAX_MENSAJE 150
#define EOL '\n'




#define COMANDO_AYUDA_CORTO 'h'
#define COMANDO_VERSION_CORTO 'V'
#define COMANDO_AYUDA_LARGO "help"
#define COMANDO_VERSION_LARGO "version"

#define COMANDO_INPUT_CORTO 'i'
#define COMANDO_OUTPUT_CORTO 'o'
#define COMANDO_INPUT_LARGO "input"
#define COMANDO_OUTPUT_LARGO "output"


#define RUTA_AYUDA "comandos/help.txt"
#define RUTA_VERSION "comandos/version.txt"


#define CANTIDAD_ARGUMENTOS_FUNCIONAL 5
#define CANTIDAD_ARGUMENTOS_INFO 2



#define MENSAJE_COMANDO_INVALIDO "\nEl comando usado es invalido, use -h para ayuda"
#define MENSAJE_ORDENAMIENTO_FALLO "\n No se pudo ordenar, el input no tiene el formato requerido"




int mostrar_en_pantalla(char* ruta);
void notificar_problema_ruta(char *ruta);


int main(int argc, char** argv){

	FILE* stream_entrada = NULL;
	FILE* stream_salida = NULL;
	int flag_ordenamiento = -1;
	int long_index = 0;
	int opt = 0;

	static struct option long_options[] = {
        {COMANDO_VERSION_LARGO,      no_argument,       NULL, COMANDO_VERSION_CORTO },
        {COMANDO_AYUDA_LARGO,         no_argument,       NULL,  COMANDO_AYUDA_CORTO },
        {COMANDO_INPUT_LARGO,    required_argument,     NULL,  COMANDO_INPUT_CORTO },
        {COMANDO_OUTPUT_LARGO,   required_argument,     NULL,  COMANDO_OUTPUT_CORTO },
        {NULL,           0,                     NULL,    0 }
    };


	while ( (opt = getopt_long(argc, argv,"Vhi:o:", 
                   long_options, &long_index )) != -1) {
        switch (opt) {
            case COMANDO_VERSION_CORTO :
             	return mostrar_en_pantalla(RUTA_VERSION);
	    case COMANDO_AYUDA_CORTO :
             	return mostrar_en_pantalla(RUTA_AYUDA);
            case COMANDO_INPUT_CORTO :
				stream_entrada = fopen(optarg, "r");
				if(stream_entrada == NULL){
					notificar_problema_ruta(optarg);
					if(stream_salida !=NULL ){ // se pudo abrir el otro archivo.
						fclose(stream_salida);
					}
					return FALLO;
				}
            	break;
            case COMANDO_OUTPUT_CORTO :
				stream_salida = fopen(optarg, "w");
				if(stream_salida == NULL){
					notificar_problema_ruta(optarg);
					if(stream_entrada != NULL ){ // se pudo abrir el otro archivo.
						fclose(stream_entrada);
					}
					return FALLO;
				}
                break;
            default:
            	perror(MENSAJE_COMANDO_INVALIDO); 
            	return FALLO;
        }
    }

    // En el caso que se tenga que activar el default.
    if(stream_entrada == NULL ) stream_entrada = stdin;
    if(stream_salida == NULL ) stream_salida = stdout;

	flag_ordenamiento = ordenar(stream_entrada, stream_salida);

	if(stream_salida != stdout) fclose(stream_salida);
	if(stream_entrada != stdin ) fclose(stream_entrada);

	if(flag_ordenamiento == FALLO){
		perror(MENSAJE_ORDENAMIENTO_FALLO);
		return FALLO;
	}

	return EXITO;
}

/*Pre: Recibe una ruta a un archivo en formato de string.
  Pos: Muestra por stdin dicho archivo (similar al comando unix "cat".
*/
int mostrar_en_pantalla(char * ruta){
	FILE* archivo = fopen(ruta,"r");
	if (archivo == NULL){
		perror("\n no se pudo abrir el archivo \n");
		return FALLO;
	}

	int caracter  = 1;

	while(caracter != EOF){
		caracter = fgetc(archivo);
		if(caracter !=EOF) putc(caracter, stdout);
	}

	fclose(archivo);
	return FALLO;
}

/*Pre: Recibe una ruta a un archivo en formato de string.
  Pos: Notifica por stderror que se tuvo un error con un archivo de dicha ruta.
*/
void notificar_problema_ruta(char *ruta){
	char mensaje [MAX_MENSAJE];
	strcpy(mensaje,"\nEl archivo en la ruta: ");
	strcat(mensaje,ruta);
	strcat(mensaje,". No se pudo abrir correctamente\0"); //esto lo hago porque perror no recibe parametros.
	perror(mensaje);
}
