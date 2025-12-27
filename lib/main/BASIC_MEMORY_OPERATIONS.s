;; вставить в память значение из стека
__0_=:
	pop %R_FA_9%, %R_FA_0%, 1
	pop %R_FA_9%, %R_FA_1%, 1
	
	mov %R_FA_2%, 0
	mov %R_FA_3%, <LIB_=_continue>
	if %R_USER% == %R_FA_2%, %R_FA_3%
	
	mov %R_RETURN_CODE%, 30
	mov %R_FA_2%, 6900000
	mov %R_FA_4%, <LIB_exit>
	mov %R_RETURN_CODE%, 30
	if %R_FA_0% < %R_FA_2%, %R_FA_4%
	
	LIB_=_continue:
	
	isv %R_FA_1%, %R_FA_0%
	
	jmp %R_FA_8%

;; загрузить из памяти значение в стек
__0_.:
	pop %R_FA_9%, %R_FA_0%, 1
	ild %R_FA_0%, %R_FA_0%
	push %R_FA_0%, %R_FA_9%, 1
	jmp %R_FA_8%

