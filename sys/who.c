/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * who
 *  показывает UID текущего пользователя
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("who");
	
	int uid = alloc(1);
	getreg(_R_USER, uid);
	put_mn(uid, _OUT_ST);
	
	exit_app(0);
}

