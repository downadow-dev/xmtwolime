/* вывести список файлов */

#include <stdlib.h>
#include <stdio.h>
#include <file.h>
#include <string.h>

void main(int argc, char *argv[]) {
    if(argc > 1 && argv[1][0] == '-') {
        puts("usage: xtl lst [PREFIX]");
        exit(EXIT_FAILURE);
    }
    
    char *name;
    int n = 0;
    freset();
    while(name = fnext()) {
        if(argc > 1) {
            if(strlen(name) > strlen(argv[1])) {
                char buf[MAX_PATH];
                memset(buf, '\0', sizeof buf);
                memcpy(buf, name, strlen(argv[1]));
                
                if(strcmp(argv[1], buf) == 0) {
                    printf("%s  ", name + strlen(buf));
                    n++;
                }
                
            } else continue;
        } else {
            printf("%s  ", name);
            n++;
        }
    }
    printf("\n\n%d", n);
}

