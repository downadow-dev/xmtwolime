
__0_memset:
    ; размер
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_2%
    ; символ
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    ; начальный адрес
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
	mov %R_RETURN_CODE%, 30
	mov2 %R_FA_3%, 6900000
	mov %R_FA_4%, <LIB_exit>
	mov %R_RETURN_CODE%, 30
	if %R_FA_0% < %R_FA_3%, %R_FA_4%
	
    inc %R_FA_9%
    
    mov2 %R_FA_3%, <LIB_memset>
    LIB_memset:
        isv %R_FA_1%, %R_FA_0%
        inc %R_FA_0%
        dec %R_FA_2%
        
        if %R_FA_2% > %R_ZERO%, %R_FA_3%
    
    jmp %R_FA_8%

