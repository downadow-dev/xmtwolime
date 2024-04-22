/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * str ЦЦЦЦЦЦЦ
 *   печатать символы из памяти, начиная с ЦЦЦЦЦЦЦ
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("str");
	
	int addr = alloc(1), user = alloc(1), c = alloc(1);
	vcatv2(_ARGS_ST - 1, addr);
	
	getreg(_R_USER, user);
	
	ifmn(user, _NE, 0, "<str_endif0>");
		ifmn(addr, _LT, _ORDINARY_USER_SPACE_ST, "<str_endif1>");
			aprint("root required", _OUT_ST);
			exit_app(1);
		L("str_endif1");
	L("str_endif0");
	
	int i = alloc(1);
	mset(i, _OUT_ST);
	L("str_loop");
	    mcopymn(addr, c);
	    put_mcm(c, i);
	ifmn(i, _LT, 1600, "<str_loop>");
	
	exit_app(0);
}

