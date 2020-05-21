#include <sys/regdef.h>
#include <sys/syscall.h>
#include <sys/mymalloc.h>
#include <sys/myfree.h>

        .abicalls
        .text
        .align	2
        .globl merge_sort
        .ent merge_sort

main:
#### en esta primera y segunda linea chequear el 44?
        .frame fp,44,ra
        subu    sp,sp,44    #creacion stack frame
      	.cprestore 24   #Saved register area.
      	sw      ra,32(sp)
      	sw      fp,28(sp)   #almaceno valor de fp a 28bytes del sp
      	move    fp,sp       #fp = sp

      	sw      a0,40(fp)   #salvo *vec
      	sw      a1,44(fp)   #salvo len

      	addi    a2,a0,0     #establezco un valor para el indice izquierdo
      	sub     a3,a1,1     #le resto 1 a la longitud del vector
      	sll     a3,a3,2     #multiplico la longitud del vector por 4 (el tamaño de los elementos)
      	add     a3,a0,a3    #establezco un valor para el indice derecho
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
        lw      a3,4(sp)    #cargo en a1 el valor del indice derecho
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
####deberia guardar en tx o en sx???
        addi    s1,a2,1
        sub     s1,s0,s1    #guardo en s1 la longitud del primer vector
        sub     s2,a3,s0    #guardo en s2 la longitud del segundo vector
####arreglar los parametros para pasarle a mymalloc y ver en donde devuleve los resultados
        jal     mymalloc    #me devuelve en la posicion p1 un puntero a una direccion con espacio para guardar el vector L[s1]    
        addi    s3,p1,1
        jal     mymalloc    #me devuelve en la posicion p1 un puntero a una direccion con espacio para guardar el vector R[s2]
        addi    s4,p1,1

for_loop:
        move    t0,zero     #i=0: t0
        sw      t0,0(fp)    #i:t0

        slt     t1,t0,s1    #si t0<s1 entonces t1=1 sino t1=0
        beq     t1,0,exit_loop  #si t1=0 salto a exit_loop
        
        addi    t2,s3,t0    #t2=L[i]
        lw      a0,40(fp)   #creo que redundante
        addi    t3,a0,t0    #t3=vec[i]
        addi    t2,t3,0     #L[i]=vec[i]
        addu    t0,t0,1     #i++

#sale del primer for para entrar en el segundo for        
exit_loop:
        move    t0,zero     #j=0: t0
        sw      t0,0(fp)    #j:t0
        
        slt     t1,t0,s2    #si t0<s2 entonces t1=1 sino t1=0
        beq     t1,0,while1  #si t1=0 salto a while1
        
        addi    t2,s4,t0    #t2=R[j]
        addi    t3,s0,1     #t3=vec[medio+1]
        addi    t3,t3,t0    #t3=vec[medio+1+j]
        addi    t2,t3,0     #R[j]=vec[medio+1+j]
        addu    t0,t0,1     #j++
        
while1: