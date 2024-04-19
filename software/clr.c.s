clr:
mov UR28, 126
vld 0006, UR18
isv UR18, 8699999
ild 8699999, UR18
mov2 UR19, 0000048
sub UR18 UR19, UR18
isv UR18, 8699999
ild 8699999, UR18
mov2 UR19, 0000000
mov2 UR20, <clr_L0>
if UR18 > UR19, UR20
mov2 UR20, <clr_endif>
jmp UR20
clr_L0:
vrst
ild 8699999, UR18
vsv UR18, 1998
updd
mov UR1, 0
clr_L1:
mov UR18, 25
lslp UR18
mov UR19, 0
mov2 UR20, <clr_L1>
if UR1 == UR19, UR20
mov2 %R_RETURN_CODE%, 0000000
%__END_THE_APP__%
clr_endif:
vstr 0126, "black         0"
updd
vstr 0189, "white         1"
updd
vstr 0252, "green         2"
updd
vstr 0315, "blue          3"
updd
vstr 0378, "green2        4"
updd
vstr 0441, "grey          5"
updd
vstr 0504, "red           6"
updd
vstr 0567, "yellow        7"
updd
mov2 %R_RETURN_CODE%, 0000000
%__END_THE_APP__%
