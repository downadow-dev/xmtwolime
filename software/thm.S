      ;;;;;;;                                                      ;;;;;;;
      ;;;;;       Автор:                  Downadow (Sviatoslav).     ;;;;;
      ;;;;;                                                          ;;;;;
      ;;;;;  Этот файл доступен Вам по лицензии Downadow License 7   ;;;;;
      ;;;;;  как "Програмное обеспечение".                           ;;;;;
      ;;;;;;;                                                      ;;;;;;;


;; данная программа меняет цвет фона и ячеек видеопамяти
; пример использования:  thm 1 0
thm:
	vld 0006, %R_FA_0%
	vld 0008, %R_FA_1%
	
	mov %R_FA_2%, 48
	
	sub %R_FA_0% %R_FA_2%, %R_FA_0%
	sub %R_FA_1% %R_FA_2%, %R_FA_1%
	
	mov2 %R_FA_2%, <thm_exit1>
	;; цвет фона и цвет ячеек видеопамяти не должны быть равными
	if %R_FA_0% == %R_FA_1%, %R_FA_2%
	
	isv %R_FA_0%, <_main_bgColor>
	isv %R_FA_1%, <_main_otherColor>
	
	%__END_THE_APP__%
	
	thm_exit1:
		mov %R_RETURN_CODE%, 1
		%__END_THE_APP__%
