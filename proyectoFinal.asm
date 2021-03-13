.data
	#Letras Romanas
	letram: .asciiz "M"
	letracm: .asciiz "CM"
	letrad: .asciiz "D"
	letracd: .asciiz "CD"
	letrac: .asciiz "C"
	letraxc: .asciiz "XC"
	letral: .asciiz "L"
	letraxl: .asciiz "XL"
	letrax: .asciiz "X"
	letraix: .asciiz "IX"
	letrav: .asciiz "V"
	letraiv: .asciiz "IV"
	letrai: .asciiz "I"
	nada: .asciiz  "NADA"
	negativo: .asciiz "-"
	
	#Separador
	separador: .asciiz "\n-------------------------------------------------------------------------------------------------------------------\n"
	
	#mensajes
	saludo: .asciiz  "Bienvenido a operaciones aritméticas con números romanos!\n"
	autores: .asciiz "Realizado por Nicolas Bolinaga, Carlos González y Felix Maldifassi"
	menu: .asciiz "\nSeleccione operación (Ingrese el número): \n1.Suma (A+B)\n2.Resta (A-B)\n3.Multiplicación (A*B)\n"
	msjSuma: .asciiz "\nSuma\n"
	msjResta: .asciiz "\nResta\n"
	msjMulti: .asciiz "\nMultiplicación\n"
	entrada1: .asciiz "Ingrese el primer número Romano: "
	entrada2: .asciiz "\nIngrese el segundo número Romano: "
	msj1: .asciiz "\nEl primer número (A) es: "
	msj2: .asciiz "\nEl segundo número (B) es: "
	resultado: .asciiz "El resultado de la operación es: "
	
	#Numeros Romanos
	input: .word 32
	
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
	la $a0,%label
	li $v0,4
	syscall
	.end_macro
	
	#pedir numero
	.macro pedirNumero()
        la $a0, input 
        move $a1, $a0 
        li $v0, 8 
        syscall 
        move $s0, $a0 
        .end_macro
	
	#print numero
	.macro printNum(%numero)
	move $a0, %numero
        li $v0, 1 
        syscall 
        .end_macro
        
        #convertir numero de romano a decimal
        .macro convertNum()
         convertNum:
 		add $s7, $0, $0 
        	li $s3, 0 
 		#Recorre la cadena para obterner el tamaño
 		getTamanoInput:
        		addu $s1, $s0, $s3 
        		lbu $a0, 0($s1) 
        		bne $a0, $0, incrementar 
       	 		j recorrerInput 
        	#Incrementa la iteración del loop
        	incrementar:
        		addi $s3, $s3, 1 
        		j getTamanoInput 
		#Recorre cada letra para identificarla con la tabla de ASCII
        	recorrerInput:  
        		addu $s1, $s0, $s3 
                	lbu $t2, 0($s1) 
                	addi $t1, $0, 48 	
                	move $s6, $t1 
                	bne $t2, $t1, tablaLetras 
                	j final
		#Ubica el valor de cada letra para convertirlo
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
                    		bge $s6, 100, serieCien  
                    		li $t1, 99 
                        	beq $t2, $t1, conversionACien 
                	serieCien:
                    		li $t1, 100 
                        	beq $t2, $t1, conversionAQuinientos 
                        	li $t1, 105 
                       		beq $t2, $t1, conversionToOneHandler 
                        	li $t1, 108 
                        	beq $t2, $t1, conversionACincuenta 
                        	li $t1, 109 
                        	beq $t2, $t1, conversionAMil 
                        	li $t1, 118 
                        	beq $t2, $t1, conversionACinco 
                        	li $t1, 120 
                   		beq $t2, $t1, conversionADiez 
                	addi $s4, $0, 0   
                	jal continuar 
                	j recorrerInput
        
    		#De acuerdo a cada valor, se asigna el número al registro
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

	#Permite sumar o restar valores cuando sea necesario de acuerdo en la manera que están
	#escritos los números romános
    	prefijo:
        	adicion:       
        		blt $s2, $s4, substraccion 
                	add $s7, $s7, $s2 
                	j continuar 
        	substraccion:   
        		sub $s7, $s7, $s2 
            		j continuar 
        #Condición para continuar el programa    
    	continuar:
    		beq $s3, $0, imprimir 
        	addi $s3, $s3, -1 
        	move $s4, $s2 
        	jr $ra 
        #Imprime el número convertido    
    	imprimir:     
    		move $a0, $s7 
        	li $v0, 1 
        	syscall 
        .end_macro
        
