num:
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
mov2 UR20, <num_L0>
if UR22 != UR21, UR20
tnp UR23
num_L0:
isv UR23, 8699999
isv UR29, 8699998
ild 8699998, UR18
mov2 UR19, 0000000
mov2 UR20, <num_L1>
if UR18 != UR19, UR20
mov2 UR20, <num_endif0>
jmp UR20
num_L1:
ild 8699999, UR18
mov2 UR19, 8700000
mov2 UR20, <num_L2>
if UR18 < UR19, UR20
mov2 UR20, <num_endif1>
jmp UR20
num_L2:
vstr 0126, "root required"
updd
mov2 %R_RETURN_CODE%, 0000001
%__END_THE_APP__%
num_endif1:
num_endif0:
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0126
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0189
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0252
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0315
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0378
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0441
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0504
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0567
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0630
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0693
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0756
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0819
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0882
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 0945
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1008
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1071
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1134
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1197
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1260
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1323
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1386
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1449
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1512
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1575
ild 8699999, UR18
inc UR18
isv UR18, 8699999
ild 8699999, UR18
ild UR18, UR18
isv UR18, 8699997
ild 8699997, UR18
vsvan UR18, 1638
ild 8699999, UR18
inc UR18
isv UR18, 8699999
mov2 %R_RETURN_CODE%, 0000000
%__END_THE_APP__%
