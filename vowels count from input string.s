.data
string_space: .space 1024
string: .asciiz "enter a string to count vowels:\n"
.text
.globl main
main:
	li $v0,4		#v0 should 4 for printing string
	la $a0,string	#load the address referred by mathsn in the register a0	
	syscall

	#taking string as input
	la $a0 , string_space
	li $a1 , 1024
	li $v0 , 8
	syscall


	#printing the string
	la $t1,string_space #loading starting address of array in $t1
	
	li $t9,0 #count

	For:
		lb $t2,($t1)	#load the character from address in $t1 
		beq $t2,0,Exit	#if char in t2 == 0 (NULL) so jump to exit
		
		beq $t2,'A',INCREMENT #if t2==t3(A) jump to increment
		beq $t2,'E',INCREMENT #if t2==t4(E) jump to increment
		beq $t2,'I',INCREMENT #if t2==t5(I) jump to increment
		beq $t2,'O',INCREMENT #if t2==t6(O) jump to increment
		beq $t2,'U',INCREMENT #if t2==t7(U) jump to increment
		beq $t2,'a',INCREMENT #if t2==t3(A) jump to increment
		beq $t2,'e',INCREMENT #if t2==t4(E) jump to increment
		beq $t2,'i',INCREMENT #if t2==t5(I) jump to increment
		beq $t2,'o',INCREMENT #if t2==t6(O) jump to increment
		beq $t2,'u',INCREMENT #if t2==t7(U) jump to increment
		BACK:
		
		add $t1,$t1,1 #address = address+1
		b For
	Exit:
		li $v0,1
		move $a0,$t9
		syscall
	li $v0 , 10
	syscall
	
INCREMENT:
	add $t9,$t9,1
	b BACK