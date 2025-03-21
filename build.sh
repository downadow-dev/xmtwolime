#!/bin/bash
# автор            downadow (Sviatoslav)

# ИЗМЕНИТЕ ЭТО
assembler='../mxm2c-as/mxm2c-as'
##############

#####################################################

mkdir -p software

echo '#include <string.h>' > sys/main.c
echo '#include <stdio.h>' >> sys/main.c
for prog in sys/???.c; do
    echo '#define main '`basename $prog .c`'_prog' >> sys/main.c
    echo '#include "'`basename $prog`'"' >> sys/main.c
    echo '#undef main' >> sys/main.c
done

echo 'int main(int argc, char *argv[]) {' >> sys/main.c

for prog in sys/???.c; do
    echo '    if(strcmp(argv[1], "'`basename $prog .c`'") == 0) { '`basename $prog .c`'_prog(argc - 1, argv + 1); exit(EXIT_SUCCESS); }' >> sys/main.c
done

echo -n '    puts("' >> sys/main.c
for prog in sys/???.c; do
    echo -n "`basename $prog .c` " >> sys/main.c
done
echo '");' >> sys/main.c
echo '    exit(3);' >> sys/main.c

echo '}' >> sys/main.c

#####################################################

python3 cc/xm2cc.py xtl sys/main.c "-Icc/include -Iinclude -include cc/include/___get_args.h" > software/xtl_sys.s

rm -f *tab.py

# сборка библиотеки XmConC
cat lib/main.s lib/main/*.s > software/LIB_sys.s

cd os-builder
javac downadow/xmtwolime_builder/main/Builder.java
cd ../software
java -cp ../os-builder/ downadow.xmtwolime_builder.main.Builder ../boot.s ../kernel.s * > ../image.s
cd ..
$assembler image.s image
rm image.s
rm software/*_sys.s
rm sys/main.c

