#include "board.h"
#include "c_func.h"
#include "asm_func.h"

#include <stdlib.h>
#include <stdnoreturn.h>



// Variable que se incrementa cada vez que se llama al handler de interrupcion
// del SYSTICK.
static volatile uint32_t s_ticks = 0;


// Inicia soporte de la placa y periodo de la interrupcion del SYSTICK
// cada 1 milisegundo.
static void Inicio (void)
{
    Board_Init ();
    SystemCoreClockUpdate ();
    SysTick_Config (SystemCoreClock / 1000);
}


// Segun la configuracion realizada en Inicio(), este handler de interrupcion
// se ejecutara cada 1 milisegundo.
void SysTick_Handler (void)
{
    ++ s_ticks;
}


static void Suma (void)
{
    const uint32_t A = 20;
    const uint32_t B = 30;

    const uint32_t SumResult_C = c_sum (A, B);
    const uint32_t SumResult_Asm = asm_sum (A, B);

    // Actividad de debug: SumResult_C y SumResult_Asm deberian contener el
    // mismo valor.
    __BKPT (0);

    (void) SumResult_C;
    (void) SumResult_Asm;
}


static void LlamandoAMalloc (void)
{
    // De donde saca memoria malloc?
    // (se vera en clase)
    void * ptr = malloc (2048);

    (void) ptr;
}


static void PrivilegiosSVC (void)
{
    // Obtiene valor del registro de 32 bits del procesador llamado "control".
    // El registro guarda los siguientes estados:
    // bit 2: Uso de FPU en el contexto actual. Usado=1, no usado=0.
    // bit 1: Mapeo del stack pointer(sp). MSP=0, PSP=1.
    // bit 0: Modo de ejecucion en Thread. Privilegiado=0, No privilegiado=1.
    //        Recordar que este valor solo se usa en modo Thread. Las
    //        interrupciones siempre se ejecutan en modo Handler con total
    //        privilegio.
    uint32_t x = __get_CONTROL ();

    // Actividad de debug: Ver registro "control" y valor de variable "x".
    __BKPT (0);

    x |= 1;
    // bit 0 a modo No privilegiado.
    __set_CONTROL (x);

    // En este punto se estaria ejecutando en modo No privilegiado.
    // Lectura del registro "control" para confirmar.
    x = __get_CONTROL ();

    // Actividad de debug: Ver registro "control" y valor de variable "x".
    __BKPT (0);

    x &= ~1u;
    // Se intenta volver a modo Privilegiado (bit 0, valor 0).
    __set_CONTROL (x);

    // Confirma que esta operacion es ignorada por estar ejecutandose en modo
    // Thread no privilegiado.
    x = __get_CONTROL ();

    // Actividad de debug: Ver registro "control" y valor de variable "x".
    __BKPT (0);

    // En este punto, ejecutando en modo Thread no privilegiado, la unica forma
    // de volver a modo privilegiado o de realizar cualquier cambio que requiera
    // modo privilegiado, es pidiendo ese servicio a un hipotetico sistema
    // opertivo de tiempo real.
    // Para esto se invoca por software a la interrupcion SVC (Supervisor Call)
    // utilizando la instruccion "svc".
    // No hay intrinsics para realizar esta tarea. Para utilizar la instruccion
    // es necesario implementar una funcion en assembler. Ver el archivo suma.S.
    asm_svc ();

    // El sistema operativo (el handler de SVC) deberia haber devuelto el modo
    // de ejecucion de Thread a privilegiado (bit 0 en valor 0).
    x = __get_CONTROL ();

    // Fin del ejemplo de SVC
}


