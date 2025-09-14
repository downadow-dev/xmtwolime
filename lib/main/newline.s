;; переход на новую строку
__0_newline:
	mov %R_FA_0%, 63
	rem %R_FA_7% %R_FA_0%, %R_FA_1%
	sub %R_FA_0% %R_FA_1%, %R_FA_0%
	add %R_FA_7% %R_FA_0%, %R_FA_7%
	
	jmp %R_FA_8%

