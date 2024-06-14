
;; данная программа изменяет значение ячейки памяти на число из 7 цифр
bed:
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
	
	mov2 %R_FA_1%, <bed_root?>
	mov2 %R_FA_2%, %ORDINARY_USER_SPACE_ST%
	if %R_FA_0% < %R_FA_2%, %R_FA_1%
	
	bed_write:
		;;; получение значения
		
		mov %R_FA_8%, 48
		
		vld 0014, %R_FA_1%
		sub %R_FA_1% %R_FA_8%, %R_FA_1%
		
		vld 0015, %R_FA_2%
		sub %R_FA_2% %R_FA_8%, %R_FA_2%
		
		vld 0016, %R_FA_3%
		sub %R_FA_3% %R_FA_8%, %R_FA_3%
		
		vld 0017, %R_FA_4%
		sub %R_FA_4% %R_FA_8%, %R_FA_4%
		
		vld 0018, %R_FA_5%
		sub %R_FA_5% %R_FA_8%, %R_FA_5%
		
		vld 0019, %R_FA_6%
		sub %R_FA_6% %R_FA_8%, %R_FA_6%
		
		vld 0020, %R_FA_7%
		sub %R_FA_7% %R_FA_8%, %R_FA_7%
		
		mov3 %R_FA_8%, %R_FA_2% %R_FA_3% %R_FA_4% %R_FA_5% %R_FA_6% %R_FA_7%
		mov2 %R_FA_2%, 1000000
		mul %R_FA_2% %R_FA_1%, %R_FA_1%
		add %R_FA_8% %R_FA_1%, %R_FA_8%
		
		;;;;;;;;;;;;;;;;;;;;;;
		
		isv %R_FA_8%, %R_FA_0%
		
		%__END_THE_APP__%
	
	bed_root?:
		mov2 %R_FA_1%, <bed_write>
		if %R_USER% == %R_ZERO%, %R_FA_1%
		;; иначе
		vstr %OUT_ST% "root required"
		mov %R_RETURN_CODE%, 1
		updd
		
		%__END_THE_APP__%
