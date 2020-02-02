.data
arr:	.word  1, 2, 3, 4
.text
.globl main
main:
	la $t0,arr
	
	
	add $t0,$t0,12
	
	li $t2,0
	
	FOR:
		beq $t2,4,exit
		
		lw $t1,($t0)
		
		li $v0,1
		move $a0,$t1
		syscall
		
		sub $t0,$t0,4
		
		add $t2,$t2,1
		
		b FOR
		
	exit:
		li $v0,10
		syscall