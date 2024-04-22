/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * sed ЦЦЦЦЦЦЦ АРГ-Ы
 *   записать АРГ-Ы в память, начиная с ЦЦЦЦЦЦЦ
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("sed");
	
	int addr = alloc(1), user = alloc(1);
	vcatv2(_ARGS_ST - 1, addr);
	
	getreg(_R_USER, user);
	ifmn(user, _NE, 0, "<sed_endif0>");
		ifmn(addr, _LT, _ORDINARY_USER_SPACE_ST, "<sed_endif1>");
			aprint("root required", _OUT_ST);
			exit_app(1);
		L("sed_endif1");
	L("sed_endif0");
	
	int c = alloc(1);
	for(int i = _ARGS_ST + 8; i < _OUT_ST; i++, inc(addr)) {
	    get_c(i, c);
	    mcopynm(c, addr);
	}
	
	exit_app(0);
}

