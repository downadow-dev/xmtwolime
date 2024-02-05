     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;;;;                                                              ;;;;
     ;;;;           Автор:          Downadow (Sviatoslav)              ;;;;
     ;;;;                                                              ;;;;
     ;;;;  Доступно по лицензии Downadow License 7 как "Программное    ;;;;
     ;;;;  обеспечение".                                               ;;;;
     ;;;;                                                              ;;;;
     ;;;;                                                     2024 г.  ;;;;
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


fastboot_start:
	vrst
	
	mov UR17, 0
	;; установка фона
	vsv UR17, 1998
	
	mov UR17, 1
	;; установка цвета ячеек видеопамяти
	vsv UR17, 1999
	
	mov2 UR0, <boot_start>
	jmp UR0

fastboot_rescueMode:
	mov UR16, 0
	
	isv UR16, 9999872
	isv UR16, 9999881
	
	vsv UR16, 1998
	
	mov UR16, 1
	vsv UR16, 1999
	
	vrst
	
	vstr 0063, "fastboot RESCUE_MODE"
	vstr 0189, " state"
	
	vstr 1827, "..............................................................."
	
	ild <info_BSTATE>, UR0
	vsvan UR0, 0223
	mov2 UR0, 0000261
	vsv UR0, 0000
	mov2 UR0, 0000256
	vsv UR0, 0126
	mov2 UR0, 0000258
	vsv UR0, 1000
	
	mov UR17, 2
	mov UR1, 0
	
	fastboot_clear_comm2_0_byte:
		mov UR29, 0
		isv UR29, 9999000
	
	fastboot_clear_command:
		mov UR29, 0
		isv UR29, 9999872
		isv UR29, 9999881
		isv UR29, 9999888
	
	fastboot_rescueMode_loop:
		ild <info_BSTATE>, UR29
		isv UR29, 9999001
		
		mov UR29, 5
		lslp UR29
		mov UR29, 32
		mov2 UR28, <xloader_start2>
		mov UR27, 2
		
		if UR1 == UR29, UR28
		
		mov UR29, 'u'
		mov2 UR28, <fastboot_unlock>
		if UR1 == UR29, UR28
		mov UR28, 0
		
		mov UR29, 'l'
		mov2 UR28, <fastboot_lock>
		if UR1 == UR29, UR28
		mov UR28, 0
		
		updd
		
		;;; интерпретация команд
		
		ild 9999872, UR16
		ild 9999881, UR17
		
		mov UR13, 'f'
		
		mov2 UR15, <fastboot_rescueMode_loop_flash>
		if UR16 == UR13 && UR17 == UR13, UR15
		
		ild 9999881, UR16
		ild 9999888, UR17
		
		mov UR13, 'r'
		
		mov UR14, 'b'
		mov2 UR15, <fastboot_rescueMode>
		if UR16 == UR13 && UR17 == UR14, UR15
		
		mov UR14, 'e'
		ild <info_BSTATE>, UR16
		mov UR13, 0
		mov2 UR15, <edl>
		if UR16 == UR13 && UR17 == UR14, UR15
		
		ild 9999872, UR16
		ild 9999881, UR17
		
		mov UR13, 'f'
		
		mov UR14, 'r'
		mov2 UR15, <xloader_start2>
		if UR16 == UR13 && UR17 == UR14, UR15
		
		mov UR13, 'e'
		ild 9999881, UR16
		ild 9999887, UR17
		mov2 UR25, <fastboot_clear_command>
		
		mov UR14, 'x'
		mov2 UR29, <xloader_start>
		mov2 UR28, <xloader_end>
		mov2 UR15, <fastboot_erase>
		if UR16 == UR13 && UR17 == UR14, UR15
		
		mov UR14, 'b'
		mov2 UR29, <boot_start>
		mov2 UR28, <boot_end>
		mov2 UR15, <fastboot_erase>
		if UR16 == UR13 && UR17 == UR14, UR15
		
		mov UR14, 's'
		mov2 UR29, <system_start>
		mov2 UR28, 6899999
		mov2 UR15, <fastboot_erase>
		if UR16 == UR13 && UR17 == UR14, UR15
		
		mov UR14, 'u'
		mov2 UR29, 6900000
		mov2 UR28, 9999999
		mov2 UR15, <fastboot_erase>
		if UR16 == UR13 && UR17 == UR14, UR15
		
		;;;;;;;;;;;;;;;;;;;;;;;;
		
		mov UR1, 0
		mov2 UR28, <fastboot_rescueMode_loop>
		jmp UR28
		
		fastboot_rescueMode_loop_flash:
			mov UR1, 0
			mov UR29, 0
			isv UR29, 9999872
			isv UR29, 9999881
			ild <info_BSTATE>, UR0
			mov2 UR28, <fastboot_clear_comm2_0_byte>
			if UR0 != UR29, UR28
			
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
			
			mov2 UR29, <xloader_start>
			mov2 UR28, <fastboot_clear_comm2_0_byte>
			
			if UR12 < UR29, UR28
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			
			fastboot_rescueMode_loop_flash_write:
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
				mov2 UR15, <fastboot_rescueMode_loop_flash_write_m>
				ild 9999895, UR13
				if UR13 == UR14, UR15
				
				mov2 UR15, <fastboot_rescueMode_loop_flash_write_continue>
				jmp UR15
				
				fastboot_rescueMode_loop_flash_write_m:
					tnp UR20
				
				;;;;;;;;;;;;;;;;;;;;;;
				
				fastboot_rescueMode_loop_flash_write_continue:
					isv UR20, UR12
			
		fastboot_rescueMode_loop_flash2:
			mov UR1, 0
			mov UR29, 0
			isv UR29, 9999872
			isv UR29, 9999881
			ild <info_BSTATE>, UR0
			mov2 UR28, <fastboot_clear_comm2_0_byte>
			if UR0 != UR29, UR28
			
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
			
			mov2 UR29, <xloader_start>
			mov2 UR28, <fastboot_clear_comm2_0_byte>
			
			if UR12 < UR29, UR28
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			
			fastboot_rescueMode_loop_flash_write2:
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
				mov2 UR15, <fastboot_rescueMode_loop_flash_write_m2>
				ild 9999912, UR13
				if UR13 == UR14, UR15
				
				mov2 UR15, <fastboot_rescueMode_loop_flash_write_continue2>
				jmp UR15
				
				fastboot_rescueMode_loop_flash_write_m2:
					tnp UR20
				
				;;;;;;;;;;;;;;;;;;;;;;
				
				fastboot_rescueMode_loop_flash_write_continue2:
					isv UR20, UR12
		
		fastboot_rescueMode_loop_flash3:
			mov UR1, 0
			mov UR29, 0
			isv UR29, 9999872
			isv UR29, 9999881
			ild <info_BSTATE>, UR0
			mov2 UR28, <fastboot_clear_comm2_0_byte>
			if UR0 != UR29, UR28
			
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
			
			mov2 UR29, <xloader_start>
			mov2 UR28, <fastboot_clear_comm2_0_byte>
			
			if UR12 < UR29, UR28
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			
			fastboot_rescueMode_loop_flash_write3:
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
				mov2 UR15, <fastboot_rescueMode_loop_flash_write_m3>
				ild 9999929, UR13
				if UR13 == UR14, UR15
				
				mov2 UR15, <fastboot_rescueMode_loop_flash_write_continue3>
				jmp UR15
				
				fastboot_rescueMode_loop_flash_write_m3:
					tnp UR20
				
				;;;;;;;;;;;;;;;;;;;;;;
				
				fastboot_rescueMode_loop_flash_write_continue3:
					isv UR20, UR12
					
					mov UR16, 0
					;; смена цвета ячеек видеопамяти на чёрный
					vsv UR16, 1999
					
					mov UR16, 15
					isv UR16, 9999000
					
					mov2 UR20, <fastboot_clear_command>
					jmp UR20


	fastboot_unlock:
		mov UR29, 2
		slp UR29
		mov UR29, 'u'
		mov2 UR28, <fastboot_rescueMode>
		if UR1 != UR29, UR28
		
		mov UR17, 0
		
		mov UR16, 7
		vsv UR16, 1999
		
		mov UR16, 0
		;; смена цвета фона на чёрный
		vsv UR16, 1998
		
		vrst
		
		vstr 0063, " (!)   UNLOCK BOOTLOADER REQUEST"
		mov2 UR29, 0000261
		vsv UR29, 0000
		
		vstr 0441, "Use unlocked RESCUE_MODE for flashing/erasing partitions, rooting etc."
		mov2 UR29, 0000262
		vsv UR29, 0126
		
		vstr 0882, "   [y]  unlock bootloader and reboot"
		vstr 0945, " or"
		vstr 1008, "   do not unlock bootloader and reboot"
		mov2 UR29, 0000256
		vsv UR29, 0693
		
		updd
		
		mov UR29, 8
		slp UR29
		mov UR26, 'y'
		mov2 UR27, <xloader_start>
		if UR1 != UR26, UR27
		
		mov UR0, 0
		isv UR0, <info_BSTATE>
		
		mov UR17, 1
		slp UR17
		
		fastboot_unlock_continue:
			mov2 UR29, 6900000
			mov2 UR28, 9999999
			mov2 UR25, <xloader_start>
			
			fastboot_erase:
				mov2 UR20, <fastboot_erase_loop>
				mov UR0, 0
				ild <info_BSTATE>, UR27
				mov2 UR26, <fastboot_clear_command>
				if UR27 != UR0, UR26
				isv UR0, UR28
				
				fastboot_erase_loop:
					isv UR0, UR29
					
					inc UR29
					
					if UR29 < UR28, UR20
			
			
			jmp UR25


	fastboot_lock:
		mov UR0, 1
		isv UR0, <info_BSTATE>
		mov2 UR0, <recovery_loop_1>
		jmp UR0



fastboot_end:
	nop
