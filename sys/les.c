/* архивация текстовых файлов */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <file.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl les FILE... OUT_FILE");
        exit(EXIT_FAILURE);
    }
    
    fd_t fo = creat(argv[argc - 1]);
    if(fo == NULL) {
        puts("file creating/opening error");
        exit(EXIT_FAILURE);
    }
    
    char *pfo = filedata(fo);
    for(int i = 1; i < argc - 1; i++) {
        fd_t f = file(argv[i]);
        if(f == NULL) {
            puts("file opening error");
            exit(EXIT_FAILURE);
        }
        
        pfo = stpcpy(pfo, argv[i]);
        *pfo++ = 0x1;
        
        char *p = filedata(f);
        while(*p) {
            *pfo++ = (*p & 0xFFFF) + ((*(p+1) & 0xFFFF) << 16);
            p += 2;
        }
        *pfo++ = '\0';
    }
    *pfo = -1;
}

