
__1_memset:
    ; размер
    dec %R_FA_19%
    ild %R_FA_19%, %R_FA_12%
    ; символ
    dec %R_FA_19%
    ild %R_FA_19%, %R_FA_11%
    ; начальный адрес
    dec %R_FA_19%
    ild %R_FA_19%, %R_FA_10%
    
    inc %R_FA_19%
    
    mov2 %R_FA_13%, <LIB_1_memset>
    LIB_1_memset:
        isv %R_FA_11%, %R_FA_10%
        inc %R_FA_10%
        dec %R_FA_12%
        
        if %R_FA_12% > %R_ZERO%, %R_FA_13%
    
    jmp %R_FA_18%

