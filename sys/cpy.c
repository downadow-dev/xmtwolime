#include <useful.h>
#include <xmtwolime.h>
#include <___get_args.h>
#include "check_root.h"

int main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl cpy <addr1> <addr2>");
        exit(EXIT_FAILURE);
    }
    
    int addr1 = atoi(argv[1]),
        addr2 = atoi(argv[2]);
    
    check_addr(addr1);
    check_addr(addr2);
    
    memcpy(&mem[addr2], &mem[addr1], strlen(&mem[addr1]) + 1);
}

