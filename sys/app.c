/* вывести список установленных программ и библиотек */

int main(void) {
    char *s;
    
    for(s = (char *) __extern_label("system_apps"); *s; s++) {
        if(*s == ':') {
            printf("%c%c%c ", s[-3], s[-2], s[-1]);
        }
    }
}

