	.section .data
msg:
	.ascii "Hello World\n"

	.section .text
	.globl _start
_start:
	# WRITE system call
	# see unistd_64.h under arch
	# input
	# rax: syscall number (1 for write)
	# rdi: fd (1 for stdout)
	# rsi: memory location to write from
	# rdx: the size of the memory
	movq $1, %rax
	movq $1, %rdi
	movq $msg, %rsi
	movq $12, %rdx
	syscall

	# 32bit arch way
	movq $1, %rax
	movq $0, %rbx
	int $0x80

	# 64bit arch way
	# CLOSE system call
	# input
	# rax: syscall number (60 for exit)
	# rdi: error code to return
	movq $60, %rax
	movq $0, %rdi
	syscall
	
