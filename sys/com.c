#include <xmtwolime.h>
#include <stdlib.h>
#include <stdio.h>

void main(int argc, char *argv[]) {
    if(argc > 1) {
        /* использование */
        if(argv[1][0] == '-') {
            puts("usage: xtl com [string]...");
            exit(EXIT_FAILURE);
        }
        /* отправить сообщение */
        else {
            char *p = com_in;
            for(int i = 1; i < argc; i++) {
                memcpy(p, argv[i], strlen(argv[i]));
                p += strlen(argv[i]);
                *p++ = ' ';
            }
            *(p-1) = '\0';
        }
    }
    /* ждать сообщение */
    else {
        while(!(*com_out))
            msleep(100);
        
        msleep(500);
        puts(com_out);
        *com_out = '\0';
    }
}

