#include <file.h>
#include <stdio.h>
#include <stdlib.h>

void main(int argc, char *argv[]) {
    if(argc < 4) {
        puts("usage: xtl put FILE START VALUE...");
        exit(EXIT_FAILURE);
    }
    
    fd_t f = creat(argv[1]);
    if(f == NULL) {
        puts("put: file creating/opening error");
        exit(EXIT_FAILURE);
    }
    
    char *p = filedata(f) + atoi(argv[2]);
    
    for(int i = 3; i < argc; i++, p++)
        *p = strtol(argv[i], NULL, 0);
}

