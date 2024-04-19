txt:
mov UR28, 126
mov UR22, 48
vld 0007, UR28
sub UR28 UR22, UR28
vld 0008, UR27
sub UR27 UR22, UR27
vld 0009, UR26
sub UR26 UR22, UR26
vld 0010, UR25
sub UR25 UR22, UR25
vld 0011, UR24
sub UR24 UR22, UR24
vld 0012, UR23
sub UR23 UR22, UR23
mov3 UR23, UR28 UR27 UR26 UR25 UR24 UR23
vld 0006, UR22
mov UR21, 48
sub UR22 UR21, UR22
mov2 UR21, 1000000
mul UR21 UR22, UR22
add UR23 UR22, UR23
vld 0005, UR22
mov UR21, '-'
mov2 UR20, <txt_L0>
if UR22 != UR21, UR20
tnp UR23
txt_L0:
isv UR23, 8699999
mov2 UR28, 0000126
isv UR29, 8699998
ild 8699998, UR18
mov2 UR19, 0000000
mov2 UR20, <txt_L1>
if UR18 != UR19, UR20
mov2 UR20, <txt_endif0>
jmp UR20
txt_L1:
ild 8699999, UR18
mov2 UR19, 8700000
mov2 UR20, <txt_L2>
if UR18 < UR19, UR20
mov2 UR20, <txt_endif1>
jmp UR20
txt_L2:
vstr 0126, "root required"
updd
mov2 %R_RETURN_CODE%, 0000001
%__END_THE_APP__%
txt_endif1:
txt_endif0:
txt_loop:
mov UR1, 0
txt_L3:
mov UR18, 25
lslp UR18
mov UR19, 0
mov2 UR20, <txt_L3>
if UR1 == UR19, UR20
isv UR1, 8699997
ild 8699998, UR18
mov2 UR19, 0000000
mov2 UR20, <txt_L4>
if UR18 != UR19, UR20
mov2 UR20, <txt_loop_endif2>
jmp UR20
txt_L4:
ild 8699999, UR18
mov2 UR19, 8700000
mov2 UR20, <txt_L5>
if UR18 < UR19, UR20
mov2 UR20, <txt_loop_endif3>
jmp UR20
txt_L5:
mov2 %R_RETURN_CODE%, 0000002
%__END_THE_APP__%
txt_loop_endif3:
txt_loop_endif2:
ild 8699997, UR18
mov2 UR19, 0065535
mov2 UR20, <txt_L6>
if UR18 == UR19, UR20
mov2 UR20, <txt_loop_endif-1>
jmp UR20
txt_L6:
mov2 UR18, <txt_loop>
jmp UR18
txt_loop_endif-1:
ild 8699997, UR18
mov2 UR19, 0000008
mov2 UR20, <txt_L7>
if UR18 == UR19, UR20
mov2 UR20, <txt_loop_endif0>
jmp UR20
txt_L7:
dec UR28
mov UR18, 95
vsv UR18, UR28
inc UR28
mov UR18, 32
vsv UR18, UR28
inc UR28
updd
dec UR28
dec UR28
ild 8699999, UR18
dec UR18
isv UR18, 8699999
mov2 UR18, <txt_loop>
jmp UR18
txt_loop_endif0:
ild 8699997, UR18
mov2 UR19, 0000010
mov2 UR20, <txt_L8>
if UR18 == UR19, UR20
mov2 UR20, <txt_loop_endif1>
jmp UR20
txt_L8:
mov UR18, 32
vsv UR18, UR28
inc UR28
updd
mov2 %R_RETURN_CODE%, 0000000
%__END_THE_APP__%
txt_loop_endif1:
ild 8699997, UR18
ild 8699999, UR19
isv UR18, UR19
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699997, UR18
vsv UR18, UR28
inc UR28
updd
mov UR18, 95
vsv UR18, UR28
inc UR28
updd
dec UR28
mov2 UR18, <txt_loop>
jmp UR18
