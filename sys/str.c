/* поиск подстроки в файле */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <file.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl str STRING FILE");
        exit(EXIT_FAILURE);
    }
    
    fd_t f = file(argv[2]);
    if(f == NULL) {
        puts("file opening error");
        exit(2);
    }
    
    char *p = filedata(f);
    while(p = strstr(p, argv[1])) {
        printf("%d\n", p - filedata(f));
        p++;
    }
}

