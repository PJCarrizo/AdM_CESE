#pragma once

#include <stdint.h>


extern uint32_t asm_sum (uint32_t firstOperand, uint32_t secondOperand);
extern void asm_svc (void);
extern void asm_vector_zeros (uint32_t p_vector_asm, uint32_t counter);
extern void asm_productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar);
