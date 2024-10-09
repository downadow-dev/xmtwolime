#include <xmtwolime.h>
#include <useful.h>
#include <___get_args.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl see [-n] <file>");
        exit(EXIT_FAILURE);
    }
    
    bool nflag = false;
    
    if(argv[1][0] == '-' && argv[1][1] == 'n') {
        nflag = true;
        ++argv;
    }
    
    fd_t f = file(argv[1]);
    if(f == -1) {
        puts("see: file opening error");
        exit(EXIT_FAILURE);
    }
    
    char *addr = filedata(f);
    char *start = addr;
    
    while(true) {
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
            } else if(addr[i] == '\0' || addr[i] == EOT) {
                break;
            } else {
                printf("%c", addr[i]);
            }
        }
        
        if(getchar() == 'q')
            exit(EXIT_SUCCESS);
        
        addr++;
        while(addr[-1] != '\n' && addr[-1] != '\0')
            addr++;
    }
}

