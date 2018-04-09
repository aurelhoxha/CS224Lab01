.data
	numbersArray: .space 80
	warningMessage: .asciiz "The number should be between 0 and 20."
	prompt: .asciiz "Enter the number of elements: "
	prompt1: .asciiz "Enter number: "
	show: .asciiz "Numbers are: "
	show1: .asciiz "Numbers is reverse order are: "
	newLine: .asciiz "\n"
	space: .asciiz " "
.text
	#Save the total number amount
	addi $t0, $zero, 0
	
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	addi $s0, $zero, 84
	
	#Prompt the user to enter the number of elements
	li $v0, 4
	la $a0, prompt
	syscall
	
	#Take the input from the user
	li $v0, 5
	syscall
	
	#Save the input into register (t0)
	add $t0, $t0, $v0
	sll $t0, $t0, 2
	
	#Check if the number is bigger or smaller than 20
	slt $t2, $t0, $s0
	
	#If it is bigger exit the program
	beq $t2, $zero, exit
	
	while:
	beq $t1, $t0,numberEntered
	
	#Prompt user to enter the number
	li $v0, 4
	la $a0, prompt1
	syscall
	
	#Take the input from the user
	li $v0, 5
	syscall
	
	#Save the input into register (t3)
	add $t3, $t3, $v0
	#Add the number into the array
	sw $t3, numbersArray($t1)
		addi $t1, $t1, 4
		add $t3, $zero, $zero
	#Return to the loop
	j while
	
	#Show the array content
	numberEntered:
	
	#Print the message
	li $v0, 4
	la $a0, show
	syscall
	
	thenumber:
	#Check for the final number
	beq $t4, $t0, done
	#Save the number to register (t3)
	lw $t3, numbersArray($t4)
	#Increse the position by 4
	addi $t4, $t4, 4
	
	#Print the number
	li $v0, 1
	add $a0, $t3, 0
	syscall
	
	#Print a space
	li $v0, 4
	la $a0, space
	syscall
	
	j thenumber
	done:
	
	#Go to the next Line
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Show the message
	li $v0,4
	la $a0, show1
	syscall
	
	#Printing the reversed method
	
	addi $t2, $zero, -4
	addi $t4, $t4, -4
	while1:
	beq $t4,$t2, done1
	lw $t3, numbersArray($t4)
	#Increse the position by 4
	addi $t4, $t4, -4
	
	#Print the number
	li $v0, 1
	add $a0, $t3, 0
	syscall
	
	#Print a space
	li $v0, 4
	la $a0, space
	syscall
	
	j while1
	done1:
	
	#Shows the assembler when the program finishes
	li $v0, 10
	syscall
	
	exit:
	li $v0, 4
	la $a0, warningMessage
	syscall
	
	
	
	
	
