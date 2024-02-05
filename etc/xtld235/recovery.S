     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;;;;                                                              ;;;;
     ;;;;           Автор:          Downadow (Sviatoslav)              ;;;;
     ;;;;                                                              ;;;;
     ;;;;  Доступно по лицензии Downadow License 7 как "Программное    ;;;;
     ;;;;  обеспечение".                                               ;;;;
     ;;;;                                                              ;;;;
     ;;;;                                                     2024 г.  ;;;;
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


recovery_start:
	mov UR1, 0	
	
	mov UR16, 0
	;; смена цвета ячеек видеопамяти на чёрный
	vsv UR16, 1999
	
	mov UR16, 1
	;; смена цвета фона на белый
	vsv UR16, 1998
	
	vrst
	
	vstr 0028, "RECOVERY"
	vstr 0126, " [1]  erase userdata"
	vstr 0189, " [2]  full reboot"
	updd
	
	recovery_loop:
		mov UR29, 60
		lslp UR29
		mov UR29, '1'
		mov2 UR28, <recovery_loop_1>
		if UR1 == UR29, UR28
		mov UR29, '2'
		mov2 UR28, <recovery_loop_2>
		if UR1 == UR29, UR28
		
		mov2 UR28, <recovery_loop>
		jmp UR28
		
		recovery_loop_1:
			mov2 UR29, 6900000
			mov2 UR28, 9999999
			mov2 UR25, <xloader_start2>
			
			mov UR0, 0
			mov2 UR20, <recovery_loop_1_eraseLoop>
			isv UR0, UR28
			
			recovery_loop_1_eraseLoop:
				isv UR0, UR29
				
				inc UR29
				
				if UR29 < UR28, UR20
			
			jmp UR25
		
		recovery_loop_2:
			mov UR29, 0
			jmp UR29


recovery_end:
	nop
