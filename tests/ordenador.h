#ifndef _ORDENADOR_H_
#define _ORDENADOR_H_

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define EXITO  0
#define FALLO -1





/*Pre: Recibe un stream correctamente abierto en modo de lectura
		y otro en modo escritura.
 *Pos: En el caso que el stream de entrada tenga formato de lineas consecutivas
 		de numeros enteros separados por espacios. Ordena cada linea en modo ascendente
 		y dicho resultado lo imprime en el stream de salida. Devolviendo el flag "EXITO"
 		En caso que no se respete el formato se devuelve "FALLO"
*/
int ordenar(FILE* entrada, FILE* salida);



#endif