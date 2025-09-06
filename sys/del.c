/* удаление файлов */

#include <stdlib.h>
#include <stdio.h>
#include <xmtwolime.h>

void main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl del FILE...");
        exit(EXIT_FAILURE);
    }
    
    int errors = 0;
    
    for(int i = 1; i < argc; i++)
        if(unlink(argv[i]) == -1)
            printf("%d: %s: error\n", ++errors, argv[i]);
    
    exit(-errors);
}

