/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * jmp ЦЦЦЦЦЦЦ
 *  переход к ЦЦЦЦЦЦЦ (для root)
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("jmp");
	
	int uid = alloc(1);
	getreg(_R_USER, uid);
	ifmn(uid, _EQ, 0, "<jmp_else>");
		int addr = alloc(1);
		vcatv2(_ARGS_ST - 1, addr);
		Gm(addr);
	L("jmp_else");
		aprint("root required", _OUT_ST);
		exit_app(1);
}

