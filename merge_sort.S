#include <sys/regdef.h>
#include <sys/syscall.h>

        .abicalls
        .text
        .align	2
        .globl merge_sort
        .ent merge_sort

main:
        .frame fp,40,ra
        subu    sp,sp,40    #creacion stack frame
      	.cprestore 24       #Saved register area.
      	sw      ra,32(sp)
      	sw      fp,28(sp)   #almaceno valor de fp a 28bytes del sp
      	move    fp,sp       #fp = sp

      	sw      a0,40(fp)   #salvo *vec
      	sw      a1,44(fp)   #salvo len

      	addi    a2,zero,0   #establezco un valor para el indice izquierdo
      	sub     a3,a1,1     #establezco un valor para el indice derecho
      	jal     merge_sort

merge_sort:
        slt     t0,a2,a3    #si a2<a3 entonces t0=1 sino t0=0
        beq     t0,0,exit   #si t0=0 salto a exit

        #como va a haber llamadas recursivas guardo algunos elementos en stack
#####deberia guardar los elementos en el stack o en el frame???
        addi    sp,sp,-16   #hago espacio para 4 elementos
        sw      ra,12(sp)   #salvo la direcc de retorno
        sw      a2,8(sp)    #salvo el valor del indice izquierdo
        sw      a3,4(sp)    #salvo el valor del indice derecho

####puede haber overflow???(en la linea 2)
        add     s0,a2,a3    #sumo ambos indices
        sra     s0,s0,1     #divido por 2
        sw      s0,0(sp)    #salvo el valor del indice del medio

        addi    a3,s0,0     #establezco el nuevo indice derecho como el indice del medio
        jal     merge_sort  #tomo la primera mitad del vector y aplico merge sort

        lw      s0,0(sp)    #cargo en s0 el valor del indice del medio
        lw      a3,4(sp)    #cargo en a3 el valor del indice derecho
        addi    s0,s0,1     #sumo s0=s0+1
        addi    a2,s0,0     #establezco el nuevo indice izquierdo como el indice del medio
        jal     merge_sort  #tomo la segunda mitad del vector y aplico merge sort

        lw      a2,8(sp)    #cargo en a2 el valor del indice izquierdo
        lw      a3,4(sp)    #cargo en a3 el valor del indice derecho
        lw      s0,0(sp)    #cargo en s0 el valor del indice del medio
        jal     merge       #llamo a la funcion merge para mergear las mitades de vectores

####chequear si todo esto deberia ir ahora o solo jr ra
        lw      ra,12(sp)   #cargo en ra su valor inicial
        move    sp,fp
      	lw      fp,28(sp)
      	addiu   sp,sp,40
      	jr      ra

merge: