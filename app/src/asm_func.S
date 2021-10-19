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

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 							Ejercicio 7
@
@ Prototipo en "C":
@  int32_t max (int32_t * vectorIn, uint32_t longitud);
@
@ Parametros recibidos:
@   r0: vectorIn
@   r1: longitud
@
@
@ Valor de retorno:
@   r0: valor del valor maximo
@
@

.thumb_func
    asm_max:
        @ Registros usados
        @   r2: accum maximo - temporal
        @   r3: posicion del valor maximo
        @   r4: index vector
        push {r2, r4}
        ldr r2, [r0]            @ ubico al pincipio del vector
        mov r3, 0               @ inicializo en 0
        mov r4, 0               @ inicializo en 0
        .loop_max:
            ldr r2, [r0], 4     @ guardo el valor del vector de entrada
            cmp r4, r2          @ comparo si el valor leido es mayor al maximo temporal
            blt .is_less
            mov r2, r4          @ si es mayor guardo el nuevo maximo
            mov r3, r5          @ actualizo la posicion del maximo
        .is_less:
            add r5, 1           @ incremento el indice del vector
            subs r1, 1          @ decremento el contador del loop
            bne .loop_max
        mov r0, r3            @ return max pos
        pop {r4, r5}
        bx lr



@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@	Realizar una función que reciba un vector de muestras no signadas de 16 bits
@	e invierta su orden.
@   void invertir (uint16_t * vector, uint32_t longitud);
@ Parametros recibidos:
@   r0: *vectorIn
@	r1: longitud
.thumb_func
	asm_invertir:
	push {r2-r8}
	mov r3,r1, ASR #1 @uint32_t centro = longitud >> 2;
	mov r5,#0 @ r5 es i del for

	mov r6,r0 @copio el puntero de posicion inicial
	sub r7,r1,#1 @ en las 2 copio longitud -1
	add r6,r6,r7, LSL #1	@se asigna a r6 la ultima posicion
	@r7 lo puedes usar.
	.loop_inv:
	ldrh r7, [r0]
    ldrh r8, [r6]

    strh r8, [r0],#2    @ mem16[r0] = r6 ; copio la ultima en la primera
	strh r7, [r6],#-2	@copio en la ultims pos y le resto 2
	add r5, 1
	cmp  r5, r3 @solo hago la mitad del arreglo
	blt  .loop_inv
	pop {r2-r8}
	bx lr
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@
@   void downsampleM (int32_t * vectorIn, int32_t * vectorOut, uint32_t longitud, uint32_t N);
@ Parametros recibidos:
@   r0: *in
@	r1: *eco
@ 	r2: pos es la que ve la posicion max definida
@ 	r3 es i del for
@	r4 es los 20ms donde se debe meter el eco
@
.thumb_func
	asm_eco:
	push {r2-r8,lr}

	mov r2,#4095 @r2 es pos
	mov r4,#882 @r3 es i
	mov r3,#0 @r3 es i
	.loop_eco:
		cmp r3,r4 @if init
		blt .ifunomax
		@el else
		sub r6,r0,#1764	@j=ptrR0-882
		ldrh r5,[r0],#2
		ldrh r7,[r6]
		mov r6,#0
		uhadd16 r6,r7,r6
		uadd16 r5,r5,r6
		strh r5,[r1],#2
		@---------------------
		bl .endifunomax
		.ifunomax:
		@ el if
		ldrh r5,[r0],#2
		strh r5,[r1],#2
		@---------------------
		.endifunomax:@if end

	add r3, 1
	cmp  r3, r2
	blt  .loop_eco

	pop {r2-r8,pc}
	bx lr


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void invertir (uint16_t * vector, uint32_t longitud)
@
@ Parametros recibidos:
@   r0: *vectorIn
@   r1: longitud
@
.thumb_func
    asm_invertir:
        @ Registros usados
        @   r2: utilizado para recorrer el vector de atras hacia adelante
        @   r3: utilizado para guardar el valor de adelante
        @   r4: utilizado para guardar el valor de atras

        push {r4}
        mov r2, r0              @ hago una copia de la direccion del vector
        add r2, r2, r1, lsl 1   @ me posiciono en la ultima posicion
        sub r2, 2               @ la ultima posicion esta en longitud-1
        lsr r1, 1               @ La cantidad de iteraciones es la mitad de la longitud ya que
                                @ voy cambiando los valores de adelante hacia atras y atras hacia
                                @ adelante en cada ciclo.
        .ej9_loop:
            ldrh r3, [r0]        @ guardo el valor de adelante en una variable temporal
            ldrh r4, [r2]        @ guardo el valor de atras en una variable temporal
            strh r4, [r0], 2     @ el valor de atras pasa adelante
            strh r3, [r2], -2    @ el valor de adelante pasa atras
            subs r1, 1
            bne .ej9_loop
        pop {r4}
        bx lr
