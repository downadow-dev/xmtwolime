/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * bed ЦЦЦЦЦЦЦ ЦЦЦЦЦЦЦ
 *   изменить содержимое ячейки памяти <первый арг.> на <второй арг.>
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("bed");
	
	int addr = alloc(1), user = alloc(1), value = alloc(1);
	vcatv2(_ARGS_ST - 1, addr);
	vcatv2(_ARGS_ST + 7, value);
	
	getreg(_R_USER, user);
	ifmn(user, _NE, 0, "<bed_endif0>");
		ifmn(addr, _LT, _ORDINARY_USER_SPACE_ST, "<bed_endif1>");
			aprint("root required", _OUT_ST);
			exit_app(1);
		L("bed_endif1");
	L("bed_endif0");
	
	mcopynm(value, addr);
	
	exit_app(0);
}

