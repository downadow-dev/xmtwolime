/* переименование файла */

#include <file.h>
#include <stdlib.h>
#include <stdio.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl ren FILE NEW_NAME");
        exit(EXIT_FAILURE);
    }
    
    if(rename(argv[1], argv[2]) == -1) {
        puts("ren: rename() failure");
        exit(EXIT_FAILURE);
    }
}

