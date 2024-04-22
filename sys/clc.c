/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * clc ЦЦЦЦЦЦЦ {-|+|/|*|%|^} ЦЦЦЦЦЦЦ
 *   калькулятор
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("clc");
	
	int num1   = alloc(1),
	    num2   = alloc(1),
	    result = alloc(1),
	    op     = alloc(1);
	/* получение чисел */
	vcatv2(_ARGS_ST - 1, num1);
	vcatv2(_ARGS_ST + 9, num2);
	/* получение символа операции */
	get_c(_ARGS_ST + 8, op);
	
	ifmn(op, _EQ, '-', "<clc_endif0>");
	    calcmm(num1, '-', num2, result);
	    put_mn(result, _OUT_ST);
	    exit_app(0);
	L("clc_endif0");
	ifmn(op, _EQ, '+', "<clc_endif1>");
	    calcmm(num1, '+', num2, result);
	    put_mn(result, _OUT_ST);
	    exit_app(0);
	L("clc_endif1");
	ifmn(op, _EQ, '/', "<clc_endif2>");
	    calcmm(num1, '/', num2, result);
	    put_mn(result, _OUT_ST);
	    exit_app(0);
	L("clc_endif2");
	ifmn(op, _EQ, '*', "<clc_endif3>");
	    calcmm(num1, '*', num2, result);
	    put_mn(result, _OUT_ST);
	    exit_app(0);
	L("clc_endif3");
	ifmn(op, _EQ, '%', "<clc_endif4>");
	    calcmm(num1, '%', num2, result);
	    put_mn(result, _OUT_ST);
	    exit_app(0);
	L("clc_endif4");
	ifmn(op, _EQ, '^', "<clc_else>");
	    calcmm(num1, '^', num2, result);
	    put_mn(result, _OUT_ST);
	    exit_app(0);
	L("clc_else");
	    aprint("unknown operation", _OUT_ST);
	    exit_app(1);
}

