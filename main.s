	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=xx
	.module	nooddspreg
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"comandos/help.txt\000"
	.align	2
$LC1:
	.ascii	"comandos/version.txt\000"
	.align	2
$LC2:
	.ascii	"\012El comando usado es invalido, use -h para ayuda\000"
	.align	2
$LC3:
	.ascii	"-\000"
	.align	2
$LC4:
	.ascii	"r\000"
	.align	2
$LC5:
	.ascii	"w\000"
	.align	2
$LC6:
	.ascii	"\012 No se pudo ordenar, el input no tiene el formato re"
	.ascii	"querido\000"
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,48,$31		# vars= 16, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$fp,40($sp)
	move	$fp,$sp
	.cprestore	16
	sw	$4,48($fp)
	sw	$5,52($fp)
	sw	$0,24($fp)
	sw	$0,28($fp)
	li	$2,-1			# 0xffffffffffffffff
	sw	$2,32($fp)
	lw	$3,48($fp)
	li	$2,2			# 0x2
	bne	$3,$2,$L2
	nop

	lw	$2,52($fp)
	addiu	$2,$2,4
	lw	$2,0($2)
	move	$4,$2
	lw	$2,%got(es_comando_ayuda)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,es_comando_ayuda
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L3
	nop

	lw	$2,%got($LC0)($28)
	addiu	$4,$2,%lo($LC0)
	lw	$2,%got(mostrar_en_pantalla)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,mostrar_en_pantalla
1:	jalr	$25
	nop

	lw	$28,16($fp)
	b	$L4
	nop

$L3:
	lw	$2,52($fp)
	addiu	$2,$2,4
	lw	$2,0($2)
	move	$4,$2
	lw	$2,%got(es_comando_version)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,es_comando_version
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L5
	nop

	lw	$2,%got($LC1)($28)
	addiu	$4,$2,%lo($LC1)
	lw	$2,%got(mostrar_en_pantalla)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,mostrar_en_pantalla
1:	jalr	$25
	nop

	lw	$28,16($fp)
	b	$L4
	nop

$L5:
	lw	$2,%got($LC2)($28)
	addiu	$4,$2,%lo($LC2)
	lw	$2,%call16(perror)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,perror
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L4
	nop

$L2:
	lw	$3,48($fp)
	li	$2,5			# 0x5
	bne	$3,$2,$L6
	nop

	lw	$2,52($fp)
	addiu	$2,$2,4
	lw	$2,0($2)
	move	$4,$2
	lw	$2,%got(es_comando_input)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,es_comando_input
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L7
	nop

	lw	$2,52($fp)
	addiu	$2,$2,12
	lw	$2,0($2)
	move	$4,$2
	lw	$2,%got(es_comando_output)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,es_comando_output
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L7
	nop

	lw	$2,52($fp)
	addiu	$2,$2,8
	lw	$3,0($2)
	lw	$2,%got($LC3)($28)
	addiu	$5,$2,%lo($LC3)
	move	$4,$3
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L8
	nop

	lw	$2,%got(stdin)($28)
	lw	$2,0($2)
	sw	$2,24($fp)
	b	$L9
	nop

$L8:
	lw	$2,52($fp)
	addiu	$2,$2,8
	lw	$3,0($2)
	lw	$2,%got($LC4)($28)
	addiu	$5,$2,%lo($LC4)
	move	$4,$3
	lw	$2,%call16(fopen)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fopen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,24($fp)
	lw	$2,24($fp)
	bne	$2,$0,$L9
	nop

	lw	$2,52($fp)
	addiu	$2,$2,8
	lw	$2,0($2)
	move	$4,$2
	lw	$2,%got(notificar_problema_ruta)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,notificar_problema_ruta
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L4
	nop

$L9:
	lw	$2,52($fp)
	addiu	$2,$2,16
	lw	$3,0($2)
	lw	$2,%got($LC3)($28)
	addiu	$5,$2,%lo($LC3)
	move	$4,$3
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L10
	nop

	lw	$2,%got(stdout)($28)
	lw	$2,0($2)
	sw	$2,28($fp)
	b	$L11
	nop

$L10:
	lw	$2,52($fp)
	addiu	$2,$2,16
	lw	$3,0($2)
	lw	$2,%got($LC5)($28)
	addiu	$5,$2,%lo($LC5)
	move	$4,$3
	lw	$2,%call16(fopen)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fopen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,28($fp)
	lw	$2,28($fp)
	bne	$2,$0,$L11
	nop

	lw	$2,52($fp)
	addiu	$2,$2,16
	lw	$2,0($2)
	move	$4,$2
	lw	$2,%got(notificar_problema_ruta)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,notificar_problema_ruta
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L4
	nop

