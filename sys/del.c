#include <useful.h>
#include <xmtwolime.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl del <file>");
        exit(EXIT_FAILURE);
    }
    
    if(unlink(argv[1]) == -1) {
        puts("del: unlink() failure");
        exit(EXIT_FAILURE);
    }
}

