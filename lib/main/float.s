__0_funzip:
    ; lw ptr
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    ; n ptr
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    ; x
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_10%
    
    ld %R_FA_10%, %R_FA_11%
    
    mov %R_FA_2%, <LIB_funzip_negativeEnd>
    if %R_FA_11% > %R_ZERO%, %R_FA_2%
    if %R_FA_11% == %R_ZERO%, %R_FA_2%
    
    tnp %R_FA_10%, %R_FA_10%
    mov %R_FA_2%, 1
    mov %R_FA_4%, 27
    lshift %R_FA_2% %R_FA_4%, %R_FA_2%
    dec %R_FA_2%
    and %R_FA_10% %R_FA_2%, %R_FA_2%
    tnp %R_FA_2%, %R_FA_2%
    isv %R_FA_2%, %R_FA_0%
    mov %R_FA_2%, <LIB_funzip_final>
    jmp %R_FA_2%
    
    LIB_funzip_negativeEnd:
    
    mov %R_FA_2%, 1
    mov %R_FA_4%, 27
    lshift %R_FA_2% %R_FA_4%, %R_FA_2%
    dec %R_FA_2%
    and %R_FA_10% %R_FA_2%, %R_FA_2%
    isv %R_FA_2%, %R_FA_0%
    
    LIB_funzip_final:
    
    mov %R_FA_2%, 27
    rshift %R_FA_10% %R_FA_2%, %R_FA_2%
    isv %R_FA_2%, %R_FA_1%
    
    jmp %R_FA_8%

__0_fzip:
    ; lw
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    ; n
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov %R_FA_2%, <LIB_fzip_positive>
    if %R_FA_0% > %R_ZERO%, %R_FA_2%
    if %R_FA_0% == %R_ZERO%, %R_FA_2%
    
    tnp %R_FA_0%, %R_FA_0%
    mov %R_FA_2%, 27
    lshift %R_FA_1% %R_FA_2%, %R_FA_2%
    or %R_FA_0% %R_FA_2%, %R_FA_0%
    tnp %R_FA_0%, %R_FA_0%
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%
    
    LIB_fzip_positive:
    
    mov %R_FA_2%, 27
    lshift %R_FA_1% %R_FA_2%, %R_FA_2%
    or %R_FA_0% %R_FA_2%, %R_FA_0%
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%

