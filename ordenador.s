	.file	1 "ordenador.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=xx
	.module	nooddspreg
	.abicalls
	.text
	.align	2
	.globl	ordenar
	.set	nomips16
	.set	nomicromips
	.ent	ordenar
	.type	ordenar, @function
ordenar:
	.frame	$fp,56,$31		# vars= 24, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	move	$fp,$sp
	.cprestore	16
	sw	$4,56($fp)
	sw	$5,60($fp)
	sw	$0,24($fp)
	sw	$0,28($fp)
	sw	$0,32($fp)
	sw	$0,36($fp)
	sw	$0,40($fp)
	b	$L2
	nop

$L5:
	addiu	$3,$fp,40
	addiu	$2,$fp,36
	move	$6,$3
	move	$5,$2
	lw	$4,56($fp)
	lw	$2,%got(leer)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,leer
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,24($fp)
	lw	$3,24($fp)
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L3
	nop

	lw	$2,40($fp)
	lw	$3,36($fp)
	addiu	$4,$fp,32
	move	$6,$4
	move	$5,$3
	move	$4,$2
	lw	$2,%got(pasar_a_enteros)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,pasar_a_enteros
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,28($fp)
	lw	$2,32($fp)
	move	$5,$2
	lw	$4,28($fp)
	lw	$2,%call16(merge_sort)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,merge_sort
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,32($fp)
	lw	$6,60($fp)
	move	$5,$2
	lw	$4,28($fp)
	lw	$2,%got(imprimir_enteros)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,imprimir_enteros
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,28($fp)
	lw	$3,0($2)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L4
	nop

	lw	$3,32($fp)
	li	$2,1			# 0x1
	bne	$3,$2,$L4
	nop

	li	$2,1			# 0x1
	sw	$2,24($fp)
