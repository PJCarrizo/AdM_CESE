#pragma once

#include <stdint.h>


uint32_t c_sum (uint32_t firstOperand, uint32_t secondOperand);

// Ejercicio 1. Inicializar un vector en cero //
void c_vector_zeros (uint32_t * vector, uint32_t longitud);

// Ejercicio 2. Producto de un vector por un escalar en 32 bits//
void c_producto_Vector_Escalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar);

// Ejercicio 3. Producto de un vector por un escalar en 16 bits//
void c_producto_Vector_Escalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint16_t longitud, uint16_t escalar);

// Ejercicio 4. Producto de un vector por un escalar en 16 bits y sturación a 12 bits//
//void c_producto_Vector_Escalar16_sat12bits (uint16_t * vectorIn, uint16_t * vectorOut, uint16_t longitud, uint16_t escalar);

// Ejercicio 5. Filtro ventana de 10 unidades
void c_filtroventana10 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn);

// Ejercicio 6. Empaquetado
void c_pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);

// Ejercicio 7. Máximo valor en un vector
int32_t c_max (int32_t * vectorIn, uint32_t longitud);

// Ejercicio 8. Muestreo
void downsampleM (int32_t * vectorIn, int32_t * vectorOut, uint32_t longitud, uint32_t N);

// Ejercicio 9. Invertir valor en un vector
void invertir (uint16_t * vector, uint32_t longitud);

// Ejercicio 10. Echo
uint32_t c_echo(p_long_vector, ingreso_echo);



