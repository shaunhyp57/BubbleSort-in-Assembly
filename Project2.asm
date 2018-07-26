.data
msg1: .asciiz "\nEnter integer values followed by return (-1 terminates input): \n"
msg2: .asciiz ","
msg3: .asciiz "Bubble Sort"
msg4: .asciiz "#########pass#########"
msg5: .asciiz "\n"
msg6: .asciiz "\nNumber list has been sorted\n"
msg7: .asciiz "\nEnter your request:\n1. Sort ascending\n2. Sort descending\n3. Calculate maximum\n4. Calculate minimum\n5. Find average\n6. Search a key\n7. Exit\n"
msg8: .asciiz "\nMax value is "
msg9: .asciiz "\nMin value is "
msg10: .asciiz "\nAverage is "
msg11: .asciiz " with a remainder of "
msg12: .asciiz "\nWhat number would you like to search for?\n"
msg13: .asciiz "\nThe key, "
msg14: .asciiz ", was found\n"
msg15: .asciiz ", was not found\n"
msg16: .asciiz " "
msg17: .asciiz "This program will take a list a numbers given by the user and be\nable to run a series of commands with those numbers, such as\nsort ascending and descending, find max and min, find the average,\nand search for a key\n"
msg18: .asciiz "\nDevelopers: Shauna Hyppolite and Spencer Ross\n\n"
.text 				
		
.globl main
main:
	move $s0, $gp			# get the intial point to save array
	add $s5, $zero, $zero		# initialize length of array to 0
	sub $t7, $zero, 1		# terminate
	li $v0, 4			# system call to put the string
	la $a0, msg17			# program info
	syscall	
	li $v0, 4			# system call to put the string
	la $a0, msg18			# developer info
	syscall		       
	li $v0, 4			# system call to put the string
	la $a0, msg1			
	syscall		
	add $s1, $s0, $zero		# copy the pointer to array in $s1
entervalues:
	li $v0, 5			# get the value in v0 
	syscall				 
	beq $v0, $t7, menu		# end of string run to bubblesort
	sw $v0, 0($s1)			# put the value at the position pointed by $s1
	addi $s5, $s5, 1		# increment length of array
	addi $s1, $s1, 4		# move the $s1 pointer by 4
	j entervalues
menu:
	add $t0, $zero, 1		# option 1: sort ascending
	add $t1, $zero, 2		# option 2: sort descending
	add $t2, $zero, 3		# option 3: calculate max
	add $t3, $zero, 4		# option 4: calculate min
	add $t4, $zero, 5		# option 5: find average
	add $t5, $zero, 6		# option 6: search key
	add $t6, $zero, 7		# option 7: exit
	li $v0, 4			# system call to print the string
	la $a0, msg7		
	syscall
	li $v0, 5			# get the value in v0 
	syscall				
	beq $v0, $t0, ascendingbs	# end of string run to ascending bubblesort
	beq $v0, $t1, descendingbs	# end of string run to descending bubblesort
	beq $v0, $t2, max		# end of string run to calculate max
	beq $v0, $t3, min		# end of string run to calculate min
	beq $v0, $t4, average		# end of string run to find average
	beq $v0, $t5, searchkey		# end of string run to search key
	beq $v0, $t6, exit		# end of string run to exit		
ascendingbs:
	addi $s4, $zero, 0		# initialization for outerloop: i = 0
	add $s1, $s0, $zero		# copy the pointer to array in $s1 
outerloop1:
	slt $t0, $s4, $s5		# outer for-loop condition statment: i < length
	beq $t0, $zero, exascbs		# breaks outerloop if false
	addi $s3, $zero, 0		# initialize swap = 0 before inner loop
	addi $t3, $zero, 0		# initialization for innerloop: j = 0
	add $s1, $s0, $zero		# copy the pointer to array in $s1
innerloop1:
	sub $t0, $s5, $s4		# length - i for innerloop conditional statement
	sub $t0, $t0, 1			# length-i-1
	slt $t0, $t3, $t0		# inner for-loop condition statement: j < (length-i-1)
	beq $t0, $zero, if1		# if false, breaks inner loop
	sll $t4, $t3, 2
	add $s2, $t4, $s1		# address for array + j
	lw $t0, 0($s2)			# load array[j] into register
	lw $t1, 4($s2)			# load array[j+1] into register
	slt $t2, $t1, $t0		# condition statement: if array[j] > array[j+1]
	beq $t2, $zero, else1		# if false, jumps to else statement
	sw $t1, 0($s2)			# array[j] = array[j+1]
	sw $t0, 4($s2)			# array[j+1] = x
	addi $s3, $zero, 1		# swap = 1
