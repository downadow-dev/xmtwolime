; SHA256
__0_h256:
    ;; m
    pop %R_FA_9%, %R_FA_10%, 1
    
    ;; a = h256_res[0]; b = h256_res[1]; c = h256_res[2]; d = h256_res[3];
    ;; e = h256_res[4]; f = h256_res[5]; g = h256_res[6]; h = h256_res[7];
    mov %R_FA_0%, <LIB_h256_res>
    mov %R_FA_1%, <LIB_h256_a>
    ild %R_FA_0%, %R_FA_2%
    isv %R_FA_2%, %R_FA_1%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_0%, %R_FA_2%
    isv %R_FA_2%, %R_FA_1%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_0%, %R_FA_2%
    isv %R_FA_2%, %R_FA_1%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_0%, %R_FA_2%
    isv %R_FA_2%, %R_FA_1%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_0%, %R_FA_2%
    isv %R_FA_2%, %R_FA_1%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_0%, %R_FA_2%
    isv %R_FA_2%, %R_FA_1%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_0%, %R_FA_2%
    isv %R_FA_2%, %R_FA_1%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_0%, %R_FA_2%
    isv %R_FA_2%, %R_FA_1%
    
    mov %R_FA_11%, 0
LIB_h256_rounds:
    mov %R_FA_0%, 15
    mov %R_FA_1%, <LIB_h256_ge16>
    if %R_FA_11% > %R_FA_0%, %R_FA_1%
    
    add %R_FA_10% %R_FA_11%, %R_FA_1%
    ild %R_FA_1%, %R_FA_0%
    mov %R_FA_1%, <LIB_h256_w>
    add %R_FA_1% %R_FA_11%, %R_FA_1%
    isv %R_FA_0%, %R_FA_1%
    
    mov %R_FA_1%, <LIB_h256_ge16_end>
    jmp %R_FA_1%
LIB_h256_ge16:
    ;;; o1_256(w[i-2])
    mov %R_FA_0%, <LIB_h256_w>
    mov %R_FA_1%, 2
    sub %R_FA_11% %R_FA_1%, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_1%
    ild %R_FA_1%, %R_FA_0%
    
    mov %R_FA_1%, 17
    rshift %R_FA_0% %R_FA_1%, %R_FA_1%
    mov %R_FA_2%, 15
    lshift %R_FA_0% %R_FA_2%, %R_FA_2%
    or %R_FA_1% %R_FA_2%, %R_FA_1%
    
    mov %R_FA_2%, 19
    rshift %R_FA_0% %R_FA_2%, %R_FA_2%
    mov %R_FA_3%, 13
    lshift %R_FA_0% %R_FA_3%, %R_FA_3%
    or %R_FA_2% %R_FA_3%, %R_FA_2%
    xor %R_FA_1% %R_FA_2%, %R_FA_1%
    
    mov %R_FA_2%, 10
    rshift %R_FA_0% %R_FA_2%, %R_FA_2%
    xor %R_FA_1% %R_FA_2%, %R_FA_0%
    
    ;;; + o0_256(w[i-15])
    mov %R_FA_1%, <LIB_h256_w>
    mov %R_FA_2%, 15
    sub %R_FA_11% %R_FA_2%, %R_FA_2%
    add %R_FA_1% %R_FA_2%, %R_FA_2%
    ild %R_FA_2%, %R_FA_1%
    
    mov %R_FA_2%, 7
    rshift %R_FA_1% %R_FA_2%, %R_FA_2%
    mov %R_FA_3%, 25
    lshift %R_FA_1% %R_FA_3%, %R_FA_3%
    or %R_FA_2% %R_FA_3%, %R_FA_2%
    
    mov %R_FA_3%, 18
    rshift %R_FA_1% %R_FA_3%, %R_FA_3%
    mov %R_FA_4%, 14
    lshift %R_FA_1% %R_FA_4%, %R_FA_4%
    or %R_FA_3% %R_FA_4%, %R_FA_3%
    xor %R_FA_2% %R_FA_3%, %R_FA_2%
    
    mov %R_FA_3%, 3
    rshift %R_FA_1% %R_FA_3%, %R_FA_1%
    xor %R_FA_1% %R_FA_2%, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_0%
    
    ;;; + w[i-7] + w[i-16]
    mov %R_FA_1%, <LIB_h256_w>
    mov %R_FA_2%, 7
    sub %R_FA_11% %R_FA_2%, %R_FA_2%
    add %R_FA_1% %R_FA_2%, %R_FA_2%
    ild %R_FA_2%, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_0%
    mov %R_FA_1%, <LIB_h256_w>
    mov %R_FA_2%, 16
    sub %R_FA_11% %R_FA_2%, %R_FA_2%
    add %R_FA_1% %R_FA_2%, %R_FA_2%
    ild %R_FA_2%, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_0%
    
    mov %R_FA_1%, <LIB_h256_w>
    add %R_FA_1% %R_FA_11%, %R_FA_1%
    isv %R_FA_0%, %R_FA_1%
