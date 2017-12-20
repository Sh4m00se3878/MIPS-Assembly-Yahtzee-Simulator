#Seamus Tynan MIPS Yahtzee Project  
	.data
Dice: 		.byte 		0, 0, 0, 0, 0  		# Array of bytes to store in Die 1-5. Initialized to 0 for all values
i:		.byte		0			# Array counter, initialized to 0
DiceAmt:	.byte		5			# Initial Dice ammount set to 5
IntroMsg:	.asciiz		"Welcome to Yahtzee sim!\n"
YAHTZEE:	.asciiz 	"YAHTZEEEE!!!!!!!\n"
NOTYAHTZEE:	.asciiz 	"Not Yahtzee... :(\n"
TurnMsg:	.asciiz 	"Turn: "
FaceMsg:	.asciiz 	"Your face value for yahtzee was: "
EndGame:	.asciiz		"Game over..."
DiceDisplay:	.asciiz		"The face values of your dice were: "
DieReroll1:	.asciiz		"\nDo you want to reroll Die1? 0==no, 1==yes \n"
DieReroll2:	.asciiz		"Do you want to reroll Die2? \n"
DieReroll3:	.asciiz		"Do you want to reroll Die3? \n"
DieReroll4:	.asciiz		"Do you want to reroll Die4? \n"
DieReroll5:	.asciiz		"Do you want to reroll Die5? \n"
	.text
Main:	
	li $v0, 4
	la $a0, IntroMsg 		# Displays start message
	syscall
	
	addi $t6, $zero, 1
	addi $t7, $zero, 1
	addi $t8, $zero, 1
	addi $t9, $zero, 1
	addi $v1, $zero, 1

	lb $s1, DiceAmt			# Begins game with 5 dice

	lb $s0, i			# Array Counter 
	
Loop:	
	jal ROLLDICE 			# jump to the dice rolling procedure.
	addi $s0, $s0, 1		# Increment counter
	bge $s0, 3, EXIT		# while (ArrayAmmt < 3){
	bne $t1, $t2, NotYahtzee
	bne $t2, $t3, NotYahtzee
	bne $t3, $t4, NotYahtzee
	bne $t4, $t5, NotYahtzee
	jal, Yahtzee
	
	j Loop				# Return to top of loop
EXIT:	
	li $v0, 4
	la $a0, EndGame 		# Displays game over
	syscall
	
	li $v0, 10			# Hopefully Exits code
	syscall
	

Yahtzee:
	li $v0, 4		# Displays Yahtzee
	la $a0, YAHTZEE
	syscall
	
	li $v0, 4		# Displays message prior to turn #
	la $a0, TurnMsg
	syscall
	
	li $v0, 1		# Displays the turn #
	addi $a0, $s0, 1
	syscall
	
	li $v0, 4		# Displays message prior to dice value
	la $a0, FaceMsg
	syscall
	
	li $v0, 1		# Displays the dice value 
	addi $a0, $t1, 1
	syscall
	
	li $v0, 10		# Hopefully Exits code
	syscall
	
NotYahtzee: 							#################################
	li $v0, 4		# Displays NotYahtzee
	la $a0, NOTYAHTZEE
	syscall
	
	li $v0, 4		# Message to user prior to dice output
	la $a0, DiceDisplay
	syscall	
	
	li $v0, 1		# Outputs dice values
	add $a0, $t1, $zero
	syscall
	add $a0, $t2, $zero
	syscall
	add $a0, $t3, $zero
	syscall
	add $a0, $t4, $zero
	syscall
	add $a0, $t5, $zero
	syscall
	
	li $v0, 4		# Dice 1 Reroll prompt
	la $a0, DieReroll1
	syscall
	li $v0, 5		# Ask user if they want to reroll first die
	syscall
	add $t6, $v0, $zero
	
	li $v0, 4		# Dice 2 Reroll prompt
	la $a0, DieReroll2
	syscall
	li $v0, 5		# Ask user if they want to reroll first die
	syscall
	add $t7, $v0, $zero
	
	li $v0, 4		# Dice 3 Reroll prompt
	la $a0, DieReroll3
	syscall
	li $v0, 5		# Ask user if they want to reroll first die
	syscall
	add $t8, $v0, $zero
	
	li $v0, 4		# Dice 4 Reroll prompt
	la $a0, DieReroll4
	syscall
	li $v0, 5		# Ask user if they want to reroll first die
	syscall
	add $t9, $v0, $zero
	
	li $v0, 4		# Dice 5 Reroll prompt
	la $a0, DieReroll5
	syscall
	li $v0, 5		# Ask user if they want to reroll first die
	syscall
	add $v1, $v0, $zero
	
	
ROLLDICE:			# Accepts $a0, which is the # of dice rolled
	#li $t6, $a0
	#bgt $a0, 5, Else 	# if (DICE($a0) <= 5 AND >= 1)
	#blt $a0, 1, Else
	
	beq $t6, $zero, skip1
	li $a1, 6
	li $v0, 42		# RollDice 1
	syscall
	add $t1, $a0, $zero
	addi $t1, $t1, 1

skip1:
	#blt $t7, 2, NUMDICE 1 	# If DICE >= 2
	beq $t7, 0, skip2
	li $a1, 6
	li $v0, 42		# RollDice 2
	syscall
	add $t2, $a0, $zero
	addi $t2, $t2, 1
skip2:	
	#blt $t7, 3, NUMDICE 2	# If DICE >= 3
	beq $t8, 0, skip3
	li $a1, 6
	li $v0, 42		# RollDice 3
	syscall
	add $t3, $a0, $zero
	addi $t3, $t3, 1
skip3:
	#blt $t7, 4, NUMDICE 3	# If DICE >= 4
	beq $t9, 0, skip4
	li $a1, 6
	li $v0, 42		# RollDice 4
	syscall
	add $t4, $a0, $zero
	addi $t4, $t4, 1
skip4:
	#blt $t7, 5, NUMDICE 4	# If DICE >= 5
	beq $v1, 0, skip5
	li $a1, 6
	li $v0, 42		# RollDice 5
	syscall
	add $t5, $a0, $zero
	addi $t5, $t5, 1
skip5:
	
NUMDICE5:	
	jr $ra 
		
NUMDICE1:	addi $t1, $t1, 1	# When 1 die is present, and add 1 to find actual dice face value
		jr $ra 
		
NUMDICE2:	addi $t1, $t1, 1	# When 2 dice are present, and add 1 to find actual dice face value
		addi $t2, $t2, 1
		jr $ra 
		
NUMDICE3:	addi $t1, $t1, 1	# When 3 dice are present, and add 1 to find actual dice face value
		addi $t2, $t2, 1
		addi $t3, $t3, 1
		jr $ra 
		
NUMDICE4:	addi $t1, $t1, 1	# When 4 dice are present, and add 1 to find actual dice face value
		addi $t2, $t2, 1
		addi $t3, $t3, 1
		addi $t4, $t4, 1
		jr $ra 
		
Else: 	addi $v0, $zero, -1
	jr $ra
