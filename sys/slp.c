/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * slp
 *  "спящий" режим
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("slp");
	
	setcolor(_BLACK, _BLACK);
	upddisp();
	get_char(-1);
	slp(1);
	
	exit_app(0);
}

