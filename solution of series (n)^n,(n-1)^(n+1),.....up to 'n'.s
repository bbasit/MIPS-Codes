.data
	input:	.asciiz "\ninput:"		#message declaration
	comma:	.asciiz ","				#message declaration
	
.text
.globl main
main:
	li $v0 , 4			#$v0=4 for printing string
	la $a0 , input
	syscall
	
	li $v0 , 5			#$v0=4 for taking integer a an input
	syscall
	move $t0 , $v0		#user input #t0 or a=input 
	
	
	move $t1,$t0		#b = a  ,b=$t1
	
	move $t2,$t0		#for counter
	
	move $t8,$t0
	
	sub $t8,$t8,1
	
	move $t6,$t0
	li $t5,0			#for power calculation
	li $t3,0		#i=0
	
	add $t0,$t0,1	#add $t0=$t0+1 
	sub $t1,$t1,1	#sub $t1=$t1-1
	For:
		bge $t3,$t2,exit
		sub $t0,$t0,1		#a-- 
		add $t1,$t1,1		#b++
		
		move $t6,$t0
		
		add $t3,$t3,1		#i++
		add $t8,$t8,1
		
		li $t5,1
		newloop:
				beq $t5,$t1,While		
				mul $t6,$t6,$t0
				add $t5,$t5,1
				b newloop
				
		
		b For
	
	While:
		li $v0,1
		move $a0,$t6
		syscall
		
		li $v0 , 4
		la $a0 , comma
		syscall
		
		b For
	
	exit:
		li $v0 , 10
		syscall
		
		
		
		
		
		
		
		