#include <useful.h>
#include <xmtwolime.h>
#include <___get_args.h>

int main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl cpy <addr1> <addr2>");
        exit(EXIT_FAILURE);
    }
    
    int addr1 = atoi(argv[1]),
        addr2 = atoi(argv[2]);
    
    if((addr1 < USERSPACE_START || addr2 < USERSPACE_START) && getuid() != UID_ROOT) {
        puts("root required");
        exit(EXIT_FAILURE);
    }
    
    memcpy(&mem[addr2], &mem[addr1], strlen(&mem[addr1]) + 1);
}