.text
	#imprime saludo
	printMsj(saludo)
	printMsj(autores)
	separacion
	
	#imprime mensaje de entrada pri-num
	printMsj(entrada1)
	
	#toma el pri-num
	pedirNumero() 
	convertNum()
	move $t8, $a0
	
	#imprime mensaje de entrada sec-num
	printMsj(entrada2)

	#toma el sec-num
	pedirNumero()
	convertNum()
	move $t9, $a0
	
	separacion
	
	#imprime mensaje de pri-num
	printMsj(msj1)
	
	#imprime el pri-num
	printNum($t8)
	
	#imprime mensaje de sec-num
	printMsj(msj2)
	
	#imprime el sec-num
	printNum($t9)

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
		add $a1, $t8, $t9  
		#imprime resultado
		printMsj(resultado)
		beqz $a1 NADA
		b reconvertirNumero
	resta:
		#imprime msj
		printMsj(msjResta)
		sub $a1, $t8, $t9  
		#imprime resultado
		printMsj(resultado)
		beqz $a1 NADA
		b reconvertirNumero
	multi:
		#imprime msj
		printMsj(msjMulti)
		mul  $a1, $t8, $t9
		#imprime resultado
		printMsj(resultado)
		beqz $a1 NADA
		b reconvertirNumero
	final:
		separacion
		#fin del programa
		li $v0,10
		syscall
		
reconvertirNumero:
		bltz $a1, Negativo
		bgt $a1, 999, M 	# Si es mayor a 999 es mil por ende colocamos una M y restamos 1000 del numero original
		bgt $a1, 899, CM	# Si es mayor a 899 es novecientos por ende colocamos una CM y restamos 900 del numero original
		bgt $a1, 499, D		# Quinientos - D - restamos 500
		bgt $a1, 399, CD	# Cuatrocientos - CD - restamos 400
		bgt $a1, 99, C		# Cien - C - restamos 100
		bgt $a1, 89, XC		# y asi sucesivamente...
		bgt $a1, 49, L		# .
		bgt $a1, 39, XL		# .
		bgt $a1, 9, X		# .
		bgt $a1, 8, IX		# .
		bgt $a1, 4, V		# .
		bgt $a1, 3, IV		# .
		bgt $a1, 0, I		# Hasta que ya no queden numeros por restar
		
		j final
        
        # aqui suceden las restas de cada letra segun sea el caso 
	M:
		sub $a1, $a1, 1000	
		printMsj(letram)
    		j reconvertirNumero
	CM:
		sub $a1, $a1, 900
		printMsj(letracm)
		j reconvertirNumero
	D:
		sub $a1, $a1, 500
		printMsj(letrad)
		j reconvertirNumero
	CD:
		sub $a1, $a1, 400
		printMsj(letracd)
		j reconvertirNumero
	C:
		sub $a1, $a1, 100
		printMsj(letrac)
		j reconvertirNumero
	XC:
		sub $a1, $a1, 90
		printMsj(letraxc)
		j reconvertirNumero
	L:
		sub $a1, $a1, 50
		printMsj(letral)
		j reconvertirNumero
	XL:
		sub $a1, $a1, 40
		printMsj(letraxl)
		j reconvertirNumero
	X:
		sub $a1, $a1, 10
		printMsj(letrax)
		j reconvertirNumero
	IX:
		sub $a1, $a1, 9
		printMsj(letraix)
		j reconvertirNumero
	V:
		sub $a1, $a1, 5
		printMsj(letrav)
		j reconvertirNumero
	IV:
		sub $a1, $a1, 4
		printMsj(letraiv)
		j reconvertirNumero
	I:
		sub $a1, $a1, 1
		printMsj(letrai)
		j reconvertirNumero
		
	NADA:
		printMsj(nada)
		j final
		
	Negativo:
		abs $a1, $a1
		printMsj(negativo)
		j reconvertirNumero
