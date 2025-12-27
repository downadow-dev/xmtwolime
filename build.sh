#!/bin/bash
# автор            downadow

#####################################################

set -e

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

python3 cc/xm2cc.py xtl '-Icc/include -Iinclude -include cc/include/__get_args.h -include cc/include/__float.h' sys/main.c > software/xtl_sys.s
rm sys/main.c

rm -f *tab.py

# сборка библиотеки XmConC
cat lib/main.s lib/main/*.s > software/LIB_sys.s

python3 os-builder/main.py boot.s kernel.s software/* > out.s
rm software/*_sys.s

