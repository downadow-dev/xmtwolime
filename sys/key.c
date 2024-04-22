/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * key
 *  выводит код нажатой клавиши
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("key");
	
	int c = alloc(1);
	get_char(c);
	put_mn(c, _OUT_ST);
	
	exit_app(0);
}

