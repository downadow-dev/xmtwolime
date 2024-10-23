/* поиск подстроки в файле */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <___get_args.h>
#include <file.h>

int main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: str <string> <file>");
        exit(EXIT_FAILURE);
    }
    
    fd_t f = file(argv[2]);
    if(f == NULL) {
        puts("file opening error");
        exit(2);
    }
    
    char *p = filedata(f);
    while(p = strstr(p, argv[1])) {
        printf("%d\n", p - filedata(f));
        p++;
    }
}

