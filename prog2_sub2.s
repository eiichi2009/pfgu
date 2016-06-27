	.section .data
	.section .text
	.globl _start
_start:
	movq $1, %rax
	cmpq $1, %rax
	je jump_if_equal		# 2nd == 1st

	movq $2, %rax
	cmpq $1, %rax
	jg jump_if_greater		# 2nd > 1st

	movq $3, %rax
	cmpq $3, %rax
	jge jump_if_greater_or_equal	# 2nd >= 1st
	
	movq $10, %rax
	cmpq $11, %rax
	jl jump_if_less			# 2nd < 1st

	movq $100, %rax
	cmpq $100, %rax
	jle jump_if_less_or_equal	# 2nd <= 1st
	
jump_if_equal:
	movq $0, %rbx
	movq $1, %rax
	int $0x80

jump_if_greater:
	movq $1, %rbx
	movq $1, %rax
	int $0x80

jump_if_greater_or_equal:	
	movq $2, %rbx
	movq $1, %rax
	int $0x80

jump_if_less:	
	movq $3, %rbx
	movq $1, %rax
	int $0x80

jump_if_less_or_equal:	
	movq $4, %rbx
	movq $1, %rax
	int $0x80
