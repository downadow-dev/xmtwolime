lst:
mov UR28, 126
vstr 0126, "/home/data                 : 8700000..9999999"
updd
vstr 0252, "/dev/mem0p6                : 6900000..9999999"
updd
vstr 0315, "/dev/vmem                  : 0... (vmem)"
updd
vstr 0378, "/dev/out                   : %OUT_ST%... (vmem)"
updd
vstr 0441, "/dev/in  ->  /dev/out"
updd
vstr 0504, "/dev/err  ->  /dev/out"
updd
isv UR29, 8699999
ild 8699999, UR18
mov2 UR19, 0000000
mov2 UR20, <lst_L0>
if UR18 == UR19, UR20
mov2 UR20, <lst_else>
jmp UR20
lst_L0:
vstr 0567, "/dev/mem0p0                : <xloader_start>..<xloader_end>"
updd
vstr 0630, "/dev/mem0p1                : <fastboot_start>..<fastboot_end>"
updd
vstr 0693, "/dev/mem0p2                : <recovery_start>..<recovery_end>"
updd
vstr 0756, "/dev/mem0p3                : <info_start>..<info_end>"
updd
vstr 0819, "/dev/mem0p4                : <boot_start>..<boot_end>"
updd
vstr 0882, "/dev/mem0p5                : <system_start>..6899999"
updd
vstr 0945, "/dev/mem0                  : 0..9999999"
updd
vstr 1008, "/dev/mem                   : 6900000..8699999"
updd
vstr 1071, "/krnl  ->  /dev/mem0p4"
updd
vstr 1134, "/system/bootanim           : <system_bootanim>..<system_bootanim_end>"
updd
mov2 %R_RETURN_CODE%, 0000000
%__END_THE_APP__%
lst_else:
vstr 0567, "..."
updd
mov2 %R_RETURN_CODE%, 0000001
%__END_THE_APP__%
