#include <sys/regdef.h>
#include <sys/syscall.h>

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

	sub	t0,a1,1		#t0 = len - 1
	move	a2,t0
	move	a1,zero

	jal	merge_sort

	lw      ra,32(sp)	
        lw	gp,24(sp)
      	lw      fp,28(sp)
      	addu   	sp,sp,40
      	jr      ra

	.end	merge_sort





merge_sort_rec:
        .frame fp,40,ra
        subu    sp,sp,40	#4(SRA) + 2(LTA) + 4(ABA)
      	.cprestore 24		#Saved register area.
      	sw      fp,28(sp)	#almaceno valor de fp a 28bytes del sp
      	sw      ra,32(sp)
	move    fp,sp		#fp = sp

      	sw      a0,40(fp)	#salvo *vec
      	sw      a1,44(fp)	#salvo inicio
	sw      a2,48(fp)	#salvo fin

        slt     t0,a1,a2	#si a1<a2 entonces t0=1 sino t0=0
        beq     t0,0,return	#si t0=0 salto a return

####puede haber overflow???(en la linea 2)
        add     t0,a1,a2	#t0 = inicio + final
        sra     t0,t0,1		#t0 = (inicio + final)/2, s0=medio
        sw      t0,16(fp)	#como medio es propio de cada scope se almacena en la LTA

        addi    a2,t0,0		#establezco el medio como nuevo fin
        jal     merge_sort_rec	#tomo la primera mitad del vector y aplico merge sort

        lw      t0,16(fp)	#cargo medio en t0
        lw      a2,48(fp)	#cargo en a2 el valor de fin
        addi    t0,t0,1		#sumo t0=t0+1
        addi    a1,t0,0		#establezco el nuevo inicio como el medio
        jal     merge_sort_rec	#tomo la segunda mitad del vector y aplico merge sort

        lw      a1,44(fp)	#cargo en a1 el valor del inicio
        lw      a2,16(fp)	#cargo en a2 el valor del medio
        lw      a3,48(fp)	#cargo en a3 el valor del final
        jal     merge		#llamo a la funcion merge para mergear las mitades de vectores

return:
        lw      ra,32(sp)	
        lw	gp,24(sp)
      	lw      fp,28(sp)
      	addu   	sp,sp,40
      	jr      ra

	.end	merge_sort_rec






merge:
        .frame fp,40,ra
        subu    sp,sp,40	#4(SRA) + 2(LTA) + 4(ABA)
      	.cprestore 24		#Saved register area.
      	sw      fp,28(sp)	#almaceno valor de fp a 28bytes del sp
      	sw      ra,32(sp)
	move    fp,sp		#fp = sp

      	sw      a0,40(fp)	#salvo *vec
      	sw      a1,44(fp)	#salvo el valor del inicio
	sw      a2,48(fp)	#salvo el valor del medio
	sw	a3,52(fp)	#salvo el valor del final
    
	addi    t0,a1,1		#t0 = inicio + 1
        subu    t0,a2,t0	#t0 = medio - inicio + 1, t0 = tope1 (longitud del primer vector)
	sll	a0,t0,2		#a0 = tope1*4, (4 = sizeof(int))
        jal     mymalloc	#devuelve en la posicion v0 un puntero a una direccion con espacio para guardar el vector aux1    
        addi    t2,v0,0		#t2 = aux1
        
	subu    t1,a3,a2	#t1 = fin - medio, t1 = tope2 (longitud del segundo vector)
	sll	a0,t1,2		#a0 = tope2*4
        jal     mymalloc	#devuelve en la posicion v0 un puntero a una direccion con espacio para guardar el vector aux2
        addi    t3,v0,0		#t3 = aux2

        lw      a0,40(fp)
	lw      a1,44(fp)	
	lw      a2,48(fp)	
	lw	a3,52(fp)		

	move    t4,zero		#t4 = 0, t4 = i





for_loop:

        slt     t5,t4,t0	#si t4<tope1 entonces t5=1 sino t5=0
        beq     t5,0,pre_loop   #si t5==0 salto a pre_loop
        
	addu	t5,a1,t4	#t5 = inicio + i
	sll	t5,t5,2		#escalo t5
	addu	t6,a0,t5	#t6 = vec + (inicio+i) escalado
	lw	t6,0(t6)	#t6 = vec[inicio+i]	esto puede fallar

	sll	t5,t4,2			
	addu	t7,t2,t5	#t7 = aux1 + i escalado
	lw	t7,0(t7)	#t7 = aux1[i]		esto puede fallar	
        
	sw	t6,0(t7)	#aux1[i] = vec[inicio+i]

	addu    t4,t4,1		#i++
        b       for_loop





