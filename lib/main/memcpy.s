
__0_memcpy:
    ; размер
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_2%
    ; адрес источника
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    ; адрес назначения
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
	mov %R_RETURN_CODE%, 30
	mov2 %R_FA_3%, 6900000
	mov %R_FA_4%, <LIB_exit>
	mov %R_RETURN_CODE%, 30
	if %R_FA_0% < %R_FA_3%, %R_FA_4%
	
    inc %R_FA_9%
    
    mov2 %R_FA_4%, <LIB_memcpy>
    LIB_memcpy:
        ild %R_FA_1%, %R_FA_3%
        isv %R_FA_3%, %R_FA_0%
        
        inc %R_FA_0%
        inc %R_FA_1%
        
        dec %R_FA_2%
        
        if %R_FA_2% > %R_ZERO%, %R_FA_4%
    
    jmp %R_FA_8%

