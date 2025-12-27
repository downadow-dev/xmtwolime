;; получить символ от пользователя
__0_getc:
    vld 1900, %R_KEY%
    isv %R_KEY%, %R_FA_9%
    inc %R_FA_9%
	mov %R_KEY%, 0
	vsv %R_KEY%, 1900
	
	jmp %R_FA_8%

