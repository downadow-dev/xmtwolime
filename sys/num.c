#include <xmtwolime.h>
#include <file.h>
#include <stdlib.h>
#include <stdio.h>
#include <___get_args.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl num <file>");
        exit(EXIT_FAILURE);
    }
    
    fd_t f = file(argv[1]);
    if(f == NULL) {
        puts("num: file opening error");
        exit(EXIT_FAILURE);
    }
    
    char *addr = filedata(f);
    
    while(true) {
        clear_output();
        
        for(int i = 0; i < 27; i++) {
            printf("%d: %d '%c'\n", &addr[i], addr[i], addr[i]);
        }
        
        if(getchar() == 'q')
            exit(EXIT_SUCCESS);
        
        addr += 4;
    }
}

