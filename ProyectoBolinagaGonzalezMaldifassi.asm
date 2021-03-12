.data
	#Separador
	separador: .asciiz "\n-------------------------------------------------------------------------------------------------------------------\n"
	#mensajes
	saludo: .asciiz  "Bienvenido a operaciones aritméticas con números romanos!"
	menu: .asciiz "\nSeleccione operación (Ingrese el número): \n1.Suma (A+B)\n2.Resta (A-B)\n3.Multiplicación (A*B)\n"
	msjSuma: .asciiz "\nSuma\n"
	msjResta: .asciiz "\nResta\n"
	msjMulti: .asciiz "\nMultiplicación\n"
	entrada1: .asciiz "Ingrese el primer número Romano: "
	entrada2: .asciiz "\nIngrese el segundo número Romano: "
	msj1: .asciiz "\nEl primer número (A) es: "
	msj2: .asciiz "El segundo número (B) es: "
	resultado: .asciiz "El resultado de la operación es: "
	#Numeros Romanos
	numero1: .space 15
	numero2: .space 15
	#Numeros Enteros
	entero1: .word 
	entero2: .word
	
	#separacion
	.macro separacion
	li $v0,4
	la $a0, separador
	syscall
	.end_macro
	
	#imprimir mensajes
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
	
	li $v0,4
	
	j convertNum
	regreso1:
	addi $t0,$t0,1
	beq $t0,2,parte2
	
	#imprime mensaje de entrada sec-num
	printMsj(entrada2)

	#toma el sec-num
	li $v0,8
	la $a0, numero2
	li $a1,15
	syscall
	
	j convertNum
	
	separacion
	
	parte2:
	separacion
	#imprime mensaje de pri-num
	printMsj(msj1)
	
	#imprime el pri-num
	printMsj(numero1)
	
	#imprime mensaje de sec-num
	printMsj(msj2)
	
	#imprime el sec-num
	printMsj(numero2)

	
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
		#addi $t7,  
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
		
convertNum:
	move $s0,$a0
	add $s7, $0, $0 
	li $s3, 0

	getTamanoInput:
        	addu $s1, $s0, $s3 
        	lbu $a0, 0($s1) 
        	bnez $a0, incrementar 
       	 	j recorrerInput
       	 	
        incrementar:
        	addi $s3, $s3, 1 
        	j getTamanoInput 

        recorrerInput:  
        	addu $s1, $s0, $s3 
                lbu $t2, 0($s1) 
                addi $t1, $0, 48 	
                move $s6, $t1 
                bne $t2, $t1, tablaLetras 
                j imprimir

        tablaLetras:
        	add $s2, $0, $0
            	serieSesenta:
                	bge $s6, 70, serieSetenta 
                        li $t1, 67 
                        beq $t2, $t1, conversionACien 
                        li $t1, 68 
                        beq $t2, $t1, conversionAQuinientos 
            	serieSetenta:
                	bge $s6, 80, serieOchenta 
                        li $t1, 73 
                        beq $t2, $t1, conversionToOneHandler 
                        li $t1, 76 
                        beq $t2, $t1, conversionACincuenta 
                        li $t1, 77
                        beq $t2, $t1, conversionAMil 
            	serieOchenta:     
                	bge $s6, 90, serieNoventa 
                	li $t1, 86 
                        beq $t2, $t1, conversionACinco 
                        li $t1, 88 
                        beq $t2, $t1, conversionADiez 
                serieNoventa: 
                    	li $t1, 99 
                        beq $t2, $t1, conversionACien
                addi $s4, $0, 0   
                jal continuar 
                j recorrerInput
        
    
        conversion:
            	conversionAMil:   
                	addi $s2, $0, 1000 
                        jal prefijo
                        j recorrerInput                  
            	conversionAQuinientos:    
                	addi $s2, $0, 500 
                        jal prefijo 
                        j recorrerInput              
            	conversionACien:   
                	addi $s2, $0, 100 
                        jal prefijo 
                        j recorrerInput               
           	conversionACincuenta:      
                	addi $s2, $0, 50 
                        jal prefijo 
                        j recorrerInput                 
            	conversionADiez:        
                	addi $s2, $0, 10
                        jal prefijo 
                        j recorrerInput           
            	conversionACinco:       
                	addi $s2, $0, 5  
                	jal prefijo 
                        j recorrerInput
            	conversionToOneHandler:      
                	addi $s2, $0, 1 
                        jal prefijo
                        j recorrerInput
    prefijo:
        adicion:       
        	blt $s2, $s4, substraccion 
                add $s7, $s7, $s2 
                j continuar 
        substraccion:   
        	sub $s7, $s7, $s2 
            	j continuar 
            
    continuar:
    	beq $s3, $0, imprimir 
        addi $s3, $s3, -1 
        move $s4, $s2 
        jr $ra 
            
    imprimir:     
    	move $a0, $s7
        li $v0, 1 
        syscall
        
    j regreso1
        
