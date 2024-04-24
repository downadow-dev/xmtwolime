      ;;;;;;;                                                      ;;;;;;;
      ;;;;;       Автор:                  Downadow (Sviatoslav).     ;;;;;
      ;;;;;       Год создания:           2024.                      ;;;;;
      ;;;;;                                                          ;;;;;
      ;;;;;  Этот файл доступен Вам по лицензии Downadow License 7   ;;;;;
      ;;;;;  как "Програмное обеспечение".                           ;;;;;
      ;;;;;;;                                                      ;;;;;;;


;; выводит адреса разделов, кроме bootrom; требует root
prt:
	mov2 %R_FA_0%, <prt_main>
	if %R_USER% == %R_ZERO%, %R_FA_0%
	
	vstr %OUT_ST%, "root required"
	mov %R_RETURN_CODE%, 1
	%__END_THE_APP__%
	
	prt_main:
		vstr 0126, "xloader            <xloader_start>-<xloader_end>"
		vstr 0189, "fastboot           <fastboot_start>-<fastboot_end>"
		vstr 0252, "recovery           <recovery_start>-<recovery_end>"
		vstr 0315, "info               <info_start>-<info_end>"
		vstr 0378, "boot               <boot_start>-<boot_end>"
		vstr 0441, "system             <system_start>-6899999"
		vstr 0504, "userdata           6900000-9999999"
		
		updd
		%__END_THE_APP__%


