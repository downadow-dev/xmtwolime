      ;;;;;;;                                                      ;;;;;;;
      ;;;;;       Автор:                  Downadow (Sviatoslav).     ;;;;;
      ;;;;;       Год создания:           2023.                      ;;;;;
      ;;;;;                                                          ;;;;;
      ;;;;;  Этот файл доступен Вам по лицензии Downadow License 7   ;;;;;
      ;;;;;  как "Програмное обеспечение".                           ;;;;;
      ;;;;;;;                                                      ;;;;;;;


;; эта программа сохраняет строку в память
sed:
	;;; получение адреса ячейки памяти
	
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
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	mov2 %R_FA_1%, <sed_root?>
	mov2 %R_FA_2%, %ORDINARY_USER_SPACE_ST%
	if %R_FA_0% < %R_FA_2%, %R_FA_1%
	
	sed_write:
		mov %R_FA_10%, 14
		mov %R_FA_9%, %OUT_ST%
		mov2 %R_FA_7%, <sed_write_loop>
		
		sed_write_loop:	
			vld %R_FA_10%, %R_FA_1%
			
			isv %R_FA_1%, %R_FA_0%
			
			inc %R_FA_10%
			inc %R_FA_0%
			
			if %R_FA_10% < %R_FA_9%, %R_FA_7%
		
		%__END_THE_APP__%
	
	sed_root?:
		mov2 %R_FA_1%, <sed_write>
		if %R_USER% == %R_ZERO%, %R_FA_1%
		;; иначе
		vstr %OUT_ST% "root required"
		mov %R_RETURN_CODE%, 1
		updd
		
		%__END_THE_APP__%
