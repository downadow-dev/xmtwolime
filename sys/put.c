#include <useful.h>
#include <xmtwolime.h>
#include <___get_args.h>
#include "check_root.h"

int main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl put <address> <text>");
        exit(EXIT_FAILURE);
    }
    
    int addr = atoi(argv[1]);
    
    check_addr(addr);
    
    memcpy(&mem[addr], argv[2], strlen(argv[2]));
}

