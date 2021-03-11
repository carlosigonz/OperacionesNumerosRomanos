.data
	separador: .asciiz "\n-------------------------------------------------------------------------------------------------------------------\n"
	saludo: .asciiz  "Bienvenido a operaciones algebraicas con números romanos!\n"
	menu: .asciiz "Seleccione: \n1.Suma\n2.Resta\n3.Multiplicación\n"
	entrada1: .asciiz "Ingrese el primer número Romano: "
	entrada2: .asciiz "Ingrese el segundo número Romano: "
	numero1: .space 15
	numero2: .space 15
	msj1: .asciiz "El primer número es: "
	msj2: .asciiz "\nEl segundo número es: "
	resultado: .asciiz "El resultado de la operación es: "
.text
	#imprime saludo
	li $v0,4
	la $a0, saludo
	syscall
	
	#imprime separacion
	li $v0,4
	la $a0, separador
	syscall
	
	#imprime menu
	li $v0,4
	la $a0, menu
	syscall
	
	#imprime mensaje de entrada pri-num
	li $v0,4
	la $a0, entrada1
	syscall
	
	#toma el pri-num
	li $v0,8
	la $a0, numero1
	li $a1,10
	syscall
	
	#imprime mensaje de entrada sec-num
	li $v0,4
	la $a0, entrada2
	syscall
	
	#toma el sec-num
	li $v0,8
	la $a0, numero2
	li $a1,10
	syscall
	
	#imprime separacion
	li $v0,4
	la $a0, separador
	syscall
	
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
	
	#imprime separacion
	li $v0,4
	la $a0, separador
	syscall
	
	#imprime resultado
	li $v0,4
	la $a0, resultado
	syscall
	
	#fin del programa
	li $v0,10
	syscall	