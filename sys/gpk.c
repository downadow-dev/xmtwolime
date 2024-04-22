/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * gpk
 *  печатает pkey
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("gpk");
	
	int num = alloc(1);
	
	char buf[64];
	for(int i = 0; i < 12; i++) {
	    /* pkey находится в разделе info */
	    sprintf(buf, "<info_PKEYCHAR%d_address>", i);
	    
	    mcopyln(buf, num);
	    put_mn(num, _OUT_ST + i);
	}
	
	exit_app(0);
}

