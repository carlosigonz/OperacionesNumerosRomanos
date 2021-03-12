 .data
	mensajeEntrada: .asciiz "\nIngrese un numero romano (0 para salir): \n"
	mensajeSalida: .asciiz "\nFinalizado\n"
	input: .word 64	
.text 
    main:                               
    	mostrarInput:
        	la $a0, mensajeEntrada 
        	li $v0, 4 
        	syscall
                
        getInput:
        	la $a0, input 
        	move $a1, $a0 
        	li $v0, 8 
                syscall 
        	move $s0, $a0 
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
                j salir 

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

    salir:      
        li $v0, 4 
        la $a0, mensajeSalida
        syscall 
        li $v0, 10 
        syscall 
