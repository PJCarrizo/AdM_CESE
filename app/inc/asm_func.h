#pragma once

#include <stdint.h>


extern uint32_t asm_sum (uint32_t firstOperand, uint32_t secondOperand);
extern void asm_svc (void);
extern void asm_vector_zeros (uint32_t * p_vector_asm, uint32_t counter);
extern void asm_producto_Vector_Escalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar);
extern void asm_producto_Vector_Escalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint16_t longitud, uint16_t escalar);
//extern void asm_producto_Vector_Escalar16_sat12bits (uint16_t * vectorIn, uint16_t * vectorOut, uint16_t longitud, uint16_t escalar);
extern void  asm_filtroventana10 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn);
extern void asm_pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);
