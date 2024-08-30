#include <useful.h>
#include <xmtwolime.h>
#include "check_root.h"

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl del <address>");
        exit(EXIT_FAILURE);
    }
    
    int addr = atoi(argv[1]);
    
    check_addr(addr);
    
    memset(&mem[addr], '\0', strlen(&mem[addr]));
}

