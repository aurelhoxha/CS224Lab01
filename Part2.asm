.data
message: .asciiz "Please enter the string: "
wordString: .space 100
newLine: .asciiz "\n"
palindromeMessage: .asciiz "The string is Palindromic"
notPalindromeMessage: .asciiz "The string is not Palindromic"

.text
#Promp to user to enter the string that he want to check
li $v0, 4
la $a0, message
syscall

#Prints a new line for a better view
li $v0, 4
la $a0, newLine
syscall

#String loading starts from $a0 and load the input
li $v0, 8
li $a1, 100
la $a0, wordString
syscall

#Tell the system that we are going to print
li $v0, 4
syscall

#Prints the first char of the string
li $v0, 11
la $t0, wordString
lb $a0, ($t0)
syscall

#Goes to the last character of the String
la $t1,wordString 
loopOne: 
	lb $t2,($t1) 
	beq $t2,$0,loopTwo 
	addi $t1,$t1,1 
	j loopOne
loopTwo:
	#Use the second loop two print the new Line
	li $v0, 4
	la $a0, newLine
	syscall
#Decrement from the register t1 one in order to get the last charater of the string
	li $v0, 11
	subi $t1,$t1,2
	lb $a0,($t1)

#Check if the last and the first are palindromes
forLoop:
	lb $t3,($t0)
	lb $t4, ($t1)
	bne $t3,$t4,wordNotPalindrome
	la $t3,wordString 
	beq $t3, $t1, wordPalindrome
	addi $t0,$t0,1
	subi $t1, $t1,1
	j forLoop
	
#Prints the message when the word is not Palindrome
wordNotPalindrome:
	li $v0, 4
	la $a0, notPalindromeMessage
	syscall 
	j exit
	
#Prints the message when the word is Palindrome
wordPalindrome:
	li $v0, 4
	la $a0, palindromeMessage
	syscall

#Tell the compiler the program execution ends here
exit:
	li $v0, 10
        syscall

