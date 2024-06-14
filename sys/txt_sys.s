
;; эта программа копирует пользовательский ввод в память
txt:
    ;;; получение адреса ячейки памяти
    
    mov %R_FA_8%, 48
    
    vld 0006, %R_FA_1%
    sub %R_FA_1% %R_FA_8%, %R_FA_1%
    
    vld 0007, %R_FA_2%
    sub %R_FA_2% %R_FA_8%, %R_FA_2%
    
    vld 0008, %R_FA_3%
    sub %R_FA_3% %R_FA_8%, %R_FA_3%
    
    vld 0009, %R_FA_4%
    sub %R_FA_4% %R_FA_8%, %R_FA_4%
    
    vld 0010, %R_FA_5%
    sub %R_FA_5% %R_FA_8%, %R_FA_5%
    
    vld 0011, %R_FA_6%
    sub %R_FA_6% %R_FA_8%, %R_FA_6%
    
    vld 0012, %R_FA_7%
    sub %R_FA_7% %R_FA_8%, %R_FA_7%
    
    mov3 %R_FA_0%, %R_FA_2% %R_FA_3% %R_FA_4% %R_FA_5% %R_FA_6% %R_FA_7%
    mov2 %R_FA_2%, 1000000
    mul %R_FA_2% %R_FA_1%, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_0%
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    mov2 %R_FA_1%, <txt_root?>
    mov2 %R_FA_2%, %ORDINARY_USER_SPACE_ST%
    if %R_FA_0% < %R_FA_2%, %R_FA_1%
    
    txt_write:
        mov %R_FA_1%, %OUT_ST%
        
        txt_loop:
            mov %R_FA_2%, 30
            lslp %R_FA_2%
            mov %R_FA_2%, %OUT_ST%
            mov2 %R_FA_3%, <txt_exit2>
            if %R_FA_1% < %R_FA_2%, %R_FA_3%
            mov2 %R_FA_2%, 0001800
            if %R_FA_1% > %R_FA_2%, %R_FA_3%
            mov2 %R_FA_2%, <txt_loop>
            if %R_KEY% == %R_ZERO%, %R_FA_2%
            mov %R_FA_3%, 8
            mov2 %R_FA_2%, <txt_loop_BACKSPACE>
            if %R_KEY% == %R_FA_3%, %R_FA_2%
            mov2 %R_FA_3%, 0065535
            mov2 %R_FA_2%, <txt_loop>
            if %R_KEY% == %R_FA_3%, %R_FA_2%
            mov %R_FA_3%, 10
            mov2 %R_FA_2%, <txt_loop_ENTER>
            if %R_KEY% == %R_FA_3%, %R_FA_2%
            
            vsv %R_KEY%, %R_FA_1%
            isv %R_KEY%, %R_FA_0%
            inc %R_FA_0%
            inc %R_FA_1%
            
            mov2 %R_FA_2%, 0009608
            vsv %R_FA_2%, %R_FA_1%
            
            updd
            
            mov %R_KEY%, 0
            
            mov2 %R_FA_2%, <txt_loop>
            jmp %R_FA_2%
            
            txt_loop_BACKSPACE:
                mov2 %R_FA_2%, <txt_loop_BACKSPACE_continue>
                if %R_USER% == %R_ZERO%, %R_FA_2%
                
                mov2 %R_FA_2%, %ORDINARY_USER_SPACE_ST%
                inc %R_FA_2%
                mov2 %R_FA_3%, <txt_exit2>
                if %R_FA_0% < %R_FA_2%, %R_FA_3%
                
                txt_loop_BACKSPACE_continue:
                
                vsv %R_ZERO%, %R_FA_1%
                dec %R_FA_0%
                dec %R_FA_1%
                mov2 %R_FA_2%, 0009608
                vsv %R_FA_2%, %R_FA_1%
                mov %R_KEY%, 0
                updd
                mov2 %R_FA_2%, <txt_loop>
                jmp %R_FA_2%
            
            txt_loop_ENTER:
                vsv %R_ZERO%, %R_FA_1%
                %__END_THE_APP__%
            
        
    
    txt_root?:
        mov2 %R_FA_1%, <txt_write>
        if %R_USER% == %R_ZERO%, %R_FA_1%
        ;; иначе
        vstr %OUT_ST% "root required"
        mov %R_RETURN_CODE%, 1
        updd
        
        %__END_THE_APP__%
    
    txt_exit2:
        mov %R_RETURN_CODE%, 2
        %__END_THE_APP__%

