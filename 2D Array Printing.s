.data
Array: .word 10, 20, 30, 40
	   .word 50, 60, 70, 80
	   .word 90, 100, 110, 120
	   .word 130, 140, 150, 160
	   
tab: .asciiz " \n";
spaces: .asciiz " ";
cmma: .asciiz ","


.text
.globl main
.ent main
main:
		la $t0 , Array
		li $t1 , 0 # Row no.
		li $t2 , 0 # Column no.
		li $t4 , 4 # No. of columns in the array
		
		For1:
		  beq $t1,4 Exit1
		  
		    For2: 
			
				beq $t2,4 Exit2
				
			   	mul $t3 , $t1, $t4 # (Row No. * No. of columns in the array)
				add $t3 , $t3, $t2 # [(Row No. * No. of columns in the array) + Column No.]
				mul $t3 , $t3, 4 # (((Row No. * No. of columns in the array) + Column No.) *(Size of element))

				add $t3 , $t3, $t0 # [(((Row No. * No. of columns in the array) + Column No.) *(Size of element)) + Base address of array]

				lw $t5 , ($t3) #loading value t5 = Array[2][3]
				li $v0 , 1 #printing Array[2][3]
				move $a0 , $t5
		        syscall
				
				li $v0,4	
				la $a0,spaces
				syscall
				li $v0,4	
				la $a0,cmma
				syscall
					
				add $t2,$t2,1
				b For2
			
			 Exit2:
			 
			   li $v0,4	  
			   la $a0,tab
			   syscall
				
			   add $t1,$t1,1
			   li $t2 , 0 
			   b For1
		
	    Exit1:	
		
			 li $v0 , 10
			 syscall
		 
