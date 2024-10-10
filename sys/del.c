#include <useful.h>
#include <xmtwolime.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl del <file>...");
        exit(EXIT_FAILURE);
    }
    
    for(int i = 1; i < argc; i++)
        unlink(argv[i]);
    
}

