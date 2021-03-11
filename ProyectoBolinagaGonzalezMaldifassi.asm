.data
	saludo: .asciiz  "Ingrese un numero Romano: \n"
	numero: .space 10
	prueba: .asciiz  "El numero es: "
.text
	li $v0,4
	la $a0, saludo
	syscall 
	
	li $v0,8
	la $a0, numero
	li $a1,10
	syscall
	
	li $v0,4
	la $a0, prueba
	syscall 
	
	li $v0,4
	la $a0, numero
	syscall 

	li $v0,10
	syscall	