$L11:
	lw	$5,28($fp)
	lw	$4,24($fp)
	lw	$2,%call16(ordenar)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,ordenar
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,32($fp)
	lw	$2,%got(stdout)($28)
	lw	$2,0($2)
	lw	$3,28($fp)
	beq	$3,$2,$L12
	nop

	lw	$4,28($fp)
	lw	$2,%call16(fclose)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fclose
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L12:
	lw	$2,%got(stdin)($28)
	lw	$2,0($2)
	lw	$3,24($fp)
	beq	$3,$2,$L15
	nop

	lw	$4,24($fp)
	lw	$2,%call16(fclose)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fclose
1:	jalr	$25
	nop

	lw	$28,16($fp)
	b	$L15
	nop

$L7:
	lw	$2,%got($LC2)($28)
	addiu	$4,$2,%lo($LC2)
	lw	$2,%call16(perror)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,perror
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L4
	nop

$L6:
	lw	$2,%got($LC2)($28)
	addiu	$4,$2,%lo($LC2)
	lw	$2,%call16(perror)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,perror
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L4
	nop

$L15:
	lw	$3,32($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L16
	nop

	lw	$2,%got($LC6)($28)
	addiu	$4,$2,%lo($LC6)
	lw	$2,%call16(perror)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,perror
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L4
	nop

$L16:
	move	$2,$0
$L4:
	move	$sp,$fp
	lw	$31,44($sp)
	lw	$fp,40($sp)
	addiu	$sp,$sp,48
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.rdata
	.align	2
$LC7:
	.ascii	"--help\000"
	.align	2
$LC8:
	.ascii	"-h\000"
	.text
	.align	2
	.globl	es_comando_ayuda
	.set	nomips16
	.set	nomicromips
	.ent	es_comando_ayuda
	.type	es_comando_ayuda, @function
es_comando_ayuda:
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
	sw	$4,32($fp)
	lw	$2,%got($LC7)($28)
	addiu	$5,$2,%lo($LC7)
	lw	$4,32($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L18
	nop

	lw	$2,%got($LC8)($28)
	addiu	$5,$2,%lo($LC8)
	lw	$4,32($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L19
	nop

$L18:
	li	$2,1			# 0x1
	b	$L20
	nop

$L19:
	move	$2,$0
$L20:
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
	.end	es_comando_ayuda
	.size	es_comando_ayuda, .-es_comando_ayuda
	.rdata
	.align	2
$LC9:
	.ascii	"--version\000"
	.align	2
$LC10:
	.ascii	"-V\000"
	.text
	.align	2
	.globl	es_comando_version
	.set	nomips16
	.set	nomicromips
	.ent	es_comando_version
	.type	es_comando_version, @function
es_comando_version:
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
	sw	$4,32($fp)
	lw	$2,%got($LC9)($28)
	addiu	$5,$2,%lo($LC9)
	lw	$4,32($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L23
	nop

	lw	$2,%got($LC10)($28)
	addiu	$5,$2,%lo($LC10)
	lw	$4,32($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L24
	nop

$L23:
	li	$2,1			# 0x1
	b	$L25
	nop

$L24:
	move	$2,$0
$L25:
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
	.end	es_comando_version
	.size	es_comando_version, .-es_comando_version
	.rdata
	.align	2
$LC11:
	.ascii	"--input\000"
	.align	2
$LC12:
	.ascii	"-i\000"
	.text
	.align	2
	.globl	es_comando_input
	.set	nomips16
	.set	nomicromips
	.ent	es_comando_input
	.type	es_comando_input, @function
es_comando_input:
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
	sw	$4,32($fp)
	lw	$2,%got($LC11)($28)
	addiu	$5,$2,%lo($LC11)
	lw	$4,32($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L28
	nop

	lw	$2,%got($LC12)($28)
	addiu	$5,$2,%lo($LC12)
	lw	$4,32($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L29
	nop

$L28:
	li	$2,1			# 0x1
	b	$L30
	nop

$L29:
	move	$2,$0
$L30:
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
	.end	es_comando_input
	.size	es_comando_input, .-es_comando_input
	.rdata
	.align	2
$LC13:
	.ascii	"--output\000"
	.align	2
$LC14:
	.ascii	"-o\000"
	.text
	.align	2
	.globl	es_comando_output
	.set	nomips16
	.set	nomicromips
	.ent	es_comando_output
	.type	es_comando_output, @function
es_comando_output:
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
	sw	$4,32($fp)
	lw	$2,%got($LC13)($28)
	addiu	$5,$2,%lo($LC13)
	lw	$4,32($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	beq	$2,$0,$L33
	nop

	lw	$2,%got($LC14)($28)
	addiu	$5,$2,%lo($LC14)
	lw	$4,32($fp)
	lw	$2,%call16(strcmp)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcmp
1:	jalr	$25
	nop

	lw	$28,16($fp)
	bne	$2,$0,$L34
	nop

$L33:
	li	$2,1			# 0x1
	b	$L35
	nop

$L34:
	move	$2,$0
$L35:
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
	.end	es_comando_output
	.size	es_comando_output, .-es_comando_output
	.rdata
	.align	2
$LC15:
	.ascii	"\012 no se pudo abrir el archivo \012\000"
	.text
	.align	2
	.globl	mostrar_en_pantalla
	.set	nomips16
	.set	nomicromips
	.ent	mostrar_en_pantalla
	.type	mostrar_en_pantalla, @function
mostrar_en_pantalla:
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
	lw	$2,%got($LC4)($28)
	addiu	$5,$2,%lo($LC4)
	lw	$4,40($fp)
	lw	$2,%call16(fopen)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fopen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,28($fp)
	lw	$2,28($fp)
	bne	$2,$0,$L38
	nop

	lw	$2,%got($LC15)($28)
	addiu	$4,$2,%lo($LC15)
	lw	$2,%call16(perror)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,perror
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
	b	$L39
	nop

$L38:
	li	$2,97			# 0x61
	sb	$2,24($fp)
	b	$L40
	nop

$L41:
	lw	$4,28($fp)
	lw	$2,%call16(fgetc)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fgetc
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sb	$2,24($fp)
	lb	$3,24($fp)
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L40
	nop

	lb	$3,24($fp)
	lw	$2,%got(stdout)($28)
	lw	$2,0($2)
	move	$5,$2
	move	$4,$3
	lw	$2,%call16(_IO_putc)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,_IO_putc
1:	jalr	$25
	nop

	lw	$28,16($fp)
$L40:
	lb	$3,24($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L41
	nop

	lw	$4,28($fp)
	lw	$2,%call16(fclose)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fclose
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,-1			# 0xffffffffffffffff
$L39:
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	mostrar_en_pantalla
	.size	mostrar_en_pantalla, .-mostrar_en_pantalla
	.rdata
	.align	2
$LC16:
	.ascii	"\012El archivo en la ruta: \000"
	.align	2
$LC17:
	.ascii	". No se pudo abrir correctamente\000\000"
	.text
	.align	2
	.globl	notificar_problema_ruta
	.set	nomips16
	.set	nomicromips
	.ent	notificar_problema_ruta
	.type	notificar_problema_ruta, @function
notificar_problema_ruta:
	.frame	$fp,184,$31		# vars= 152, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-184
	sw	$31,180($sp)
	sw	$fp,176($sp)
	move	$fp,$sp
	.cprestore	16
	sw	$4,184($fp)
	lw	$2,%got($LC16)($28)
	lw	$8,%lo($LC16)($2)
	addiu	$3,$2,%lo($LC16)
	lw	$7,4($3)
	addiu	$3,$2,%lo($LC16)
	lw	$6,8($3)
	addiu	$3,$2,%lo($LC16)
	lw	$5,12($3)
	addiu	$3,$2,%lo($LC16)
	lw	$4,16($3)
	addiu	$3,$2,%lo($LC16)
	lw	$3,20($3)
	sw	$8,24($fp)
	sw	$7,28($fp)
	sw	$6,32($fp)
	sw	$5,36($fp)
	sw	$4,40($fp)
	sw	$3,44($fp)
	addiu	$2,$2,%lo($LC16)
	lbu	$2,24($2)
	sb	$2,48($fp)
	lw	$5,184($fp)
	addiu	$2,$fp,24
	move	$4,$2
	lw	$2,%call16(strcat)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strcat
1:	jalr	$25
	nop

	lw	$28,16($fp)
	addiu	$2,$fp,24
	move	$4,$2
	lw	$2,%call16(strlen)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,strlen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	move	$3,$2
	addiu	$2,$fp,24
	addu	$3,$2,$3
	lw	$2,%got($LC17)($28)
	move	$4,$3
	addiu	$2,$2,%lo($LC17)
	li	$3,33			# 0x21
	move	$6,$3
	move	$5,$2
	lw	$2,%call16(memcpy)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,memcpy
1:	jalr	$25
	nop

	lw	$28,16($fp)
	addiu	$2,$fp,24
	move	$4,$2
	lw	$2,%call16(perror)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,perror
1:	jalr	$25
	nop

	lw	$28,16($fp)
	nop
	move	$sp,$fp
	lw	$31,180($sp)
	lw	$fp,176($sp)
	addiu	$sp,$sp,184
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	notificar_problema_ruta
	.size	notificar_problema_ruta, .-notificar_problema_ruta
	.ident	"GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
