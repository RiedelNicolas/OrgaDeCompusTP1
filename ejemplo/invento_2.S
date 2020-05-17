#include <sys/regdef.h>
#include <sys/syscall.h>

        .text
        .ent multiplicar_2
        .globl multiplicar_2

        multiplicar_2:

        .frame 	fp,40,ra

        subu 	sp,sp,40 	#Stack frame creation

      	.cprestore 24		#Saved register area.
      	sw	ra,32(sp)
      	sw	fp,28(sp)	#almaceno valor de fp a 28bytes del sp
      	move	fp,sp    #fp = sp

       	jal 	multiplicar

        lw	ra,32(sp)
        lw	fp,28(sp)
        addu	sp,sp,40

        jr	ra
        .end 	multiplicar_2