// Handler de la interrupcion "SVC" (Supervisor Call).
// Usado por el ejemplo "EjemploPrivilegiosSVC".
void SVC_Handler (void)
{
    // Se obtiene el valor del registro "control". El bit 0 indica el nivel
    // de privilegio en modo "Thread". Deberia ser 1: No privilegiado.
    uint32_t x = __get_CONTROL ();

    // Borra el bit 0. Nuevo valor 0: privilegiado.
    x &= ~1u;

    // Asigna el nuevo valor al registro "control". Esta operacion deberia
    // ejecutarse ya que todo manejador de interrupciones se ejecuta en modo
    // "Handler" con total privilegio.
    __set_CONTROL (x);
}


noreturn void LoopInfinito (void)
{
    while (1)
    {
        // Procesador en modo espera hasta que ocurra una interrupcion
        // (Bajo consumo)
        __WFI();
    }
}

//************************************************************************************************************//
// Estructura del programa donde se desarrollan las funciones de los Ejercicios de la Guia Práctica
//************************************************************************************************************//




static void Ejercicio1_vector_zeros (void)
{
    uint32_t counter = 20;
	uint32_t vector_c [counter];
    uint32_t vector_asm [counter];


	c_vector_zeros (vector_c, counter);
	asm_vector_zeros (vector_asm, counter);



    __BKPT (0);
}


//************************************************************************************************************//
// Estructura del programa donde se desarrollan las funciones de los Ejercicios de la Guia Práctica
//************************************************************************************************************//




static void Ejercicio2_vector_escalar (void)
{
    uint32_t counter = 20;
	uint32_t vector_c [counter];
    uint32_t vector_asm [counter];

    uint32_t vectorOut_c [counter];
    uint32_t vectorOut_asm [counter];

    uint32_t escalar = 10;

    c_producto_Vector_Escalar32 (vector_c, vectorOut_c, counter, escalar);
    asm_producto_Vector_Escalar32 (vector_asm, vectorOut_asm, counter, escalar);



    __BKPT (0);
}

//************************************************************************************************************//
// Estructura del programa donde se desarrollan las funciones de los Ejercicios de la Guia Práctica
//************************************************************************************************************//



static void Ejercicio3_vector16bits_escalar (void)
{
    uint16_t counter = 20;
	uint16_t vector_c [counter];
    uint16_t vector_asm [counter];

	uint16_t vectorOut_c [counter];
    uint16_t vectorOut_asm [counter];


    uint16_t escalar = 10;

    c_producto_Vector_Escalar16 (vector_c, vectorOut_c, counter, escalar);
    asm_producto_Vector_Escalar16 (vector_asm, vectorOut_asm, counter, escalar);

    __BKPT (0);
}

//************************************************************************************************************//
// Estructura del programa donde se desarrollan las funciones de los Ejercicios de la Guia Práctica
//************************************************************************************************************//



static void Ejercicio4_vector16bits_escalar_sat12bits (void)
{
    uint16_t counter = 20;
	uint16_t vector_c [counter];
    uint16_t vector_asm [counter];

	uint16_t vectorOut_c [counter];
    uint16_t vectorOut_asm [counter];


    uint16_t escalar = 10;
    escalar = escalar * 0x0FFF;
    c_producto_Vector_Escalar16 (vector_c, vectorOut_c, counter, escalar);
    asm_producto_Vector_Escalar16 (vector_asm, vectorOut_asm, counter, escalar);

    __BKPT (0);
}

//************************************************************************************************************//
// Estructura del programa donde se desarrollan las funciones de los Ejercicios de la Guia Práctica
//************************************************************************************************************//

static void Ejercicio5_filtroventana (void)
{
    uint16_t counter = 10;
	uint16_t vector_c [counter];
    uint16_t vector_asm [counter];

	uint16_t vectorOut_c [counter];
    uint16_t vectorOut_asm [counter];

    //void filtroVentana10(uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn);
    c_filtroventana10 (vector_c, vectorOut_c, counter);
    asm_filtroventana10 (vector_asm, vectorOut_asm, counter);

    __BKPT (0);
}

//************************************************************************************************************//
// Estructura del programa donde se desarrollan las funciones de los Ejercicios de la Guia Práctica
//************************************************************************************************************//

