#include <xmtwolime.h>
#include <___get_args.h>
#include <useful.h>
#include <gets.h>

int main(int argc, char *argv[]) {
    int addr, uid;
    
    if(argc < 2) {
        puts("usage: xtl txt <address>");
        exit(EXIT_FAILURE);
    } else if((addr = atoi(argv[1])) < USERSPACE_START && getuid() != UID_ROOT) {
        puts("root required");
        exit(EXIT_FAILURE);
    }
    
    char buf[256];
    do {
        gets(buf, sizeof(buf));
        addr = memcpy(&mem[addr], buf, strlen(buf)) + strlen(buf);
        mem[addr++] = '\n';
    } while(buf[strlen(buf) - 1] != EOT);
}

