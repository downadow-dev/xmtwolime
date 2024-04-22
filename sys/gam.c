/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * gam
 *   "игра"
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("gam");
	
	vclear();
	
	int c = alloc(1);
	L("gam_loop");
	    get_char(c);
	    
	    ifmn(c, _EQ, '0', "<gam_endif0>");
	        xprint("zero, ", _WHITE);
	    L("gam_endif0");
	    
	    ifmn(c, _EQ, '1', "<gam_endif1>");
	        xprint("one, ", _GREY);
	    L("gam_endif1");
	    
	    ifmn(c, _EQ, '2', "<gam_endif2>");
	        xprint("two, ", _RED);
	    L("gam_endif2");
	    
	    ifmn(c, _EQ, '3', "<gam_endif3>");
	        xprint("three, ", _BLUE);
	    L("gam_endif3");
	    
	    ifmn(c, _EQ, '4', "<gam_endif4>");
	        xprint("four, ", _GREEN);
	    L("gam_endif4");
	    
	    ifmn(c, _EQ, '5', "<gam_endif5>");
	        xprint("five, ", _YELLOW);
	    L("gam_endif5");
	    
	    ifmn(c, _EQ, '6', "<gam_endif6>");
	        xprint("six, ", _GREEN2);
	    L("gam_endif6");
	    
	    ifmn(c, _EQ, '7', "<gam_endif7>");
	        xprint("seven, ", _WHITE);
	    L("gam_endif7");
	    
	    ifmn(c, _EQ, '8', "<gam_endif8>");
	        xprint("eight, ", _BLUE);
	    L("gam_endif8");
	    
	    ifmn(c, _EQ, '9', "<gam_endif9>");
	        xprint("nine", _YELLOW);
	        exit_app(0);
	    L("gam_endif9");
	G("<gam_loop>");
}

