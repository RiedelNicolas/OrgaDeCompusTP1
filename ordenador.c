 #include "ordenador.h"

#define MAX_PATH 150
#define EOL '\n'
#define MAX_DIGITOS 20
#define FLAG_FIN_DE_ARCHIVO 1 
#define FLAG_LINEA_INVALIDA -1
#define FLAG_CONTINUAR 0



int ordenar(FILE* entrada, FILE* salida);
int leer (FILE* stream, int *largo_linea, char** linea);
int* pasar_a_enteros(char* linea, int largo_linea, int* largo_enteros);
bool es_fin_de_linea(char caracter);
bool es_numerico(char caracter);
void merge_sort(int *vec, size_t len);
void imprimir_enteros(int *enteros, size_t largo, FILE* salida);


int ordenar(FILE* entrada, FILE* salida){

	int flag_lectura = FLAG_CONTINUAR ;
	int *enteros = NULL;
	int largo_enteros = 0;
	int largo_linea = 0;
	char* linea = NULL;

	while(flag_lectura == FLAG_CONTINUAR){

		flag_lectura = leer(entrada, &largo_linea, &linea);
		
		if(flag_lectura !=FLAG_LINEA_INVALIDA ){

			enteros = pasar_a_enteros(linea, largo_linea, &largo_enteros);
			merge_sort(enteros, (size_t) largo_enteros);
			imprimir_enteros(enteros, largo_enteros, salida); 
			free(enteros);
		}

		free(linea);
		}
		return 0;
	}


 int leer(FILE* stream, int *largo_linea, char** linea){

	int largo_buffer = 20;
	*linea = (char*) malloc(sizeof(char) * largo_buffer); // Asigno un lugar en memoria para el linea.
	(*largo_linea) = 0;
	char caracter = 'A'; // un valor trivial

	while ( (caracter != EOL ) && (caracter != EOF) ) {

    	if( (*largo_linea) == (largo_buffer-1) ){ // tengo que agrandar mi memoria.(Dejo lugar para /0)
     	 	largo_buffer +=10; //Voy agregando de a 10 lugares. 
      		(*linea) = (char*) realloc((*linea), sizeof(char) * largo_buffer); // re ubico en la memoria.
    	}

    	caracter = getc(stream); // Leo un caracter del stream.
    	(*linea) [ (*largo_linea) ] = caracter; //Lo guardo en el linea.
    	(*largo_linea)+=1; //Incremento mi tope.
	}





	if( (*largo_linea) <=1 ){     // Siempre va a leer por lo menos un caracter, sea eof o fin de linea
		return FLAG_LINEA_INVALIDA;
	}

	if(caracter == EOF){
		return FLAG_FIN_DE_ARCHIVO;
	}


	return 	FLAG_CONTINUAR;
		
}


int* pasar_a_enteros(char* linea, int largo_linea, int* largo_enteros){

	char temporal [MAX_DIGITOS];
	char caracter = 'A';
	int largo_buffer = 10;
	int *enteros = (int*) malloc(sizeof(int) * largo_buffer);

 	(*largo_enteros) = 0;

	int i = 0;
 	int j = 0;

	while( i<largo_linea ){

		if( (*largo_enteros) == (largo_buffer-1) ){
			largo_buffer +=10; //Voy agregando de a 10 lugares. 
      		enteros = (int*) realloc(enteros, sizeof(int)* largo_buffer); // re ubico en la memoria.
		}

		caracter = linea[i]; i++;
		if( es_numerico(caracter) ){
			temporal[j] = caracter; j++;	
		}
		else if( (caracter =' ' || es_fin_de_linea(caracter) ) && j!=0 ){
			temporal[j] = '\0';
			enteros[(*largo_enteros)] = atoi(temporal);
			(*largo_enteros) += 1;
			j = 0;
		}

	}

	return enteros;
}

bool es_fin_de_linea(char caracter){

	return(caracter == EOF || caracter == EOL);
}

bool es_numerico(char caracter){
	return(caracter >= '0' && caracter <= '9' );
}

void merge_sort(int *vec, size_t len){ // en realiad es un bubble xDDDDDD

  int aux;

  for (size_t i = 0; i < (len-1); i++) {
    for (size_t j = 0; j < (len-i-1); j++) {
      if (vec[j] > vec[j+1]) {
        // swap
        aux      = vec[j];
        vec[j]   = vec[j+1];
        vec[j+1] = aux;
      }
    }
  }
}

void imprimir_enteros(int *enteros, size_t largo, FILE* salida){
	for (int i = 0; i < largo; i++){
		fprintf(salida, "%i ",enteros[i] );
	}

	fprintf(salida,"\n");
}