# page 13
# Simple program that exits and returns a status code back to the Linux kernel
# Status code is stored in %rbx	

	.section .data

	.section .text

	.globl _start
_start:	
	movq $1, %rax
	movq $0, %rbx
	int $0x80
