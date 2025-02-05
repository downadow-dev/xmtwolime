
__0___next_thread:
    mov2 %R_FA_0%, 6900000
    mov %R_FA_1%, 2
    mul %R_FA_7% %R_FA_1%, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_0%
    
    isv %R_FA_8%, %R_FA_0%
    inc %R_FA_0%
    isv %R_FA_9%, %R_FA_0%
    
    inc %R_FA_7%
    mov2 %R_FA_0%, 6900000
    mov %R_FA_1%, 2
    mul %R_FA_7% %R_FA_1%, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_0%
    ild %R_FA_0%, %R_FA_1%
    inc %R_FA_0%
    ild %R_FA_0%, %R_FA_2%
    
    mov %R_FA_0%, 1
    neg %R_FA_0%
    mov2 %R_FA_3%, <LIB___next_thread_0>
    if %R_FA_1% != %R_FA_0%, %R_FA_3%
    
    mov %R_FA_7%, 0
    mov2 %R_FA_0%, 6900000
    ild %R_FA_0%, %R_FA_8%
    inc %R_FA_0%
    ild %R_FA_0%, %R_FA_9%
    jmp %R_FA_8%
    
    LIB___next_thread_0:
        ld %R_FA_1%, %R_FA_8%
        ld %R_FA_2%, %R_FA_9%
        jmp %R_FA_8%

__0_this_thread:
    isv %R_FA_7%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%

__0_set_thread:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov2 %R_FA_3%, 6900000
    mov %R_FA_4%, 2
    mul %R_FA_0% %R_FA_4%, %R_FA_4%
    add %R_FA_4% %R_FA_3%, %R_FA_3%
    
    isv %R_FA_1%, %R_FA_3%
    inc %R_FA_3%
    
    mov2 %R_FA_4%, 6900100
    mov2 %R_FA_5%, 0001000
    mul %R_FA_0% %R_FA_5%, %R_FA_5%
    add %R_FA_5% %R_FA_4%, %R_FA_4%
    
    isv %R_FA_4%, %R_FA_3%
    
    jmp %R_FA_8%

__0_destroy_thread:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    
    mov2 %R_FA_3%, 6900000
    mov %R_FA_4%, 2
    mul %R_FA_0% %R_FA_4%, %R_FA_4%
    add %R_FA_4% %R_FA_3%, %R_FA_3%
    
    mov %R_FA_0%, 1
    neg %R_FA_0%
    isv %R_FA_0%, %R_FA_3%
    
    mov %R_FA_7%, 0
    
    jmp %R_FA_8%

