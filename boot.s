.orig 0

vrst
updd

mov UR1, 0
mov UR0, 1
slp UR0

; проверка на ESC
mov UR0, 27
mov2 UR6, <kernel_start>
if UR1 != UR0, UR6

boot_downloadMode:
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
	
	boot_downloadMode_loop:
		mov UR29, 10
		lslp UR29
		
		;;; интерпретация команд
		
		ild 9999872, UR17
		
		mov UR13, 'f'
		
		mov2 UR15, <boot_downloadMode_loop_flash>
		if UR17 == UR13, UR15
		
		mov UR13, 'r'
		mov UR15, 0
		if UR17 == UR13, UR15
		
		mov UR13, 'g'
		mov2 UR15, <boot_downloadMode_loop_get>
		if UR17 == UR13, UR15
		
		;;;;;;;;;;;;;;;;;;;;;;;;
		
		mov2 UR28, <boot_downloadMode_loop>
		jmp UR28
		
		boot_downloadMode_loop_get:
	        ;;; получение адреса ячейки памяти
			
			mov UR20, 48
			
			ild 9999873, UR13
			sub UR13 UR20, UR13
			
			ild 9999874, UR14
			sub UR14 UR20, UR14
			
			ild 9999875, UR15
			sub UR15 UR20, UR15
			
			ild 9999876, UR16
			sub UR16 UR20, UR16
			
			ild 9999877, UR17
			sub UR17 UR20, UR17
			
			ild 9999878, UR18
			sub UR18 UR20, UR18
			
			ild 9999879, UR19
			sub UR19 UR20, UR19
			
			mov2 UR20, 1000000
			mul UR13 UR20, UR12
			mov2 UR20, 0100000
			mul UR14 UR20, UR14
			add UR14 UR12, UR12
			mov2 UR20, 0010000
			mul UR15 UR20, UR15
			add UR15 UR12, UR12
			mov2 UR20, 0001000
			mul UR16 UR20, UR16
			add UR16 UR12, UR12
			mov UR20, 100
			mul UR17 UR20, UR17
			add UR17 UR12, UR12
			mov UR20, 10
			mul UR18 UR20, UR18
			add UR18 UR12, UR12
			add UR19 UR12, UR12
			
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
			
			mov2 UR20, <boot_downloadMode_loop>
			jmp UR20
		
		boot_downloadMode_loop_flash:
			mov UR1, 0
			mov UR29, 0
			isv UR29, 9999872

			;;; получение адреса ячейки памяти
			
			mov UR20, 48
			
			ild 9999873, UR13
			sub UR13 UR20, UR13
			
			ild 9999874, UR14
			sub UR14 UR20, UR14
			
			ild 9999875, UR15
			sub UR15 UR20, UR15
			
			ild 9999876, UR16
			sub UR16 UR20, UR16
			
			ild 9999877, UR17
			sub UR17 UR20, UR17
			
			ild 9999878, UR18
			sub UR18 UR20, UR18
			
			ild 9999879, UR19
			sub UR19 UR20, UR19
			
			mov2 UR20, 1000000
			mul UR13 UR20, UR12
			mov2 UR20, 0100000
			mul UR14 UR20, UR14
			add UR14 UR12, UR12
			mov2 UR20, 0010000
			mul UR15 UR20, UR15
			add UR15 UR12, UR12
			mov2 UR20, 0001000
			mul UR16 UR20, UR16
			add UR16 UR12, UR12
			mov UR20, 100
			mul UR17 UR20, UR17
			add UR17 UR12, UR12
			mov UR20, 10
			mul UR18 UR20, UR18
			add UR18 UR12, UR12
			add UR19 UR12, UR12
			
			;;; защита
			
			mov2 UR14, <kernel_start>
			mov2 UR15, <boot_downloadMode_loop>
			if UR12 < UR14, UR15
			
			;;; запись
			
			ild 9999880, UR13
			isv UR13, UR12
			inc UR12
			ild 9999881, UR13
			isv UR13, UR12
			inc UR12
			ild 9999882, UR13
			isv UR13, UR12
			inc UR12
			ild 9999883, UR13
			isv UR13, UR12
			inc UR12
			ild 9999884, UR13
			isv UR13, UR12
			inc UR12
			ild 9999885, UR13
			isv UR13, UR12
			inc UR12
			ild 9999886, UR13
			isv UR13, UR12
			inc UR12
			ild 9999887, UR13
			isv UR13, UR12
			inc UR12
			ild 9999888, UR13
			isv UR13, UR12
			inc UR12
			ild 9999889, UR13
			isv UR13, UR12
			
			;;;;;;;;;;;;;;;;;;;;;;;;;
			
			jmp UR15