LIB_h256_ge16_end:
    ;;; w[i] + h + k_256[i]
    mov %R_FA_1%, <LIB_h256_h>
    ild %R_FA_1%, %R_FA_2%
    add %R_FA_0% %R_FA_2%, %R_FA_0%
    mov %R_FA_1%, <LIB_h256_k>
    add %R_FA_1% %R_FA_11%, %R_FA_1%
    ild %R_FA_1%, %R_FA_2%
    add %R_FA_0% %R_FA_2%, %R_FA_0%
    ;;; + s1_256(e)
    mov %R_FA_2%, <LIB_h256_e>
    ild %R_FA_2%, %R_FA_1%
    
    mov %R_FA_2%, 6
    rshift %R_FA_1% %R_FA_2%, %R_FA_2%
    mov %R_FA_3%, 26
    lshift %R_FA_1% %R_FA_3%, %R_FA_3%
    or %R_FA_2% %R_FA_3%, %R_FA_2%
    
    mov %R_FA_3%, 11
    rshift %R_FA_1% %R_FA_3%, %R_FA_3%
    mov %R_FA_4%, 21
    lshift %R_FA_1% %R_FA_4%, %R_FA_4%
    or %R_FA_3% %R_FA_4%, %R_FA_3%
    xor %R_FA_2% %R_FA_3%, %R_FA_2%
    
    mov %R_FA_3%, 25
    rshift %R_FA_1% %R_FA_3%, %R_FA_3%
    mov %R_FA_4%, 7
    lshift %R_FA_1% %R_FA_4%, %R_FA_4%
    or %R_FA_3% %R_FA_4%, %R_FA_3%
    xor %R_FA_2% %R_FA_3%, %R_FA_2%
    add %R_FA_0% %R_FA_2%, %R_FA_0%
    ;;; + ch(e, f, g)
    mov %R_FA_1%, <LIB_h256_e>
    ild %R_FA_1%, %R_FA_2%
    inc %R_FA_1%
    ild %R_FA_1%, %R_FA_3%
    and %R_FA_2% %R_FA_3%, %R_FA_1%
    tnp %R_FA_2%, %R_FA_2%
    dec %R_FA_2%
    mov %R_FA_4%, <LIB_h256_g>
    ild %R_FA_4%, %R_FA_3%
    and %R_FA_2% %R_FA_3%, %R_FA_2%
    xor %R_FA_1% %R_FA_2%, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_0%
    
    isv %R_FA_0%, <LIB_h256_t1>
    ;;; s0_256(a)
    ild <LIB_h256_a>, %R_FA_1%
    
    mov %R_FA_2%, 2
    rshift %R_FA_1% %R_FA_2%, %R_FA_2%
    mov %R_FA_3%, 30
    lshift %R_FA_1% %R_FA_3%, %R_FA_3%
    or %R_FA_2% %R_FA_3%, %R_FA_2%
    
    mov %R_FA_3%, 13
    rshift %R_FA_1% %R_FA_3%, %R_FA_3%
    mov %R_FA_4%, 19
    lshift %R_FA_1% %R_FA_4%, %R_FA_4%
    or %R_FA_3% %R_FA_4%, %R_FA_3%
    xor %R_FA_2% %R_FA_3%, %R_FA_2%
    
    mov %R_FA_3%, 22
    rshift %R_FA_1% %R_FA_3%, %R_FA_3%
    mov %R_FA_4%, 10
    lshift %R_FA_1% %R_FA_4%, %R_FA_4%
    or %R_FA_3% %R_FA_4%, %R_FA_3%
    xor %R_FA_2% %R_FA_3%, %R_FA_0%
    ;;; + maj(a, b, c)
    mov %R_FA_1%, <LIB_h256_a>
    ild %R_FA_1%, %R_FA_2%
    inc %R_FA_1%
    ild %R_FA_1%, %R_FA_3%
    and %R_FA_2% %R_FA_3%, %R_FA_1%
    mov %R_FA_4%, <LIB_h256_c>
    ild %R_FA_4%, %R_FA_3%
    and %R_FA_2% %R_FA_3%, %R_FA_2%
    xor %R_FA_1% %R_FA_2%, %R_FA_1%
    mov %R_FA_4%, <LIB_h256_b>
    ild %R_FA_4%, %R_FA_2%
    and %R_FA_2% %R_FA_3%, %R_FA_2%
    xor %R_FA_1% %R_FA_2%, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_0%
    isv %R_FA_0%, <LIB_h256_t2>
    
    ild <LIB_h256_g>, %R_FA_0%
    isv %R_FA_0%, <LIB_h256_h>
    ild <LIB_h256_f>, %R_FA_0%
    isv %R_FA_0%, <LIB_h256_g>
    ild <LIB_h256_e>, %R_FA_0%
    isv %R_FA_0%, <LIB_h256_f>
    ild <LIB_h256_d>, %R_FA_0%
    ild <LIB_h256_t1>, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_0%
    isv %R_FA_0%, <LIB_h256_e>
    ild <LIB_h256_c>, %R_FA_0%
    isv %R_FA_0%, <LIB_h256_d>
    ild <LIB_h256_b>, %R_FA_0%
    isv %R_FA_0%, <LIB_h256_c>
    ild <LIB_h256_a>, %R_FA_0%
    isv %R_FA_0%, <LIB_h256_b>
    ild <LIB_h256_t1>, %R_FA_0%
    ild <LIB_h256_t2>, %R_FA_1%
    add %R_FA_0% %R_FA_1%, %R_FA_0%
    isv %R_FA_0%, <LIB_h256_a>
    
    inc %R_FA_11%
    mov %R_FA_0%, 64
    mov %R_FA_1%, <LIB_h256_rounds>
    if %R_FA_11% < %R_FA_0%, %R_FA_1%
    
    ;; h256_res[0] += a; h256_res[1] += b; h256_res[2] += c; h256_res[3] += d;
    ;; h256_res[4] += e; h256_res[5] += f; h256_res[6] += g; h256_res[7] += h;
    mov %R_FA_0%, <LIB_h256_res>
    mov %R_FA_1%, <LIB_h256_a>
    ild %R_FA_1%, %R_FA_2%
    ild %R_FA_0%, %R_FA_3%
    add %R_FA_2% %R_FA_3%, %R_FA_2%
    isv %R_FA_2%, %R_FA_0%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_1%, %R_FA_2%
    ild %R_FA_0%, %R_FA_3%
    add %R_FA_2% %R_FA_3%, %R_FA_2%
    isv %R_FA_2%, %R_FA_0%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_1%, %R_FA_2%
    ild %R_FA_0%, %R_FA_3%
    add %R_FA_2% %R_FA_3%, %R_FA_2%
    isv %R_FA_2%, %R_FA_0%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_1%, %R_FA_2%
    ild %R_FA_0%, %R_FA_3%
    add %R_FA_2% %R_FA_3%, %R_FA_2%
    isv %R_FA_2%, %R_FA_0%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_1%, %R_FA_2%
    ild %R_FA_0%, %R_FA_3%
    add %R_FA_2% %R_FA_3%, %R_FA_2%
    isv %R_FA_2%, %R_FA_0%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_1%, %R_FA_2%
    ild %R_FA_0%, %R_FA_3%
    add %R_FA_2% %R_FA_3%, %R_FA_2%
    isv %R_FA_2%, %R_FA_0%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_1%, %R_FA_2%
    ild %R_FA_0%, %R_FA_3%
    add %R_FA_2% %R_FA_3%, %R_FA_2%
    isv %R_FA_2%, %R_FA_0%
    inc %R_FA_0%
    inc %R_FA_1%
    ild %R_FA_1%, %R_FA_2%
    ild %R_FA_0%, %R_FA_3%
    add %R_FA_2% %R_FA_3%, %R_FA_2%
    isv %R_FA_2%, %R_FA_0%
    
    jmp %R_FA_8%

