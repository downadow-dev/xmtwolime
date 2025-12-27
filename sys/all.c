/* вывести список установленных программ и библиотек */

#include <stdio.h>

void main(int argc, char *argv[]) {
    char *s;
    
    for(s = (char *) __extern_label("system_apps"); *s; s++) {
        if(*s == ':') {
            printf("%c%c%c ", s[-3], s[-2], s[-1]);
        }
    }
}

