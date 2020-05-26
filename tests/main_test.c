#include <stdio.h>

extern void merge_sort(int* vec, size_t len);

int main(){
  int a[] = {65,3,2};
  size_t tope = 3;
  merge_sort(a,tope);

  for(int i=0; i<tope; i++){
      printf("%i ", a[i]);
  }
  return 0;
}
