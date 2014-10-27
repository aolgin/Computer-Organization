# Written by Adam Olgin
# Assembly Code for Insertion Sort

.globl main
.data
	
# Data to be inputed to the arra
	.align 5
array:  .asciiz "Joe"
	.align 5
	.asciiz "Jenny"
	.align 5
	.asciiz "Jill"
	.align 5
	.asciiz "John"
	.align 5
	.asciiz "Jeff"
	.align 5
	.asciiz "Joyce"
	.align 5
	.asciiz "Jerry"
	.align 5
	.asciiz "Janice"
	.align 5
	.asciiz "Jake"
	.align 5
	.asciiz "Jonna"
	.align 5
	.asciiz "Jack"
	.align 5
	.asciiz "Jocelyn"
	.align 5
	.asciiz "Jessie"
	.align 5
	.asciiz "Jess"
	.align 5
	.asciiz "Janet"
	.align 5
	.asciiz "Jane"
	.align 2
data:	.space 64
space:	.asciiz " "
size:	.word 16
	
# Strings to be printed
preSort_print: .asciiz "Initial Array is: \n"
postSort_print: .asciiz "Insertion sort is finished: \n"
bracket_printF: .asciiz "["
bracket_printL: .asciiz " ]\n"

.text
# int main(void)
main:
	jal 	init_data	# initialize the array

	lw 	$s0, data	# load first word of data into $s0 
	lw	$a1, size	# load the size into $a1
	
	# Part 1/2 for the Pre-Sorted Array Print-Out: printing out the pre-sorted array statement
	# printf("Initial array is:\n")
	la	$a0, preSort_print	# load the data into $a0
	li	$v0, 4			# call code for print_string
	syscall				# make the call
	
	# Part 2/2 for the Pre-Sorted Array Print-Out: print the array itself 
	# print_array(data, size)
	
	la	$a0, data		# load the first string of data array to $a0
	lw	$a1, size		# load the size to $a1
	jal	print_array		# print the data array
	
	# Sort the data with insertionSort
	la	$a0, data		# load the first string of the data array to $a0
	lw	$a1, size		# load the size to $a1
	jal	insertSort		# perform the insertion sort

	# Part 1/2 for the Post-Sorted Array Print-Out: printing out the post-sorted array statement
	# printf("Insertion sort is finished:\n")
	la	$a0, postSort_print	# load the data into $a0
	li	$v0, 4			# call code for print_string
	syscall

	# Part 2/2 for the Post-Sorted Array Print-Out: print the sorted array
	# print_array(data, size)
	la	$a0, data		# load data into $a0 again
	lw	$a1, size		# load size into $a1 again
	jal	print_array		# print the data array

	# exit(0);
	li	$v0, 10			# call code for exit
	syscall				# make the call

.text
init_data:
	li	$t0, 0			# set the index = 0
	
	init_data_loop:
		mul	$t3, $t0, 32		# points to next address in array
		la	$t1, array($t3)		# load the address at $t3 into $t1
		mul	$t2, $t0, 4		# moves to the next pointer in data
		sw	$t1, data($t2)		# store current location in array to $t1
		addi	$t0, $t0, 1		# i++
		bne	$t0, 16, init_data_loop	# if i is not equal to 16, recur
	
	jr 	$ra			# return
	
