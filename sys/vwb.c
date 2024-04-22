/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * vwb ЦЦЦЦЦЦЦ
 *   напечатать значение яч. памяти ЦЦЦЦЦЦЦ
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("vwb");
	
	int addr = alloc(1), user = alloc(1), value = alloc(1);
	vcatv2(_ARGS_ST - 1, addr);
	
	getreg(_R_USER, user);
	
	ifmn(user, _NE, 0, "<vwb_endif0>");
		ifmn(addr, _LT, _ORDINARY_USER_SPACE_ST, "<vwb_endif1>");
			aprint("root required", _OUT_ST);
			exit_app(1);
		L("vwb_endif1");
	L("vwb_endif0");
	
	mcopymn(addr, value);
	put_mn(value, _OUT_ST);
	
	exit_app(0);
}

