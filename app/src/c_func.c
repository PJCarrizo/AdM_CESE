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
void c_producto_Vector_Escalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar)
{
	for (uint32_t i = 0; i < longitud; i++)
			vectorOut [i] = vectorIn [i] * escalar;
}
void c_producto_Vector_Escalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint16_t longitud, uint16_t escalar)
{
	for (uint16_t i = 0; i < longitud; i++)
			vectorOut [i] = vectorIn [i] * escalar;
}
/*
void c_producto_Vector_Escalar16_sat12bits (uint16_t * vectorIn, uint16_t * vectorOut, uint16_t longitud, uint16_t escalar)
{
	for (uint16_t i = 0; i < longitud; i++)
			vectorOut [i] = vectorIn [i] * escalar;
}
*/


void c_filtroventana10 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn)
{
	uint32_t ventana = 10;
	uint32_t i = 0;
	uint32_t j = 0;

	for (i = 0; i < longitudVectorIn; i++)
	{
		j = i++;

		if (j == longitudVectorIn)
			j = 0;

		vectorOut [i]= (vectorIn [i] + vectorIn [j]) / ventana;
	}

}

void c_pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud)
{
	for (uint32_t i = 0; i < longitud; i++) {
	        vectorOut[i] = vectorIn[i] >> 16;
	    }
}


int32_t c_max (int32_t * vectorIn, uint32_t longitud)
{
	uint32_t j = 0;
	uint32_t max = 0;
	for (uint32_t i = 0; i < longitud - 1; i++) {
		        if (vectorIn[j] > vectorIn[i++]){
		        	max = vectorIn[j];
		        }
		        else
		        	j = i + 1;
		        	max = vectorIn[j];
		        return max;

	}


}
/*
uint32_t c_echo(uint32_t * p_long_vector, uint32_t ingreso_echo, uint32_t counter)
{
	for (uint32_t i = ingreso_echo; i < counter; counter)
	{

	}
}
*/
