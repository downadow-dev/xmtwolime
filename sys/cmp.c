/* сравнение двух файлов */

#include <stdlib.h>
#include <stdio.h>
#include <xmtwolime.h>
#include <file.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl cmp FILE1 FILE2");
        exit(EXIT_FAILURE);
    }
    
    fd_t f1 = file(argv[1]);
    fd_t f2 = file(argv[2]);
    if(f1 == NULL || f2 == NULL) {
        puts("cmp: file opening error");
        exit(EXIT_FAILURE);
    }
    
    char *addr1 = filedata(f1);
    char *addr2 = filedata(f2);
    
    size_t length = strlen(addr1);
    
    if(strlen(addr2) != length)
        exit(2);
    
    int eq = 1;
    for(int i = 0; i < length; i++) {
        if(addr1[i] != addr2[i]) {
            printf("%d: %c/%c\n", i, addr1[i], addr2[i]);
            eq = 0;
        }
    }
    
    if(!eq) exit(2);
}

