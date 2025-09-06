__0_clock:
    time %R_FA_0%
    isv %R_FA_0%, %R_FA_9%
    inc %R_FA_9%
    jmp %R_FA_8%

__0_clock_reset:
    trst
    jmp %R_FA_8%