pre_loop:
	move    t4,zero		#t4 = 0, t4 = i
       
for_loop2:

        slt     t5,t4,t1	#si t4<tope1 entonces t5=1 sino t5=0
        beq     t5,0,pre_loop_2 #si t5==0 salto a pre_loop_2
        
	addu	t5,t4,1		#t5 = i + 1
	addu	t5,t5,a2	#t5 = medio + i + 1 
	sll	t5,t5,2		#escalo t5
	addu	t6,a0,t5	#t6 = vec + (medio+i+1) escalado
	lw	t6,0(t6)	#t6 = vec[medio+i+1]	esto puede fallar

	sll	t5,t4,2			
	addu	t7,t3,t5	#t7 = aux2 + i escalado
	lw	t7,0(t7)	#t7 = aux2[i]		esto puede fallar	
        
	sw	t6,0(t7)	#aux2[i] = vec[medio+i+1]

	addu    t4,t4,1		#i++
        b       for_loop_2





pre_loop_2:
	sw	t0,16(fp)	#guardo tope1 en 16(fp), debería hacer esto antes del for
	sw	t1,20(fp)	#guardo tope2 en 20(fp), debería hacer esto antes del for
	move    t4,zero		#t4 = 0, t4 = i
	move    t5,zero		#t5 = 0, t5 = j
	move	t6,a1		#t6 = inicio, t6 = k

while1:
	lw	t0,16(fp)
	lw	t1,20(fp)
       
       	ble     t0,t4,pre_loop_3 	#si tope1 <= i salto a pre_loop_3
       	ble     t1,t5,pre_loop_3 	#si tope2 <= j salto a pre_loop_3
 
if:
       	sll     t0,t4,2		#escalo i: t0 = i*4
       	addu    t0,t2,t0	#t0 = direccion de aux1[i]
       	lw      t0,0(t0)	#cargo el valor de aux1[i] en t0, puede fallar
       
       	sll     t1,t5,2		#escalo j: t1 = j*4
       	addu    t1,t3,t1	#t1 = direccion de aux2[j]
       	lw      t1,0(t1)	#cargo el valor de aux2[j] en t1, puede fallar

       	sll     t7,t6,2		#escalo k: t6 = k*4
       	addu    t7,a0,t7	#t6 = direccion de vec[k]
       
       	blt     t1,t0,else	#si aux2[j]<aux1[i] salto a else

       	sw      t0,0(t7)	#vec[k]=aux1[i]
       	addi    t4,t4,1		#i++
       	addi    t6,t6,1		#k++
       	b       while1
       
else:
       	sw      t1,0(t7)	#vec[k]=aux2[j]
       	addi    t5,t5,1		#j++
       	addi    t6,t6,1		#k++
       	b       while1





pre_loop_3:
	lw	t0,16(fp)

while2:
	ble	t0,t4,pre_loop_4 #si tope1<=i salto a pre_loop_4
	
	sll     t1,t4,2		#escalo i: t0 = i*4
       	addu    t1,t2,t1	#t0 = direccion de aux1[i]
       	lw      t1,0(t1)	#cargo el valor de aux1[i] en t1
	
	sll     t7,t6,2		#escalo k: t6 = k*4
       	addu    t7,a0,t7	#t6 = direccion de vec[k]
	sw      t1,0(t7)	#vec[k]=aux1[i]

	addi    t4,t4,1		#i++
       	addi    t6,t6,1		#k++
	b 	while2





pre_loop_4:
	lw	t1,20(fp)

while3:
	ble	t1,t5,_return	#si tope2<=j salto a _return
	
	sll	t0,t5,2		#escalo j: t0 = j*4
	addu    t0,t3,t0	#t1 = direccion de aux2[j]
       	lw      t0,0(t0)	#cargo el valor de aux2[j] en t1, puede fallar
	
	sll     t7,t6,2		#escalo k: t6 = k*4
       	addu    t7,a0,t7	#t6 = direccion de vec[k]
	sw      t0,0(t7)	#vec[k]=aux1[i]
       
	addi	t5,t5,1		#j++
	addi	t6,t6,1		#k++
	b	while3

_return:
	move	a0,t2		#a0 = aux1
	jal	myfree		#libero memoria de aux1[]
	move	a0,t3		#a0 = aux2
	jal	myfree		#libero memoria de aux2[]
	lw      ra,32(sp)	


        lw	gp,24(sp)
      	lw      fp,28(sp)
      	addu	sp,sp,40
      	jr      ra

	.end	merge
