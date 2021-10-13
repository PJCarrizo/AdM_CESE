.syntax unified
.thumb
.text

@ Simbolos exportados
.global asm_sum
.global asm_svc
.global asm_vector_zeros
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
                    @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 							Ejercicio 2
@
@ Prototipo en "C":
@  void c_vector_zeros (uint32_t * vector, uint32_t longitud)
@
@ Parametros recibidos:
@   r0: vector
@   r2: longitud
@	r3: escalar
@
@ Valor de retorno:
@   r1: valor del producto del vector por el escalar
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
                    @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}
