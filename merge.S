#include <sys/regdef.h>
#include <sys/syscall.h>
#include <sys/mymalloc.h>
#include <sys/myfree.h>

        .abicalls
        .text
        .align	2
        .globl merge
        .ent merge

merge:
        .frame fp,40,ra
        subu    sp,sp,40	#4(SRA) + 2(LTA) + 4(ABA)
      	.cprestore 24		#Saved register area.
      	sw      fp,28(sp)	#almaceno valor de fp a 28bytes del sp
      	sw      ra,32(sp)
	move    fp,sp		#fp = sp

      	sw      a0,40(fp)	#salvo *vec
      	sw      a1,44(fp)	#salvo el valor del medio
	sw      a2,48(fp)	#salvo el valor del inicio
	sw	a3,52(fp)	#salvo el valor del final

####deberia guardar en tx o en sx??? IMPORTANTE: segun ABI todos los s_x se tienen que devolver por SRA asique chequear si el uso es correcto       
	addi    s1,a2,1		#s1= inicio +1
        sub     s1,a1,s1	#s1 = tope1(la longitud del primer vector)
	sll	a0,s1,2		#a0 = tope1*4
        jal     mymalloc	#me devuelve en la posicion v0 un puntero a una direccion con espacio para guardar el vector aux1[]    
        addi    s2,v0,0		#s2 = puntero a aux1[]
        
	sub     s3,a3,a1	#s3 = tope2(la longitud del segundo vector)
	sll	a0,s3,2		#a0 = tope2*4
        jal     mymalloc	#me devuelve en la posicion v0 un puntero a una direccion con espacio para guardar el vector aux2[]
        addi    s4,v0,0		#s4 = puntero a aux2[]
        lw      a0,40(fp)

for_loop:
        move    t0,zero		#i=0: t0
        sw      t0,0(fp)	#i:t0

        slt     t1,t0,s1	#si t0<tope1 entonces t1=1 sino t1=0
        beq     t1,0,for_loop2  #si t1=0 salto a exit_loop
        
        addi    t2,s2,t0	#t2=aux1[i]	
        addi    t3,a0,t0	#t3=vec[i]
        addi    t2,t3,0		#aux1[i]=vec[i]
        addu    t0,t0,1		#i++
        j       for_loop

#sale del primer for para entrar en el segundo for        
for_loop2:
        move    t0,zero		#j=0: t0
        sw      t0,0(fp)	#j:t0
        
        slt     t1,t0,s3	#si t0<tope2 entonces t1=1 sino t1=0
        beq     t1,0,while1	#si t1=0 salto a while1
        
        addi    t2,s4,t0	#t2=aux2[j]
        addi    t3,a1,1		#t3=vec[medio+1]
        addi    t3,t3,t0	#t3=vec[medio+1+j]
        addi    t2,t3,0		#aux2[j]=vec[medio+1+j]
        addu    t0,t0,1		#j++
        j       for_loop2 
        
while1:
####estoy bastante segura que estoy usando registros de mas pero por ahora no me quiero pisar
       add      s5,zero,0	#s5 = i = 0 (indice de comienzo del primer vector)
       addi     s6,zero,0	#s6 = j = 0 (indice de comienzo del segundo vector)
       add      s7,a2,zero	#s7 = k = inicio (indice de comienzo del vector mergeado)
       
       ble      s1,s5,while2    #si tope1 <= i salto a while 2
       ble      s3,s6,while2    #si tope2 <= j salto a while 2
       j        if              #si i<tope1 && j<tope2 salto a if
       
if:
       sll      t0,s5,2		#escalo i: t0 = i*4
       addu     t0,s2,t0	#t0 = direccion de aux1[i]
       lw       t1,0(t0)	#cargo el valor de aux1[i] en t1
       
       sll      t2,s6,2		#escalo j: t2 = j*4
       addu     t2,s4,t2	#t2 = direccion de aux2[j]
       lw       t3,0(t2)	#cargo el valor de aux2[j] en t3
       
       blt      t3,t1,else	#si aux2[j]<aux1[i] salto a else
       
       sll      t4,s7,2		#escalo k: t4 = k*4
       addu     t4,a0,t4	#t4 = direccion de vec[k]
       sw       t1,0(t4)	#vec[k]=aux1[i]
       
       addi     s5,s5,1		#i++
       addi     s7,s7,1		#k++
       j        while1
       
else:
       sll      t0,s6,2		#escalo j: t0 = j*4
       addu     t0,s4,t0	#t0 = direccion de aux2[j]
       lw       t1,0(t0)	#cargo el valor de aux2[j] en t1
       
       sll      t2,s7,2		#escalo k: t2 = k*4
       addu     t2,a0,t2	#t2 = direccion de vec[k]
       sw       t1,0(t2)	#vec[k]=aux2[j]
       
       addi     s6,s6,1		#j++
       addi     s7,s7,1		#k++
       j        while1

while2:
	ble	s1,s5,while3	#si i>=tope1 salto a while3
	
	sll	t0,s5,2		#escalo i: t0 = i*4
	addu	t0,s2,t0	#t0 = direccion de aux1[i]
	lw	t1,0(t0)	#cargo el valor de aux1[i] en t1
	
	sll	t2,s7,2		#escalo k: t2 = k*4
	addu	t2,a0,t2	#t2 = direccion de vec[k]
	sw	t1,0(t2)	#vec[k]=aux1[i]
       
	addi	s5,s5,1		#i++
	addi	s7,s7,1		#k++
	
	j while2

while3:
	ble	s1,s6,while3	#si i>=tope1 salto a while3
	
	sll	t0,s6,2		#escalo j: t0 = j*4
	addu	t0,s4,t0	#t0 = direccion de aux2[j]
	lw	t1,0(t0)	#cargo el valor de aux2[j] en t1
	
	sll	t2,s7,2		#escalo k: t2 = k*4
	addu	t2,a0,t2	#t2 = direccion de vec[k]
	sw	t1,0(t2)	#vec[k]=aux2[j]
       
	addi	s6,s6,1		#j++
	addi	s7,s7,1		#k++

return:
	sll	a0,s1,2		#a0 = tope1*4
	jal	myfree		#libero memoria de aux1[]
	sll	a0,s3,2		#a0 = tope2*4
	jal	myfree		#libero memoria de aux2[]
	lw      ra,32(sp)	
        lw	gp,24(sp)
      	lw      fp,28(sp)
      	addu	sp,sp,40
      	jr      ra

	.end	merge