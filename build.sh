#!/bin/bash
# автор            downadow (Sviatoslav)

# ИЗМЕНИТЕ ЭТО
ctoxmconc_path="../c-to-xmconc"
xmconcc_path="../xmconcc"
assembler='../mxm2c-as/mxm2c-as'
##############

#####################################################

mkdir -p software

echo '#include <string.h>' > sys/main.c
echo '#include <stdio.h>' >> sys/main.c
for prog in sys/???.c; do
    echo '#define main '`basename $prog .c` >> sys/main.c
    echo '#include "'`basename $prog`'"' >> sys/main.c
    echo '#undef main' >> sys/main.c
done

echo 'int main(int argc, char *argv[]) {' >> sys/main.c
echo '    if(argc > 1 && strcmp(argv[1], "xtl") == 0) puts("xtl -- the basic Xmtwolime utilities");' >> sys/main.c

for prog in sys/???.c; do
    echo '    else if(strcmp(argv[1], "'`basename $prog .c`'") == 0) ' "`basename $prog .c`" '(argc - 1, argv + 1);' >> sys/main.c
done

echo '    else {' >> sys/main.c
echo -n '        puts("' >> sys/main.c
for prog in sys/???.c; do
    echo -n "`basename $prog .c` " >> sys/main.c
done
echo -n "`basename $prog .c` " >> sys/main.c
echo '");' >> sys/main.c
echo '        exit(3);' >> sys/main.c
echo '    }' >> sys/main.c

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
$assembler image image
rm software/*_sys.s
rm sys/main.c

