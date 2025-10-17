.orig 0
; начало непривилегированной области памяти
.byte 40000
; адрес прерывания
.byte 512
; адрес системного вызова
.byte 1024

.byte 0
.byte 10000000
.byte 0
.orig 27

open 0
mov UR1, 1
vsv UR1, 1902
mov UR1, 1
vsv UR1, 1901

mov UR0, 100
mov UR8, <boot_sleep0>
time UR6
add UR6 UR0, UR0
boot_sleep0:
    nop
    time UR6
    if UR6 < UR0, UR8

; проверка на ESC
mov UR0, 27
mov UR6, <kernel_start>
vld 1900, UR1
if UR1 < UR0, UR6
if UR1 > UR0, UR6

boot_downloadMode:
    mov UR1, 1
    vsv UR1, 1902
    mov UR0, 3
    ; сделать фон синим
    vsv UR0, 1998
    
    mov UR1, 1
    vsv UR1, 1901
    
    nop
    open 1
    
    boot_downloadMode_loop:
        nop
        
        ;;; интерпретация команд
        
        vld 0000, UR17
        
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
        
        mov UR23, <boot_downloadMode_loop>
        jmp UR23
        
        boot_downloadMode_loop_get:
            vld 0001, UR12
            
            mov UR19, 1000
            
            ild UR12, UR20
            vsv UR20, UR19
            inc UR12
            inc UR19
            
            ild UR12, UR20
            vsv UR20, UR19
            inc UR12
            inc UR19
            
            ild UR12, UR20
            vsv UR20, UR19
            inc UR12
            inc UR19
            
            ild UR12, UR20
            vsv UR20, UR19
            inc UR12
            inc UR19
            
            ild UR12, UR20
            vsv UR20, UR19
            inc UR12
            inc UR19
            
            ild UR12, UR20
            vsv UR20, UR19
            inc UR12
            inc UR19
            
            ild UR12, UR20
            vsv UR20, UR19
            inc UR12
            inc UR19
            
            ild UR12, UR20
            vsv UR20, UR19
            inc UR12
            inc UR19
            
            mov UR20, <boot_downloadMode_loop>
            jmp UR20
        
        boot_downloadMode_loop_flash:
            vld 0001, UR12
            
            ;;; защита
            
            mov UR14, <kernel_start>
            mov UR15, <boot_downloadMode_loop>
            if UR12 < UR14, UR15
            
            ;;; запись
            
            vld 0002, UR13
            isv UR13, UR12
            inc UR12
            vld 0003, UR13
            isv UR13, UR12
            inc UR12
            vld 0004, UR13
            isv UR13, UR12
            inc UR12
            vld 0005, UR13
            isv UR13, UR12
            inc UR12
            vld 0006, UR13
            isv UR13, UR12
            inc UR12
            vld 0007, UR13
            isv UR13, UR12
            inc UR12
            vld 0008, UR13
            isv UR13, UR12
            inc UR12
            vld 0009, UR13
            isv UR13, UR12
            inc UR12
            vld 0010, UR13
            isv UR13, UR12
            inc UR12
            vld 0011, UR13
            isv UR13, UR12
            
            ;;;;;;;;;;;;;;;;;;;;;;;;;
            
            jmp UR15


