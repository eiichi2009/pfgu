# page 46-48
# Given a number, this program computes the factorial.
# For example, the factorial of 3 is 3 * 2 * 1	
# This program shows how to call a function recursively.
	
	.section .data
	.section .text
	.globl _start
_start:
	pushq %rbp
	movq %rsp, %rbp
	
	pushq $4
	call factorial
	addq $8, %rsp
	movq %rax, %rbx
	movq $1, %rax
	int $0x80

	.type factorial, @function
factorial:
	pushq %rbp
	movq %rsp, %rbp
	movq 16(%rbp), %rax
	cmpq $1, %rax
	je end_factorial

	decq %rax
	pushq %rax
	call factorial
	movq 16(%rbp), %rbx
	imulq %rbx, %rax

end_factorial:
	movq %rbp, %rsp
	popq %rbp
	ret
