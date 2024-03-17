#!/bin/bash
# автор         downadow (Sviatoslav)
# Доступно по лицензии Downadow License 7 как "Программное обеспечение".

if [[ "$1" == "" ]] then
	echo 'Usage:  bash build.sh DIR'
	exit
fi

for prog in `ls src`; do
	cc src/$prog -o tmp
	./tmp > "$1/$prog.s"
	rm tmp
done
