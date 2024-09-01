#!/bin/bash
# автор            downadow (Sviatoslav)

# ИЗМЕНИТЕ ЭТО
ctoxmconc_path="../c-to-xmconc"
xmconcc_path="../xmconcc"
makexm2ctools_path='../makexm2c-tools'
##############

#####################################################

mkdir -p software

echo > sys/main.c
for prog in `ls sys/???.c`; do
    echo '#define main '`basename $prog .c` >> sys/main.c
    echo '#include "'`basename $prog`'"' >> sys/main.c
    echo '#undef main' >> sys/main.c
done

echo 'int main(int argc, char *argv[]) {' >> sys/main.c
echo '    if(argc < 2) exit(3);' >> sys/main.c

for prog in `ls sys/???.c`; do
    echo '    else if(strcmp(argv[1], "'`basename $prog .c`'")) ' "`basename $prog .c`" '(argc - 1, argv + 1);' >> sys/main.c
done

echo '    else exit(3);' >> sys/main.c
echo '}' >> sys/main.c

#####################################################

python3 $ctoxmconc_path/c2xcc.py sys/main.c "-I$ctoxmconc_path/include -Iinclude" > $xmconcc_path/tmp.xcc
python3 $xmconcc_path/xmconcc.py . xtl $xmconcc_path/tmp.xcc > software/xtl_sys.s

rm -f $xmconcc_path/tmp.xcc *tab.py

# сборка библиотеки XmConC
cat xmconc-lib/main.s xmconc-lib/main/*.s xmconc-lib/thread1/*.s > software/LIB_sys.s

cd os-builder
javac downadow/xmtwolime_builder/main/Builder.java
cd ../software
java -cp ../os-builder/ downadow.xmtwolime_builder.main.Builder ../bios.s ../kernel.s $(ls) > ../image
cd ..
java -cp "$makexm2ctools_path" downadow.makexm2c_tools.main.Assembler image image
rm software/*_sys.s
rm sys/main.c

