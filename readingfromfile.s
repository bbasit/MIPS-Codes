.data
fname: .asciiz "C:\Users\adil.rao\Desktop\HELLO WORLD.txt" # File Path & Name
input_buffer: .space 15
.text
.globl main
main:
	# Open the File
	li $v0,13 # System call for opening the file
	la $a0, fname
	li $a1,0 # Opening the File for reading (Flags are 0: Read, 1:Write)
	syscall # Open the File (File descriptor returned in $v0)
	
	move $t6,$v0
	# Now Read from the File
	li $v0, 14 # System call for reading from the file
	move $a0, $t6 #Copying the file descriptor
	la $a1, input_buffer #Address of input buffer; at this address the content of file would be written
	li $a2, 15 #Size of input buffer
	syscall
	
	# Now Close the file
	li $v0, 16 # System call for closing the file
	move $a0, $t6 # Copying file descriptor
	syscall
	#exit
	
	li $v0, 10
	syscall