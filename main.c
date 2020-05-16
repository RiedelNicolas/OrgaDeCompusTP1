#include <stdio.h>
#include <stdlib.h>

#define MAX_PATH 150
#define EOL '\n'

// #incluir la biblioteca del codigo en mips


char* leer(FILE* stream,int* largo );


int main(){

	FILE* stream = stdin;
	int largo_linea = 0;
	char* linea;


	linea = leer (stdin, &largo_linea);

	for (int i = 0; i < largo_linea; ++i){
		printf("%c \n", linea[i] );
	}
		
	free(linea);

	return 0;
}



char* leer( FILE* stream,int* largo_linea ){

	int largo_buffer = 20;
	char *linea = (char*) malloc(sizeof(char) * largo_buffer); // Asigno un lugar en memoria para el linea.
	*largo_linea = 0;
	char caracter = 'A'; // un valor trivial

	while ( (caracter != EOL ) || (caracter != EOF) ) {

    	if( *largo_linea == largo_buffer){ // tengo que agrandar mi memoria.
     	 	largo_buffer +=10; //Voy agregando de a 10 lugares. 
      		linea = realloc(linea, largo_buffer); // re ubico la memoria.
    	}

    caracter = getc(stream); // Leo un caracter del stream.
    printf("%i \n",*largo_linea );
    linea[*largo_linea] = caracter; //Lo guardo en el linea.
    (*largo_linea)+=1; //Incremento mi tope.

	}
	
	return linea;

}