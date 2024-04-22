/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * ech АРГ-Ы
 *  выводит свои аргументы
 */


#include <xmtwolime_mkxm2cc.h>

#define ARGS_SIZE     (_OUT_ST - _ARGS_ST)

int main() {
	init("ech");
	
	addr_t args = alloc(ARGS_SIZE);
	strv(_ARGS_ST, args, ARGS_SIZE);
	xprintm(args, ARGS_SIZE, -1);
	
	exit_app(0);
}

