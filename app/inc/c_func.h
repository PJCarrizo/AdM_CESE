#pragma once

#include <stdint.h>


uint32_t c_sum (uint32_t firstOperand, uint32_t secondOperand);

// Ejercicio 1. Inicializar un vector en cero //
void c_vector_zeros (uint32_t * vector, uint32_t longitud);

// Ejercicio 2. Producto de un vector por un escalar //
void c_productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar);
