.data
fname: .asciiz "C:\Users\DELL\Desktop\HELLO WORLD.txt" # File Path & Name
buffer: .asciiz "My name is Adil"
.text
.globl main
main:
	# Open the File
	li $v0,13 # System call for opening the file
	la $a0, fname
	li $a1,1 # Opening the File for writing (Flags are 0: Read, 1:Write, 9:Write and append)
	syscall # Open the File (File descriptor returned in $v0)
	
	move $t6,$v0
	# Now Write in the File
	
	li $v0, 15 # System call for writing in the file
	move $a0, $t6 #Copying the file descriptor
	la $a1, buffer #Address of buffer from which to write
	li $a2, 15 #Buffer length
	syscall
	
	# Now Close the file
	li $v0, 16 # System call for closing the file
	move $a0, $t6 # Copying file descriptor
	syscall
	
	#exit
	li $v0, 10
	syscall