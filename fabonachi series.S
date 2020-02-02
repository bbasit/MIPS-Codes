.data

 var1:	.asciiz	"enter length of Fabonachi Series\n"
 var2:	.asciiz	","


.globl main
.text

main:

	li $v0,4	#printing msg1
	la $a0,var1
	syscall
	
	li $v0,5	#taking length of fabbonachi series input
	syscall
	move $a1,$v0	#move input to $a1
	
	sub $a1,$a1,2
	
	jal Fabonachi
	
	li $v0,10 #Exit code
	syscall

	Fabonachi:
		li $t5,0	#counter
		li $a2,0	#firstValue=1
		li $a3,1	#secondValue=1
		
		li $v0,1	#printing value
		move $a0,$a2
		syscall 
			
		li $v0,4	#printing COMMA
		la $a0,var2
		syscall
		
		li $v0,1	#printing value
		move $a0,$a3
		syscall 
			
		li $v0,4	#printing COMMA
		la $a0,var2
		syscall
		
		
		For:
			bge $t5,$a1,Exit
			add $t2,$a2,$a3
			
			li $v0,1		#printing value
			move $a0,$t2
			syscall 
			
			li $v0,4	#printing COMMA
			la $a0,var2
			syscall
			
			move $a2,$a3
			move $a3,$t2
			
			add $t5,$t5,1
			
			b For		#unConditional jump
			
		Exit:
			jr $ra		#jump to the line next to "jal Fabonachi"
	
	.end MyFunc
		


