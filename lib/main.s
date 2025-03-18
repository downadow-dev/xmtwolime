LIB:
	mov %R_FA_0%, %OUT_ST%
	mov %R_FA_1%, 'L'
	vsv %R_FA_1%, %R_FA_0%
	inc %R_FA_0%
	mov %R_FA_1%, 'i'
	vsv %R_FA_1%, %R_FA_0%
	inc %R_FA_0%
	mov %R_FA_1%, 'b'
	vsv %R_FA_1%, %R_FA_0%
	inc %R_FA_0%
	mov %R_FA_1%, 'r'
	vsv %R_FA_1%, %R_FA_0%
	inc %R_FA_0%
	mov %R_FA_1%, 'a'
	vsv %R_FA_1%, %R_FA_0%
	inc %R_FA_0%
	mov %R_FA_1%, 'r'
	vsv %R_FA_1%, %R_FA_0%
	inc %R_FA_0%
	mov %R_FA_1%, 'y'
	vsv %R_FA_1%, %R_FA_0%
	updd
	
	mov %R_RETURN_CODE%, 0
	off

LIB_fail:
	mov %R_RETURN_CODE%, 30
	off
