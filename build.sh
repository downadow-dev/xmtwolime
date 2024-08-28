#!/bin/bash
# автор            downadow (Sviatoslav)

if [[ "$1" == "" || "$1" == "--help" ]]; then
	echo "Использование:  bash build.sh [--help] ПУТЬ_К_MAKEXM2C-TOOLS"
	exit 1
fi

mkdir -p software
cp sys/* software/
cd os-builder
javac downadow/xmtwolime_builder/main/Builder.java
cd ../software
java -cp ../os-builder/ downadow.xmtwolime_builder.main.Builder ../bios.s ../kernel.s $(ls) > ../image
cd ..
java -cp "$1" downadow.makexm2c_tools.main.Assembler image image
rm software/*_sys.s
