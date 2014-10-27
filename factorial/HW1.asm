# Written by Adam Olgin

# compute the factorial of a number

# Code for factorial in Java
#
# int factorial (int x) {
#    if (x === 0) {
#       return 1;
#    } else {
#       return x * factorial(x-1)
# }

.data
prompt_contents: .asciiz "Positve Integer: "
prompt: .word prompt_contents

result_contents_p1: .asciiz "The value of factorial ("
result_p1: .word result_contents_p1

result_contents_p2: .asciiz ") is: "
result_p2: .word result_contents_p2

.text
# int main()
main:

	# prompt the user for input
	# printf("Positive Integer: ");
	la	$t0, prompt		# load address of the prompt message
	lw	$a0, 0($t0)		# load the word into $a0
	li	$v0, 4			# call code for print_string
	syscall				# make the call

	# reading the user input
	# scanf("%d", &number);
	li 	$v0, 5			# call code for read_int
	syscall				# make the call
	move 	$t0, $v0		# save the input to $t0

	move 	$a0, $t0		# move input to $a0
	addi	$sp, $sp, -16		# move stack pointer up 4 words
	sw	$t0, 0($sp)		# store x at top of stack
	sw	$ra, 12($sp)		# store $ra at bottom of the stack
	jal 	factorial		# call factorial

	lw	$t4, 4($sp)		# load result to $t4

	# print the result out
	# printf("The value of 'factorial(%d)' is:  %d\n", number, factorial(number));

	# Part 1/4: printing out the first part of the result string
	la	$t1, result_p1		# load the address of the first part of the result string to $t0
	lw	$a0, 0($t1)		# load the data into $a0
	li	$v0, 4			# call code for print_string
	syscall				# make the call

	# Part 2/4: adding the user input to the result string printout
	lw	$a0, 0($sp)		# load the user's input to $a0
	li	$v0, 1			# call code for print_int
	syscall				# make the call

	# Part 3/4: adding the second and final part of the result message onto the rest
	la	$t2, result_p2		# load the address of the second part of the result string to $t1
	lw	$a0, 0($t2)		# load the data into $a0
	li	$v0, 4			# call code for print_string
	syscall

	# Part 4/4: add the final result to the entire result string
	move	$a0, $t4		# move return value to $a0
	li	$v0, 1			# call code for print_int
	syscall				# make the call

	addi $sp, $sp, 16		# move stack pointer back down

	# return 0;
	li	$v0, 10			# call code for exit
	syscall				# make the call

.text
# int factorial (int x)
factorial:

      	lw 	$t0, 0($sp)		# load user input's current value (x) to $t0
      	beq	$t0, $zero, baseCase	#if (x == 0), branch to the base case

      	# prologue for recursion
      	addi	$t0, $t0, -1		# put x-1 in $t0
      	addi 	$sp, $sp, -16		# move stack pointer up 4 words
      	sw 	$t0, 0($sp)		    # store current number in $t0 to 0($sp)
      	sw 	$ra, 12($sp)		# store stack counter in 12($sp)
      
      	jal 	factorial		# recursive call to factorial
      
      	# acquire current return value (x-1)
      	lw	$ra, 12($sp)		# load the call's $ra
      	lw	$t1, 4($sp)		# load current value to $t1
      	lw	$t2, 16($sp)		# load previous value to $t2
      
      	# x * factorial(x-1)
      	mul	$t3, $t1, $t2		# multiply the the current and previous value
      	sw	$t3, 20($sp)		# store return value in parent's return value
      
      	addi	$sp, $sp, 16		# move stack pointer back down
      
      	jr 	$ra			# jump back
      
.text
# The base case;
# return 1;
baseCase:
  	li      $t0, 1            	# load 1 into register $t0
  	sw      $t0, 4($sp)       	# store 1 into the parent's return value register
  	jr      $ra               	# jump back