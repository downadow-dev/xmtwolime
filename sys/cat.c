/* "склеить" текстовые файлы */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <file.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: cat FILE... OUT_FILE");
        exit(EXIT_FAILURE);
    }
    
    fd_t f = creat(argv[argc - 1]);
    if(f == NULL) {
        puts("file creating/opening error");
        exit(2);
    }
    char *p = filedata(f);
    
    for(int i = 1; i < argc - 1; i++) {
        f = file(argv[i]);
        if(f == NULL) {
            puts("file opening error");
            exit(2);
        }
        p = stpcpy(p, filedata(f));
    }
}

