.data
msg1: .asciiz "Enter an integer:"
msg2: .asciiz "Result:"
.text
.globl main
main:
	li $v0,4		#msg1
	la $a0,msg1
	syscall
	
	li $v0,5		#input1
	syscall
	move $a1,$v0
	li $v1,1
	
	jal Fac
	
	li $v0,4		#msg2
	la $a0,msg2
	syscall
	
	li $v0,1		#printing Results
	move $a0,$v1
	syscall
	
	li $v0,10		#exit code
	syscall
	
Fac:
	sub $sp,$sp,4	#pushing return address into stack
	sw $ra,($sp)
	
	ble $a1,0,Base #Base Case condition
	
	mul $v1,$v1,$a1#calculating factorial res=res*x
	
	sub $a1,$a1,1	#x=x-1
	
	jal Fac		#function call
	
	
	Base:
		lw $ra,($sp)	#fetching value from Stack
		add $sp,$sp,4
		jr $ra			#return