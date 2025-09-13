__0_goto:
__0_xm2_code:
    ; Ctrl+C check
    mov %R_RETURN_CODE%, 0
    mov %R_FA_1%, 3
    mov %R_FA_0%, <LIB_exit>
    vld 1900, %R_KEY%
    if %R_KEY% == %R_FA_1%, %R_FA_0%
    
	dec %R_FA_9%
	ild %R_FA_9%, %R_FA_8%
	jmp %R_FA_8%

