;;; функции задержки выполнения

__0_sleep:
	dec %R_FA_9%
	ild %R_FA_9%, %R_FA_0%
	mov %R_FA_1%, 1000
	mul %R_FA_0% %R_FA_1%, %R_FA_0%
	time %R_FA_1%
	add %R_FA_0% %R_FA_1%, %R_FA_0%
	mov %R_FA_2%, <LIB_sleep>
	
    mov %R_RETURN_CODE%, 0
	LIB_sleep:
        ; Ctrl+C check
        mov %R_FA_11%, 3
        mov %R_FA_10%, <LIB_exit>
        if %R_KEY% == %R_FA_11%, %R_FA_10%
        
	    time %R_FA_1%
	    if %R_FA_1% < %R_FA_0%, %R_FA_2%
	
	jmp %R_FA_8%

__0_msleep:
	dec %R_FA_9%
	ild %R_FA_9%, %R_FA_0%
	time %R_FA_1%
	add %R_FA_0% %R_FA_1%, %R_FA_0%
	mov %R_FA_2%, <LIB_msleep>
	
    mov %R_RETURN_CODE%, 0
	LIB_msleep:
        ; Ctrl+C check
        mov %R_FA_11%, 3
        mov %R_FA_10%, <LIB_exit>
        if %R_KEY% == %R_FA_11%, %R_FA_10%
        
	    time %R_FA_1%
	    if %R_FA_1% < %R_FA_0%, %R_FA_2%
	
	jmp %R_FA_8%

