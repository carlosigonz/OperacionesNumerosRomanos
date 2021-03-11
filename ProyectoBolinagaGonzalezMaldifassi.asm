.data
	saludo: .asciiz  "Ingrese un numero Romano: \n"
	numero: .space 10
	prueba: .asciiz  "El numero es: "
.text
	#imprime saludo
	li $v0,4
	la $a0, saludo
	syscall 
	
	#toma el numero romano
	li $v0,8
	la $a0, numero
	li $a1,10
	syscall
	
	#imprime mensaje de despedida
	li $v0,4
	la $a0, prueba
	syscall 
	
	#imprime el numero insertado
	li $v0,4
	la $a0, numero
	syscall 
	
	#fin del programa
	li $v0,10
	syscall	