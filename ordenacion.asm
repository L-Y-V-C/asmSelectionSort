.text
.globl __start

__start:
addi $s2, $zero, 10 # guarda 10 en s2
la $s1,lista # carga listas
lw $t0,0($s1) # initialize minimum in t0 to A[0]
addi $t5,$s1,0 # save adress of minimum in $t5
addi $t1,$zero,0 # initialize index i to 0
addi $t8,$zero,0 # initialize index j to 0
addi $s3,$s1,0 # copy address s1 in s3
addi $s4,$zero,0 # for 1st print
la $a0,textLista
li $v0,4
syscall

la $a0,0($t0)
li $v0,1
syscall

loop: 
add $t1,$t1,1 # increment index i by 1
beq $t1,$s2,change # if all elements examined, quit
add $t2,$t1,$t1 # compute 2i in $t2
add $t2,$t2,$t2 # compute 4i in $t2
add $t2,$t2,$s1 # form address of A[i] in $t2

lw $t3,0($t2) # load value of A[i] into $t3

beq $s4,$zero,print
bne $s4,$zero,continue
print:
la $a0,space
li $v0,4
syscall
la $a0,0($t3)
li $v0,1
syscall

continue:
slt $t4,$t3,$t0 # A[i] t3 < minimum $t0 ? save res in t4
beq $t4,$zero,loop # if not, repeat with no change
addi $t0,$t3,0 # if so, A[i] is the new minimum
addi $t5,$t2,0 # save adress of new minimum in $t5
j loop # change completed; now repeat

change:

addi $s4,$zero,1 # for print

lw $t6,0($t5) # t6 = valor minimo (direccion)
lw $t7,0($s3) # t7 = new 1st element
sw $t6,0($s3) # t6 to new 1st position array
sw $t7,0($t5) # t7 to minimum num position

add $t8,$t8,1 # increment index j by 1
beq $t8,$s2,done
add $t9,$t8,$t8 # compute 2j in $t9
add $t9,$t9,$t9 # compute 4j in $t9
add $s3,$t9,$s1 # form address of A[j] in $s3

addi $t1,$t8,0 # initialize index i = j
lw $t0,0($s3) # initialize minimum in t0 to A[j]
addi $t5,$s3,0 # save adress of minimum in $t5
j loop

done: # continuation of the program

addi $t1,$zero,0 # index in 0
lw $t0,0($s1) # t0 = A[0]
addi $t2,$zero,0 # t2 in 0

la $a0,endl
li $v0,4
syscall

la $a0,textListOrd
li $v0,4
syscall

la $a0,0($t0)
li $v0,1
syscall

printLoop: 
add $t1,$t1,1 # increment index i by 1
beq $t1,$s2,fin # if all elements examined, quit
add $t2,$t1,$t1 # compute 2i in $t2
add $t2,$t2,$t2 # compute 4i in $t2
add $t2,$t2,$s1 # form address of A[i] in $t2

lw $t3,0($t2) # load value of A[i] into $t3

la $a0,space
li $v0,4
syscall

la $a0,0($t3)
li $v0,1
syscall

j printLoop

fin:

li $v0,10
syscall

.data
textMin: .asciiz "numero menor: "
textLista: .asciiz "Lista: "
textListOrd: .asciiz "Lista ordenada: "
endl: .asciiz "\n"
space: .asciiz " "
.align 2
lista: .word  2, 5, 2, 6, 8, 10, 1, 9, 4, 7
