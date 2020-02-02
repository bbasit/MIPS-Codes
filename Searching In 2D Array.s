.data
Array: .word 10, 70, 30, 40
	   .word 50, 95, 70, 80
	   .word 90, 10, 150, 120
	   .word 130, 140, 190, 160
	
mesag: .asciiz "maximum of each row are \n"	
tab: .asciiz " \n";
spaces: .asciiz " ";
cmma: .asciiz ","


.text
.globl main
.ent main
main:

		li $v0,4		#v0 should 4 for printing string
		la $a0,mesag	#load the address referred by mathsn in the register a0	
		syscall
		
		la $t0 , Array
		li $t1 , 0 # Row no.
		li $t2 , 0 # Column no.
		li $t4 , 4 # No. of columns in the array
		
		For1:
		  beq $t1,4 Exit1
		  li $t6,0
		    For2: 
			
				beq $t2,4 Exit2
				
			   	mul $t3 , $t1, $t4 # (Row No. * No. of columns in the array)
				add $t3 , $t3, $t2 # [(Row No. * No. of columns in the array) + Column No.]
				mul $t3 , $t3, 4 # (((Row No. * No. of columns in the array) + Column No.) *(Size of element))

				add $t3 , $t3, $t0 # [(((Row No. * No. of columns in the array) + Column No.) *(Size of element)) + Base address of array]

				lw $t5 , ($t3) #loading value t5 = Array[2][3]
				
				
				sgt $t7,$t5,$t6
				
				beq $t7,1,swap
				jumpback:
					
						add $t2,$t2,1
						b For2
					
						 Exit2:
							li $v0 , 1 #printing maximum number
							move $a0 , $t6
							syscall
						 
						   li $v0,4	  
						   la $a0,tab
						   syscall
							
						   add $t1,$t1,1
						   li $t2 , 0 
						   b For1
				
						Exit1:	
						
							 li $v0 , 10
							 syscall
		swap:
			move $t6,$t5
			b jumpback
