.data
	dimension: .asciiz "Enter dimension of the matrix: "

	enter_first: .asciiz "Enter first matrix:\n"
	enter_second: .asciiz "Enter second matrix:\n"

	show_first: .asciiz "First matrix:\n"
	show_second: .asciiz "Second matrix:\n"

	menu: .asciiz "\n1.Addition\n2.Subtraction\n7.Exit"

	choice: .asciiz "\nEnter your choice :"

	num_scale:.asciiz "\nEnter a number for scaling:"

	wrongchoice: .asciiz "\nInvalid Choice!"
	exiting: .asciiz "\n\tExiting."
	show_result: .asciiz "Result:\n"

	space: .asciiz " "
	newline: .asciiz "\n"

.text
.globl main
main:

# Prompt and take dimension input
	li $v0, 4
	la $a0, dimension
	syscall

	li $v0, 5
	syscall
	addu $s0, $zero, $v0		    # $s0 == N

# Size of the 2d array stored in $a0 for next three steps
	mul $a0, $s0, $s0
	mul $a0, $a0, 4

# Declaring matrix A in $s1
	li $v0, 9
	syscall
	addu $s1, $zero, $v0

# Declaring matrix B in $s2
	li $v0, 9
	syscall
	addu $s2, $zero, $v0

# Declaring resultant matrix in $s3
	li $v0, 9
	syscall
	addu $s3, $zero, $v0

# $s4 = N^2
	mul $s4, $s0, $s0

# Take input in matrix A
	li $v0, 4
	la $a0, enter_first
	syscall

	xor $t1, $t1, $t1		# loop variable
	move $t2, $s1			# pointer

loop1:

	slt $t0, $t1, $s4
	beq $t0, $zero, exit1

	li $v0, 5
	syscall
	sw $v0, 0($t2)

	addiu $t1, $t1, 1
	addiu $t2, $t2, 4

	j loop1

exit1:

# Take input in matrix B
	li $v0, 4
	la $a0, enter_second
	syscall

	xor $t1, $t1, $t1		# loop variable
	move $t2, $s2			# pointer

loop2:

	slt $t0, $t1, $s4
	beq $t0, $zero, exit2

	li $v0, 5
	syscall
	sw $v0, 0($t2)

	addiu $t1, $t1, 1
	addiu $t2, $t2, 4

	j loop2

exit2:

    # Print matrix A
	li $v0, 4
	la $a0, show_first
	syscall

	move $a1, $s1
	jal printMatrix

# Print matrix B
	li $v0, 4
	la $a0, show_second
	syscall

	move $a1, $s2
	jal printMatrix

	li $v0,4
	la $a0, menu
	syscall

INPUT:
    li $v0,4
	la $a0, choice
	syscall

	li $v0,5
	syscall

	move $t0, $v0

	li $t1, 1
	li $t2, 2
	li $t7, 7

    move $a0,$s0
    move $a1,$s1
    move $a2,$s2
    move $a3,$s3

	blez $t0, Label0
	bgt $t0, $t7, Label0
	beq $t0, $t1, Label1
	beq $t0, $t2, Label2
	beq $t0, $t7, Label7

	Label0:
        li $v0,4
        la $a0,wrongchoice
        syscall
        j INPUT
    Label1:
        jal addition
        j INPUT
    Label2:
        jal subtraction
        j INPUT
    Label7:
        li $v0,4
        la $a0,exiting
        syscall

        li $v0,10
        syscall
.end main

.globl addition
.ent addition
addition:
    move $s0,$a0
    move $s1,$a1
    move $s2,$a2
    xor $t1, $t1, $t1

    L1:
        slt $t0, $t1, $s0
        beq $t0, $zero, endL1
        xor $t2, $t2, $t2

        L2:
            slt $t0, $t2, $s0
            beq $t0, $zero, endL2

            mul $t4, $t1, $s0
            addu $t4, $t4, $t2
            sll $t4, $t4, 2
            addu $t4, $t4, $s1

            mul $t5, $t1, $s0
            addu $t5, $t5, $t2
            sll $t5, $t5, 2
            addu $t5, $t5, $s2

            lw $t6, 0($t4)
            lw $t7, 0($t5)

            add $t8, $t6, $t7

            li $v0,1
            move $a0, $t8
            syscall

            li $v0,4
            la $a0,space
            syscall

            addiu $t2, $t2, 1
            j L2
    endL2:
        addiu $t1, $t1, 1

        li $v0,4
        la $a0, newline
        syscall

        j L1
endL1:

    jr $ra
.end addition

.globl subtraction
.ent subtraction
subtraction:
    move $s0,$a0
    move $s1,$a1
    move $s2,$a2
    xor $t1, $t1, $t1

    L3:
        slt $t0, $t1, $s0
        beq $t0, $zero, endL3
        xor $t2, $t2, $t2

        L4:
            slt $t0, $t2, $s0
            beq $t0, $zero, endL4

            mul $t4, $t1, $s0
            addu $t4, $t4, $t2
            sll $t4, $t4, 2
            addu $t4, $t4, $s1

            mul $t5, $t1, $s0
            addu $t5, $t5, $t2
            sll $t5, $t5, 2
            addu $t5, $t5, $s2

            lw $t6, 0($t4)
            lw $t7, 0($t5)

            sub $t8, $t6, $t7

            li $v0,1
            move $a0,$t8
            syscall

            li $v0,4
            la $a0,space
            syscall

            addiu $t2, $t2, 1
            j L4

    endL4:
        li $v0,4
        la $a0,newline
        syscall

        addiu $t1, $t1, 1
        j L3
endL3:
    jr $ra
.end subtraction


.globl printMatrix
.ent printMatrix
printMatrix:
	xor $t1, $t1, $t1				# loop 1 variable

	print1:
		slt $t0, $t1, $s0
		beq $t0, $zero, end_print1
		addiu $t1, $t1, 1

		xor $t2, $t2, $t2			# loop 2 variable

		print2:
			slt $t0, $t2, $s0
			beq $t0, $zero, end_print2
			addiu $t2, $t2, 1

			li $v0, 1
			lw $a0, 0($a1)
			syscall

			addiu $a1, $a1, 4		# increment pointer

			li $v0, 4
			la $a0, space
			syscall

			j print2

        end_print2:

            li $v0, 4
            la $a0, newline
            syscall

            j print1
    end_print1:
            jr $ra
.end printMatrix