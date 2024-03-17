/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * gen
 *   печатает сгенерированные цифры на экран
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("gen");
	
	int num = alloc(1);
	
	for(int i = 0; i < 16; i++) {
		gen(num);
		put_mn(num, _OUT_ST + i);
	}
	
	exit_app(0);
}

