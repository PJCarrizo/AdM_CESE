#include "c_func.h"


uint32_t c_sum (uint32_t firstOperand, uint32_t secondOperand)
{
    return (firstOperand + secondOperand);
}

void c_vector_zeros (uint32_t * vector, uint32_t longitud)
{
	for (uint32_t i = 0; i < longitud; i++)
		vector [i] = 0;

}
void c_productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar)
{
	for (uint32_t i = 0; i < longitud; i++)
			vectorOut [i] = vectorIn [i] * escalar;
}
uint32_t c_echo(uint32_t * p_long_vector, uint32_t ingreso_echo, uint32_t counter)
{
	for (uint32_t i = ingreso_echo; i < counter; counter)
	{

	}
}
