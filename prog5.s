# page 57-62
# This program converts an input file to an output file with all letters converted to uppercase.

	.section .data

	.equ SYS_READ,	0
	.equ SYS_WRITE,	1
	.equ SYS_OPEN,	2
	.equ SYS_CLOSE,	3
	.equ SYS_EXIT,	60

	.equ O_RDONLY,	0
	.equ O_CREAT_WRONLY_TRUNC_APPEND,	03101

	.equ STDIN,	0
	.equ STDOUT,	1
	.equ STDERR,	2

	.equ END_OF_FILE,	0
	.equ NUMBER_ARGUMENTS,	2

	.section .bss
	.equ buffer_size, 500
	.lcomm buffer_data, buffer_size

	.section .text

	.equ ST_SIZE_PRESERVE,	16
	.equ ST_FD_IN,		-8
	.equ ST_FD_OUT,		-16
	.equ ST_ARGC,		0
	.equ ST_ARGV_0,		8	# name of program
	.equ ST_ARGV_1,		16	# input file name
	.equ ST_ARGV_2,		24	# output file name

	.globl _start
_start:
	movq %rsp, %rbp
	subq $ST_SIZE_PRESERVE, %rsp

open_files:
open_fd_in:
	# system call OPEN
	# input
	# rax: system call number (2 for open)
	# rdi: filename
	# rsi: flag
	# rdx: file mode (0666, 0664, etc...)
	movq $SYS_OPEN, %rax
	movq ST_ARGV_1(%rbp), %rdi
	movq $O_RDONLY, %rsi
	movq $0666, %rdx
	syscall
	movq %rax, ST_FD_IN(%rbp)

open_fd_out:
	movq $SYS_OPEN, %rax
	movq ST_ARGV_2(%rbp), %rdi
	movq $O_CREAT_WRONLY_TRUNC_APPEND, %rsi
	movq $0666, %rdx
	syscall
	movq %rax, ST_FD_OUT(%rbp)

read_loop_begin:
	movq $SYS_READ, %rax
	movq ST_FD_IN(%rbp), %rdi
	movq $buffer_data, %rsi
	movq $buffer_size, %rdx
	syscall
	cmpq $END_OF_FILE, %rax
	jle end_loop

continue_read_loop:
	pushq $buffer_data
	pushq %rax
	call convert_to_upper
	popq %rax
	addq $8, %rsp

	movq %rax, %rdx
	movq $SYS_WRITE, %rax
	movq ST_FD_OUT(%rbp), %rdi
	movq $buffer_data, %rsi
	syscall

	jmp read_loop_begin	
	
end_loop:
	movq $SYS_CLOSE, %rax
	movq ST_FD_OUT(%rbp), %rdi
	syscall

	movq $SYS_CLOSE, %rax
	movq ST_FD_IN(%rbp), %rdi
	syscall
	
	movq $SYS_EXIT, %rax
	movq $0, %rdi
	syscall


	.equ LOWERCASE_A, 'a'
	.equ LOWERCASE_Z, 'z'
	.equ UPPER_DIFF, 'A' - 'a'
	.equ ST_BUFFER_LEN, 16
	.equ ST_BUFFER, 24

convert_to_upper:
	pushq %rbp
	movq %rsp, %rbp
	movq ST_BUFFER(%rbp), %rax
	movq ST_BUFFER_LEN(%rbp), %rbx
	movq $0, %rdi	

	cmpq $0, %rbx
	je end_convert_loop

convert_loop:
	movb (%rax,%rdi,1), %cl

	cmpb $LOWERCASE_A, %cl
	jl next_byte

	cmpb $LOWERCASE_Z, %cl
	jg next_byte

	addb $UPPER_DIFF, %cl

	movb %cl, (%rax,%rdi,1)

next_byte:
	incq %rdi
	cmpq %rdi, %rbx
	jne convert_loop

end_convert_loop:
	movq %rbp, %rsp
	popq %rbp
	ret
	
