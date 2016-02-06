.globl main                     # Make main global so you can refer to it by name in QtSPIM.

.data                           # start putting stuff in the data segment

oddNum:   .asciiz "Odd numbers from 1 to 50 are: \n"
subSum:   .asciiz "Subtracting the sum of even/odd numbers: \n"
printSum: .asciiz "The sum total of adding all of the numbers was: "
space:    .asciiz " "
comma:    .asciiz ", "
newline:  .asciiz "\n"

odd:      .word 0     #variable for odd number sum
even:     .word 0     #variable for even number sum

# This line tells the computer this is the text section of the program. (No data contained here).
.text 
main:

    # Print prompt evenNum
    li $v0, 4                     # system call code for print_str
    la $a0, evenNum               # address of string to print
    syscall                       # print the string

    # Even numbers 
    li $t0, 0                     # load immediate 0 into $a0

    # Generate all of the even numbers
    evenGen:
        li  $v0, 1                # system call code for print integer
        addi $t0, $t0, 2          # Add two to $t0 : to get $t0 = 2, 4, 6, 8... 
        add  $t4, $t0, $t4        # Add the even numbers up in register $t4.
        
        #Store sum into variable odd.
        sw   $t0, even            # store number into odd
        move $a0, $t0             # load number into argument $v0
        syscall                   # print the number

        # Print space
        li $v0, 4                 # system call code for print_str
        la $a0, space             # print comma
        syscall                   # print the string
        bne  $t0, 50, evenGen     # break if $t0 is 50 
   
    #Print prompt 
    li $v0, 4                  # system call code for print_str
    la $a0, newline            # load address of newline into $a0
    syscall                    # print to console
    la $a0, printSum           # load address of printsum prompt
    syscall                    # system call to print to console

    # Store even number
    sw $t4, even               # store sum into even variable  
    
    # Print the sum of the even number
    li $v0, 1                  # load system call code for print integer
    move $a0, $t4              # move the sum into $a0             
    syscall                    # print to terminal 
    
    # print newline    
    li $v0, 4                  # load system call code for print_str
    la $a0, newline            # load address of newline
    syscall                    # print to terminal
    syscall                    # do it again

    # Print prompt oddNum
    la $a0, oddNum             # address of string to print
    syscall                    # print the string

    #clear registers
    move $t4, $zero            # zero out $t4 

    # Odd numbers are generated using 2n + 1
    li $t0, 1                  # load immediate 1 into program
    li $v0, 1                  # system call code for print integer
    move $a0, $t0              # move $t0 into $a0 
    syscall                    # print the number 1
    
    # Print space
    li $v0, 4                  # system call code for print_str
    la $a0, space              # print comma
    syscall                    # print the string
    
    add $t4, $t4, $t0          # Add 1 to $t4 register
    
    # Generate all of the odd numbers
    oddGen:
        li  $v0, 1             # system call code for print integer
        addi $t0, $t0, 2       # add by two every time
        add  $t4, $t0, $t4     # add up all of the odd numbers
        
        # Print the integer
        move $a0, $t0          # move the value into $a0 to print to screen                  
        syscall                # print the integer
        
        # Print space
        li $v0, 4              # system call code for print_str
        la $a0, space          # print comma
        syscall                # print the string
        
        bne  $t0, 49, oddGen   # break if $t0 is 50 

    #Print sum of all even numbers
    li $v0, 4                  # system call code for print_str
    la $a0, newline            # load address of newline into $a0
    syscall                    # print to console
    la $a0, printSum           # load address of printsum prompt
    syscall                    # system call to print to console

    li $v0, 1                  # load system call code for print integer
    move $a0, $t4              # move the sum into $a0  
    syscall                    # print to terminal 
    
    # Store odd number
    sw $t4, odd 

    # print newline    
    li $v0, 4                  # load system call code for print_str
    la $a0, newline            # load address of newline
    syscall                    # print to terminal
    syscall                    # do it again

    # Print prompt subNum
    li $v0, 4           # system call code for print_str
    la $a0, subSum      # address of string to print
    syscall             # print the string

    # Clear register
    move $a0, $zero

    # Subtract even from odd -> odd - even
    lw $s0, even        # load number into $s0
    lw $s1, odd         # load number in $s1 
    sub $a0, $s0, $s1   # subtract two numbers
    
    # Print the integer
    li $v0, 1           # system call code for print integer
    syscall

    # Beam me up Scotty 
ori $v0, $0, 10         # Sets $v0 to "10" so when syscall is executed, program will exit.
syscall # Exit.
