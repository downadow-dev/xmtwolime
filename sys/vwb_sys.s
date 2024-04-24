      ;;;;;;;                                                      ;;;;;;;
      ;;;;;       Автор:                  Downadow (Sviatoslav).     ;;;;;
      ;;;;;       Год создания:           2023.                      ;;;;;
      ;;;;;                                                          ;;;;;
      ;;;;;  Этот файл доступен Вам по лицензии Downadow License 7   ;;;;;
      ;;;;;  как "Програмное обеспечение".                           ;;;;;
      ;;;;;;;                                                      ;;;;;;;


;; эта программа выводит значение полученного байта
; просмотр значения байта, который находится не
; в пределах ordinary user space, запрещено для обычного
; пользователя
vwb:
	mov2 %R_FA_0%, <vwb_main>
	jmp %R_FA_0%
	
	vwb_root?:
		mov2 %R_FA_2%, <vwb_main_output>
		if %R_USER% == %R_ZERO%, %R_FA_2%
		;; иначе
		vstr %OUT_ST%, "root required"
		mov %R_RETURN_CODE%, 1
		%__END_THE_APP__%
	
	vwb_main:
		mov %R_FA_8%, 48
		
		vld 0006, %R_FA_1%
		sub %R_FA_1% %R_FA_8%, %R_FA_1%
		
		vld 0007, %R_FA_2%
		sub %R_FA_2% %R_FA_8%, %R_FA_2%
		
		vld 0008, %R_FA_3%
		sub %R_FA_3% %R_FA_8%, %R_FA_3%
		
		vld 0009, %R_FA_4%
		sub %R_FA_4% %R_FA_8%, %R_FA_4%
		
		vld 0010, %R_FA_5%
		sub %R_FA_5% %R_FA_8%, %R_FA_5%
		
		vld 0011, %R_FA_6%
		sub %R_FA_6% %R_FA_8%, %R_FA_6%
		
		vld 0012, %R_FA_7%
		sub %R_FA_7% %R_FA_8%, %R_FA_7%
		
		mov3 %R_FA_0%, %R_FA_2% %R_FA_3% %R_FA_4% %R_FA_5% %R_FA_6% %R_FA_7%
		mov2 %R_FA_2%, 1000000
		mul %R_FA_2% %R_FA_1%, %R_FA_1%
		add %R_FA_0% %R_FA_1%, %R_FA_0%
		ild %R_FA_0%, %R_FA_8%
		
		mov2 %R_FA_1%, %ORDINARY_USER_SPACE_ST%
		mov2 %R_FA_2%, <vwb_root?>
		if %R_FA_0% < %R_FA_1%, %R_FA_2%
		
		vwb_main_output:
			vsvan %R_FA_8%, %OUT_ST%
			updd
			
		%__END_THE_APP__%
