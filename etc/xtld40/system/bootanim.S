     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;;;;                                                              ;;;;
     ;;;;           Автор:          Downadow (Sviatoslav)              ;;;;
     ;;;;                                                              ;;;;
     ;;;;  Доступно по лицензии Downadow License 7 как "Программное    ;;;;
     ;;;;  обеспечение".                                               ;;;;
     ;;;;                                                              ;;;;
     ;;;;                                                     2024 г.  ;;;;
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


system_bootanim:
	mov UR16, 2
	;; смена цвета ячеек видеопамяти на зелёный
	vsv UR16, 1999
	
	mov UR16, 100
	mov2 UR8, 0001500
	mov UR0, '*'
	
	sel UR8, UR6
	vsv UR0, UR6
	updd
	lslp UR16
	
	sel UR8, UR6
	vsv UR0, UR6
	updd
	lslp UR16
	
	sel UR8, UR6
	vsv UR0, UR6
	updd
	lslp UR16
	
	sel UR8, UR6
	vsv UR0, UR6
	updd
	lslp UR16
	
	vstr 0063, " #   #"
	vstr 0126, "  # #"
	vstr 0189, "   #"
	vstr 0252, "  # #"
	vstr 0315, " #   # mtwolime"
	
	sel UR8, UR6
	vsv UR0, UR6
	updd
	lslp UR16
	
	sel UR8, UR6
	vsv UR0, UR6
	updd
	lslp UR16
	
	mov UR8, 3
	slp UR8
	
	mov2 UR16, <boot_continue>
	jmp UR16
	

system_bootanim_end:
	nop