static void Ejercicio6_empaquetado (void)
{
    uint32_t counter = 10;
	int32_t vector_c [counter];
    int32_t vector_asm [counter];

	int16_t vectorOut_c [counter];
    int16_t vectorOut_asm [counter];

    //void pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);
    c_pack32to16 (vector_c, vectorOut_c, counter);
    asm_pack32to16 (vector_asm, vectorOut_asm, counter);

    __BKPT (0);
}

//************************************************************************************************************//
// Estructura del programa donde se desarrollan las funciones de los Ejercicios de la Guia Práctica
//************************************************************************************************************//

static void Ejercicio7_max_valor (void)
{
    uint32_t counter = 10;
	int32_t vector_c [counter];
    int32_t vector_asm [counter];

	int32_t c_maximo = 0;
	int32_t asm_maximo = 0;
    //int32_t max (int32_t * vectorIn, uint32_t longitud);
    c_maximo = c_max(vector_c, counter);
    //asm_maximo = asm_pack32to16 (vector_asm, counter);

    __BKPT (0);
}
/*
static void Ejercicio10_echo (void)
{
	uint32_t counter = 4096;
	uint32_t long_vector [counter];
	uint32_t *p_long_vector [counter] = long_vector;
	uint32_t ingreso_echo = 882;
	uint32_t salida_echo;

	salida_echo = c_echo(p_long_vector, ingreso_echo, counter);
	asm_echo();

    __BKPT (0);
}

*/
//************************************************************************************************************//

//************************************************************************************************************//
// Carrera de Especialización / Maestría de Sistemas Embebidos
// Universidad de Buenos Aires
// Arquitectura de Microprocesadores
//
//		Guía de Ejercicios
// Se pide realizar los ejercicios primeros en C y luego en assembler, verificando posteriormente que
// el algoritmo funcione correctamente y tomando nota del tiempo de ejecución en ciclos de cada
// función y su diferencia.

int main (void)
{
    Inicio ();

    Suma ();

    PrivilegiosSVC ();

    LlamandoAMalloc ();

    //	1) Realizar una función que inicialice un vector con ceros. La función debe tener el siguiente
    //    prototipo:
    // 				void zeros (uint32_t * vector, uint32_t longitud); //
    Ejercicio1_vector_zeros ();
	//	2) Realizar una función que realice el producto de un vector y un escalar (por ejemplo, podría servir
	//    para cambiar el nivel de amplitud de una señal).
	//    			void productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut uint32_t longitud, uint32_t escalar);
    Ejercicio2_vector_escalar ();

    //	3) Adapte la función del ejercicio 2 para realizar operaciones sobre vectores de 16 bits:
    //				void productoEscalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar);
    Ejercicio3_vector16bits_escalar ();

    //	4) Adapte la función del ejercicio 3 para saturar el resultado del producto a 12 bits:
    //				void productoEscalar12 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar);
    Ejercicio4_vector16bits_escalar_sat12bits ();


    //	5) Realice una función que implemente un filtro de ventana móvil de 10 valores sobre un vector de
    //	muestras.
    //				void filtroVentana10(uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn);
    Ejercicio5_filtroventana ();

    //	6) Realizar una función que reciba un vector de números signados de 32 bits y los “empaquete” en
    //	otro vector de 16 bits. La función deberá adecuar los valores de entrada a la nueva precisión.
    //				void pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);
    Ejercicio6_empaquetado ();


    //	7) Realizar una función que reciba un vector de números signados de 32 bits y devuelva la posición
    //	del máximo del vector.
    //				int32_t max (int32_t * vectorIn, uint32_t longitud);
    Ejercicio7_max_valor ();


    //Ejercicio10_echo ();
	// 2) Realizar una función que realice el producto de un vector y un escalar (por ejemplo, podría servir
	//    para cambiar el nivel de amplitud de una señal).
	//    			void productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut uint32_t longitud, uint32_t escalar);

    LoopInfinito ();
}
