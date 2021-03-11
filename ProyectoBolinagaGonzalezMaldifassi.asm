.data
	separador: .asciiz "\n-------------------------------------------------------------------------------------------------------------------\n"
	saludo: .asciiz  "Bienvenido a operaciones algebraicas con números romanos!\n"
	menu: .asciiz "Seleccione: \n1.Suma\n2.Resta\n3.Multiplicación\n"
	msjSuma: .asciiz "\nSuma\n"
	msjResta: .asciiz "\nResta\n"
	msjMulti: .asciiz "\nMultiplicación\n"
	entrada1: .asciiz "Ingrese el primer número Romano: "
	entrada2: .asciiz "\nIngrese el segundo número Romano: "
	numero1: .space 15
	numero2: .space 15
	msj1: .asciiz "El primer número es: "
	msj2: .asciiz "\nEl segundo número es: "
	resultado: .asciiz "El resultado de la operación es: "
	
	.macro separacion()
	li $v0,4
	la $a0, separador
	syscall
	.end_macro 
.text
	#imprime saludo
	li $v0,4
	la $a0, saludo
	syscall
	
	separacion()
	#imprime separacion
	#li $v0,4
	#la $a0, separador
	#syscall
	
	#imprime menu
	li $v0,4
	la $a0, menu
	syscall
	
	#Recibir seleccion
	li $v0,5
	syscall 
	
	move $t0,$v0
	beq $t0,1,suma
	beq $t0,2,resta
	beq $t0,3,multi
	
	suma:
		#imprime msj
		li $v0,4
		la $a0, msjSuma
		syscall
		b final
		
	resta:
		#imprime msj
		li $v0,4
		la $a0, msjResta
		syscall
		b final
	multi:
		#imprime msj
		li $v0,4
		la $a0, msjMulti
		syscall
	final:
		#imprime mensaje de entrada pri-num
		li $v0,4
		la $a0, entrada1
		syscall
		
		#toma el pri-num
		li $v0,8
		la $a0, numero1
		li $a1,15
		syscall
	
		#imprime mensaje de entrada sec-num
		li $v0,4
		la $a0, entrada2
		syscall
	
		#toma el sec-num
		li $v0,8
		la $a0, numero2
		li $a1,15
		syscall
	
		separacion()
	
		#imprime mensaje de pri-num
		li $v0,4
		la $a0,msj1
		syscall
	
		#imprime el pri-num
		li $v0,4
		la $a0, numero1
		syscall
	
		#imprime mensaje de sec-num
		li $v0,4
		la $a0,msj2
		syscall 
	
		#imprime el sec-num
		li $v0,4
		la $a0, numero2
		syscall
	
		separacion()
	
		#imprime resultado
		li $v0,4
		la $a0, resultado
		syscall
	
		#fin del programa
		li $v0,10
		syscall	