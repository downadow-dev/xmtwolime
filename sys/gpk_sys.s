
;; использование:  gpk
; печатает pkey
gpk:
	ild <info_PKEYCHAR0_address>, %R_FA_0%
	vsvan %R_FA_0%, 0126
	ild <info_PKEYCHAR1_address>, %R_FA_0%
	vsvan %R_FA_0%, 0127
	ild <info_PKEYCHAR2_address>, %R_FA_0%
	vsvan %R_FA_0%, 0128
	ild <info_PKEYCHAR3_address>, %R_FA_0%
	vsvan %R_FA_0%, 0129
	ild <info_PKEYCHAR4_address>, %R_FA_0%
	vsvan %R_FA_0%, 0130
	ild <info_PKEYCHAR5_address>, %R_FA_0%
	vsvan %R_FA_0%, 0131
	ild <info_PKEYCHAR6_address>, %R_FA_0%
	vsvan %R_FA_0%, 0132
	ild <info_PKEYCHAR7_address>, %R_FA_0%
	vsvan %R_FA_0%, 0133
	ild <info_PKEYCHAR8_address>, %R_FA_0%
	vsvan %R_FA_0%, 0134
	ild <info_PKEYCHAR9_address>, %R_FA_0%
	vsvan %R_FA_0%, 0135
	ild <info_PKEYCHAR10_address>, %R_FA_0%
	vsvan %R_FA_0%, 0136
	ild <info_PKEYCHAR11_address>, %R_FA_0%
	vsvan %R_FA_0%, 0137
	
	updd
	
	%__END_THE_APP__%

