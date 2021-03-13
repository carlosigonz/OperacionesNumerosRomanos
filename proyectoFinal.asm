.data
	#Separador
	separador: .asciiz "\n-------------------------------------------------------------------------------------------------------------------\n"
	#mensajes
	saludo: .asciiz  "Bienvenido a operaciones aritméticas con números romanos!\n"
	autores: .asciiz "Realizado por Nicolas Bolinaga, Carlos González y Felix Maldifassi."
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
	input: .word 64
	#Numeros Enteros
	entero1: .word 
	entero2: .word
	#Letras Romanas
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
 		getTamanoInput:
        		addu $s1, $s0, $s3 
        		lbu $a0, 0($s1) 
        		bne $a0, $0, incrementar 
       	 		j recorrerInput 
        
        	incrementar:
        		addi $s3, $s3, 1 
        		j getTamanoInput 

        	recorrerInput:  
        		addu $s1, $s0, $s3 
                	lbu $t2, 0($s1) 
                	addi $t1, $0, 48 	
                	move $s6, $t1 
                	bne $t2, $t1, mapLetras 
                	j final

        	mapLetras:
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
		b reconvertirNumero
	resta:
		#imprime msj
		printMsj(msjResta)
		sub $a1, $t8, $t9  
		#imprime resultado
		printMsj(resultado)
		b reconvertirNumero
	multi:
		#imprime msj
		printMsj(msjMulti)
		mul  $a1, $t8, $t9
		#imprime resultado
		printMsj(resultado)
		b reconvertirNumero
	final:
		separacion
		#fin del programa
		li $v0,10
		syscall
		

reconvertirNumero:
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
		
		j final
        	
	M:
		sub $a1, $a1, 1000
		la $t1, letraM
		jal concatenation
    		j reconvertirNumero
	CM:
		sub $a1, $a1, 900
		la $t1, letraCM
		jal concatenation
		j reconvertirNumero
	D:
		sub $a1, $a1, 500
		la $t1, letraD
		jal concatenation
		j reconvertirNumero
	CD:
		sub $a1, $a1, 400
		la $t1, letraCD
		jal concatenation
		j reconvertirNumero
	C:
		sub $a1, $a1, 100
		la $t1, letraC
		jal concatenation
		j reconvertirNumero
	XC:
		sub $a1, $a1, 90
		la $t1, letraXC
		jal concatenation
		j reconvertirNumero
	L:
		sub $a1, $a1, 50
		la $t1, letraL
		jal concatenation
		j reconvertirNumero
	XL:
		sub $a1, $a1, 40
		la $t1, letraXL
		jal concatenation
		j reconvertirNumero
	X:
		sub $a1, $a1, 10
		la $t1, letraX
		jal concatenation
		j reconvertirNumero
	IX:
		sub $a1, $a1, 9
		la $t1, letraIX
		jal concatenation
		j reconvertirNumero
	V:
		sub $a1, $a1, 5
		la $t1, letraV
		jal concatenation
		j reconvertirNumero
	IV:
		sub $a1, $a1, 4
		la $t1, letraIV
		jal concatenation
		j reconvertirNumero
	I:
		sub $a1, $a1, 1
		la $t1, letraI
		jal concatenation
		j reconvertirNumero
	
	concatenation:
		la $a0, ($t1) 
        	li $v0, 4 
        	syscall 
		jr $ra
