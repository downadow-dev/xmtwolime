.orig 0

vrst
updd

mov UR0, 1000
mov UR8, <boot_sleep0>
trst
boot_sleep0:
    nop
    time UR6
    if UR6 < UR0, UR8

; проверка на ESC
mov UR0, 27
mov UR6, <kernel_start>
if UR1 != UR0, UR6

boot_downloadMode:
	mov UR0, 'D'
	isv UR0, 9999000
	mov UR0, 1
	isv UR0, 9999001
	
	vrst
	mov UR0, 3
	; сделать фон синим
	vsv UR0, 1998
	
	updd
	
	boot_downloadMode_loop:
		nop
		
		;;; интерпретация команд
		
		ild 9999872, UR17
		
		mov UR13, 'f'
		
		mov UR15, <boot_downloadMode_loop_flash>
		if UR17 == UR13, UR15
		
		mov UR13, 'r'
		mov UR15, 0
		if UR17 == UR13, UR15
		
		mov UR13, 'g'
		mov UR15, <boot_downloadMode_loop_get>
		if UR17 == UR13, UR15
		
		;;;;;;;;;;;;;;;;;;;;;;;;
		
		mov UR28, <boot_downloadMode_loop>
		jmp UR28
		
		boot_downloadMode_loop_get:
			ild 9999873, UR12
			
			mov UR19, 9999005
			
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
			
			mov UR20, <boot_downloadMode_loop>
			jmp UR20
		
		boot_downloadMode_loop_flash:
			mov UR1, 0

			ild 9999873, UR12
			
			;;; защита
			
			mov UR14, <kernel_start>
			mov UR15, <boot_downloadMode_loop>
			if UR12 < UR14, UR15
			
			;;; запись
			
			ild 9999874, UR13
			isv UR13, UR12
			inc UR12
			ild 9999875, UR13
			isv UR13, UR12
			inc UR12
			ild 9999876, UR13
			isv UR13, UR12
			inc UR12
			ild 9999877, UR13
			isv UR13, UR12
			inc UR12
			ild 9999878, UR13
			isv UR13, UR12
			inc UR12
			ild 9999879, UR13
			isv UR13, UR12
			inc UR12
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
			
			;;;;;;;;;;;;;;;;;;;;;;;;;
			
			jmp UR15


