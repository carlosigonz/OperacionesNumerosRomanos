 .data
	mensajeEntrada: .asciiz "\nIngrese un numero: \n""
	letraM: .asciiz "M"
	letraCM: .asciiz "CM"
	letraD: .asciiz "D"
	letraCD: .asciiz "CD"
	letraC: .asciiz "C"
	letraXC: .asciiz "XC"
	letraL: .asciiz "L"
	letraXL: .asciiz "XL"
	letraX: .asciiz "X"
	letraIX: .asciiz "IX"
	letraV: .asciiz "V"
	letraIV: .asciiz "IV"
	letraI: .asciiz "I"
.text 
    main:                               
    	mostrarInput:
        	la $a0, mensajeEntrada 
        	li $v0, 4 
        	syscall 
                
        getInput:
        	li $v0, 5
                syscall 
                move $a1, $v0
                
	conversion:

		bgt $a1, 999, M
		bgt $a1, 899, CM
		bgt $a1, 499, D
		bgt $a1, 399, CD
		bgt $a1, 99, C
		bgt $a1, 89, XC
		bgt $a1, 49, L
		bgt $a1, 39, XL
		bgt $a1, 9, X
		bgt $a1, 8, IX
		bgt $a1, 4, V
		bgt $a1, 3, IV
		bgt $a1, 0, I
		
		li $v0, 10 
        	syscall 
        	
	M:
		sub $a1, $a1, 1000
		la $t1, letraM
		jal concatenation
    		j conversion
	CM:
		sub $a1, $a1, 900
		la $t1, letraCM
		jal concatenation
		j conversion
	D:
		sub $a1, $a1, 500
		la $t1, letraD
		jal concatenation
		j conversion
	CD:
		sub $a1, $a1, 400
		la $t1, letraCD
		jal concatenation
		j conversion
	C:
		sub $a1, $a1, 100
		la $t1, letraC
		jal concatenation
		j conversion
	XC:
		sub $a1, $a1, 90
		la $t1, letraXC
		jal concatenation
		j conversion
	L:
		sub $a1, $a1, 50
		la $t1, letraL
		jal concatenation
		j conversion
	XL:
		sub $a1, $a1, 40
		la $t1, letraXL
		jal concatenation
		j conversion
	X:
		sub $a1, $a1, 10
		la $t1, letraX
		jal concatenation
		j conversion
	IX:
		sub $a1, $a1, 9
		la $t1, letraIX
		jal concatenation
		j conversion
	V:
		sub $a1, $a1, 5
		la $t1, letraV
		jal concatenation
		j conversion
	IV:
		sub $a1, $a1, 4
		la $t1, letraIV
		jal concatenation
		j conversion
	I:
		sub $a1, $a1, 1
		la $t1, letraI
		jal concatenation
		j conversion
	
	concatenation:
		la $a0, ($t1) 
        	li $v0, 4 
        	syscall 
		jr $ra
