
__1_memcpy:
    ; размер
    dec %R_FA_19%
    ild %R_FA_19%, %R_FA_12%
    ; адрес источника
    dec %R_FA_19%
    ild %R_FA_19%, %R_FA_11%
    ; адрес назначения
    dec %R_FA_19%
    ild %R_FA_19%, %R_FA_10%
    
    inc %R_FA_19%
    
    mov2 %R_FA_14%, <LIB_1_memcpy>
    LIB_1_memcpy:
        ild %R_FA_11%, %R_FA_13%
        isv %R_FA_13%, %R_FA_10%
        
        inc %R_FA_10%
        inc %R_FA_11%
        
        dec %R_FA_12%
        
        if %R_FA_12% > %R_ZERO%, %R_FA_14%
    
    jmp %R_FA_18%

