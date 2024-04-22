/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * thm Ц Ц
 *  изменение цвета фона и текста оболочки
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("thm");
	
	int bg = alloc(1), text = alloc(1);
	
	get_c(_ARGS_ST, bg);
	calcmn(bg, '-', 48, bg);
	get_c(_ARGS_ST + 2, text);
	calcmn(text, '-', 48, text);
	
	mcopynl(bg, "<_main_bgColor>");
	mcopynl(text, "<_main_otherColor>");
	
	exit_app(0);
}

