.data
	message: .asciiz "The remainder is: "
	message1: .asciiz "Enter the first number: "
	message2: .asciiz "Enter the second number: "
.text

#Prompt the user to enter the first number
li, $v0, 4
la $a0, message1
syscall
#Get the first number from the user
li $v0, 5
syscall
move $t0, $v0
#Prompt the user to enter the second number
li, $v0, 4
la $a0, message2
syscall
#Get the second number from the user
li $v0,5
syscall
move $t1, $v0

#Save the result into register ($t0)
sub $t0, $t0, $t1
add $t1, $zero, $zero
slt $t1, $t0, $zero
beq $t1, $zero, positivefor

negativefor:
bgez $t0, exit
addi $t0, $t0, 2
j negativefor

positivefor:
	blez $t0, exit
	subi $t0, $t0, 2
	j positivefor
exit:

caseBigOne:
	beqz $t0, caseZero
	bltz $t0, caseLessOne
	j exit1
caseLessOne:
	addi $t0, $t0, 2
	j exit1
caseZero:
exit1:
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall


li $v0, 10
syscall
