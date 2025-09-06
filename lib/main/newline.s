;; переход на новую строку
__0_newline:
	mov %R_FA_0%, 63
	mod %R_FA_15% %R_FA_0%, %R_FA_1%
	sub %R_FA_0% %R_FA_1%, %R_FA_0%
	add %R_FA_15% %R_FA_0%, %R_FA_15%
	
	jmp %R_FA_8%

