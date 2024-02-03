      ;;;;;;;                                                      ;;;;;;;
      ;;;;;       Автор:                  Downadow (Sviatoslav).     ;;;;;
      ;;;;;       Год создания:           2023.                      ;;;;;
      ;;;;;                                                          ;;;;;
      ;;;;;  Этот файл доступен Вам по лицензии Downadow License 7   ;;;;;
      ;;;;;  как "Програмное обеспечение".                           ;;;;;
      ;;;;;;;                                                      ;;;;;;;


;; данная программа выводит результат операции, пример запуска:
;     clc 0000998 - 0010000
clc:
	vld 0014, %R_FA_0%
	
	mov %R_FA_1%, '+'
	mov2 %R_FA_2%, <clc_add>
	if %R_FA_0% == %R_FA_1%, %R_FA_2%
	
	mov %R_FA_1%, '-'
	mov2 %R_FA_2%, <clc_sub>
	if %R_FA_0% == %R_FA_1%, %R_FA_2%
	
	vld 0015, %R_FA_3%
	mov %R_FA_1%, '*'
	mov2 %R_FA_2%, <clc_exp>
	if %R_FA_0% == %R_FA_1% && %R_FA_3% == %R_FA_1%, %R_FA_2%
	
	mov2 %R_FA_2%, <clc_mul>
	if %R_FA_0% == %R_FA_1%, %R_FA_2%
	
	mov %R_FA_1%, '/'
	mov2 %R_FA_2%, <clc_div>
	if %R_FA_0% == %R_FA_1%, %R_FA_2%
	
	mov %R_FA_1%, '%'
	mov2 %R_FA_2%, <clc_mod>
	if %R_FA_0% == %R_FA_1%, %R_FA_2%
	
	;; иначе
	vstr %OUT_ST%, "unknown operation"
	mov %R_RETURN_CODE%, 1
	%__END_THE_APP__%
	
	clc_add:
		;;; получение первого числа
		
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
		
		;;; получение второго числа
		
		mov %R_FA_8%, 48
		
		vld 0016, %R_FA_1%
		sub %R_FA_1% %R_FA_8%, %R_FA_1%
		
		vld 0017, %R_FA_2%
		sub %R_FA_2% %R_FA_8%, %R_FA_2%
		
		vld 0018, %R_FA_3%
		sub %R_FA_3% %R_FA_8%, %R_FA_3%
		
		vld 0019, %R_FA_4%
		sub %R_FA_4% %R_FA_8%, %R_FA_4%
		
		vld 0020, %R_FA_5%
		sub %R_FA_5% %R_FA_8%, %R_FA_5%
		
		vld 0021, %R_FA_6%
		sub %R_FA_6% %R_FA_8%, %R_FA_6%
		
		vld 0022, %R_FA_7%
		sub %R_FA_7% %R_FA_8%, %R_FA_7%
		
		mov3 %R_FA_8%, %R_FA_2% %R_FA_3% %R_FA_4% %R_FA_5% %R_FA_6% %R_FA_7%
		mov2 %R_FA_2%, 1000000
		mul %R_FA_2% %R_FA_1%, %R_FA_1%
		add %R_FA_8% %R_FA_1%, %R_FA_8%
		
		;;; сложение
		add %R_FA_0% %R_FA_8%, %R_FA_0%
		
		;;; печать результата
		vsvan %R_FA_0%, %OUT_ST%
		updd
		
		;;; выход
		%__END_THE_APP__%
	
	clc_sub:
		;;; получение первого числа
		
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
		
		;;; получение второго числа
		
		mov %R_FA_8%, 48
		
		vld 0016, %R_FA_1%
		sub %R_FA_1% %R_FA_8%, %R_FA_1%
		
		vld 0017, %R_FA_2%
		sub %R_FA_2% %R_FA_8%, %R_FA_2%
		
		vld 0018, %R_FA_3%
		sub %R_FA_3% %R_FA_8%, %R_FA_3%
		
		vld 0019, %R_FA_4%
		sub %R_FA_4% %R_FA_8%, %R_FA_4%
		
		vld 0020, %R_FA_5%
		sub %R_FA_5% %R_FA_8%, %R_FA_5%
		
		vld 0021, %R_FA_6%
		sub %R_FA_6% %R_FA_8%, %R_FA_6%
		
		vld 0022, %R_FA_7%
		sub %R_FA_7% %R_FA_8%, %R_FA_7%
		
		mov3 %R_FA_8%, %R_FA_2% %R_FA_3% %R_FA_4% %R_FA_5% %R_FA_6% %R_FA_7%
		mov2 %R_FA_2%, 1000000
		mul %R_FA_2% %R_FA_1%, %R_FA_1%
		add %R_FA_8% %R_FA_1%, %R_FA_8%
		
		;;; вычитание
		sub %R_FA_0% %R_FA_8%, %R_FA_0%
		
		;;; печать результата
		vsvan %R_FA_0%, %OUT_ST%
		updd
		
		;;; выход
		%__END_THE_APP__%
	
	clc_mul:
		;;; получение первого числа
		
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
		
		;;; получение второго числа
		
		mov %R_FA_8%, 48
		
		vld 0016, %R_FA_1%
		sub %R_FA_1% %R_FA_8%, %R_FA_1%
		
		vld 0017, %R_FA_2%
		sub %R_FA_2% %R_FA_8%, %R_FA_2%
		
		vld 0018, %R_FA_3%
		sub %R_FA_3% %R_FA_8%, %R_FA_3%
		
		vld 0019, %R_FA_4%
		sub %R_FA_4% %R_FA_8%, %R_FA_4%
		
		vld 0020, %R_FA_5%
		sub %R_FA_5% %R_FA_8%, %R_FA_5%
		
		vld 0021, %R_FA_6%
		sub %R_FA_6% %R_FA_8%, %R_FA_6%
		
		vld 0022, %R_FA_7%
		sub %R_FA_7% %R_FA_8%, %R_FA_7%
		
		mov3 %R_FA_8%, %R_FA_2% %R_FA_3% %R_FA_4% %R_FA_5% %R_FA_6% %R_FA_7%
		mov2 %R_FA_2%, 1000000
		mul %R_FA_2% %R_FA_1%, %R_FA_1%
		add %R_FA_8% %R_FA_1%, %R_FA_8%
		
		;;; умножение
		mul %R_FA_0% %R_FA_8%, %R_FA_0%
		
		;;; печать результата
		vsvan %R_FA_0%, %OUT_ST%
		updd
		
		;;; выход
		%__END_THE_APP__%
	
	clc_exp:
		;;; получение первого числа
		
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
		
		;;; получение второго числа
		
		mov %R_FA_8%, 48
		
		vld 0017, %R_FA_1%
		sub %R_FA_1% %R_FA_8%, %R_FA_1%
		
		vld 0018, %R_FA_2%
		sub %R_FA_2% %R_FA_8%, %R_FA_2%
		
		vld 0019, %R_FA_3%
		sub %R_FA_3% %R_FA_8%, %R_FA_3%
		
		vld 0020, %R_FA_4%
		sub %R_FA_4% %R_FA_8%, %R_FA_4%
		
		vld 0021, %R_FA_5%
		sub %R_FA_5% %R_FA_8%, %R_FA_5%
		
		vld 0022, %R_FA_6%
		sub %R_FA_6% %R_FA_8%, %R_FA_6%
		
		vld 0023, %R_FA_7%
		sub %R_FA_7% %R_FA_8%, %R_FA_7%
		
		mov3 %R_FA_8%, %R_FA_2% %R_FA_3% %R_FA_4% %R_FA_5% %R_FA_6% %R_FA_7%
		mov2 %R_FA_2%, 1000000
		mul %R_FA_2% %R_FA_1%, %R_FA_1%
		add %R_FA_8% %R_FA_1%, %R_FA_8%
		
		;;; возведение
		exp %R_FA_0% %R_FA_8%, %R_FA_0%
		
		;;; печать результата
		vsvan %R_FA_0%, %OUT_ST%
		updd
		
		;;; выход
		%__END_THE_APP__%
	
	clc_div:
		;;; получение первого числа
		
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
		
		;;; получение второго числа
		
		mov %R_FA_8%, 48
		
		vld 0016, %R_FA_1%
		sub %R_FA_1% %R_FA_8%, %R_FA_1%
		
		vld 0017, %R_FA_2%
		sub %R_FA_2% %R_FA_8%, %R_FA_2%
		
		vld 0018, %R_FA_3%
		sub %R_FA_3% %R_FA_8%, %R_FA_3%
		
		vld 0019, %R_FA_4%
		sub %R_FA_4% %R_FA_8%, %R_FA_4%
		
		vld 0020, %R_FA_5%
		sub %R_FA_5% %R_FA_8%, %R_FA_5%
		
		vld 0021, %R_FA_6%
		sub %R_FA_6% %R_FA_8%, %R_FA_6%
		
		vld 0022, %R_FA_7%
		sub %R_FA_7% %R_FA_8%, %R_FA_7%
		
		mov3 %R_FA_8%, %R_FA_2% %R_FA_3% %R_FA_4% %R_FA_5% %R_FA_6% %R_FA_7%
		mov2 %R_FA_2%, 1000000
		mul %R_FA_2% %R_FA_1%, %R_FA_1%
		add %R_FA_8% %R_FA_1%, %R_FA_8%
		
		;;; деление
		div %R_FA_0% %R_FA_8%, %R_FA_0%
		
		;;; печать результата
		vsvan %R_FA_0%, %OUT_ST%
		updd
		
		;;; выход
		%__END_THE_APP__%
	
	clc_mod:
		;;; получение первого числа
		
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
		
		;;; получение второго числа
		
		mov %R_FA_8%, 48
		
		vld 0016, %R_FA_1%
		sub %R_FA_1% %R_FA_8%, %R_FA_1%
		
		vld 0017, %R_FA_2%
		sub %R_FA_2% %R_FA_8%, %R_FA_2%
		
		vld 0018, %R_FA_3%
		sub %R_FA_3% %R_FA_8%, %R_FA_3%
		
		vld 0019, %R_FA_4%
		sub %R_FA_4% %R_FA_8%, %R_FA_4%
		
		vld 0020, %R_FA_5%
		sub %R_FA_5% %R_FA_8%, %R_FA_5%
		
		vld 0021, %R_FA_6%
		sub %R_FA_6% %R_FA_8%, %R_FA_6%
		
		vld 0022, %R_FA_7%
		sub %R_FA_7% %R_FA_8%, %R_FA_7%
		
		mov3 %R_FA_8%, %R_FA_2% %R_FA_3% %R_FA_4% %R_FA_5% %R_FA_6% %R_FA_7%
		mov2 %R_FA_2%, 1000000
		mul %R_FA_2% %R_FA_1%, %R_FA_1%
		add %R_FA_8% %R_FA_1%, %R_FA_8%
		
		;;; получение остатка от деления
		mod %R_FA_0% %R_FA_8%, %R_FA_0%
		
		;;; печать результата
		vsvan %R_FA_0%, %OUT_ST%
		updd
		
		;;; выход
		%__END_THE_APP__%

