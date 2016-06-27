	.section .data
base_number:
	.8byte 0
power_number:
	.8byte 0
result_number:
	.8byte 0
	
	.section .text
	.globl _start
_start:
	movq $2, power_number
	movq $7, base_number
	call power
	movq result_number, %rbx
	movq $1, %rax
	int $0x80
	
power:
	movq base_number, %rdi
power_loop:
	decq power_number
	cmpq $0, power_number
	je power_exit
	
	imulq base_number, %rdi
	jmp power_loop

power_exit:
	movq %rdi, result_number
	ret
	
