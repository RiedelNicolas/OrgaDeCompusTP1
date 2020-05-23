#include <sys/regdef.h>
#include <sys/syscall.h>
#include <sys/mymalloc.h>
#include <sys/myfree.h>
#include <sys/merge.h>

        .abicalls
        .text
        .align	2
        .globl merge_sort
        .ent merge_sort


merge_sort:
        .frame fp,40,ra
        subu    sp,sp,40	#4(SRA) + 2(LTA) + 4(ABA)
      	.cprestore 24		#Saved register area.
      	sw      fp,28(sp)	#almaceno valor de fp a 28bytes del sp
      	sw      ra,32(sp)
	move    fp,sp		#fp = sp

      	sw      a0,40(fp)	#salvo *vec
      	sw      a1,44(fp)	#salvo len

      	addi    a2,zero,0	#establezco un valor para el inicio
      	sub     a3,a1,1		#le resto 1 a la longitud del vector y establezco un valor para el final

if_merge_sort:
        slt     t0,a2,a3	#si a2<a3 entonces t0=1 sino t0=0
        beq     t0,0,return	#si t0=0 salto a return

        #como va a haber llamadas recursivas guardo algunos elementos en stack
#####deberia guardar los elementos en el stack o en el frame???
        addi    sp,sp,-16	#hago espacio para 4 elementos
        sw      ra,12(sp)	#salvo la direcc de retorno
        sw      a2,8(sp)	#salvo el valor del inicio
        sw      a3,4(sp)	#salvo el valor del final

####puede haber overflow???(en la linea 2)
        add     s0,a2,a3	#s0 = inicio + final
        sra     s0,s0,1		#divido s0 por 2
        sw      s0,0(sp)	#salvo el valor del medio

        addi    a3,s0,0		#establezco el nuevo final como el medio
        jal     if_merge_sort	#tomo la primera mitad del vector y aplico merge sort

        lw      s0,0(sp)	#cargo en s0 el valor del medio
        lw      a3,4(sp)	#cargo en a3 el valor del final
        addi    s0,s0,1		#sumo s0=s0+1
        addi    a2,s0,0		#establezco el nuevo inicio como el medio
        jal     if_merge_sort	#tomo la segunda mitad del vector y aplico merge sort

        lw      a2,8(sp)	#cargo en a2 el valor del inicio
        lw      a3,4(sp)	#cargo en a3 el valor del final
        lw      a1,0(sp)	#cargo en a1 el valor del medio (piso len)
        jal     merge		#llamo a la funcion merge para mergear las mitades de vectores

	lw      ra,12(sp)	#cargo en ra su valor inicial	
	addi	sp,sp,16	#vuelvo a sp su valor inicial

return:
        lw      ra,32(sp)	
        lw	gp,24(sp)
      	lw      fp,28(sp)
      	addu   sp,sp,40
      	jr      ra

	.end	merge_sort
