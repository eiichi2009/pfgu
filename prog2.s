# page 22-23
# This program finds the maximum number of a set of data items	
# variables
# %rdi - Holds the index of the data item being examined	
# %rbx - Largest data item found so far
# %rax - Current data item being examined
# data_items is the memory location that contains the item data.
# A 0 is used to terminate the data

	.section .data

data_items:
	.8byte 3,67,89,34,55,222,4,2,4,1,8,9,6,5,0

	.section .text
	.globl _start
_start:
	movq $0, %rdi
	mov data_items(,%rdi,8), %rax
	movq %rax, %rbx

start_loop:
	cmpq $0, %rax
	je loop_exit

	incq %rdi
	mov data_items(,%rdi,8), %rax
	cmpq %rbx, %rax
	jle start_loop

	movq %rax, %rbx
	jmp start_loop

loop_exit:
	movq $1, %rax
	int $0x80
	
