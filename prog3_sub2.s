	.section .data
	.section .text
	.globl _start
_start:
	call func
	movq $1, %rax
	int $0x80

	.type func, @function
func:
	pushq %rbp
	movq %rsp, %rbp

	leave
	# equivalent to
	# movq %rbp, %rsp
	# pop %rbp
	ret
	