; initialize hash value
__0_h256_init:
    mov %R_FA_0%, <LIB_h256_res>
    push %R_FA_0%, %R_FA_9%, 1
    
    mov %R_FA_1%, 1779033703
    isv %R_FA_1%, %R_FA_0%
    inc %R_FA_0%
    mov %R_FA_1%, 1150833019
    tnp %R_FA_1%, %R_FA_1%
    isv %R_FA_1%, %R_FA_0%
    inc %R_FA_0%
    mov %R_FA_1%, 1013904242
    isv %R_FA_1%, %R_FA_0%
    inc %R_FA_0%
    mov %R_FA_1%, 1521486534
    tnp %R_FA_1%, %R_FA_1%
    isv %R_FA_1%, %R_FA_0%
    inc %R_FA_0%
    mov %R_FA_1%, 1359893119
    isv %R_FA_1%, %R_FA_0%
    inc %R_FA_0%
    mov %R_FA_1%, 1694144372
    tnp %R_FA_1%, %R_FA_1%
    isv %R_FA_1%, %R_FA_0%
    inc %R_FA_0%
    mov %R_FA_1%, 528734635
    isv %R_FA_1%, %R_FA_0%
    inc %R_FA_0%
    mov %R_FA_1%, 1541459225
    isv %R_FA_1%, %R_FA_0%
    
    jmp %R_FA_8%


