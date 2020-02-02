.data
arr1: .word 6, 9, 8, 4, 1
nextLine: .asciiz "\n"
temp: .word 10
.text 
.globl main
main:
	la $t1,arr1
	# sub $t1,$t1,4
	li $t2,0
    li $t3,0
	la $t9,arr1
	
	For:
		bgt $t2,3,Exit
		
		la $t1,arr1

		la $t4,arr1

		mul $t8,$t2,4

		add $t1,$t1,$t8
		lw $t5,($t1)   # arr [min]
		
		move $t7,$t1
		
		move $t3,$t2
		
		add $t2,$t2,1
		
		# mul $t8,$t3,4
		# add $t8,$t8,4
		
		For2:
			bgt $t3,3,Exit2
			
			
			
			add $t4,$t1,4
			lw $t6, ($t4)   # arr [j]
			 
			add $t3,$t3,1
			add $t1,$t1,4
			
			bgt $t6,$t5,For2
			
			move $t5,$t6
			move $t7,$t4
			
			b For2
			
	Exit2:
		lw $t4,($t7)
		lw $t8,($t9)
		
		
		sw $t8,($t7)
		sw $t4,($t9)
		
		add $t9,$t9,4
		
		b For
		
	Exit:
	
		
		        la $t0, arr1
    
  
				li $t2, 1
				For3:
                bgt $t2, 5,Ex
         
                lw $t1, ($t0)
         
                li $v0, 1
                move $a0, $t1
                syscall
				
				li $v0, 4
				la $a0,nextLine
				syscall
                
                add $t0, 4
                add $t2,$t2,1

                b For3


               Ex:
                    li $v0, 10
                    syscall
		
		
		
   
   
   