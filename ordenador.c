 #include "ordenador.h"

#define MAX_PATH 150
#define EOL '\n'
#define MAX_DIGITOS 20
#define FLAG_FIN_DE_ARCHIVO 1 
#define FLAG_LINEA_INVALIDA -1
#define FLAG_CONTINUAR 0
#define FLAG_PROBLEMA_MEMORIA -2
#define FLAG_LINEA_INVALIDA -1



int ordenar(FILE* entrada, FILE* salida);
int leer (FILE* stream, int *largo_linea, char** linea);
int* pasar_a_enteros(char* linea, int largo_linea, size_t* largo_enteros);
bool es_fin_de_linea(char caracter);
bool es_numerico(char caracter);
extern void merge_sort(int *vec, size_t len);
void imprimir_enteros(int *enteros, size_t largo, FILE* salida);
bool es_caracter_invalido(char caracter);




/*Pre: Recibe un stream correctamente abierto en modo de lectura
		y otro en modo escritura.
 *Pos: En el caso que el stream de entrada tenga formato de lineas consecutivas
 		de numeros enteros separados por espacios. Ordena cada linea en modo ascendente
 		y dicho resultado lo imprime en el stream de salida. Devolviendo el flag "EXITO"
 		En caso que no se respete el formato se devuelve "FALLO"
*/

int ordenar(FILE* entrada, FILE* salida){

	int flag_lectura = FLAG_CONTINUAR ;
	int *enteros = NULL;
	size_t largo_enteros = 0;
	int largo_linea = 0;
	char* linea = NULL;

	while(flag_lectura == FLAG_CONTINUAR){

		flag_lectura = leer(entrada, &largo_linea, &linea);

		if(flag_lectura == FLAG_PROBLEMA_MEMORIA){
			perror("Problema asignando memoria dinamica");
			return FALLO;
		}
		
		if(flag_lectura != FLAG_LINEA_INVALIDA ){

			enteros = pasar_a_enteros(linea, largo_linea, &largo_enteros);

			if(enteros == NULL){
				perror("Problema asignando memoria dinamica");
				free(linea);
				return FALLO;
			}

			merge_sort(enteros, largo_enteros);
			imprimir_enteros(enteros, largo_enteros, salida);
			free(enteros);
		}

		free(linea);
		}

		if(flag_lectura == FLAG_LINEA_INVALIDA) return FALLO;

		return EXITO; 
}


/*POS: Recibe un file stream correctamente abierto en modo lectura.
  Pre: Lee una linea de dicho stream, devolviendo por parametros la misma
  		en forma de array de caracteres y el largo de la linea. En forma de retorno	
  		devuelve un flag indicando el resultado de la lectura :
  		FLAG_CONTINUAR:      En caso de que el archivo continue.
  		FLAG_FIN_DE_ARCHIVO: En caso de encontrase con un EOF o una linea
							que solo contenga -1(indicador para dejar de iterar).
		FLAG_LINEA_INVALIDA: En que se haya tenido que detener la ejecucion debido a un
							caracter invalido encontrado en el stream.
*/	
int leer(FILE* stream, int *largo_linea, char** linea){

	int largo_buffer = 20;
	*linea = (char*) malloc(sizeof(char) * largo_buffer); // Asigno un lugar en memoria para el linea.

	if( (*linea) == NULL){
		return FLAG_PROBLEMA_MEMORIA;
	}

	(*largo_linea) = 0;
	int caracter = 1; // un valor trivial

	while ( (caracter != EOL ) && (caracter != EOF) ) {

    	if( (*largo_linea) == (largo_buffer-1) ){ // tengo que agrandar mi memoria.(Dejo lugar para /0)
     	 	largo_buffer +=10; //Voy agregando de a 10 lugares. 
      		(*linea) = (char*) realloc((*linea), sizeof(char) * largo_buffer); // re ubico en la memoria.
      		if( (*linea) == NULL){
				return FLAG_PROBLEMA_MEMORIA;
			}
    	}

    	if( ferror(stream) ){
    		perror("Problema leyendo el archivo");
    		return FLAG_LINEA_INVALIDA;
    	}

    	caracter = getc(stream); // Leo un caracter del stream.
    	if( es_caracter_invalido(caracter) ){
    		 return FLAG_LINEA_INVALIDA; // Si lee un caracter que no corresponde, devuelve linea invalida.	
    	}
    	(*linea) [ (*largo_linea) ] = (char) caracter; //Lo guardo en el linea.
    	(*largo_linea)+=1; //Incremento mi tope.
	}

	if(caracter == EOF || (*largo_linea) <=1){// Siempre va a leer por lo menos un caracter, sea eof o fin de linea
		return FLAG_FIN_DE_ARCHIVO;
	}

	return 	FLAG_CONTINUAR;
		
}

/*Pre: Recibe un array de caracteres que contiene numeros enteros
       separados por un espacio(Esto es previamente validado) junto con su largo.
  Pos: Devuelve en forma de retorno el puntero a un array de enteros equivalente al de caracteres
       Y por parametro devuelve su largo.
*/
int* pasar_a_enteros(char* linea, int largo_linea, size_t* largo_enteros){

	char temporal [MAX_DIGITOS];
	char caracter = 'A';
	int largo_buffer = 10;
	int *enteros = (int*) malloc(sizeof(int) * largo_buffer);
	if( enteros == NULL ){
		return NULL ;
	}

 	(*largo_enteros) = 0;

	int i = 0;
 	int j = 0;

	while( i<largo_linea ){

		if( (*largo_enteros) == (largo_buffer-1) ){
			largo_buffer +=10; //Voy agregando de a 10 lugares. 
      		enteros = (int*) realloc(enteros, sizeof(int)* largo_buffer); // re ubico en la memoria.
      		if( enteros == NULL ){
				return NULL ;
			}
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

/*Pre: Recibe un entero que representa un..
  Pos: Devuelve TRUE si se encuentra un caracter que indice el fin de linea 
*/
bool es_fin_de_linea(char caracter){

	return(caracter == EOL || caracter == (char) EOF);
}


/*Pre: Recibe un caracter.
  Pos: Responde a la pregunta es numerico?(se considera los signos de + y - como numericos)
*/
bool es_numerico(char caracter){
	return( (caracter >= '0' && caracter <= '9') || caracter=='-'||caracter=='+'); 
}


/*Pre: Recibe un caracter
   Pos: Si el caracter es numerico, EOF, EOL o espacio devuelve TRUE.
   		en otro caso devuelve FALSE. (dicho caracter no se deberia encontrar en el input)
*/
bool es_caracter_invalido(char caracter){
	return !(es_numerico(caracter) || es_fin_de_linea(caracter) || caracter ==' ');
}


/*
Pre : Recibe un array de enteros, su largo y un stream de salida.
Pos:  "Imprime" dicho array en el stream.
*/
void imprimir_enteros(int *enteros, size_t largo, FILE* salida){

	if(largo == 0 ) return;

	for (int i = 0; i < largo; i++){
		fprintf(salida, "%i ",enteros[i] );
	}

	fprintf(salida,"\n");
}
