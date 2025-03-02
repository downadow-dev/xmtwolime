.orig 0

;; пользовательский регистр 29 хранит ID пользователя
;    0 — root (суперпользователь)
;    иное — обычный пользователь
.def %R_USER% "UR29"

;; п. регистры, которые предназначены для приложений;
;; но это не запрещает использование их ядром
.def %R_FA_0% "UR28"
.def %R_FA_1% "UR27"
.def %R_FA_2% "UR26"
.def %R_FA_3% "UR25"
.def %R_FA_4% "UR24"
.def %R_FA_5% "UR23"
.def %R_FA_6% "UR22"
.def %R_FA_7% "UR21"
.def %R_FA_8% "UR20"
.def %R_FA_9% "UR19"
.def %R_FA_10% "UR18"
.def %R_FA_11% "UR30"
.def %R_FA_12% "UR31"
.def %R_FA_13% "UR32"
.def %R_FA_14% "UR33"
.def %R_FA_15% "UR34"
.def %R_FA_16% "UR35"
.def %R_FA_17% "UR36"
.def %R_FA_18% "UR37"
.def %R_FA_19% "UR38"
.def %R_FA_20% "UR39"
.def %R_FA_21% "UR40"
.def %R_FA_22% "UR41"
.def %R_FA_23% "UR42"
.def %R_FA_24% "UR43"

;; используйте п. регистр 6 как содержащий код возврата
;; ваших программ
.def %R_RETURN_CODE% "UR6"

.def %__END_THE_APP__% "jmp UR17"

;; адрес начала аргументов приложения в видеопамяти
.def %ARGS_ST% "0006"

.def %R_ZERO% "UR0"

;; начало и конец пространства данных обычного пользователя
.def %ORDINARY_USER_SPACE_ST% "8700000"
.def %ORDINARY_USER_SPACE_ND% "9999999"

;; адрес начала раздела вывода
.def %OUT_ST% "0126"

.def %R_KEY% "UR1"

; вы можете изменить это
_is_setuid_allowed:
    .byte 0

mov UR0, 0
mov UR1, 0
mov UR5, 0
mov UR6, 0
mov UR7, 0
mov UR8, 0
mov UR9, 0
mov UR10, 0
mov UR11, 0
mov UR12, 0
mov UR13, 0
mov UR14, 0
mov UR15, 0
mov UR16, 0
mov UR17, 0
mov UR18, 0
mov UR19, 0
mov UR20, 0
mov UR21, 0
mov UR22, 0
mov UR23, 0
mov UR24, 0
mov UR25, 0
mov UR26, 0
mov UR27, 0
mov UR28, 0
mov %R_USER%, 1
mov UR30, 0
mov UR31, 0
mov UR32, 0
mov UR33, 0
mov UR34, 0
mov UR35, 0
mov UR36, 0
mov UR37, 0
mov UR38, 0
mov UR39, 0
mov UR40, 0
mov UR41, 0
mov UR42, 0
mov UR43, 0

;;; терминал
_main:
    mov %R_KEY%, 0
    mov %R_RETURN_CODE%, 0
    
    _main_otherColor:
    mov UR16, 1
    vsv UR16, 1999
    
    _main_bgColor:
    mov UR16, 0
    vsv UR16, 1998
    
    vrst
    
    _term:
        ;;;  если пользователь является обычным, то '$ ';  ;;;
        ;;;  иначе '# '                                    ;;;
        
        mov2 UR17, <_no_ordinary>
        if %R_USER% == %R_ZERO%, UR17
        vstr 0000, "$ "
        mov2 UR17, <_ordinary>
        jmp UR17
        _no_ordinary:
            vstr 0000, "# "
        _ordinary:
            nop
        
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
        ;; установка указателя
        mov UR15, 2
        
        _term_input:
            ;; для lslp
            mov UR16, 30
            ;; ждать 30 миллисекунд
            lslp UR16
            
            updd
            
            mov2 UR17, <_term_input>
            ;; если клавиша не была нажата, то перейти к `_term_input'
            if %R_KEY% == %R_ZERO%, UR17
            
            vstr %OUT_ST%, "                 "
            updd
            
            mov2 UR16, 0065535
            if %R_KEY% == UR16, UR17
            
            mov UR16, 10
            mov2 UR17, <_term_input_ENTER>
            ;; если истинно, то ввод отправлен
            if %R_KEY% == UR16, UR17
            
            mov UR16, 8
            mov2 UR17, <_term_input_BACKSPACE>
            if %R_KEY% == UR16, UR17
            
            ;;; предотвращение попытки выйти за OUT_ST
            mov2 UR17, <_term_input>
            mov UR16, %OUT_ST%
            if UR15 == UR16, UR17
            
            ;; сохранить клавишу
            vsv %R_KEY%, UR15
            ;; увеличить указатель
            inc UR15
            ;; сброс нажатой клавиши
            mov %R_KEY%, 0
            
            mov2 UR16, 0009608
            ;; сохранение '█' в конце строки
            vsv UR16, UR15
            ;; для lslp
            mov UR16, 30
            
            ;; пользовательский регистр 0 должен содержать только ноль
            mov %R_ZERO%, 0
            
            mov2 UR17, <_term_input>
            jmp UR17
        
            _term_input_BACKSPACE:
                mov %R_KEY%, 0
                
                mov2 UR17, <_term_input>
                mov UR10, 3
                ;; предотвращение попытки стереть приглашение командной строки
                if UR15 < UR10, UR17
                
                vsv %R_ZERO%, UR15
                dec UR15
                mov2 UR10, 0009608
                vsv UR10, UR15
                updd
                mov %R_KEY%, 0
                jmp UR17
            
        ;;; выводит код возврата приложения и ждёт клавишу
        .orig 32768
        _term_applicationCompleted:
            mov %R_ZERO%, 0
            
            mov UR16, 1
            ;; смена цвета ячеек видеопамяти на белый
            vsv UR16, 1999
            
            mov UR16, 0
            ;; смена цвета фона на чёрный
            vsv %R_ZERO%, 1998
            
            mov %R_KEY%, 0
            vsvan %R_RETURN_CODE%, 1822
            updd
            
            mov2 UR17, <_term_applicationCompleted_keyWait>
            mov UR16, 50
            
            _term_applicationCompleted_keyWait:
                lslp UR16
                if %R_KEY% == %R_ZERO%, UR17
            
            mov %R_KEY%, 0
            mov2 UR17, <_main>
            jmp UR17
        
        
            _term_input_ENTER:
                mov %R_KEY%, 0
                mov %R_ZERO%, 0
                ;; убрать спецсимвол
                vsv %R_ZERO%, UR15
                
                mov UR16, 2
                mov2 UR17, <_term_input_ENTER_continue>
                ild <_is_setuid_allowed>, UR10
                if UR10 == %R_ZERO%, UR17
                if UR15 != UR16, UR17
                
                mov UR16, 1
                xor %R_USER% UR16, %R_USER%
                mov2 UR17, <_term>
                jmp UR17
                
                _term_input_ENTER_continue:
                
                updd
                trst
                
                ; ...

