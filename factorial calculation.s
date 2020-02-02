.data
msg: .asciiz "enter value to calculate factorial"
.text
.globl main
main:
	li $v0,4	#printing msg1
	la $a0,msg
	syscall

	li $v0,5	
	syscall
	move $a1,$v0

	
	li $a2,1
	jal HelloFun	#function call
	
	li $v0,1	#printing value
	move $a0,$v1
	syscall
	
	li $v0,10	#exit code
	syscall

HelloFun:
	sub $sp,$sp,4	#pushing return address in Stack
	sw $ra,($sp)
	
	beq $a1,0,Base #Base Case condition
	
	mul $a2,$a2,$a1
	
	sub $a1,$a1,1	#x=x-1
	
	jal HelloFun	#function call
	Base:			#Base Case Defination
	
		move $v1,$a2

		lw $ra,($sp)
		add $sp,$sp,4
		jr $ra
	
	
	
	
	
	
	
	
	
	
	
	