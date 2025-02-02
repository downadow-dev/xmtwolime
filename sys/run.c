/* запуск файла */

#include <file.h>
#include <xmtwolime.h>
#include <stdio.h>
#include <file.h>

void main(int argc, char **argv) {
    if(argc < 2) {
        printf("usage: xtl run <file>");
        exit(EXIT_FAILURE);
    } else if(getuid() != UID_ROOT) {
        printf("root required");
        exit(EXIT_FAILURE);
    }
    
    fd_t f;
    if(!(f = file(argv[1]))) {
        printf("file opening error");
        exit(EXIT_FAILURE);
    }
    
    __jump(filedata(f));
}
