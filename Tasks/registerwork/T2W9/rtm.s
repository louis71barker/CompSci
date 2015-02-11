	.file	"rtm.c"
	.section	.rodata
.LC0:
	.string	"R%d:%x\t"
.LC1:
	.string	"X1:%x\t"
.LC2:
	.string	"X2:%x\t"
	.text
.globl printReg
	.type	printReg, @function
printReg:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$0, -4(%ebp)
	jmp	.L2
.L3:
	movl	-4(%ebp), %eax
	movl	reg(,%eax,4), %eax
	movl	%eax, 8(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	addl	$1, -4(%ebp)
.L2:
	cmpl	$3, -4(%ebp)
	jle	.L3
	movl	reg+16, %eax
	movl	%eax, 4(%esp)
	movl	$.LC1, (%esp)
	call	printf
	movl	reg+20, %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	$10, (%esp)
	call	putchar
	leave
	ret
	.size	printReg, .-printReg
	.section	.rodata
.LC3:
	.string	"%d\t%x  \t"
.LC4:
	.string	"\n\r"
	.text
.globl printRomVal
	.type	printRomVal, @function
printRomVal:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	8(%ebp), %eax
	movl	rom(,%eax,4), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC3, (%esp)
	call	printf
	movl	$32, -4(%ebp)
	jmp	.L13
.L8:
	movl	8(%ebp), %eax
	movl	rom(,%eax,4), %eax
	movl	-4(%ebp), %ecx
	sarl	%cl, %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L9
	movl	$42, (%esp)
	call	putchar
	jmp	.L7
.L9:
	movl	$46, (%esp)
	call	putchar
.L7:
.L13:
	cmpl	$0, -4(%ebp)
	setg	%al
	subl	$1, -4(%ebp)
	testb	%al, %al
	jne	.L8
	movl	$.LC4, (%esp)
	call	printf
	leave
	ret
	.size	printRomVal, .-printRomVal
	.section	.rodata
.LC5:
	.string	"transfer %d->%d\n"
	.text
.globl main
	.type	main, @function
main:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%ecx
	subl	$48, %esp
	movl	$0, -24(%ebp)
	jmp	.L15
.L16:
	movl	-24(%ebp), %eax
	movl	$-2147483648, rom(,%eax,4)
	addl	$1, -24(%ebp)
.L15:
	cmpl	$99, -24(%ebp)
	jle	.L16
	movl	$0, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	$36, rom(,%eax,4)
	addl	$1, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	$37, rom(,%eax,4)
	addl	$1, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	$82, rom(,%eax,4)
	addl	$1, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	$-2147483648, rom(,%eax,4)
	addl	$1, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	$536870912, rom(,%eax,4)
	addl	$1, -24(%ebp)
	movl	$0, -24(%ebp)
	jmp	.L18
.L19:
	movl	-24(%ebp), %ebx
	call	random
	andl	$255, %eax
	movl	%eax, reg(,%ebx,4)
	addl	$1, -24(%ebp)
.L18:
	cmpl	$5, -24(%ebp)
	jle	.L19
	movl	$1, reg
	movl	$1, reg+4
	movl	$0, -24(%ebp)
	call	printReg
.L21:
	movl	-24(%ebp), %eax
	movl	%eax, (%esp)
	call	printRomVal
	movl	-24(%ebp), %eax
	movl	rom(,%eax,4), %eax
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	jns	.L22
	movl	$0, -28(%ebp)
	jmp	.L24
.L22:
	movl	-20(%ebp), %eax
	andl	$536870912, %eax
	testl	%eax, %eax
	je	.L25
	movl	-24(%ebp), %eax
	movl	rom(,%eax,4), %eax
	andl	$65535, %eax
	subl	$1, %eax
	movl	%eax, -24(%ebp)
	jmp	.L27
.L25:
	movl	-20(%ebp), %eax
	sarl	$4, %eax
	andl	$15, %eax
	movl	%eax, -16(%ebp)
	movl	-20(%ebp), %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC5, (%esp)
	call	printf
	movl	-16(%ebp), %eax
	movl	%eax, -32(%ebp)
	cmpl	$4, -32(%ebp)
	je	.L29
	cmpl	$5, -32(%ebp)
	je	.L30
	jmp	.L28
.L29:
	movl	-12(%ebp), %ecx
	movl	reg+16, %edx
	movl	reg+20, %eax
	leal	(%edx,%eax), %eax
	movl	%eax, reg(,%ecx,4)
	call	random
	andl	$15, %eax
	movl	%eax, reg+16
	call	random
	andl	$15, %eax
	movl	%eax, reg+20
	jmp	.L31
.L30:
	movl	-12(%ebp), %ecx
	movl	reg+16, %edx
	movl	reg+20, %eax
	movl	%edx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	movl	%eax, reg(,%ecx,4)
	call	random
	andl	$15, %eax
	movl	%eax, reg+16
	call	random
	andl	$15, %eax
	movl	%eax, reg+20
	jmp	.L31
.L28:
	movl	-12(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	reg(,%edx,4), %edx
	movl	%edx, reg(,%eax,4)
.L31:
	call	printReg
.L27:
	addl	$1, -24(%ebp)
	movl	$5, (%esp)
	call	sleep
	cmpl	$0, -24(%ebp)
	js	.L32
	cmpl	$99, -24(%ebp)
	jle	.L21
.L32:
	movl	$-1, -28(%ebp)
.L24:
	movl	-28(%ebp), %eax
	addl	$48, %esp
	popl	%ecx
	popl	%ebx
	popl	%ebp
	leal	-4(%ecx), %esp
	ret
	.size	main, .-main
	.comm	reg,24,4
	.comm	rom,400,32
	.ident	"GCC: (GNU) 4.1.2 (Ubuntu 4.1.2-0ubuntu4)"
	.section	.note.GNU-stack,"",@progbits
