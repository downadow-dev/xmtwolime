/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * clr [НОМЕР_ЦВЕТА]
 *   печатает информацию об цветах, либо
 *   заполняет экран цветом НОМЕР_ЦВЕТА
 *   НОМЕР_ЦВЕТА не может быть нулём
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("clr");
	
	int color = alloc(1);
	strv(_ARGS_ST, color, 1);
	calcmn(color, '-', 48, color);
	
	/* заполнить экран цветом */
	ifmn(color, _GT, 0, "<clr_endif>");
		vclear();
		put_mc(color, _BG_COLOR_VADDR);
		upddisp();
		get_char(-1);
		exit_app(0);
	L("clr_endif");
	
	aprint("black         0", _OUT_ST);
	aprint("white         1", _OUT_ST + 63);
	aprint("green         2", _OUT_ST + 63 * 2);
	aprint("blue          3", _OUT_ST + 63 * 3);
	aprint("green2        4", _OUT_ST + 63 * 4);
	aprint("grey          5", _OUT_ST + 63 * 5);
	aprint("red           6", _OUT_ST + 63 * 6);
	aprint("yellow        7", _OUT_ST + 63 * 7);
	
	exit_app(0);
}

