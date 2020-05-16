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

char* leer (FILE* stream,int* largo );
int* pasar_a_enteros(char* linea, int largo_linea, int* largo_enteros);4
bool es_fin_de_linea(char caracter);
bool es_numerico(char caracter);

int main(){

	int largo_linea = 0;
	char* linea == NULL;
	FILE* stream_entrada == NULL;
	int *enteros = NULL;
	int largo_enteros = 0;

	stream_entrada = fopen("tests/entrada.txt", "r");


	linea = leer(stream_entrada, &largo_linea);
	enteros = pasar_a_enteros(linea, &largo_enteros);

		
	free(linea);
	free(enteros);
	fclose(entrada);
	return 0;
}



char* leer( FILE* stream,int* largo_linea ){

	int largo_buffer = 20;
	char *linea = (char*) malloc(sizeof(char) * largo_buffer); // Asigno un lugar en memoria para el linea.
	*largo_linea = 0;
	char caracter = 'A'; // un valor trivial

	while ( (caracter != EOL ) && (caracter != EOF) ) {

    	if( *largo_linea == largo_buffer){ // tengo que agrandar mi memoria.
     	 	largo_buffer +=10; //Voy agregando de a 10 lugares. 
      		linea = realloc(linea, largo_buffer); // re ubico en la memoria.
    	}

    caracter = getc(stream); // Leo un caracter del stream.
    linea[*largo_linea] = caracter; //Lo guardo en el linea.
    (*largo_linea)+=1; //Incremento mi tope.

	}
	
	return linea;

}

int* pasar_a_enteros(char* linea, int largo_linea, int* largo_enteros){
	char entero_en_string [MAX_DIGITOS];
	char caracter = 'A';
	int entero;
	int largo_buffer = 10;
 	(*largo_enteros) = 0;
 	int i = 0;
 	int j = 0;

	int *enteros = (int*) malloc(sizeof(int) * largo_buffer);

	for (int i = 0; i < largo_linea; i++){
		if( (*largo_enteros) == (largo_buffer-1) ){
			largo_buffer +=10; //Voy agregando de a 10 lugares. 
      		enteros = realloc(enteros, largo_buffer); // re ubico en la memoria.
		}
		
		caracter = linea[i];
		while(es_numerico(caracter)){

		}

	}



	while( !es_fin_de_linea(caracter) ){	
		if( (*largo_enteros) == (largo_buffer-1) ){
			largo_buffer +=10; //Voy agregando de a 10 lugares. 
      		enteros = realloc(enteros, largo_buffer); // re ubico en la memoria.
		}

		j = 0 ;

		do{
			caracter = linea[i]
			i++;
			if(es_numerico){

			}

		}while( !es_fin_de_linea(caracter) && caracter!=' ' )

	}

}


bool es_fin_de_linea(char caracter){

	return(caracter == EOF || caracter || EOL || caracter !='\0');
}

bool es_numerico(char caracter){
	return(caracter >= '0' && caracter <= '9' );
}