else1:
	addi $t3, $t3, 1		# increment for inner loop: j++
	j innerloop1			# jump to beginning of inner loop
if1:
	bne $s3, $zero, inci1		# if swap != 0
	j exascbs			# exit ascending
inci1:
	addi $s4, $s4, 1		# increment for outer loop: i++
	j outerloop1			# jump to beginning of outerloop
exascbs:
	li $v0, 4			# system call to put the string
	la $a0, msg6
	syscall
	j printarray
	j menu
descendingbs:
	addi $s4, $zero, 0		# initialization for outerloop: i = 0
	add $s1, $s0, $zero		# copy the pointer to array in $s1 
outerloop2:
	slt $t0, $s4, $s5		# outer for-loop condition statment: i < length
	beq $t0, $zero, exdscbs		# breaks outerloop if false
	addi $s3, $zero, 0		# initialize swap = 0 before inner loop
	addi $t3, $zero, 0		# initialization for innerloop: j = 0
	add $s1, $s0, $zero		# copy the pointer to array in $s1
innerloop2:
	sub $t0, $s5, $s4		# length - i for innerloop conditional statement
	sub $t0, $t0, 1
	slt $t0, $t3, $t0		# inner for-loop condition statement: j < (length-i-1)
	beq $t0, $zero, if2		# if false, breaks inner loop
	sll $t4, $t3, 2
	add $s2, $t4, $s1		# address for array + j
	lw $t0, 0($s2)			# load array[j] into register
	lw $t1, 4($s2)			# load array[j+1] into register
	slt $t2, $t0, $t1		# condition statement: if array[j] > array[j+1]
	beq $t2, $zero, else2		# if false, jumps to else statement
	sw $t1, 0($s2)			# array[j] = array[j+1]
	sw $t0, 4($s2)			# array[j+1] = x
	addi $s3, $zero, 1		# swap = 1
else2:
	addi $t3, $t3, 1		# increment for inner loop: j++
	j innerloop2			# jump to beginning of inner loop
if2:
	bne $s3, $zero, inci2		# if swap != 0
	j exdscbs			# exit ascending
inci2:
	addi $s4, $s4, 1		# increment for outer loop: i++
	j outerloop2			# jump to beginning of outerloop
exdscbs:
	li $v0, 4			# system call to put the string
	la $a0, msg6
	syscall
	j printarray
	j menu
max:
	add $t0, $zero, $zero		# initialize i = 0
	add $t1, $zero, $zero		# initialize max = 0
	add $s1, $s0, $zero		# copy the pointer to array in $s1
	lw  $t1, 0($s1)			# set max to equal array[0]
loop1:
	slt $t2, $t0, $s5		# for-loop condition statment: i < length
	beq $t2, $zero, printmax	# if false, jump to print max
	sll $t3, $t0, 2			# shift i by 2 to get i x 4 for the address of array + i
	add $s2, $s1, $t3		# address for array + i
	lw $t4, 0($s2)			# load array[i] into register
	slt $t5, $t1, $t4		# conditional if (max < array[i])
	beq $t5, $zero, inci3		# if max < array, increment i
	add $t1, $zero, $t4		# set max = array[i]
inci3:
	add $t0, $t0, 1			# i++
	j loop1				# jump to beginning of loop
printmax:
	li $v0, 4			# system call to print the string
	la $a0, msg8			# print max message
	syscall
	li $v0, 1			# system call to print integer
	add $a0, $t1, $zero		# print max
	syscall
	li $v0, 4			# system call to print the string
	la $a0, msg5		
	syscall
	j menu				# jump back to menu
min:
	add $t0, $zero, $zero		# initialize i = 0
	add $t1, $zero, $zero		# initialize min = 0
	add $s1, $s0, $zero		# copy the pointer to array in $s1
	lw  $t1, 0($s1)			# set max to equal array[0]
loop2:
	slt $t2, $t0, $s5		# for-loop condition statment: i < length
	beq $t2, $zero, printmin	# if false, jump to print min
	sll $t3, $t0, 2			# shift i by 2 to get i x 4 for the address of array + i
	add $s2, $s1, $t3		# address for array + i
	lw $t4, 0($s2)			# load array[i] into register
	slt $t5, $t4, $t1		# conditional if (min > array[i])
	beq $t5, $zero, inci4		# if min > array[i], increment i
	add $t1, $zero, $t4		# set min = array[i]
inci4:
	add $t0, $t0, 1			# i++
	j loop2				# jump to beginning of loop
