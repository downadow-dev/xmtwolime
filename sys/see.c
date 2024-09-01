#include <xmtwolime.h>
#include <useful.h>
#include <___get_args.h>
#include "check_root.h"

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl see [-n] <address>");
        exit(EXIT_FAILURE);
    }
    
    bool nflag = false;
    
    if(argv[1][0] == '-' && argv[1][1] == 'n') {
        nflag = true;
        ++argv;
    }
    
    int addr = atoi(argv[1]);
    
    check_addr(addr);
    
    while(true) {
        clear_output();
        
        for(int i = 0, j = 0; j < 25; i++) {
            if(mem[addr + i] == '\n') {
                printf("\n");
                
                if(nflag) {
                    setcolor(WHITE);
                    setcolor(GREY);
                    printf("%d", &mem[addr + i + 1]);
                    setcolor(WHITE);
                    printf("\n");
                    
                    j++;
                }
                
                j++;
            } else if(mem[addr + i] == '\0' || mem[addr + i] == EOT) {
                break;
            } else {
                printf("%c", mem[addr + i]);
            }
        }
        
        if(getchar() == 'q')
            exit(EXIT_SUCCESS);
        
        addr++;
        while(mem[addr - 1] != '\n' && mem[addr - 1] != '\0')
            addr++;
    }
}

