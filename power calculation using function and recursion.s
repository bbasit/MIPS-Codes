.data
msg1: .asciiz "Enter A: " #message declaration
msg2: .asciiz "Enter B: " #message declaration
msg3: .asciiz "A^B: " #message declaration
.globl main
.text
main:

	li $a1,0 #A
	li $a2,0 #B
	li $t2,1 #Result
	
	li $v0,4	#printing msg1
	la $a0,msg1
	syscall
	
	li $v0,5	#taking A input
	syscall
	move $a1,$v0
	
	li $v0,4	#printing msg2
	la $a0,msg2
	syscall
	
	li $v0,5	#taking B input
	syscall
	move $a2,$v0
	
	
	jal MyFunc	#FUNCTION CALL
	
	li $v0,4		#printing msg3
	la $a0,msg3
	syscall

	li $v0,1		#printing result
	move $a0,$v1
	syscall

	li $v0,10 #Exit code
	syscall
	
	MyFunc:
		sub $sp,$sp,4	#pushing return address in Stack
		sw $ra,($sp)
		
		beq $a2,0,BASE #conditional branch (Base case)
			
		mul $t2,$t2,$a1  #result = result * A
			
		sub $a2,$a2,1 
			
		jal MyFunc #Again function call
		
	BASE:
		move $v1,$t2

		lw $ra,($sp)
		add $sp,$sp,4
		jr $ra
		