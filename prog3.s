# page 42-44
# Program to illustrate how functions work.
# This program will computer the value of 2*3 + 5^2
# Everything in the main program is tored in registers

	.section .data
	.section .text
	.globl _start
_start:
	pushq $3
	pushq $2
	call power
	addq $16, %rsp
	pushq %rax

	pushq $2
	pushq $5
	call power
	addq $16, %rsp

	popq %rbx

	addq %rax, %rbx

	movq $1, %rax
	int $0x80

	.type power, @function
power:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp

	movq 16(%rbp), %rbx
	movq 24(%rbp), %rcx
	movq %rbx, -8(%rbp)

power_loop_start:
	cmpq $1, %rcx
	je end_power

	movq -8(%rbp), %rax
	imulq %rbx, %rax
	movq %rax, -8(%rbp)

	decq %rcx
	jmp power_loop_start

end_power:
	movq -8(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
