;;; функции задержки выполнения

__0_sleep:
	dec %R_FA_9%
	ild %R_FA_9%, %R_FA_0%
	mov %R_FA_1%, 1000
	mul %R_FA_0% %R_FA_1%, %R_FA_0%
	time %R_FA_1%
	add %R_FA_0% %R_FA_1%, %R_FA_0%
	mov %R_FA_2%, <LIB_sleep>
	LIB_sleep:
	    nop
	    time %R_FA_1%
	    if %R_FA_1% < %R_FA_0%, %R_FA_2%
	
	jmp %R_FA_8%

__0_msleep:
	dec %R_FA_9%
	ild %R_FA_9%, %R_FA_0%
	time %R_FA_1%
	add %R_FA_0% %R_FA_1%, %R_FA_0%
	mov %R_FA_2%, <LIB_msleep>
	LIB_msleep:
	    nop
	    time %R_FA_1%
	    if %R_FA_1% < %R_FA_0%, %R_FA_2%
	
	jmp %R_FA_8%

