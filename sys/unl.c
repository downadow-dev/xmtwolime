/* разархивация */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <file.h>

void main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl unl ARCHIVE [PREFIX]");
        exit(EXIT_FAILURE);
    }
    
    fd_t fa = file(argv[1]);
    if(fa == NULL) {
        puts("file opening error");
        exit(EXIT_FAILURE);
    }
    
    char *pfa = filedata(fa);
    while(*pfa != -1) {
        if(*pfa) {
            char buf[MAX_PATH];
            char *p2 = buf;
            if(argc > 2) p2 = stpcpy(p2, argv[2]); /* добавление префикса */
            while(*pfa != 0x1) *p2++ = *pfa++; /* записывание имени файла */
            *p2 = '\0';
            
            fd_t f = creat(buf);
            if(f == NULL) {
                puts("file creating/opening error");
                exit(EXIT_FAILURE);
            }
            
            char *p = filedata(f);
            pfa++;
            while(*pfa) {
                *p++ = *pfa & 0xFFFF;
                *p++ = (*pfa >> 16) & 0xFFFF;
                pfa++;
            }
        }
        pfa++;
    }
}

