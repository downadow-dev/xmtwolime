#include <xmtwolime.h>
#include <stdlib.h>
#include <stdio.h>

void main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl see [-n] FILE [POS]");
        exit(EXIT_FAILURE);
    }
    
    int nflag = 0;
    
    if(argv[1][0] == '-' && argv[1][1] == 'n') {
        nflag++;
        ++argv;
        --argc;
    }
    
    fd_t f = file(argv[1]);
    if(f == NULL) {
        puts("see: file opening error");
        exit(EXIT_FAILURE);
    }
    
    char *addr = filedata(f) + (argc > 2 ? atoi(argv[2]) : 0);
    char *start = addr;
    
    for(;;) {
        clear_output();
        
        for(int i = 0, j = 0; j < 25; i++) {
            if(addr[i] == '\n') {
                printf("\n");
                
                if(nflag) {
                    setcolor(WHITE);
                    setcolor(GREY);
                    printf("%d", (addr + i + 1) - start);
                    setcolor(WHITE);
                    printf("\n");
                    
                    j++;
                }
                
                j++;
            } else if(addr[i] == '\0') {
                break;
            } else {
                printf("%c", addr[i]);
            }
        }
        
        if(getchar() == 'q')
            exit(EXIT_SUCCESS);
        
        addr++;
        
        int n = 20;
        while(n--) {
            while(addr[-1] != '\n' && addr[-1] != '\0') {
                addr++;
            }
            addr++;
        }
        addr--;
    }
}

