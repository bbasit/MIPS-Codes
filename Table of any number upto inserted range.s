.data
	var1: .asciiz 	"X"
	var2: .asciiz 	"="
	var33: .asciiz 	"\n"
	var3: .asciiz	"\nEnter 1 to run the program or enter 0 to exit it:\n"
	var4: .asciiz	"\nEnter A:"
	var5: .asciiz	"\nEnter B:"
	var6: .asciiz 	"a"
	var7: .asciiz 	"i"
	var8: .asciiz 	"res"
	exit: .asciiz	"Exit"
.text
.globl main
main:
	li $t0,0	#$t0=a=0
	li $t1,0	#$t1=b=0
	li $t2,0	#$t2=c=0

	li $v0,4		#v0 must be 4 four printing string
	la $a0,var3		#move string to $a0 for printing
	syscall
	
	li $v0,5		#$v0 must be 5 for taking integer as input
	syscall
	move $t2,$v0	#$t2=c=user input
	
	While:
		beq $t2,0,Exit	#checking condition while (c=0) move to Exit else continue code
		
		li $v0,4
		la $a0,var4		#printing string "Enter A"
		syscall
		li $v0,5
		syscall
		move $t0,$v0	#$t0=a=input move $v0 to $t0
		
		li $v0,4
		la $a0,var5		#printing string "Enter B"
		syscall
		li $v0,5
		syscall
		move $t1,$v0	#b=input
		
		li $t4,1		#$t4=i=0
		For:
			bgt $t4,$t1,Exit2		#if i > b then move to Exit2 block 
			mul $t5,$t0,$t4			#$t5=res
			
			li $v0,1				#$v0 must be 1 for printing integer
			move $a0,$t0			#printing value of $t0 or a
			syscall
			
			li $v0,4			
			la $a0,var1				#printing string "X"
			syscall
			
			li $v0,1
			move $a0,$t4			#printing value of $t4 or i
			syscall
			
			li $v0,4
			la $a0,var2				#printing string "="
			syscall
			
			li $v0,1
			move $a0,$t5			#printing result of a*i which is $t5
			syscall
			
			li $v0,4
			la $a0,var33			#printing "\n" for next line
			syscall
			
			add $t4,$t4,1			#increment i++
			b For					#inconditional jump to For tag
		Exit2:
			li $v0,4
			la $a0,var3				#asking for input 1 or 0
			syscall
			
			li $v0,5
			syscall
			move $t2,$v0			#c=user input
			
			b While
			
			
			
		
	Exit:
		li $v0,4
		la $a0,exit		#printing string "exit"
		syscall
	
		li $v0,10		#$v0=10 for exit
		syscall