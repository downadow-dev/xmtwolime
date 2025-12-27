;; напечатать значение из стека (символ)
__0_putc:
    mov2 %R_FA_4%, <LIB_putc_continue>
    mov2 %R_FA_5%, 0001764
    if %R_FA_7% < %R_FA_5%, %R_FA_4%
    mov %R_KEY%, 1
    vsv %R_KEY%, 1902
	mov %R_FA_7%, 0
LIB_putc_continue:
	dec %R_FA_9%
	ild %R_FA_9%, %R_FA_0%
	vsv %R_FA_0%, %R_FA_7%
    mov %R_KEY%, 1
    vsv %R_KEY%, 1901
	inc %R_FA_7%
	jmp %R_FA_8%

