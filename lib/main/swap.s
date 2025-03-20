__0_swap:
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_0%
    dec %R_FA_9%
    ild %R_FA_9%, %R_FA_1%
    
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    isv %R_FA_1%, %R_FA_9%
    inc %R_FA_9%
    
    jmp %R_FA_8%
