     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;;;;                                                              ;;;;
     ;;;;           Автор:          Downadow (Sviatoslav)              ;;;;
     ;;;;                                                              ;;;;
     ;;;;  Доступно по лицензии Downadow License 7 как "Программное    ;;;;
     ;;;;  обеспечение".                                               ;;;;
     ;;;;                                                              ;;;;
     ;;;;                                                     2024 г.  ;;;;
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; предполагается, что bootrom не будет перезаписываться
bootrom_start:
	nop
	
	mov UR0, 2
	
	mov UR17, 0
	;; установка фона
	vsv UR17, 1998
	
	mov UR17, 1
	;; установка цвета ячеек видеопамяти
	vsv UR17, 1999
	
	vrst
	updd
	
	slp UR0
	;;; хочешь попасть в BROM?
	mov UR0, 127
	mov2 UR6, <brom>
	if UR1 == UR0, UR6
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov2 UR6, <xloader_start>
	jmp UR6

	brom:
		mov UR29, 0
		isv UR29, 9999000
		isv UR29, 9999881
		isv UR29, 9999888
		mov UR17, 0
		;; установка цвета фона
		vsv UR17, 1998
		
		mov UR17, 1
		;; установка цвета ячеек видеопамяти
		vsv UR17, 1999
		
		vrst
		updd
		;; ждать одну секунду
		slp UR17
		
		ild 9999877, UR0
		mov UR6, 40
		mov2 UR8, <brom_rescueMode>
		if UR0 == UR6, UR8
		
		;;; проверка auth
		
		ild 9999872, UR0
		mov UR6, 1
		mov2 UR8, <brom>
		if UR0 != UR6, UR8
		
		ild 9999873, UR0
		mov UR6, 2
		mov2 UR8, <xloader_start>
		if UR0 != UR6, UR8
		
		ild 9999874, UR0
		mov UR6, 3
		mov2 UR8, <xloader_start>
		if UR0 != UR6, UR8
		
		ild 9999875, UR0
		ild <info_PKEYCHAR0_address>, UR6
		mov2 UR8, <xloader_start>
		if UR0 != UR6, UR8
		
		;;;;;;;;;;;;;;;;;

	brom_rescueMode:
		brom_rescueMode_loop:
			mov UR29, 8
			isv UR29, 9999002
			
			mov UR29, 5
			lslp UR29
			updd
			
			;;; интерпретация команд
			
			ild 9999872, UR16
			ild 9999881, UR17
			
			mov UR13, 'f'
			
			mov2 UR15, <brom_rescueMode_loop_flash>
			if UR16 == UR13 && UR17 == UR13, UR15
			
			ild 9999872, UR16
			ild 9999881, UR17
			
			mov UR13, 'f'
			
			mov UR14, 'r'
			mov2 UR15, <xloader_start2>
			if UR16 == UR13 && UR17 == UR14, UR15
			
			;;;;;;;;;;;;;;;;;;;;;;;;
			
			mov2 UR28, <brom_rescueMode_loop>
			jmp UR28
			
			brom_rescueMode_loop_flash:
				mov UR1, 0
				mov UR29, 0
				isv UR29, 9999872
				isv UR29, 9999881
				
				mov UR16, 1
				;; смена цвета ячеек видеопамяти на белый
				vsv UR16, 1999
				updd
				
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
				
				;;; запрещаю шить bootrom
				
				mov2 UR28, <bootrom_end>
				mov2 UR27, <brom_rescueMode_loop>
				
				if UR12 < UR28, UR27
				
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
				brom_rescueMode_loop_flash_write:
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
					
					mov UR14, '@'
					mov2 UR15, <brom_rescueMode_loop_flash_write_m>
					ild 9999895, UR13
					if UR13 == UR14, UR15
					
					mov2 UR15, <brom_rescueMode_loop_flash_write_continue>
					jmp UR15
					
					brom_rescueMode_loop_flash_write_m:
						tnp UR20
					
					;;;;;;;;;;;;;;;;;;;;;;
					
					brom_rescueMode_loop_flash_write_continue:
						isv UR20, UR12
			
			brom_rescueMode_loop_flash2:
				mov UR1, 0
				mov UR29, 0
				isv UR29, 9999872
				isv UR29, 9999881
				
				mov UR16, 1
				;; смена цвета ячеек видеопамяти на белый
				vsv UR16, 1999
				updd
				
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
				
				;;; запрещаю шить bootrom
				
				mov2 UR28, <bootrom_end>
				mov2 UR27, <brom_rescueMode_loop>
				
				if UR12 < UR28, UR27
				
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
				brom_rescueMode_loop_flash_write2:
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
					
					mov UR14, '@'
					mov2 UR15, <brom_rescueMode_loop_flash_write_m2>
					ild 9999912, UR13
					if UR13 == UR14, UR15
					
					mov2 UR15, <brom_rescueMode_loop_flash_write_continue2>
					jmp UR15
					
					brom_rescueMode_loop_flash_write_m2:
						tnp UR20
					
					;;;;;;;;;;;;;;;;;;;;;;
					
					brom_rescueMode_loop_flash_write_continue2:
						isv UR20, UR12
			
			brom_rescueMode_loop_flash3:
				mov UR1, 0
				mov UR29, 0
				isv UR29, 9999872
				isv UR29, 9999881
				
				mov UR16, 1
				;; смена цвета ячеек видеопамяти на белый
				vsv UR16, 1999
				updd
				
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
				
				;;; запрещаю шить bootrom
				
				mov2 UR28, <bootrom_end>
				mov2 UR27, <brom_rescueMode_loop>
				
				if UR12 < UR28, UR27
				
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
				brom_rescueMode_loop_flash_write3:
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
					
					mov UR14, '@'
					mov2 UR15, <brom_rescueMode_loop_flash_write_m3>
					ild 9999929, UR13
					if UR13 == UR14, UR15
					
					mov2 UR15, <brom_rescueMode_loop_flash_write_continue3>
					jmp UR15
					
					brom_rescueMode_loop_flash_write_m3:
						tnp UR20
					
					;;;;;;;;;;;;;;;;;;;;;;
					
					brom_rescueMode_loop_flash_write_continue3:
						isv UR20, UR12
						
						mov2 UR20, <brom_rescueMode_loop>
						jmp UR20






bootrom_end:
	nop
