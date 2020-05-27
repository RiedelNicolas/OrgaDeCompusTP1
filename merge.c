#include <stdio.h>
#include <stdlib.h>

void merge(int vec[], int inicio, int medio, int fin) {

  // Creo los vectores  aux1 = vec[inicio..medio] y aux2 = vec[medio+1..fin]
  int tope1 = medio - inicio + 1;
  int tope2 = fin - medio;

  int* aux1 = (int*)malloc(sizeof(int)*tope1);
  int* aux2 = (int*)malloc(sizeof(int)*tope2);

  for (int i = 0; i < tope1; i++){
    aux1[i] = vec[inicio + i];
  }

  for (int j = 0; j < tope2; j++){
    aux2[j] = vec[medio + 1 + j];
  }

  int i, j, k;
  i = 0;
  j = 0;
  k = inicio;

  while (i < tope1 && j < tope2) {
    if (aux1[i] <= aux2[j]) {
      vec[k] = aux1[i];
      i++;
    } else {
      vec[k] = aux2[j];
      j++;
    }
    k++;
  }

  while (i < tope1) {
    vec[k] = aux1[i];
    i++;
    k++;
  }

  while (j < tope2) {
    vec[k] = aux2[j];
    j++;
    k++;
  }
  free(aux1);
  free(aux2);
}

void merge_sort_rec(int* vec, int inicio, int fin){

  if(inicio<fin){
    int medio = (inicio+fin-1)/2;

    merge_sort(vec, inicio, medio);
    merge_sort(vec, medio+1, fin);

    merge(vec, inicio, medio, fin);
  }
}



void merge_sort(int *vec, size_t len){
  merge_sort_rec(vec, 0, len-1);
}
