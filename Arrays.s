.data
arr: .word 11, 12, 13, 14, 15
.text
.globl main
main:
	la $t1,arr

	li $t0,1	#i=1
	
	For:
		blt $t0,5,Exit		#for i<5
		lw $t2,($t1)		#load value from adre
		mul $t5,$t2,10
		
		sw $t5,($t1)
		
		add $t0,$t0,1
		add $t1,$t1,4
		b For
		
	Exit:
		la $t0,arr
		lw $t1,($t0)
	
		li $t2,1
	
		While:
			bgt $t2,5,out
			li $v0,1
			move $a0,$t1
			syscall
			add $t0,$t0,4
			add $t2,$t2,1
			lw $t1,($t0)
			b While
		out:
			li $v0,10
			syscall
	