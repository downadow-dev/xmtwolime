#!/bin/bash
# автор            downadow (Sviatoslav)

if [[ "$2" == "" || "$1" == "--help" ]] then
	echo "Использование:  bash build.sh [--help] ПУТЬ_К_MAKEXM2C-TOOLS ТИП"
	echo
	echo "ТИП может быть одним из следующих:"
	ls etc
	exit
fi

cd utils-2
./build.sh ../software
cd ../os-builder
javac --release 8 downadow/xmtwolime_builder/main/Builder.java
cd ../software
java -cp ../os-builder/ downadow.xmtwolime_builder.main.Builder -p ../etc/$2/ ../kernel.S $(ls) > ../image
cd ..
java -cp "$1" downadow.makexm2c_tools.main.Assembler image image
