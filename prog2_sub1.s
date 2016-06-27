# practise on add,sub,mul,div

	.section .data
answer:	
	.8byte 0
	
	.section .text
	.globl _start
_start:
	movq $1, %rax
	movq $2, %rbx
	addq %rax, %rbx

	movq $20, %rax
	movq $10, %rbx
	subq %rbx, %rax		# subtract %rbx from %rax, and then store the result in %rax

	movq $3, %rax
	movq $7, %rbx
	imulq %rax, %rbx	# multiply %rax with %rbx, and then store the result in %rbx

	movq $4294967296, %rax
	movq $4294967297, %rbx
	imulq %rbx		# %rdx:%rax <= %rax * %rbx

	movq $1, %rdx
	movq $13, %rax
	movq $274177, %rbx
	idivq %rbx		# %rdx:%rax / %rbx
				# %rax ==> quotient
				# %rdx ==> remainder
	movq %rdx, answer

	movq answer, %rbx
	movq $1, %rax
	int $0x80
	
