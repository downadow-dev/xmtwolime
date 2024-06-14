
;; данная программа меняет цвет фона и ячеек видеопамяти
; пример использования:  thm 1 0
thm:
	vld 0006, %R_FA_0%
	vld 0008, %R_FA_1%
	
	mov %R_FA_2%, 48
	
	sub %R_FA_0% %R_FA_2%, %R_FA_0%
	sub %R_FA_1% %R_FA_2%, %R_FA_1%
	
	mov2 %R_FA_2%, <thm_colors>
	;; цвет фона и цвет ячеек видеопамяти не должны быть равными
	if %R_FA_0% == %R_FA_1%, %R_FA_2%
	
	isv %R_FA_0%, <_main_bgColor>
	isv %R_FA_1%, <_main_otherColor>
	
	%__END_THE_APP__%
	
	thm_colors:
	    vstr 0126, "black        0"
	    vstr 0189, "white        1"
	    vstr 0252, "green        2"
	    vstr 0315, "blue         3"
	    vstr 0378, "green2       4"
	    vstr 0441, "grey         5"
	    vstr 0504, "red          6"
	    vstr 0567, "yellow       7"
	    
		mov %R_RETURN_CODE%, 1
		%__END_THE_APP__%
