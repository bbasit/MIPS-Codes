.data
msg1: .asciiz "Enter A: " #message declaration
msg2: .asciiz "Enter B: " #message declaration
msg3: .asciiz "A^B: " #message declaration
.globl main
.text
main:
# ***Task A starts Here***

	li $t0,0 #A
	li $t1,0 #B
	li $t2,1 #Result
	
	li $v0,4	#printing msg1
	la $a0,msg1
	syscall
	
	li $v0,5	#taking A input
	syscall
	move $t0,$v0
	
	li $v0,4	#printing msg2
	la $a0,msg2
	syscall
	
	li $v0,5	#taking B input
	syscall
	move $t1,$v0
	
	li $t4,0 #i=0
	
	FOR:
		bge $t4,$t1,EXIT #conditional branch (if i >= B so jump to EXIT)
		
		mul $t2,$t2,$t0  #result = result * A
		
		add $t4,$t4,1 # i++
		
		b FOR #unconditional jump to FOR
	
	EXIT:
	
		li $v0,4		#printing msg3
		la $a0,msg3
		syscall

		li $v0,1		#printing result
		move $a0,$t2
		syscall
##***Task A Ends here***
		li $v0,10 #Exit code
		syscall