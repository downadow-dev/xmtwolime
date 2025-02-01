;;;;;;;;  ПАРАМЕТРЫ  ;;;;;;;;

bios_password:
	; выключен
	.byte 0
	
	bios_password_1:
		.byte 0
	bios_password_2:
		.byte 0
	bios_password_3:
		.byte 0
	bios_password_4:
		.byte 0
	bios_password_5:
		.byte 0
	bios_password_6:
		.byte 0

bios_delay:
	.byte 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bios_codeStart:
	mov UR0, 0
	isv UR0, 9999000
	isv UR0, 9999001
	vsv UR0, 1998
	mov UR0, 1
	vsv UR0, 1999
	
	vrst
	vstr 0000, "iiixmish2 BIOS by downadow, 2024-2025"
	updd
	ild <bios_password>, UR0
	mov UR6, 1
	mov2 UR8, <bios_continue>
	if UR0 != UR6, UR8
	
	mov UR1, 0
	vstr 0063, "Please enter the password:"
	updd
	
	;;; ввод пароля
	
	bios_loop1:
		mov UR0, 50
		lslp UR0
		mov UR0, 0
		mov2 UR6, <bios_loop1>
		if UR1 == UR0, UR6
		
		mov UR0, 48
		sub UR1 UR0, UR1
		ld UR1, UR14
		mov UR1, 0
	
	bios_loop2:
		mov UR0, 50
		lslp UR0
		mov UR0, 0
		mov2 UR6, <bios_loop2>
		if UR1 == UR0, UR6
		
		mov UR0, 48
		sub UR1 UR0, UR1
		ld UR1, UR15
		mov UR1, 0
	
	bios_loop3:
		mov UR0, 50
		lslp UR0
		mov UR0, 0
		mov2 UR6, <bios_loop3>
		if UR1 == UR0, UR6
		
		mov UR0, 48
		sub UR1 UR0, UR1
		ld UR1, UR16
		mov UR1, 0
	
	bios_loop4:
		mov UR0, 50
		lslp UR0
		mov UR0, 0
		mov2 UR6, <bios_loop4>
		if UR1 == UR0, UR6
		
		mov UR0, 48
		sub UR1 UR0, UR1
		ld UR1, UR17
		mov UR1, 0
	
	bios_loop5:
		mov UR0, 50
		lslp UR0
		mov UR0, 0
		mov2 UR6, <bios_loop5>
		if UR1 == UR0, UR6
		
		mov UR0, 48
		sub UR1 UR0, UR1
		ld UR1, UR18
		mov UR1, 0
	
	bios_loop6:
		mov UR0, 50
		lslp UR0
		mov UR0, 0
		mov2 UR6, <bios_loop6>
		if UR1 == UR0, UR6
		
		mov UR0, 48
		sub UR1 UR0, UR1
		ld UR1, UR19
		mov UR1, 0
	
	;;;;;;;;;;;;;;;;
	
	
	;;; проверка введённого пароля
	
	mov2 UR6, <bios_failure>
	
	ild <bios_password_1>, UR0
	if UR14 != UR0, UR6
	ild <bios_password_2>, UR0
	if UR15 != UR0, UR6
	ild <bios_password_3>, UR0
	if UR16 != UR0, UR6
	ild <bios_password_4>, UR0
	if UR17 != UR0, UR6
	ild <bios_password_5>, UR0
	if UR18 != UR0, UR6
	ild <bios_password_6>, UR0
	if UR19 != UR0, UR6
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	vstr 0126, "OK."
	updd
	
	bios_continue:
	
	mov UR1, 0
	ild <bios_delay>, UR0
	slp UR0
	
	; 27 - ESC
	mov UR0, 27
	mov2 UR6, <bios_setup>
	if UR1 == UR0, UR6
	
	vrst
	
	mov2 UR0, <bios_end>
	jmp UR0

	bios_failure:
		vrst
		mov2 UR0, 0000261
		vsv UR0, 0000
		vstr 0063, "Failure!"
		updd
		mov UR0, 1
		slp UR0
		mov UR0, 0
		jmp UR0
	
	bios_setup:
		vrst
		updd
		vstr 1827, "Setup Utility"
		
		vstr 0126, " [q]   set new password / reset"
		vstr 0189, " [e]   enter downloadMode"
		vstr 0252, " [ws]  change delay:"
		vstr 0315, " [t]   reset clock:"
		vstr 0378, " [ESC] reboot"
		
		ild <bios_delay>, UR0
		vsvan UR0, 0274
		
		time UR0
		vsvan UR0, 0337
		
		updd
		
		mov UR1, 0
		bios_setup_loop:
			mov UR0, 50
			lslp UR0
			mov UR0, 0
			mov2 UR6, <bios_setup_loop>
			if UR1 == UR0, UR6
		
		mov UR6, 'q'
		mov2 UR8, <bios_setup_setPassword>
		if UR1 == UR6, UR8
		
		mov UR6, 'e'
		mov2 UR8, <bios_downloadMode>
		if UR1 == UR6, UR8
		
		mov UR6, 'w'
		mov2 UR8, <bios_setup_delay++>
		if UR1 == UR6, UR8
		
		mov UR6, 's'
		mov2 UR8, <bios_setup_delay-->
		if UR1 == UR6, UR8
		
		mov UR6, 't'
		mov2 UR8, <bios_setup_resetClock>
		if UR1 == UR6, UR8
		
		mov UR6, 27
		mov UR8, 0
		if UR1 == UR6, UR8
		
		bios_setup_setPassword:
			vrst
			mov UR1, 0
			vstr 0000, "Enter a new password (6 characters):"
			updd
			
			bios_setup_loop1:
				mov UR0, 50
				lslp UR0
				mov UR0, 0
				mov2 UR6, <bios_setup_loop1>
				if UR1 == UR0, UR6
				
				; 10 - newline
				mov UR0, 10
				mov2 UR6, <bios_setup_loop1_continue>
				if UR1 != UR0, UR6
				
				mov UR0, 0
				isv UR0, <bios_password>
				vrst
				vstr 0000, "password reset OK"
				updd
				mov UR0, 2
				slp UR0
				mov2 UR0, <bios_setup>
				jmp UR0
				
				bios_setup_loop1_continue:
				
				mov UR0, 1
				isv UR0, <bios_password>
				
				mov UR0, 48
				sub UR1 UR0, UR1
				isv UR1, <bios_password_1>
				mov UR1, 0
	
			bios_setup_loop2:
				mov UR0, 50
				lslp UR0
				mov UR0, 0
				mov2 UR6, <bios_setup_loop2>
				if UR1 == UR0, UR6
		
				mov UR0, 48
				sub UR1 UR0, UR1
				isv UR1, <bios_password_2>
				mov UR1, 0
	
			bios_setup_loop3:
				mov UR0, 50
				lslp UR0
				mov UR0, 0
				mov2 UR6, <bios_setup_loop3>
				if UR1 == UR0, UR6
		
				mov UR0, 48
				sub UR1 UR0, UR1
				isv UR1, <bios_password_3>
				mov UR1, 0
	
			bios_setup_loop4:
				mov UR0, 50
				lslp UR0
				mov UR0, 0
				mov2 UR6, <bios_setup_loop4>
				if UR1 == UR0, UR6
				
				mov UR0, 48
				sub UR1 UR0, UR1
				isv UR1, <bios_password_4>
				mov UR1, 0
	
			bios_setup_loop5:
				mov UR0, 50
				lslp UR0
				mov UR0, 0
				mov2 UR6, <bios_setup_loop5>
				if UR1 == UR0, UR6
		
				mov UR0, 48
				sub UR1 UR0, UR1
				isv UR1, <bios_password_5>
				mov UR1, 0
	
			bios_setup_loop6:
				mov UR0, 50
				lslp UR0
				mov UR0, 0
				mov2 UR6, <bios_setup_loop6>
				if UR1 == UR0, UR6
		
				mov UR0, 48
				sub UR1 UR0, UR1
				isv UR1, <bios_password_6>
				mov UR1, 0
			
			vstr 0063, "OK?  "
			ild <bios_password_1>, UR0
			vsvan UR0, 0068
			ild <bios_password_2>, UR0
			vsvan UR0, 0069
			ild <bios_password_3>, UR0
			vsvan UR0, 0070
			ild <bios_password_4>, UR0
			vsvan UR0, 0071
			ild <bios_password_5>, UR0
			vsvan UR0, 0072
			ild <bios_password_6>, UR0
			vsvan UR0, 0073
			updd
			
			mov UR0, 3
			slp UR0
		
		mov2 UR0, <bios_setup>
		jmp UR0
		
	bios_downloadMode:
		mov UR0, 'D'
		isv UR0, 9999000
		mov UR0, 1
		isv UR0, 9999001
		
		mov UR0, 0
		isv UR0, 9999872
		isv UR0, 9999881
		
		vrst
		mov UR0, 3
		; сделать фон синим
		vsv UR0, 1998
		
		updd
		
		bios_downloadMode_loop:
			mov UR29, 5
			lslp UR29
			
			;;; интерпретация команд
			
			ild 9999872, UR16
			ild 9999881, UR17
			
			mov UR13, 'f'
			
			mov2 UR15, <bios_downloadMode_loop_flash>
			if UR16 == UR13 && UR17 == UR13, UR15
			
			ild 9999872, UR16
			ild 9999881, UR17
			
			mov UR13, 'f'
			
			mov UR14, 'r'
			mov UR15, 0
			if UR16 == UR13 && UR17 == UR14, UR15
			
			mov UR14, 'g'
			mov2 UR15, <bios_downloadMode_loop_get>
			if UR16 == UR13 && UR17 == UR14, UR15
			
			;;;;;;;;;;;;;;;;;;;;;;;;
			
			mov2 UR28, <bios_downloadMode_loop>
			jmp UR28
			
			bios_downloadMode_loop_get:
		        ;;; получение адреса ячейки памяти
				
				mov UR20, 48
				
				ild 9999885, UR13
				sub UR13 UR20, UR13
				
				ild 9999886, UR14
				sub UR14 UR20, UR14
				
				ild 9999887, UR15
				sub UR15 UR20, UR15
				
				ild 9999888, UR16
				sub UR16 UR20, UR16
				
				ild 9999889, UR17
				sub UR17 UR20, UR17
				
				ild 9999890, UR18
				sub UR18 UR20, UR18
				
				ild 9999891, UR19
				sub UR19 UR20, UR19
				
				mov3 UR12, UR14 UR15 UR16 UR17 UR18 UR19
				mov2 UR14, 1000000
				mul UR14 UR13, UR13
				add UR12 UR13, UR12
				
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
				mov2 UR19, 9999005
				
				ild UR12, UR20
				isv UR20, UR19
				inc UR12
				inc UR19
				
				ild UR12, UR20
				isv UR20, UR19
				inc UR12
				inc UR19
				
				ild UR12, UR20
				isv UR20, UR19
				inc UR12
				inc UR19
				
				ild UR12, UR20
				isv UR20, UR19
				inc UR12
				inc UR19
				
				mov2 UR20, <bios_downloadMode_loop>
				jmp UR20
			
			bios_downloadMode_loop_flash:
				mov UR1, 0
				mov UR29, 0
				isv UR29, 9999872
				isv UR29, 9999881

				;;; получение адреса ячейки памяти
				
				mov UR20, 48
				
				ild 9999887, UR13
				sub UR13 UR20, UR13
				
				ild 9999888, UR14
				sub UR14 UR20, UR14
				
				ild 9999889, UR15
				sub UR15 UR20, UR15
				
				ild 9999890, UR16
				sub UR16 UR20, UR16
				
				ild 9999891, UR17
				sub UR17 UR20, UR17
				
				ild 9999892, UR18
				sub UR18 UR20, UR18
				
				ild 9999893, UR19
				sub UR19 UR20, UR19
				
				mov3 UR12, UR14 UR15 UR16 UR17 UR18 UR19
				mov2 UR14, 1000000
				mul UR14 UR13, UR13
				add UR12 UR13, UR12
				
				;;; запрещаю шить биос
				
				mov2 UR29, <bios_end>
				mov2 UR28, 9999999
				mov2 UR27, <bios_downloadMode_loop>
				
				if UR12 > UR28, UR27
				if UR12 < UR29, UR27
				
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
				bios_downloadMode_loop_flash_write:
					;;; получение значения
					
					mov UR20, 48
					
					ild 9999896, UR13
					sub UR13 UR20, UR13
					
					ild 9999897, UR14
					sub UR14 UR20, UR14
					
					ild 9999898, UR15
					sub UR15 UR20, UR15
					
					ild 9999899, UR16
					sub UR16 UR20, UR16
					
					ild 9999900, UR17
					sub UR17 UR20, UR17
					
					ild 9999901, UR18
					sub UR18 UR20, UR18
					
					ild 9999902, UR19
					sub UR19 UR20, UR19
					
					mov3 UR20, UR14 UR15 UR16 UR17 UR18 UR19
					mov2 UR14, 1000000
					mul UR14 UR13, UR13
					add UR20 UR13, UR20
					
					mov UR14, '-'
					mov2 UR15, <bios_downloadMode_loop_flash_write_m>
					ild 9999895, UR13
					if UR13 == UR14, UR15
					
					mov2 UR15, <bios_downloadMode_loop_flash_write_continue>
					jmp UR15
					
					bios_downloadMode_loop_flash_write_m:
						tnp UR20
					
					;;;;;;;;;;;;;;;;;;;;;;
					
					bios_downloadMode_loop_flash_write_continue:
						isv UR20, UR12
			
			bios_downloadMode_loop_flash2:
				mov UR1, 0
				mov UR29, 0
				isv UR29, 9999872
				isv UR29, 9999881

				;;; получение адреса ячейки памяти
				
				mov UR20, 48
				
				ild 9999904, UR13
				sub UR13 UR20, UR13
				
				ild 9999905, UR14
				sub UR14 UR20, UR14
				
				ild 9999906, UR15
				sub UR15 UR20, UR15
				
				ild 9999907, UR16
				sub UR16 UR20, UR16
				
				ild 9999908, UR17
				sub UR17 UR20, UR17
				
				ild 9999909, UR18
				sub UR18 UR20, UR18
				
				ild 9999910, UR19
				sub UR19 UR20, UR19
				
				mov3 UR12, UR14 UR15 UR16 UR17 UR18 UR19
				mov2 UR14, 1000000
				mul UR14 UR13, UR13
				add UR12 UR13, UR12
				
				;;; запрещаю шить биос
				
				mov2 UR29, <bios_end>
				mov2 UR28, 9999999
				mov2 UR27, <bios_downloadMode_loop>
				
				if UR12 > UR28, UR27
				if UR12 < UR29, UR27
				
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
				bios_downloadMode_loop_flash_write2:
					;;; получение значения
					
					mov UR20, 48
					
					ild 9999913, UR13
					sub UR13 UR20, UR13
					
					ild 9999914, UR14
					sub UR14 UR20, UR14
					
					ild 9999915, UR15
					sub UR15 UR20, UR15
					
					ild 9999916, UR16
					sub UR16 UR20, UR16
					
					ild 9999917, UR17
					sub UR17 UR20, UR17
					
					ild 9999918, UR18
					sub UR18 UR20, UR18
					
					ild 9999919, UR19
					sub UR19 UR20, UR19
					
					mov3 UR20, UR14 UR15 UR16 UR17 UR18 UR19
					mov2 UR14, 1000000
					mul UR14 UR13, UR13
					add UR20 UR13, UR20
					
					mov UR14, '-'
					mov2 UR15, <bios_downloadMode_loop_flash_write_m2>
					ild 9999912, UR13
					if UR13 == UR14, UR15
					
					mov2 UR15, <bios_downloadMode_loop_flash_write_continue2>
					jmp UR15
					
					bios_downloadMode_loop_flash_write_m2:
						tnp UR20
					
					;;;;;;;;;;;;;;;;;;;;;;
					
					bios_downloadMode_loop_flash_write_continue2:
						isv UR20, UR12
			
			bios_downloadMode_loop_flash3:
				mov UR1, 0
				mov UR29, 0
				isv UR29, 9999872
				isv UR29, 9999881

				;;; получение адреса ячейки памяти
				
				mov UR20, 48
				
				ild 9999921, UR13
				sub UR13 UR20, UR13
				
				ild 9999922, UR14
				sub UR14 UR20, UR14
				
				ild 9999923, UR15
				sub UR15 UR20, UR15
				
				ild 9999924, UR16
				sub UR16 UR20, UR16
				
				ild 9999925, UR17
				sub UR17 UR20, UR17
				
				ild 9999926, UR18
				sub UR18 UR20, UR18
				
				ild 9999927, UR19
				sub UR19 UR20, UR19
				
				mov3 UR12, UR14 UR15 UR16 UR17 UR18 UR19
				mov2 UR14, 1000000
				mul UR14 UR13, UR13
				add UR12 UR13, UR12
				
				;;; запрещаю шить биос
				
				mov2 UR29, <bios_end>
				mov2 UR28, 9999999
				mov2 UR27, <bios_downloadMode_loop>
				
				if UR12 > UR28, UR27
				if UR12 < UR29, UR27
				
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
				bios_downloadMode_loop_flash_write3:
					;;; получение значения
					
					mov UR20, 48
					
					ild 9999930, UR13
					sub UR13 UR20, UR13
					
					ild 9999931, UR14
					sub UR14 UR20, UR14
					
					ild 9999932, UR15
					sub UR15 UR20, UR15
					
					ild 9999933, UR16
					sub UR16 UR20, UR16
					
					ild 9999934, UR17
					sub UR17 UR20, UR17
					
					ild 9999935, UR18
					sub UR18 UR20, UR18
					
					ild 9999936, UR19
					sub UR19 UR20, UR19
					
					mov3 UR20, UR14 UR15 UR16 UR17 UR18 UR19
					mov2 UR14, 1000000
					mul UR14 UR13, UR13
					add UR20 UR13, UR20
					
					mov UR14, '-'
					mov2 UR15, <bios_downloadMode_loop_flash_write_m3>
					ild 9999929, UR13
					if UR13 == UR14, UR15
					
					mov2 UR15, <bios_downloadMode_loop_flash_write_continue3>
					jmp UR15
					
					bios_downloadMode_loop_flash_write_m3:
						tnp UR20
					
					;;;;;;;;;;;;;;;;;;;;;;
					
					bios_downloadMode_loop_flash_write_continue3:
						isv UR20, UR12
						
						mov2 UR20, <bios_downloadMode_loop>
						jmp UR20
	
	bios_setup_delay++:
		ild <bios_delay>, UR0
		inc UR0
		isv UR0, <bios_delay>
		
		mov2 UR0, <bios_setup>
		jmp UR0
	
	bios_setup_delay--:
		ild <bios_delay>, UR0
		dec UR0
		isv UR0, <bios_delay>
		
		mov2 UR0, <bios_setup>
		jmp UR0
	
	bios_setup_resetClock:
	    trst
	    
	    mov2 UR0, <bios_setup>
	    jmp UR0


bios_end:
	nop

