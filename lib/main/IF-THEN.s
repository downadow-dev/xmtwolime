
__0_!:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    
    mov %R_FA_2%, <LIB_!_continue>
    mov %R_FA_3%, 0
    if %R_FA_1% < %R_FA_3%, %R_FA_2%
    if %R_FA_1% > %R_FA_3%, %R_FA_2%
    
    mov %R_FA_3%, 1
    isv %R_FA_3%, %R_FA_9%
    
    inc %R_FA_9%
    
    jmp %R_FA_8%
    
    LIB_!_continue:
    
    mov %R_FA_3%, 0
    isv %R_FA_3%, %R_FA_9%
    
    inc %R_FA_9%
    
    jmp %R_FA_8%

__0_|?:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov %R_FA_2%, <LIB_|?_continue>
    mov %R_FA_3%, 0
    if %R_FA_0% > %R_FA_3%, %R_FA_2%
    if %R_FA_0% < %R_FA_3%, %R_FA_2%
    if %R_FA_1% > %R_FA_3%, %R_FA_2%
    if %R_FA_1% < %R_FA_3%, %R_FA_2%
    
    mov %R_FA_0%, 0
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%
    
    LIB_|?_continue:
    
    mov %R_FA_0%, 1
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%

__0_=?:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov %R_FA_2%, <LIB_=?_continue>
    if %R_FA_0% == %R_FA_1%, %R_FA_2%
    
    mov %R_FA_0%, 0
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%
    
    LIB_=?_continue:
    
    mov %R_FA_0%, 1
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%

__0_!?:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov %R_FA_2%, <LIB_!?_continue>
    if %R_FA_0% > %R_FA_1%, %R_FA_2%
    if %R_FA_0% < %R_FA_1%, %R_FA_2%
    
    mov %R_FA_0%, 0
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%
    
    LIB_!?_continue:
    
    mov %R_FA_0%, 1
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%

__0_lt?:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov %R_FA_2%, <LIB_lt?_continue>
    if %R_FA_0% < %R_FA_1%, %R_FA_2%
    
    mov %R_FA_0%, 0
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%
    
    LIB_lt?_continue:
    
    mov %R_FA_0%, 1
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%
__0_ult?:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov %R_FA_2%, <LIB_ult?_continue>
    unsif %R_FA_0% < %R_FA_1%, %R_FA_2%
    
    mov %R_FA_0%, 0
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%
    
    LIB_ult?_continue:
    
    mov %R_FA_0%, 1
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%

__0_gt?:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov %R_FA_2%, <LIB_gt?_continue>
    if %R_FA_0% > %R_FA_1%, %R_FA_2%
    
    mov %R_FA_0%, 0
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%
    
    LIB_gt?_continue:
    
    mov %R_FA_0%, 1
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%
__0_ugt?:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov %R_FA_2%, <LIB_ugt?_continue>
    unsif %R_FA_0% > %R_FA_1%, %R_FA_2%
    
    mov %R_FA_0%, 0
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%
    
    LIB_ugt?_continue:
    
    mov %R_FA_0%, 1
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%


__0_then:
    ; Ctrl+C check
    mov %R_RETURN_CODE%, 0
    mov %R_FA_1%, 3
    mov %R_FA_0%, <LIB_exit>
    vld 1900, %R_KEY%
    if %R_KEY% == %R_FA_1%, %R_FA_0%
    
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov %R_FA_2%, 0
    if %R_FA_0% > %R_FA_2%, %R_FA_1%
    if %R_FA_0% < %R_FA_2%, %R_FA_1%
    
    jmp %R_FA_8%

__0_else:
    ; Ctrl+C check
    mov %R_RETURN_CODE%, 0
    mov %R_FA_1%, 3
    mov %R_FA_0%, <LIB_exit>
    vld 1900, %R_KEY%
    if %R_KEY% == %R_FA_1%, %R_FA_0%
    
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov %R_FA_2%, 0
    if %R_FA_0% == %R_FA_2%, %R_FA_1%
    
    jmp %R_FA_8%

