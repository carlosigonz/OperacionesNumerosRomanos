.data
	separador: .asciiz "\n-------------------------------------------------------------------------------------------------------------------\n"
	saludo: .asciiz  "Bienvenido a operaciones algebraicas con números romanos!\n"
	menu: .asciiz "Seleccione: \n1.Suma\n2.Resta\n3.Multiplicación\n"
	entrada1: .asciiz "Ingrese el primer número Romano: \n"
	entrada2: .asciiz "Ingrese el segundo número Romano: \n"
	numero1: .space 10
	numero2: .space 10
	msj1: .asciiz "El primer número es: "
	msj2: .asciiz "El segundo número es: "
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
	
	#imprime mensaje de entrada
	li $v0,4
	la $a0, entrada
	syscall
	
	#toma el numero romano
	li $v0,8
	la $a0, numero
	li $a1,10
	syscall
	
	li $v0,4
	la $a0,msj1
	syscall
	#imprime mensaje de despedida
	#li $v0,4
	#la $a0, num1
	#syscall 
	
	#imprime el numero insertado
	li $v0,4
	la $a0, numero
	syscall 
	
	#fin del programa
	li $v0,10
	syscall	