/* редактирование текста */


#include <xmtwolime.h>
#include <stdlib.h>
#include <stdio.h>

void main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl txt FILE [POS]");
        exit(EXIT_FAILURE);
    }
    
    fd_t f = creat(argv[1]);
    if(f == NULL) {
        puts("txt: file creating/opening error");
        exit(EXIT_FAILURE);
    }
    
    char buf[63];
    char *addr = filedata(f) + (argc > 2 ? atoi(argv[2]) : 0);
    for(;;) {
        for(char *p = addr; *p && *p != '\n'; p++)
            putchar(*p);
        printf("\r");
        
        /************************************/
        
        if(gets(buf, sizeof(buf)) == NULL)
            break;
        
        memset(&buf[strlen(buf)], ' ', sizeof(buf) - 1);
        buf[sizeof(buf) - 1] = '\0';
        
        addr = memcpy(addr, buf, strlen(buf)) + strlen(buf);
        *addr++ = '\n';
    }
}

