.data
  msg1:
    .asciiz "Enter a number in base 2 (-2 to quit): "
  msg2:
    .asciiz "\nResult: "
  allOnes:
    .asciiz "1111111111111111"
  empty:
    .space 16
  newLine:
    .asciiz "\n"
msg3: .asciiz "Please insert value (A > 0) : "
msg4: .asciiz "Please insert the number system B you want to 
convert to (2<=B<=10): "
msg6: .asciiz "\nbinary to decimal press 1, decimal to binary press 2, to exit press 0\n"
#Above string must be in one line
msg5: .asciiz "\nResult : "
  sum:
    .space 16 
  sumMsg:
    .asciiz "\nSUM: "
.text
.globl main
 main:
 
entry:
 
la $a0,msg6         #"input"
li $v0,4
syscall

li $v0,5
syscall
move $t9,$v0
beq $t9,2,decimal
beq $t9,0,exit
 
Binary:
getNum:
li $v0,4        	# Print string system call
la $a0,msg1         #"Please insert value (A > 0) : "
syscall

la $a0, empty
li $a1, 16              # load 16 as max length to read into $a1
li $v0,8                # 8 is string system call
syscall

la $a0, empty
li $v0, 4               # print string
syscall

li $t4, 0               # initialize sum to 0

startConvert:
  la $t1, empty
  li $t9, 16             # initialize counter to 16

firstByte:
  lb $a0, ($t1)      # load the first byte
  blt $a0, 48, printSum   
  add $t1, $t1, 1          # increment offset
  sub $a0, $a0, 48         # subtract 48 to convert to int value
  sub $t9, $t9, 1          # decrement counter
  beq $a0, 0, isZero
  beq $a0, 1, isOne
  j convert     # 

isZero:
   j firstByte

 isOne:                   # do 2^counter 
   li $t8, 1               # load 1
   sllv $t5, $t8, $t9    # shift left by counter = 1 * 2^counter, store in $t5
   add $t4, $t4, $t5         # add sum to previous sum 

   move $a0, $t4        # load sum
   li $v0, 1              # print int
   syscall
   j firstByte

convert:

printSum:
   srlv $t4, $t4, $t9

   la $a0, sumMsg
   li $v0, 4
   syscall

 move $a0, $t4      # load sum
 li $v0, 1      # print int
 syscall

b entry

decimal:

addi $s0,$zero,2
addi $s1,$zero,10
getA:

li $v0,4
la $a0,msg3
syscall
li $v0,5
syscall
blt $v0,$zero,getA

move $t0,$v0
getB:

li $t1,2

li $v0,4
la $a0,msg5
syscall

move $a0,$t0
move $a1,$t1

jal convert1

b entry

convert1:
#a0=A
#a1=B

addi $sp,$sp,-16

sw $s3,12($sp) #counter,used to know
#how many times we will pop from stack
sw $s0,8($sp) #A
sw $s1,4($sp) #B
sw $ra,0($sp)

add $s0,$zero,$a0
add $s1,$zero,$a1

beqz $s0,end

div $t4,$s0,$s1 #t4=A/B
rem $t3,$s0,$s1 #t3=A%B
add $sp,$sp,-4
sw $t3,0($sp) #save t3

add $a0,$zero,$t4 #pass A/B
add $a1,$zero,$s1 #pass B
addi $s3,$s3,1
jal convert1        #call convert1

end:

lw $ra,0($sp)
lw $s1,4($sp)
lw $s0,8($sp)
lw $s3,12($sp)
beqz $s3,done
lw $a0,16($sp)
li $v0,1
syscall

done: 
addi $sp,$sp,20
jr $ra   #return

exit:
li $v0, 10       # exit system call
   syscall