
;; эта программа выводит свои аргументы
ech:
	mov %R_FA_0%, %ARGS_ST%
	mov %R_FA_1%, %OUT_ST%
	
	mov %R_FA_2%, %OUT_ST%
	mov2 %R_FA_3%, <ech_loop>
	
	ech_loop:
		vld %R_FA_0%, %R_FA_4%
		vsv %R_FA_4%, %R_FA_1%
		
		inc %R_FA_0%
		inc %R_FA_1%
		
		if %R_FA_0% < %R_FA_2%, %R_FA_3%
	
	updd
	%__END_THE_APP__%
