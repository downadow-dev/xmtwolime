#include <useful.h>
#include <xmtwolime.h>
#include "check_root.h"

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl cnt <address>...");
        exit(EXIT_FAILURE);
    }
    
    for(int i = 1; i < argc; i++) {
        int addr = atoi(argv[i]);
        
        check_addr(addr);
        
        int lines = 1;
        for(int j = addr; mem[j]; j++)
            if(mem[j] == '\n')
                lines++;
        
        printf("%d %d\n", strlen(addr), lines);
    }
}

