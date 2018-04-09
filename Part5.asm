.data
	numbersArray: .space 400
	prompt: .asciiz "Enter the number of the elements: "
	prompt1: .asciiz "Enter the number: "
	warningMessage: .asciiz "The number should be between 0 and 100."
	newLine: .asciiz "\n"
	space: .asciiz " "
	firstOperation:  .asciiz "1. Find summation of numbers stored in the array which is greater than an input number. \n"
	secondOperation: .asciiz "2. Find summation of even and odd numbers and display them. \n"
	thirdOperation:  .asciiz "3. Display the number of occurrences of the array elements divisible by a certain input number. \n"
	quitOperation:   .asciiz "4. Quit\n"
	operation:       .asciiz "Which operation do you need to perform: "
	quitMessage:	 .asciiz "Bye Bye"
	summationMessage:.asciiz "Sum of number bigger than the input is: "
	enterNumber:	 .asciiz "Enter the number you want to check: "
	evenQuantities:  .asciiz "The sum of even elements in the array is: "
	oddQuantities:	 .asciiz "The sum of odd elements in the array is: "
	divisible:	 .asciiz "Enter the number you want to check: "
	divisibleMessage:.asciiz "The number of elements divisible by your number is: "
	
.text
	addi $s0, $zero, 404
	addi $s1, $zero, 1
	addi $s2, $zero, 2
	addi $s3, $zero, 3
	addi $s4, $zero, 4
	addi $t1, $zero, 0
	addi $t5, $zero, 0
	addi $t6, $zero, 0
	
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
		beq $t1, $t0, menu
		add $t3, $zero, $zero
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
	#Return to the loop
	j while
	
	menu:
		#Display the menu
		li $v0, 4
		la $a0, firstOperation
		syscall
		
		li $v0, 4
		la $a0, secondOperation
		syscall
		
		li $v0, 4
		la $a0, thirdOperation
		syscall
		
		li $v0, 4
		la $a0, quitOperation
		syscall
	chooseOperation:
		li $v0, 4
		la $a0, operation
		syscall
		
		#Take the input from the user
		li $v0, 5
		syscall
	
		#Save the input into register (t4)
		add  $t4, $0, $v0
		bltz $t4, chooseOperation
		bgt  $t4, $s4, chooseOperation 
		beq  $t4, $s1, summation
		beq  $t4, $s2, evenOdd
		beq  $t4, $s3, occurence
		beq  $t4, $s4, quit 
	#Find the summation of all numbers bigger than the input
	summation:
		#Make the index and current value to 0
		add $t1, $zero, $zero
		add $t3, $zero, $zero
		add $t5, $zero, $zero
		
		#Print a  message to the user
		li $v0, 4
		la $a0, enterNumber
		syscall
		
		#Take the input from the user
		li $v0, 5
		syscall
		
		#Save the input into register (t4)
		add  $t4, $zero, $v0
		
		summationFor:
			beq $t1, $t0, summationResult
			lw  $t3, numbersArray($t1)
			bgt $t3, $t4, summationAddition
			blt $t3, $t4, summationJump
			beq $t3, $t4, summationJump
		summationAddition:
			add $t5, $t5, $t3
			addi $t1, $t1, 4
			j summationFor
		summationJump:
			addi $t1, $t1, 4
			j summationFor
		summationResult:
		
				#Print the message
				li $v0, 4
				la $a0, summationMessage
				syscall
				
				#Print the sum of the numbers
				li $v0, 1
				move $a0, $t5
				syscall
				
				#Print a new Line
				li $v0, 4
				la $a0, newLine
				syscall
				j menu
	#Find the sum of the even number and the odd number
	evenOdd:
		#Make the index 0
		add $t1, $zero, $zero
		add $t5, $zero, $zero
		add $t6, $zero, $zero
		
		evenOddFor:
			beq $t1, $t0, evenOddResult
			lw $t3, numbersArray($t1)
			div $t3, $s2
			mfhi $s5
			beq $s5, $zero, addEven
			beq $s5, $s1, addOdd
		addEven:
			add $t5, $t5, $t3
			addi $t1, $t1, 4
			j evenOddFor
		addOdd:
			add $t6, $t6, $t3
			addi $t1, $t1, 4
			j evenOddFor
		evenOddResult:
			#Message for even numbers
			li $v0, 4
			la $a0, evenQuantities
			syscall
			#Show even number
			li $v0, 1
			move $a0, $t5
			syscall
			#Print a new Line
			li $v0, 4
			la $a0, newLine
			syscall
			#Message for odd numbers
			li $v0, 4
			la $a0, oddQuantities
			syscall
			#Show odd number
			li $v0, 1
			move $a0, $t6
			syscall
			#Print a new Line
			li $v0, 4
			la $a0, newLine
			syscall
			j menu
		
	#Find the ocuurence of the number that is entered by the user
	occurence:
		#Make the index 0
		add $t1, $zero, $zero
		add $t5, $zero, $zero
		
		#Print a  message to the user
		li $v0, 4
		la $a0, divisible
		syscall
		
		#Take the input from the user
		li $v0, 5
		syscall
		#Save the input into register (t4)
		add  $t4, $0, $v0
		
		occurenceFor:
			beq $t1, $t0, occurenceResult
			lw $t3, numbersArray($t1)
			div $t3, $t4
			mfhi $s5
			beq $s5, $zero, addOccurence
			bne $s5, $zero, justMove
		addOccurence:
			addi $t5, $t5, 1
			addi $t1, $t1, 4
			j occurenceFor
		justMove:
			addi $t1, $t1, 4
			j occurenceFor
		occurenceResult:
			#Message for occurenve 
			li $v0, 4
			la $a0, divisibleMessage
			syscall
			#Show odd number
			li $v0, 1
			move $a0, $t5
			syscall
			#Print a new Line
			li $v0, 4
			la $a0, newLine
			syscall
			j menu
	
	#Quit the Program
	quit:
		#Print a bye bye message to the user
		li $v0, 4
		la $a0, quitMessage
		syscall
		#Shows the assembler when the program finishes
		li $v0, 10
		syscall
	
	exit:
		li $v0, 4
		la $a0, warningMessage
		syscall