printmin:
	li $v0, 4			# system call to print the string
	la $a0, msg9			# print min message
	syscall
	li $v0, 1			# system call to print integer
	add $a0, $t1, $zero		# print min
	syscall
	li $v0, 4			# system call to print the string
	la $a0, msg5		
	syscall
	j menu				# jump back to menu
average:
	add $t0, $zero, $zero		# initialize i = 0
	add $t1, $zero, $zero		# initialize total = 0
	add $t5, $zero, $zero		# initialize quotient = 0
	add $t6, $zero, $zero		# initialize remainder = 0
	add $s1, $s0, $zero		# copy the pointer to array in $s1
loop3:
	slt $t2, $t0, $s5		# for-loop condition statment: i < length
	beq $t2, $zero, printavg	# if false, jump to print avg
	sll $t3, $t0, 2			# shift i by 2 to get i x 4 for the address of array + i
	add $s2, $s1, $t3		# address for array + i
	lw $t4, 0($s2)			# load array[i] into register
	add $t1, $t1, $t4		# set total += array[i]
inci5:
	add $t0, $t0, 1			# i++
	j loop3				# jump to beginning of loop
printavg:
	div $t1, $s5			# total / length
	mflo $t5			# set quotient
	mfhi $t6			# set remainder
	li $v0, 4			# system call to print the string
	la $a0, msg10			# print first avg message
	syscall
	li $v0, 1			# system call to print integer
	add $a0, $t5, $zero		# print quotient
	syscall
	li $v0, 4			# system call to print the string
	la $a0, msg11			# "with a remainder of "
	syscall
	li $v0, 1			# system call to print integer
	add $a0, $t6, $zero		# print remainder
	syscall
	li $v0, 4			# system call to print the string
	la $a0, msg5		
	syscall
	j menu				# jump back to menu
searchkey:
	li $v0, 4			# system call to print the string
	la $a0, msg12		
	syscall
	li $v0, 5			# get the value in v0 
	syscall				
	add $t0, $zero, $zero		# initialize i = 0
	add $t1, $zero, $zero		# initialize found = 0
	add $t5, $v0, $zero		# initialize key to user input
	add $s1, $s0, $zero		# copy the pointer to array in $s1
loop4:
	slt $t2, $t0, $s5		# for-loop condition statment: i < length
	beq $t2, $zero, printkey	# if false, jump to print if found key
	sll $t3, $t0, 2			# shift i by 2 to get i x 4 for the address of array + i
	add $s2, $s1, $t3		# address for array + i
	lw $t4, 0($s2)			# load array[i] into register
	bne $t5, $t4, inci6		# conditional if (key != array[i])
	addi $t1, $zero, 1		# set found = 1 if key == array[i]
inci6:
	add $t0, $t0, 1			# i++
	j loop4				# jump to beginning of loop
printkey:
	bne $t1, $zero, printfound
	li $v0, 4			# system call to print the string
	la $a0, msg13			# print "The key "
	syscall
	li $v0, 1			# system call to print integer
	add $a0, $t5, $zero		# print key
	syscall
	li $v0, 4			# system call to print the string
	la $a0, msg15			# "was not found"
	syscall
	li $v0, 4			# system call to print the string
	la $a0, msg5		
	syscall
	j menu				# jump back to menu
printfound:
	li $v0, 4			# system call to print the string
	la $a0, msg13			# print "The key "
	syscall
	li $v0, 1			# system call to print integer
	add $a0, $t5, $zero		# print key
	syscall
	li $v0, 4			# system call to print the string
	la $a0, msg14			# "was found"
	syscall
	li $v0, 4			# system call to print the string
	la $a0, msg5		
	syscall
	j menu				# jump back to menu
printarray:
	add $t0, $zero, $zero		# initialize i = 0
	add $s1, $s0, $zero		# copy the pointer to array in $s1
loop5:
	slt $t1, $t0, $s5		# for-loop condition statment: i < length
	beq $t1, $zero, menu		# if false, jump to menu
	sll $t2, $t0, 2			# shift i by 2 to get i x 4 for the address of array + i
	add $s2, $s1, $t2		# address for array + i
	lw $t3, 0($s2)			# load array[i] into register		
	li $v0, 1			# system call to print the integer
	add $a0, $t3, $zero		# print integer in array[i]
	syscall
	li $v0, 4			# system call to print the string
	la $a0, msg16			# print space between each number
	syscall
	addi $t0, $t0, 1		# i++
	j loop5
exit:
	li $v0, 10			# system call to exit program
	syscall