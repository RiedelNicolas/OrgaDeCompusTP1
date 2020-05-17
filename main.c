#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_PATH 150
#define EOL '\n'
#define MAX_DIGITOS 20

// #incluir la biblioteca del codigo en mips

/*PRE: Recibe un stream abierto en modo lectura
POST: Lee una linea de dicho stream y devuelve la misma en forma de array de caracteres. Tambien le asigna a largo la cantidad de caracteres que leyo
*/

char* leer (FILE* stream);
int* pasar_a_enteros(char* linea, int* largo_enteros);
bool es_fin_de_linea(char caracter);
bool es_numerico(char caracter);

void linea_a_string(char* linea);

int main(){

	char* linea = NULL;
	FILE* stream_entrada = NULL;
	int *enteros = NULL;
	int largo_enteros = 0;

	stream_entrada = fopen("tests/entrada.txt", "r");

	linea = leer(stream_entrada);

	linea_a_string(linea);
	printf("%s",linea);

	enteros = pasar_a_enteros(linea, &largo_enteros);

	printf("%i",largo_enteros);
		
	free(linea);
	free(enteros);
	fclose(stream_entrada);
	return 0;
}



char* leer(FILE* stream ){

	int largo_buffer = 20;
	char *linea = (char*) malloc(sizeof(char) * largo_buffer); // Asigno un lugar en memoria para el linea.
	int largo_linea = 0;
	char caracter = 'A'; // un valor trivial

	while ( (caracter != EOL ) && (caracter != EOF) ) {

    	if( largo_linea == (largo_buffer-1) ){ // tengo que agrandar mi memoria.(Dejo lugar para /0)
     	 	largo_buffer +=10; //Voy agregando de a 10 lugares. 
      		linea = realloc(linea, largo_buffer); // re ubico en la memoria.
    	}

    caracter = getc(stream); // Leo un caracter del stream.
    linea[largo_linea] = caracter; //Lo guardo en el linea.
    (largo_linea)+=1; //Incremento mi tope.
	}

	
	return linea;
}

void linea_a_string(char* linea){

	int i = 0;

	while(1){
		if( es_fin_de_linea(linea[i]) ){
			linea[i] = '\0';
			return;	
		}
		i++;
	}
}

bool es_fin_de_linea(char caracter){

	return(caracter == EOF || caracter == EOL);
}


int* pasar_a_enteros(char* linea, int* largo_enteros){
	char temporal [MAX_DIGITOS];
	char caracter = 'A';
	int largo_buffer = 10;
	int *enteros = (int*) malloc(sizeof(int) * largo_buffer);

 	(*largo_enteros) = 0;

	int i = 0;
 	int j = 0;

	while( caracter != '\0' ){

		if( (*largo_enteros) == (largo_buffer-1) ){
			largo_buffer +=10; //Voy agregando de a 10 lugares. 
      		enteros = realloc(enteros, largo_buffer); // re ubico en la memoria.
		}

		caracter = linea[i]; i++;
		if( es_numerico(caracter) ){
			temporal[j] = caracter; j++;	
		}
		else if(caracter =' '){
			temporal[j] = '\0';
			enteros[(*largo_enteros)] = atoi(temporal);
			(*largo_enteros) += 1;
			j = 0;
		}

	}

	return enteros;

}




bool es_numerico(char caracter){
	return(caracter >= '0' && caracter <= '9' );
}
