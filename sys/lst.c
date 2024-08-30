/* вывести список установленных программ и библиотек */


#include <xmtwolime.h>

int main(void) {
    for(char *s = (char *) __extern_label("system_apps"); *s != '\0'; *s++) {
        if(*s == ':') {
            printf("%c%c%c ", s[-3], s[-2], s[-1]);
        }
    }
}

