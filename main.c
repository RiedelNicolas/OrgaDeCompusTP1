#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <getopt.h>

#include "ordenador.h"

#define MAX_MENSAJE 150
#define EOL '\n'




#define COMANDO_AYUDA_CORTO "-h"
#define COMANDO_VERSION_CORTO "-V"
#define COMANDO_AYUDA_LARGO "--help"
#define COMANDO_VERSION_LARGO "--version"

#define COMANDO_INPUT_CORTO "-i"
#define COMANDO_OUTPUT_CORTO "-o"
#define COMANDO_INPUT_LARGO "--input"
#define COMANDO_OUTPUT_LARGO "--output"


#define IDENTIFICADOR_STDOUT "-"
#define IDENTIFICADOR_STDIN "-"

#define RUTA_AYUDA "comandos/help.txt"
#define RUTA_VERSION "comandos/version.txt"


#define CANTIDAD_ARGUMENTOS_FUNCIONAL 5
#define CANTIDAD_ARGUMENTOS_INFO 2



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
	int long_index = 0;
	int opt = 0;

	static struct option long_options[] = {
        {"-version",      no_argument,       0,  'V' },
        {"-help",         no_argument,       0,  'h' },
        {"-input",    required_argument,     0,  'i' },
        {"-output",   required_argument,     0,  'o' },
        {0,           0,                 0,  0       }
    };


 while ( (opt = getopt_long(argc, argv,"apl:b:", 
                   long_options, &long_index )) != -1) {
        switch (opt) {
             case 'V' :
              mostrar_en_pantalla(RUTA_VERSION);
                 break;
             case 'h' :
              mostrar_en_pantalla(RUTA_AYUDA);
                 break;
             case 'i' :
              length = atoi(optarg); 
                 break;
             case 'o' :
              breadth = atoi(optarg);
                 break;
             default:
              print_usage(); 
            exit(EXIT_FAILURE);
        }
    }





/*
	if(argc == CANTIDAD_ARGUMENTOS_INFO){
		if( es_comando_ayuda(argv[1]) ){

			return mostrar_en_pantalla(RUTA_AYUDA);

		}else if( es_comando_version(argv[1]) ){
			return mostrar_en_pantalla(RUTA_VERSION);
		}else{
			perror(MENSAJE_COMANDO_INVALIDO);
			return FALLO;
		}
	}else if(argc == CANTIDAD_ARGUMENTOS_FUNCIONAL ){ // -i input -o output
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

	*/
}




/*Pre: Recibe un string.
  Pos: Devuelve true en el caso que el string corresponda con algunos de los comandos asociados a ayuda.
*/
bool es_comando_ayuda(char* comando){
	return( !strcmp(comando,COMANDO_AYUDA_LARGO) || !strcmp(comando,COMANDO_AYUDA_CORTO) );
}

/*Pre: Recibe un string.
  Pos: Devuelve true en el caso que el string corresponda con algunos de los comandos asociados a version.
*/
bool es_comando_version(char* comando){
	return( !strcmp(comando,COMANDO_VERSION_LARGO) || !strcmp(comando,COMANDO_VERSION_CORTO) );
}

/*Pre: Recibe un string.
  Pos: Devuelve true en el caso que el string corresponda con algunos de los comandos asociados a input.
*/
bool es_comando_input(char* comando){
	return( !strcmp(comando,COMANDO_INPUT_LARGO) || !strcmp(comando,COMANDO_INPUT_CORTO) );			

}

/*Pre: Recibe un string.
  Pos: Devuelve true en el caso que el string corresponda con algunos de los comandos asociados a output.
*/
bool es_comando_output(char* comando){
	return( !strcmp(comando,COMANDO_OUTPUT_LARGO) || !strcmp(comando,COMANDO_OUTPUT_CORTO) );	
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
