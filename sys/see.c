#include <xmtwolime.h>
#include <useful.h>
#include <___get_args.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl see <address>");
        exit(EXIT_FAILURE);
    }
    
    int addr = atoi(argv[1]);
    
    if(addr < USERSPACE_START && getuid() != UID_ROOT) {
        puts("root required");
        exit(EXIT_FAILURE);
    }
    
    while(true) {
        clear_output();
        
        for(int i = 0, j = 0; j < 25; i++) {
            if(mem[addr + i] == '\n') {
                printf("\n");
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

