/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * chu
 *   изменить текущий UID
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("chu");
	
	int uid = alloc(1);
	getreg(_R_USER, uid);
	ifmn(uid, _EQ, 0, "<chu_else>");
	    /* root => ordinary user */
		mset(uid, 1);
		toreg(uid, _R_USER);
		exit_app(0);
	L("chu_else");
	    int is_root_allowed = alloc(1);
	    mcopyln("<_is_root_allowed?>", is_root_allowed);
	    
	    ifmn(is_root_allowed, _EQ, 1 /* yes */, "<chu_endif>");
	        /* ordinary user => root */
		    mset(uid, 0);
		    toreg(uid, _R_USER);
		    exit_app(0);
	    L("chu_endif");
	    
		exit_app(1);
}

