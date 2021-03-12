.data
	separador: .asciiz "\n-------------------------------------------------------------------------------------------------------------------\n"
	saludo: .asciiz  "Bienvenido a operaciones aritm�ticas con n�meros romanos!"
	menu: .asciiz "\nSeleccione operaci�n (Ingrese el n�mero): \n1.Suma (A+B)\n2.Resta (A-B)\n3.Multiplicaci�n (A*B)\n"
	msjSuma: .asciiz "\nSuma\n"
	msjResta: .asciiz "\nResta\n"
	msjMulti: .asciiz "\nMultiplicaci�n\n"
	entrada1: .asciiz "Ingrese el primer n�mero Romano: "
	entrada2: .asciiz "\nIngrese el segundo n�mero Romano: "
	numero1: .space 15
	numero2: .space 15
	msj1: .asciiz "El primer n�mero (A) es: "
	msj2: .asciiz "El segundo n�mero (B) es: "
	resultado: .asciiz "El resultado de la operaci�n es: "
	
	.macro separacion
	li $v0,4
	la $a0, separador
	syscall
	.end_macro
	
	.macro printMsj(%label)
	li $v0,4
	la $a0,%label
	syscall
	.end_macro 
.text
	#imprime saludo
	printMsj(saludo)
	
	separacion
	#imprime mensaje de entrada pri-num
	printMsj(entrada1)
		#toma el pri-num
	li $v0,8
	la $a0, numero1
	li $a1,15
	syscall	
	
	#imprime mensaje de entrada sec-num
	printMsj(entrada2)

	#toma el sec-num
	li $v0,8
	la $a0, numero2
	li $a1,15
	syscall
	
	separacion
	
	#imprime mensaje de pri-num
	printMsj(msj1)
	
	#imprime el pri-num
	printMsj(numero1)
	
	#imprime mensaje de sec-num
	printMsj(msj2)
	
	#imprime el sec-num
	printMsj(numero2)
	
	#loop iterativo
	li $t0,0
	li $t1,0
	li $t2,0
	#len1: 
	#	lb $t3,numero1($t0)
	
	#imprime menu
	printMsj(menu)
	
	#Recibir seleccion
	li $v0,5
	syscall 

	beq $v0,1,suma
	beq $v0,2,resta
	beq $v0,3,multi
	
	suma:
		#imprime msj
		printMsj(msjSuma)
		b final
		
	resta:
		#imprime msj
		printMsj(msjResta)
		b final
	multi:
		#imprime msj
		printMsj(msjMulti)
	final:
		
	
		separacion
	
		#imprime resultado
		printMsj(resultado)
		
		#fin del programa
		li $v0,10
		syscall	
