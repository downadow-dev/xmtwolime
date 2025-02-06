;; получить символ от пользователя
__0_getc:
    isv %R_KEY%, %R_FA_9%
    inc %R_FA_9%
	mov %R_KEY%, 0
	
	jmp %R_FA_8%

