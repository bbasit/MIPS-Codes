.data
Array01: .word 9, 3, 2, 1, 8, 3, 2, 5, 7, 9, 0        #intiallize the array
Array02: .space 4000                  #space array
comma: .asciiz ","
.globl main
.text
main:
la $t0,Array01                       # move first address of array to register
la $t1,0   
sub $t0,$t0,4                           # intiallize i=0
lw $t3,($t0)                            # move address to register
  li $t4,0                    #max value in $t4
   li $t2,0                    #counter i=0                     
ForLoop:        
        bgt $t2,10,Exit1          #if i>4 then go to Exit1
        add $t2,$t2,1              # i++
		add $t0,$t0,4              #increment in index of array
	    lw $t3,($t0)             #move first index value to register 
		bgt $t4,$t3,ForLoop             #if max value >array[i] go to Forloop
     	move $t4,$t3                    #move $t3 to $t4
         
		b ForLoop  

Exit1:
          #li $v0,1
		  #move $a0,$t4                         #print maximum value
          #syscall
		  la $t0,Array02                       # move first address of array to register
          li $t2,0                             #counter i=0
		  
		li $t5,0                                #intiallize $t5=0                     
Loop:        
        bgt $t2,$t4,Exit                         #if i>max  go to Exit
        add $t2,$t2,1                            #i++
		sw $t5,($t0)                             #move $t5 to the address of $to
        add $t0,$t0,4                            #increment in index of array
        
		b Loop  
                     
Exit:
		la $t0,Array01
		
		
Exitt:		
		bgt $t5,10,Exit2
		
		la $t1,Array02
		
		lw $t2,($t0)
		lw $t6,($t1)
		
		mul $t2,$t2,4
		
		add $t1,$t1,$t2
		
		lw $t6,($t1)
		
		add $t6,$t6,1
		
		sw $t6,($t1)
		
		add $t4,$t4,1
		add $t5,$t5,1
		add $t0,$t0,4
		b Exitt
		
Exit2:		
		
		la $t1,Array02

		li $t0,0
aac:
		bgt $t0,$t4,aaa
		
		
		lw $t5,($t1)
		
		li $t7,0
		
		For:
			beq $t7,$t5,FinallyExit
			
			li $v0,1
			move $a0,$t0
			syscall
			
			li $v0,4
			la $a0,comma
			syscall
			
			add $t7,$t7,1
			b For
		
		
		FinallyExit:	
			add $t1,$t1,4
			add $t0,$t0,1
			b aac
			

aaa:
		
		li $v0,10
		syscall	