.text
# void insertSort(char *a[], size_t length)
insertSort: 			# will come back to
	addi	$sp, $sp, -16		# move the stack pointer up
	sw	$ra, 0($sp)		# store the ra in memory at 0($sp)
	sw	$a0, 4($sp)		# store address of data in memory at 4($sp)
	sw	$a1, 8($sp)		# store size in memory at 8($sp)
	
	li	$s0, 1			# $s0 = i = 1
	
	loop:
		lw	$t0, 8($sp)			# load the size into $t0
		beq	$s0, $t0, loop_exit		# if i = size, exit the loop
		
		mul 	$t1, $s0, 4			# multiply i by 4
		lw	$t0, 4($sp)			# load the first string of data
		add	$s2, $t0, $t1			# $s2 is the next string (for str_lt)
		lw	$s2, ($s2)			# 
		
		addi	$s1, $s0, -1			# set $s1 = j = i - 1
		
		comp_loop:
			bltz	$s1, comp_loop_exit	# if j < 0, exit the loop
			
			mul	$t1, $s1, 4		# multiply j by 4
			lw	$t0, 4($sp)		# load string at current location
			add	$t0, $t0, $t1		# a[j]
			
			move 	$a0, $s2 		# move string into $a0
     			lw 	$t0, ($t0) 		# load data at a[j]
      			move 	$a1, $t0 		# move a[j] data into $a1
      			
      			jal 	str_lt			# run the comparison
      			
      			beqz	$v0, comp_loop_exit	# if str_lt returns 0, exit the loop
      			
      			lw 	$t0, 4($sp) 		# load the first address in data
      			mul 	$t1, $s1, 4 		# $t1 = j*4
      			add 	$t0, $t0, $t1 		# first address in data + (j+1) = a[j]
     		 	addi 	$t1, $t0, 4  		# a[j+1] 
      			lw 	$t2, 0($t0) 		# load a[j]
      			sw 	$t2, 0($t1) 		# store a[j+1] at address of a[j]
      
      			addi 	$s1, $s1, -1 	 	# j--
      			b 	comp_loop 		# branch to loop
      				
		comp_loop_exit:
			mul 	$t1, $s1, 4 		# address of j in $t1
  	 		lw 	$t0, 4($sp) 		# load first address in data
    			add 	$t0, $t0, $t1 		# add j to it
    			addi 	$t0, $t0, 4 		# $t0 = a[j + 1]
    			sw 	$s2, 0($t0) 		# store value in a[j + 1]
    
    			addi 	$s0, $s0, 1 		# i++
    			b 	loop 			# branch to loop
    		
    	loop_exit:
    		lw 	$ra, 0($sp)   		# load return address
    		addi 	$sp, $sp, 16 		# move stack pointer back down
    		jr 	$ra 			# return
	

.text
# print an array of pointers
# void print_array(char * a[], const int size)
print_array:

	# load array of pointers and size into temp regs
	move	$t1, $a0		# $t1 = array
	move	$t2, $a1		# $t2 = size
	li	$v0, 4			# call code for print_string
	syscall				# make the call

	# print the left bracket
	la	$a0, bracket_printF	# load the bracket into $a0
	li	$v0, 4			# call code for print_string
	syscall				# make the call
	
	# create a counter i
	move	$t0, $zero		# initialize $t0 to 0 (i = 0)
	
	# recursive step
	print_loop:
		mul	$t5, $t0, 4		# multiply the index by 4
		add	$t6, $t5, $t1		# add to the start address for the next address
		
		# print the space
		la	$a0, space		# move the space into $a0
		li	$v0, 4			# call code for print_string
		syscall				# make the call
	
		# print the string at the current location
		lw	$a0, 0($t6)		# move the space into $a0
		li	$v0, 4			# call code for print_string
		syscall				# make the call
	
		# incrementing and recurring
		addi	$t0, $t0, 1		# i++
		blt	$t0, $t2, print_loop	# if (i < size), recur
	
	# print the right bracket
	la	$a0, bracket_printL	# load the bracket into $a0
	li	$v0, 4			# call code for print_string
	syscall				# make the call
		
	jr	$ra			# return
	
str_lt:
	move	$t0, $a0		# put *x into $t0
	move	$t1, $a1		# put *y into $a1
	
	s_loop:
		lb	$t2, 0($t0)			# load x
		lb	$t3, 0($t1)			# load y
		beq	$t2, $zero, s_loop_exit		# if *x == '\0', exit the loop
		beq	$t3, $zero, s_loop_exit		# if *y == '\0', exit the loop
		blt	$t2, $t3, returnOne		# if *x < *y, return 1
		blt	$t3, $t2, returnZero		# if *y < *x, return 1
		addi	$t0, $t0, 1			# x++
		addi	$t1, $t1, 1			# y++
		b 	s_loop
	s_loop_exit:
		beq	$t3, $zero, returnZero		# if *y == '\0', return 0
		b	returnOne			# return 1
	returnZero:
		li	$v0, 0				# load 0 into $v0
		b	next				# branch to the next
	returnOne:
		li	$v0, 1				# load 1 into $v0
	next:
		jr 	$ra				# return
