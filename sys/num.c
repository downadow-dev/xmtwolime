#include <xmtwolime.h>
#include <useful.h>
#include <___get_args.h>
#include "check_root.h"

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl num <address>");
        exit(EXIT_FAILURE);
    }
    
    int addr = atoi(argv[1]);
    
    check_addr(addr);
    
    while(true) {
        clear_output();
        
        for(int i = 0; i < 27; i++) {
            printf("%d: %d\n", addr + i, mem[addr + i]);
        }
        
        if(getchar() == 'q')
            exit(EXIT_SUCCESS);
        
        addr++;
    }
}

