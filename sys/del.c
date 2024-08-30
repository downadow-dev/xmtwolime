#include <useful.h>
#include <xmtwolime.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl del <address>");
        exit(EXIT_FAILURE);
    }
    
    int addr = atoi(argv[1]);
    
    if(addr < USERSPACE_START && getuid() != UID_ROOT) {
        puts("root required");
        exit(EXIT_FAILURE);
    }
    
    memset(&mem[addr], '\0', strlen(&mem[addr]));
}

