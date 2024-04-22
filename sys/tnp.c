/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * tnp ЦЦЦЦЦЦЦ
 *   изменить знак содержимого ячейки памяти
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("tnp");
	
	int addr = alloc(1), user = alloc(1);
	vcatv2(_ARGS_ST - 1, addr);
	
	getreg(_R_USER, user);
	
	ifmn(user, _NE, 0, "<tnp_endif0>");
		ifmn(addr, _LT, _ORDINARY_USER_SPACE_ST, "<tnp_endif1>");
			aprint("root required", _OUT_ST);
			exit_app(1);
		L("tnp_endif1");
	L("tnp_endif0");
	
	negm(addr);
	
	exit_app(0);
}