LIB_h256_a:
    .byte 0
LIB_h256_b:
    .byte 0
LIB_h256_c:
    .byte 0
LIB_h256_d:
    .byte 0
LIB_h256_e:
    .byte 0
LIB_h256_f:
    .byte 0
LIB_h256_g:
    .byte 0
LIB_h256_h:
    .byte 0
LIB_h256_t1:
    .byte 0
LIB_h256_t2:
    .byte 0
LIB_h256_res:
    .skip 8
LIB_h256_w:
    .skip 64
LIB_h256_k:
    .byte 1116352408
    .byte 1899447441
    .byte -1245643825
    .byte -373957723
    .byte 961987163
    .byte 1508970993
    .byte -1841331548
    .byte -1424204075
    .byte -670586216
    .byte 310598401
    .byte 607225278
    .byte 1426881987
    .byte 1925078388
    .byte -2132889090
    .byte -1680079193
    .byte -1046744716
    .byte -459576895
    .byte -272742522
    .byte 264347078
    .byte 604807628
    .byte 770255983
    .byte 1249150122
    .byte 1555081692
    .byte 1996064986
    .byte -1740746414
    .byte -1473132947
    .byte -1341970488
    .byte -1084653625
    .byte -958395405
    .byte -710438585
    .byte 113926993
    .byte 338241895
    .byte 666307205
    .byte 773529912
    .byte 1294757372
    .byte 1396182291
    .byte 1695183700
    .byte 1986661051
    .byte -2117940946
    .byte -1838011259
    .byte -1564481375
    .byte -1474664885
    .byte -1035236496
    .byte -949202525
    .byte -778901479
    .byte -694614492
    .byte -200395387
    .byte 275423344
    .byte 430227734
    .byte 506948616
    .byte 659060556
    .byte 883997877
    .byte 958139571
    .byte 1322822218
    .byte 1537002063
    .byte 1747873779
    .byte 1955562222
    .byte 2024104815
    .byte -2067236844
    .byte -1933114872
    .byte -1866530822
    .byte -1538233109
    .byte -1090935817
    .byte -965641998

