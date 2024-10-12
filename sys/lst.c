/* вывести список файлов */

#include <useful.h>
#include <gets.h>
#include <file.h>

int main(int argc, char *argv[]) {
    if(argc > 1 && argv[1][0] == '-') {
        puts("usage: xtl lst [<prefix>]");
        exit(EXIT_FAILURE);
    }
    
    char *name;
    freset();
    while(name = fnext()) {
        if(name[0] == '.' && getuid() != UID_ROOT)
            continue;
        
        if(argc > 1) {
            if(strlen(name) > strlen(argv[1])) {
                char buf[MAX_PATH];
                memset(buf, '\0', sizeof buf);
                memcpy(buf, name, strlen(argv[1]));
                
                if(strcmp(argv[1], buf))
                    printf("%s  ", name + strlen(buf));
                
            } else continue;
        } else {
            printf("%s  ", name);
        }
    }
}

