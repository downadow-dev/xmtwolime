/*
 *   Автор:             downadow (Sviatoslav)
 * 
 * Данный файл распространяется и используется на условиях
 * Downadow License 7 как "Программное обеспечение".
 * 
 *                                               2024 г.
 */

/*
 * lst
 *  выводит информацию о памяти и видеопамяти как о файлах
 */


#include <xmtwolime_mkxm2cc.h>

int main() {
	init("lst");
	
	aprint("/home/data                 : 8700000..9999999", _OUT_ST);
	
	aprint("/dev/mem0p6                : 6900000..9999999", _OUT_ST + 63 * 2);
	aprint("/dev/vmem                  : 0... (vmem)", _OUT_ST + 63 * 3);
	aprint("/dev/out                   : %OUT_ST%... (vmem)", _OUT_ST + 63 * 4);
	aprint("/dev/in  ->  /dev/out", _OUT_ST + 63 * 5);
	aprint("/dev/err  ->  /dev/out", _OUT_ST + 63 * 6);
	
	int uid = alloc(1);
	getreg(_R_USER, uid);
	
	ifmn(uid, _EQ, 0, "<lst_else>");
		aprint("/dev/mem0p0                : <xloader_start>..<xloader_end>", _OUT_ST + 63 * 7);
		aprint("/dev/mem0p1                : <fastboot_start>..<fastboot_end>", _OUT_ST + 63 * 8);
		aprint("/dev/mem0p2                : <recovery_start>..<recovery_end>", _OUT_ST + 63 * 9);
		aprint("/dev/mem0p3                : <info_start>..<info_end>", _OUT_ST + 63 * 10);
		aprint("/dev/mem0p4                : <boot_start>..<boot_end>", _OUT_ST + 63 * 11);
		aprint("/dev/mem0p5                : <system_start>..6899999", _OUT_ST + 63 * 12);
		aprint("/dev/mem0                  : 0..9999999", _OUT_ST + 63 * 13);
		aprint("/dev/mem                   : 6900000..8699999", _OUT_ST + 63 * 14);
		aprint("/krnl  ->  /dev/mem0p4", _OUT_ST + 63 * 15);
	    aprint("/system/bootanim           : <system_bootanim>..<system_bootanim_end>", _OUT_ST + 63 * 16);
		exit_app(0);
	L("lst_else");
		aprint("...", _OUT_ST + 63 * 7);
		exit_app(1);
}

