     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;;;;                                                              ;;;;
     ;;;;           Автор:          Downadow (Sviatoslav)              ;;;;
     ;;;;                                                              ;;;;
     ;;;;  Доступно по лицензии Downadow License 7 как "Программное    ;;;;
     ;;;;  обеспечение".                                               ;;;;
     ;;;;                                                              ;;;;
     ;;;;                                                     2024 г.  ;;;;
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


xloader_start:
	xloader_start2:
		mov UR16, 1
		;; смена цвета ячеек видеопамяти на белый
		vsv UR16, 1999
		
		mov UR16, 0
		;; смена цвета фона на чёрный
		vsv UR16, 1998
		
		vrst
		updd
		
		mov UR29, 1
		;; ожидание
		slp UR29
		
		mov2 UR0, <fastboot_rescueMode>
		mov UR29, 'r'
		mov2 UR0, <recovery_start>
		;; в recovery_start
		if UR1 == UR29, UR0
		
		mov UR29, 1
		
		mov2 UR0, <fastboot_rescueMode>
		mov UR29, 'f'
		;; в fastboot_rescueMode
		if UR1 == UR29, UR0
		
		mov2 UR0, <fastboot_start>
		jmp UR0



xloader_end:
	nop
