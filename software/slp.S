      ;;;;;;;                                                      ;;;;;;;
      ;;;;;       Автор:                  Downadow (Sviatoslav).     ;;;;;
      ;;;;;       Год создания:           2023.                      ;;;;;
      ;;;;;                                                          ;;;;;
      ;;;;;  Этот файл доступен Вам по лицензии Downadow License 7   ;;;;;
      ;;;;;  как "Програмное обеспечение".                           ;;;;;
      ;;;;;;;                                                      ;;;;;;;


;; включить "спящий" режим
slp:
	mov %R_FA_0%, 2
	mov2 %R_FA_1%, <slp_keyWait>
	
	vrst
	updd
	
	slp_keyWait:
		slp %R_FA_0%
		if %R_KEY% == %R_ZERO%, %R_FA_1%
	
	mov2 %R_FA_1%, <_main>
	mov %R_KEY%, 0
	jmp %R_FA_1%
