#include <useful.h>
#include <gets.h>
#include <xmtwolime.h>

int main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl cmp <addr1> <addr2>");
        exit(EXIT_FAILURE);
    }
    
    int addr1 = atoi(argv[1]),
        addr2 = atoi(argv[2]);
    
    if((addr1 < USERSPACE_START || addr2 < USERSPACE_START) && getuid() != UID_ROOT) {
        puts("root required");
        exit(EXIT_FAILURE);
    }
    
    size_t length1 = strlen(&mem[addr1]), length2 = strlen(&mem[addr2]);
    
    printf("%d  %d\n\n", length1, length2);
    
    bool eq = true;
    for(int i = 0; i < length1 && i < length2; i++) {
        if(mem[addr1 + i] != mem[addr2 + i]) {
            printf("%d: %c/%c\n", i, mem[addr1 + i], mem[addr2 + i]);
            eq = false;
        }
    }
    
    if(!eq) exit(2);
}

