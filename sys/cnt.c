#include <useful.h>
#include <xmtwolime.h>
#include <file.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl cnt <file>...");
        exit(EXIT_FAILURE);
    }
    
    for(int i = 1; i < argc; i++) {
        fd_t f = file(argv[i]);
        if(f == NULL) {
            puts("cnt: file opening error");
            exit(EXIT_FAILURE);
        }
        
        char *addr = filedata(f);
        
        int lines = 1;
        for(char *j = addr; *j; j++)
            if(*j == '\n')
                lines++;
        
        printf("%d %d\n", strlen(addr), lines);
    }
}

