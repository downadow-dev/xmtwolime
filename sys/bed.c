#include <xmtwolime.h>
#include <useful.h>
#include <___get_args.h>
#include "check_root.h"

int main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl bed <address> <value>");
        exit(EXIT_FAILURE);
    }
    
    int addr = atoi(argv[1]);
    
    check_addr(addr);
    
    mem[addr] = atoi(argv[2]);
}

