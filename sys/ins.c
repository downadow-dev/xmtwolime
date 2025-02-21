#include <file.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl ins FILE POS [N]");
        exit(EXIT_FAILURE);
    }
    
    fd_t f = file(argv[1]);
    if(f == NULL) {
        puts("file opening error");
        exit(2);
    }
    
    int n = argc > 3 ? atoi(argv[3]) : 1;
    char *p = filedata(f) + atoi(argv[2]);
    while(n--) {
        memmove(p + 63, p, strlen(p) + 1);
        memset(p, ' ', 62);
        *(p+62) = '\n';
        p += 63;
    }
}

