#include <stdlib.h>
#include <stdio.h>
#include <xmtwolime.h>

void main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl del <file>...");
        exit(EXIT_FAILURE);
    }
    
    for(int i = 1; i < argc; i++)
        unlink(argv[i]);
    
}

