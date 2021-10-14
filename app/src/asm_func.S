.syntax unified
.thumb
.text

@ Simbolos exportados
.global asm_sum
.global asm_svc
.global asm_vector_zeros
.global asm_producto_Vector_Escalar32
.global asm_producto_Vector_Escalar16
.global asm_filtroventana10
.global asm_pack32to16
//.global asm_producto_Vector_Escalar16_sat12bits
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   uint32_t asmSum (uint32_t firstOperand, uint32_t secondOperand)
@
@ Parametros recibidos:
@   r0: firstOperand
@   r1: secondOperand
@
@ Valor de retorno:
@   r0: resultado de la suma de firstOperand y secondOperand
@
.thumb_func
    asm_sum:
        add r0, r1  @ r0 = r0 + r1
        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "bl asm_sum" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.
                    @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_svc (void)
@
.thumb_func
    asm_svc:
        svc 0
        bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 							Ejercicio 1
@
@ Prototipo en "C":
@  void c_vector_zeros (uint32_t * vector, uint32_t longitud)
@
@ Parametros recibidos:
@   r0: vector
@   r1: longitud
@
@ Valor de retorno:
@   r2: valor cero
@
.thumb_func
    asm_vector_zeros:
        mov	r2, 0;
    .loop_vector_zeros:
        str r2, [r0], 4    // cargo con cero (r2) la posicion indicada por el puntero r0 y despazo 4 bytes
        subs r1, 1         // decremento longitud
        bne .loop_vector_zeros		   // salto a .loop_vector_zeros si Z = 0

        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "bl asm_sum" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.


        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 							Ejercicio 2
@
@ Prototipo en "C":
@  void productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut uint32_t longitud, uint32_t escalar);
@
@ Parametros recibidos:
@   r0: vectorIn
@   r2: longitud
@	r3: escalar
@
@ Valor de retorno:
@   r1: valor del producto del vector por el escalar
@
.thumb_func
    asm_producto_Vector_Escalar32:
    push {r4}				// se hara uso de un registro adicional para las operaciones
    .loop_mult_32:
    	ldr r4, [r0], 4		// cargo cada valor del vector de entrada en r4 y desplazo 4 posiciones
    	mul r4, r3, r4		// multiplico con escalar (r3) cada posicion del vector cargado en r4 y guardo en r4
    	str r4, [r1], 4		// despues de la multiplicacion almaceno el valor de r4 en cada posicion de r1
    	subs r2, 1			// decremento longitud
        bne .loop_mult_32	// salto a .loop_mult si Z = 0
        pop {r4}			// restauro contexto
        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "asm_producto_Vector_Escalar32" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.


        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 							Ejercicio 3
@
@ Prototipo en "C":
@  void productoEscalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar);
@
@ Parametros recibidos:
@   r0: vectorIn
@   r2: longitud
@	r3: escalar
@
@ Valor de retorno:
@   r1: valor del producto del vector por el escalar
@
.thumb_func
    asm_producto_Vector_Escalar16:
    push {r4}				// se hara uso de un registro adicional para las operaciones
    .loop_mult_16:
    	ldr r4, [r0], 2		// cargo cada valor del vector de entrada en r4 y desplazo 4 posiciones
    	mul r4, r3, r4		// multiplico con escalar (r3) cada posicion del vector cargado en r4 y guardo en r4
    	str r4, [r1], 4		// despues de la multiplicacion almaceno el valor de r4 en cada posicion de r1
    	subs r2, 1			// decremento longitud
        bne .loop_mult_16		// salto a .loop_mult si Z = 0
        pop {r4}			// restauro contexto
        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "asm_producto_Vector_Escalar32" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.


        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 		Ejercicio 4 = Ejercicio 3 (hago uso de la misma funcion)
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@




@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 							Ejercicio 5
@
@ Prototipo en "C":
@  void filtroVentana10(uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn);
@
@ Parametros recibidos:
@   r0: vectorIn
@   r2: longitudVectorIn
@
@
@ Valor de retorno:
@   r1: valor del producto del vector por el escalar
@
@	r3: acumulador para desplazar
@	r4: 10 (filtro de 10)
@	r5: acumulador para sumar

.thumb_func
    asm_filtroventana10:
    push {r3-r5}				// se hara uso de un registro adicional para las operaciones

    .loop_filtro:
    	ldr		r3, [r0], 2		// cargo cada valor del vector de entrada en r4 y desplazo 4 posiciones
    	add		r5, r0, r3		// r5 = r0 + r3. En r5 guardo la suma de vectorIn + VectorIn desplazado
    	udiv	r5, r4			// en r5 guardo la division entre el acumulador y r4 (=10)
    	str		r5, [r1], 2			// almaceno resultado de la suma divido por 10 en r1 (Vector out)
    	cmp		r2, 1			// comparo el valor del acumulador con 1, si es igual ejecuto linea siguiente
    	sub		r0, 20			// si lo anterior es igual, vuelvo el vector In a la posicion inicial
    	sub		r2,	1			// decremento r2 en 1
    	bne		.loop_filtro	// salto a .loop_filtro si Z = 0
        pop {r3-r5}			// restauro contexto
        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "loop_filtro" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.


        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 							Ejercicio 6
@
@ Prototipo en "C":
@  void pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);
@
@ Parametros recibidos:
@   r0: vectorIn
@   r2: longitudVectorIn
@
@
@ Valor de retorno:
@   r1: valor del producto del vector por el escalar
@
@	r3: acumulador
@

.thumb_func
    asm_pack32to16:
    push {r3}				// se hara uso de un registro adicional para las operaciones
    .loop_pack:
    	ldr r3, [r0], 4     @ guardo el valor del vector In
        lsr r3, #16         @ guarda los dos mas significativos
        strh r3, [r1], 2    @ guardo en r1 (vector out)
        subs r2, 1          @ decremento longitud
        bne .loop_pack
        pop {r3}
        bx lr
        			       	@ vuelve adonde fue llamada (especificamente, si "pc"
                    		@ es la direccion, en el codigo del programa, de la
                    		@ instruccion "asm_pack32to16" usada para saltar a
                    		@ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    		@ el valor de retorno debe quedar en el registro r0.
                    		@ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}
