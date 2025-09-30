;; сложение
__0_+:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    add %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;; вычитание
__0_-:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    sub %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;; умножение
__0_*:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    mul %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;; деление
__0_/:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    div %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%
__0_u/:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    unsdiv %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;; получение остатка
__0_rem:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    rem %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%
__0_urem:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    unsrem %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;; И
__0_and:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    and %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;; ИЛИ
__0_|:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    or %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;; Исключающее ИЛИ
__0_^:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    xor %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;; левый сдвиг
__0_lsh:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    lshift %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;; и правый
__0_rsh:
    pop %R_FA_9%, %R_FA_0%, 1
    pop %R_FA_9%, %R_FA_1%, 1
    
    rshift %R_FA_1% %R_FA_0%, %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; декремент
__0_--:
    pop %R_FA_9%, %R_FA_0%, 1
    
    dec %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

;; инкремент
__0_++:
    pop %R_FA_9%, %R_FA_0%, 1
    
    inc %R_FA_0%
    
    push %R_FA_0%, %R_FA_9%, 1
    
    jmp %R_FA_8%

