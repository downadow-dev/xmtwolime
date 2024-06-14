
;; эта программа отображает код нажатой клавиши
key:
	mov %R_FA_0%, 50
	lslp %R_FA_0%
	mov2 %R_FA_0%, <key>
	if %R_KEY% == %R_ZERO%, %R_FA_0%
	
	vsvan %R_KEY%, %OUT_ST%
	updd
	
	%__END_THE_APP__%

