/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * num ЦЦЦЦЦЦЦ
 *   почти как str, но печатать числа
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("num");
	
	int addr = alloc(1), user = alloc(1), value = alloc(1);
	vcatv2(_ARGS_ST - 1, addr);
	
	getreg(_R_USER, user);
	
	ifmn(user, _NE, 0, "<num_endif0>");
		ifmn(addr, _LT, _ORDINARY_USER_SPACE_ST, "<num_endif1>");
			aprint("root required", _OUT_ST);
			exit_app(1);
		L("num_endif1");
	L("num_endif0");
	
	for(int i = 0; i < 25; i++, inc(addr)) {
		mcopymn(addr, value);
		put_mn(value, _OUT_ST + 63 * i);
	}
	
	exit_app(0);
}

