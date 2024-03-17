/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * txt ЦЦЦЦЦЦЦ
 *   записывать пользовательский ввод в память,
 *   начиная с ЦЦЦЦЦЦЦ
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("txt");
	
	int pointer = alloc(1), user = alloc(1);
	vcatv2(_ARGS_ST - 1, pointer);
	
	xset(_OUT_ST);
	
	getreg(_R_USER, user);
	
	/* UID 0 = root */
	ifmn(_R_USER, _NE, 0, "<txt_endif0>");
		ifmn(pointer, _LT, _ORDINARY_USER_SPACE_ST, "<txt_endif1>");
			aprint("root required", _OUT_ST);
			exit_app(1);
		L("txt_endif1");
	L("txt_endif0");
	
	int key = alloc(1);
	
	/********************************************/
	
	L("txt_loop");
		get_char(key);
		
		ifmn(_R_USER, _NE, 0, "<txt_loop_endif2>");
			ifmn(pointer, _LT, _ORDINARY_USER_SPACE_ST, "<txt_loop_endif3>");
				exit_app(2);
			L("txt_loop_endif3");
		L("txt_loop_endif2");
		
		/* (игнорировать SHIFT и др.) */
		ifmn(key, _EQ, 65535, "<txt_loop_endif-1>");
			G("<txt_loop>");
		L("txt_loop_endif-1");
		/* <BACKSPACE> */
		ifmn(key, _EQ, '\b', "<txt_loop_endif0>");
			xdec();
			xprint("_ ", -1);
			xdec();
			xdec();
			dec(pointer);
			/* как 'continue' */
			G("<txt_loop>");
		L("txt_loop_endif0");
		/* <ENTER> */
		ifmn(key, _EQ, '\n', "<txt_loop_endif1>");
			xprint(" ", -1);
			exit_app(0);
		L("txt_loop_endif1");
		/* <ETC> */
		
		mcopynm(key, pointer);
		inc(pointer);
		
		xprintm(key, 1, -1);
		xprint("_", -1);
		xdec();
	G("<txt_loop>");
}

