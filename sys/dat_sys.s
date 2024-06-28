;; отображение даты и времени, используя xm2net-устройство
;  эмулятор: https://notabug.org/downadow/xm2net
dat:
	;;; отправка 'n~%a %D %T %Z' в .comm2
	mov %R_FA_0%, '%'
	isv %R_FA_0%, 9999002
	mov %R_FA_0%, 'a'
	isv %R_FA_0%, 9999003
	mov %R_FA_0%, 32
	isv %R_FA_0%, 9999004
	mov %R_FA_0%, '%'
	isv %R_FA_0%, 9999005
	mov %R_FA_0%, 'D'
	isv %R_FA_0%, 9999006
	mov %R_FA_0%, 32
	isv %R_FA_0%, 9999007
	mov %R_FA_0%, '%'
	isv %R_FA_0%, 9999008
	mov %R_FA_0%, 'T'
	isv %R_FA_0%, 9999009
	mov %R_FA_0%, 32
	isv %R_FA_0%, 9999010
	mov %R_FA_0%, '%'
	isv %R_FA_0%, 9999011
	mov %R_FA_0%, 'Z'
	isv %R_FA_0%, 9999012
	
	mov %R_FA_0%, '~'
	isv %R_FA_0%, 9999001
	mov %R_FA_0%, 'n'
	isv %R_FA_0%, 9999000
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov2 %R_FA_0%, 0000400
	lslp %R_FA_0%
	isv %R_ZERO%, 9999000
	
	mov2 %R_FA_0%, 9999874
	mov %R_FA_1%, %OUT_ST%
	
	mov2 %R_FA_2%, 9999900
	mov2 %R_FA_3%, <dat_loop>
	
	dat_loop:
		ild %R_FA_0%, %R_FA_4%
		vsv %R_FA_4%, %R_FA_1%
		
		inc %R_FA_0%
		inc %R_FA_1%
		
		if %R_FA_0% < %R_FA_2%, %R_FA_3%
	
	updd
	%__END_THE_APP__%