$L4:
	lw	$4,28($fp)
	lw	$2,%call16(free)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,free
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L3:
	lw	$2,40($fp)
	move	$4,$2
	lw	$2,%call16(free)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,free
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L2:
	lw	$2,24($fp)
	beq	$2,$0,$L5
	nop

	lw	$3,24($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L6
	nop

	li	$2,-1			# 0xffffffffffffffff
	b	$L8
	nop

$L6:
	move	$2,$0
$L8:
	move	$sp,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	addiu	$sp,$sp,56
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	ordenar
	.size	ordenar, .-ordenar
	.align	2
	.globl	leer
	.set	nomips16
	.set	nomicromips
	.ent	leer
	.type	leer, @function
leer:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	.cprestore	16
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	li	$2,20			# 0x14
	sw	$2,24($fp)
	lw	$2,24($fp)
	move	$4,$2
	lw	$2,%call16(malloc)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,malloc
1:	jalr	$25
	nop

	lw	$28,16($fp)
	move	$3,$2
	lw	$2,48($fp)
	sw	$3,0($2)
	lw	$2,44($fp)
	sw	$0,0($2)
	li	$2,65			# 0x41
	sb	$2,28($fp)
	b	$L10
	nop

$L15:
	lw	$2,44($fp)
	lw	$3,0($2)
	lw	$2,24($fp)
	addiu	$2,$2,-1
	bne	$3,$2,$L11
	nop

	lw	$2,24($fp)
	addiu	$2,$2,10
	sw	$2,24($fp)
	lw	$2,48($fp)
	lw	$2,0($2)
	lw	$3,24($fp)
	move	$5,$3
	move	$4,$2
	lw	$2,%call16(realloc)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,realloc
1:	jalr	$25
	nop

	lw	$28,16($fp)
	move	$3,$2
	lw	$2,48($fp)
	sw	$3,0($2)
$L11:
	lw	$4,40($fp)
	lw	$2,%call16(_IO_getc)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,_IO_getc
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sb	$2,28($fp)
	lb	$2,28($fp)
	move	$4,$2
	lw	$2,%got(es_caracter_invalido)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,es_caracter_invalido
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L12
	nop

	li	$2,-1			# 0xffffffffffffffff
	b	$L13
	nop

$L12:
	lw	$2,48($fp)
	lw	$2,0($2)
	lw	$3,44($fp)
	lw	$3,0($3)
	addu	$2,$2,$3
	lbu	$3,28($fp)
	sb	$3,0($2)
	lw	$2,44($fp)
	lw	$2,0($2)
	addiu	$3,$2,1
	lw	$2,44($fp)
	sw	$3,0($2)
$L10:
	lb	$3,28($fp)
	li	$2,10			# 0xa
	beq	$3,$2,$L14
	nop

	lb	$3,28($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L15
	nop

$L14:
	lb	$3,28($fp)
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L16
	nop

	lw	$2,44($fp)
	lw	$2,0($2)
	slt	$2,$2,2
	beq	$2,$0,$L17
	nop

$L16:
	li	$2,1			# 0x1
	b	$L13
	nop

$L17:
	move	$2,$0
$L13:
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	leer
	.size	leer, .-leer
	.align	2
	.globl	pasar_a_enteros
	.set	nomips16
	.set	nomicromips
	.ent	pasar_a_enteros
	.type	pasar_a_enteros, @function
pasar_a_enteros:
	.frame	$fp,80,$31		# vars= 40, regs= 3/0, args= 16, gp= 8
	.mask	0xc0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-80
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$16,68($sp)
	move	$fp,$sp
	.cprestore	16
	sw	$4,80($fp)
	sw	$5,84($fp)
	sw	$6,88($fp)
	li	$2,65			# 0x41
	sb	$2,40($fp)
	li	$2,10			# 0xa
	sw	$2,24($fp)
	lw	$2,24($fp)
	sll	$2,$2,2
	move	$4,$2
	lw	$2,%call16(malloc)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,malloc
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,28($fp)
	lw	$2,88($fp)
	sw	$0,0($2)
	sw	$0,32($fp)
	sw	$0,36($fp)
	b	$L19
	nop

$L22:
	lw	$2,88($fp)
	lw	$2,0($2)
	lw	$3,24($fp)
	addiu	$3,$3,-1
	bne	$2,$3,$L20
	nop

	lw	$2,24($fp)
	addiu	$2,$2,10
	sw	$2,24($fp)
	lw	$2,24($fp)
	sll	$2,$2,2
	move	$5,$2
	lw	$4,28($fp)
	lw	$2,%call16(realloc)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,realloc
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,28($fp)
$L20:
	lw	$2,32($fp)
	lw	$3,80($fp)
	addu	$2,$3,$2
	lbu	$2,0($2)
	sb	$2,40($fp)
	lw	$2,32($fp)
	addiu	$2,$2,1
	sw	$2,32($fp)
	lb	$2,40($fp)
	move	$4,$2
	lw	$2,%got(es_numerico)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,es_numerico
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L21
	nop

	lw	$2,36($fp)
	addiu	$3,$fp,24
	addu	$2,$3,$2
	lbu	$3,40($fp)
	sb	$3,20($2)
	lw	$2,36($fp)
	addiu	$2,$2,1
	sw	$2,36($fp)
	b	$L19
	nop

$L21:
	li	$2,1			# 0x1
	sb	$2,40($fp)
	lw	$2,36($fp)
	beq	$2,$0,$L19
	nop

	lw	$2,36($fp)
	addiu	$3,$fp,24
	addu	$2,$3,$2
	sb	$0,20($2)
	lw	$2,88($fp)
	lw	$2,0($2)
	sll	$2,$2,2
	lw	$3,28($fp)
	addu	$16,$3,$2
	addiu	$2,$fp,44
	move	$4,$2
	lw	$2,%call16(atoi)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,atoi
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,0($16)
	lw	$2,88($fp)
	lw	$2,0($2)
	addiu	$3,$2,1
	lw	$2,88($fp)
	sw	$3,0($2)
	sw	$0,36($fp)
$L19:
	lw	$3,32($fp)
	lw	$2,84($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L22
	nop

	lw	$2,28($fp)
	move	$sp,$fp
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$16,68($sp)
	addiu	$sp,$sp,80
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	pasar_a_enteros
	.size	pasar_a_enteros, .-pasar_a_enteros
	.align	2
	.globl	es_fin_de_linea
	.set	nomips16
	.set	nomicromips
	.ent	es_fin_de_linea
	.type	es_fin_de_linea, @function
es_fin_de_linea:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	move	$2,$4
	sb	$2,8($fp)
	lb	$3,8($fp)
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L25
	nop

	lb	$3,8($fp)
	li	$2,10			# 0xa
	bne	$3,$2,$L26
	nop

$L25:
	li	$2,1			# 0x1
	b	$L27
	nop

$L26:
	move	$2,$0
$L27:
	andi	$2,$2,0x1
	andi	$2,$2,0x00ff
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	es_fin_de_linea
	.size	es_fin_de_linea, .-es_fin_de_linea
	.align	2
	.globl	es_numerico
	.set	nomips16
	.set	nomicromips
	.ent	es_numerico
	.type	es_numerico, @function
es_numerico:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	move	$2,$4
	sb	$2,8($fp)
	lb	$2,8($fp)
	slt	$2,$2,48
	bne	$2,$0,$L30
	nop

	lb	$2,8($fp)
	slt	$2,$2,58
	bne	$2,$0,$L31
	nop

$L30:
	lb	$3,8($fp)
	li	$2,45			# 0x2d
	beq	$3,$2,$L31
	nop

	lb	$3,8($fp)
	li	$2,43			# 0x2b
	bne	$3,$2,$L32
	nop

$L31:
	li	$2,1			# 0x1
	b	$L33
	nop

$L32:
	move	$2,$0
$L33:
	andi	$2,$2,0x1
	andi	$2,$2,0x00ff
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	es_numerico
	.size	es_numerico, .-es_numerico
	.align	2
	.globl	es_caracter_invalido
	.set	nomips16
	.set	nomicromips
	.ent	es_caracter_invalido
	.type	es_caracter_invalido, @function
es_caracter_invalido:
	.frame	$fp,32,$31		# vars= 0, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	.cprestore	16
	move	$2,$4
	sb	$2,32($fp)
	lb	$2,32($fp)
	move	$4,$2
	lw	$2,%got(es_numerico)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,es_numerico
1:	jalr	$25
	nop

	lw	$28,16($fp)
	xori	$2,$2,0x1
	andi	$2,$2,0x00ff
	beq	$2,$0,$L36
	nop

	lb	$2,32($fp)
	move	$4,$2
	lw	$2,%got(es_fin_de_linea)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,es_fin_de_linea
1:	jalr	$25
	nop

	lw	$28,16($fp)
	xori	$2,$2,0x1
	andi	$2,$2,0x00ff
	beq	$2,$0,$L36
	nop

	lb	$3,32($fp)
	li	$2,32			# 0x20
	beq	$3,$2,$L36
	nop

	li	$2,1			# 0x1
	b	$L37
	nop

$L36:
	move	$2,$0
$L37:
	andi	$2,$2,0x1
	andi	$2,$2,0x00ff
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	es_caracter_invalido
	.size	es_caracter_invalido, .-es_caracter_invalido
	.rdata
	.align	2
$LC0:
	.ascii	"%i \000"
	.text
	.align	2
	.globl	imprimir_enteros
	.set	nomips16
	.set	nomicromips
	.ent	imprimir_enteros
	.type	imprimir_enteros, @function
imprimir_enteros:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	.cprestore	16
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	lw	$2,44($fp)
	beq	$2,$0,$L44
	nop

	sw	$0,24($fp)
	b	$L42
	nop

$L43:
	lw	$2,24($fp)
	sll	$2,$2,2
	lw	$3,40($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	move	$6,$2
	lw	$2,%got($LC0)($28)
	addiu	$5,$2,%lo($LC0)
	lw	$4,48($fp)
	lw	$2,%call16(fprintf)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fprintf
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,24($fp)
	addiu	$2,$2,1
	sw	$2,24($fp)
$L42:
	lw	$3,24($fp)
	lw	$2,44($fp)
	sltu	$2,$3,$2
	bne	$2,$0,$L43
	nop

	lw	$5,48($fp)
	li	$4,10			# 0xa
	lw	$2,%call16(fputc)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fputc
1:	jalr	$25
	nop

	lw	$28,16($fp)
	b	$L39
	nop

$L44:
	nop
$L39:
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	imprimir_enteros
	.size	imprimir_enteros, .-imprimir_enteros
	.ident	"GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
