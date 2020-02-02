.data
array:		.space	4020	# an array of word, for storing values.
size:		.word	1			# actual count of the elements in the array.
space:		.asciiz " "			# a space string.
Nextline:	.asciiz	"\n"		# a newline string.
colon:		.asciiz ": "		# a colon string with space.


InputArrayLength:		.asciiz		"Enter the length of array to be sorted(0<length<1000): "
message:				.asciiz		"Input each value below! "
InputMessage:			.asciiz		"Input value"
sortedMessage:			.asciiz 	"Sorted Array :"
message2:				.asciiz		"\nEnter 1 If you wants to sort another array Else enter 0\n"
exitmessage:			.asciiz		"\nExit"
lengthmessage:			.asciiz		"Array length is out of limit\n"

.text
.globl	main
main:
	li $s0,1
	do:
		li	$v0, 4			# 4 = print_string syscall.
		la	$a0,InputArrayLength	# load params_info_string to argument register $a0.
		syscall				# issue a system call.
	
	
		li	$v0, 5			# 5 = read_int syscall.
		syscall				# issue a system call.
		sw	$v0, size	# store returned value in $v0 to size.

		bge $v0,1000,incorrectlength		#check length of aray
		ble $v0,0,incorrectlength			#check length of array
	
		li	$v0, 4			# 4 = print_string syscall.
		la	$a0,message	# load message to argument register $a0.
		syscall				# issue a system call.
		li	$v0, 4			# 4 = print_string syscall.
		la	$a0, Nextline		# load line to argument register $a0.
		syscall				# issue a system call.
	
	
		la	$t0,array		# load array to $t0.
		lw	$t1, size		# load size to $t1.
		li	$t2, 0			# loop runner, starting from 0.
	
	For:
		bge	$t2, $t1, End	# while ($t2 < $t1).
		li	$v0, 4			# 4 = print_string syscall.
		la	$a0, InputMessage # load receive_values_loop_iter_string to argument register $a0.
		syscall				# issue a system call.
		
	
		li	$v0, 4			# 4 = print_string syscall.
		la	$a0, colon		# load colonsp to argument register $a0.
		syscall				# issue a system call.

		li	$v0, 5			# 5 = read_int syscall.
		syscall				# issue a system call.
		sw	$v0, ($t0)		# store returned value from syscall in the array.

		add	$t0, $t0, 4		# increment array pointer by 4.
		add	$t2, $t2, 1		# increment loop runner by 1.
		b	For	# jump back to the beginning of the loop.
	
	End:
		jal	print			# call print routine.
	
	
		la	$t0, array		# load array to $t0.
		lw	$t1, size		# load array size to $t1.
		li	$t2, 1			# loop runner, starting from 1.
	
	outerloop:
		la	$t0, array		# load array to $t0.
		bge	$t2, $t1,outerloopend	# while (t2 < $t1). $t1=size of array
		move	$t3, $t2		# copy $t2 to $t3.
	
	sort:
		la	$t0, array			# load array to $t0.
		mul	$t5, $t3, 4			# multiply $t3 with 4, and store in $t5 to move on the value from where previouse values compared
		add	$t0, $t0, $t5		# add the array address with $t5, which is the index multiplied with 4.
		
		ble	$t3, 0, sortend		# while (t3 > 0).
		lw	$t7, ($t0)			# load array[$t3] to $t7.
		lw	$t6, -4($t0)		# load array[$t3 - 1] to $t6.
		
		bge	$t7, $t6, sortend	# while (array[$t3] < array[$t3 - 1]).
		lw	$t4, ($t0)
		sw	$t6, ($t0)			#swaping
		sw	$t4, -4($t0)		#swaping
	
		sub	$t3, $t3, 1
		b	sort		# jump back to the beginning of the sort_iloop.
	
	sortend:
		add	$t2, $t2, 1		# increment loop runner by 1.
		b	outerloop		# jump back to the beginning of the sort_xloop.
	
	outerloopend:
		li	$v0, 4			# 4 = print_string syscall.
		la	$a0, sortedMessage	# load sorted_array_string to argument register $a0.
		syscall				# issue a system call.
		li	$v0, 4			# 4 = print_string syscall.
		la	$a0, Nextline		# load line to argument register $a0.
		syscall				# issue a system call.
		jal	print			# call print routine.
	
	exit:
		li $v0,4	
		la $a0,message2
		syscall
		
		li $v0,5	
		syscall
		move $s0,$v0
		
		beq $s0,1,do
		
		li $v0,4	
		la $a0,exitmessage
		syscall
		
		li	$v0, 10			# 10 = exit syscall.
		syscall				# issue a system call.

	print:
	
			la	$t0, array
			lw	$t1, size
			li	$t2, 0
			
		For2:
			bge	$t2, $t1, End2
			li	$v0, 1
			lw	$a0, ($t0)
			syscall
			li	$v0, 4
			la	$a0, space
			syscall
			add	$t0, $t0, 4
			add	$t2, $t2, 1
			b	For2
		
		End2:
			li	$v0, 4
			la	$a0, Nextline
			syscall
			jr	$ra
			
	incorrectlength:
			li	$v0, 4
			la	$a0, lengthmessage		#message for incorrect length
			syscall
			
			b exit								