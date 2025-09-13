;; очистить вывод и сбросить указатель вывода
__0_clear_output:
    mov %R_KEY%, 1
    vsv %R_KEY%, 1902
	mov %R_FA_7%, 0
    mov %R_KEY%, 1
    vsv %R_KEY%, 1901
	jmp %R_FA_8%

