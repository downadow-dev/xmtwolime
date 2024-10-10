#include <file.h>
#include <useful.h>

int main(int argc, char *argv[]) {
    if(argc < 4) {
        puts("usage: xtl bed <file> <start> <value>...");
        exit(EXIT_FAILURE);
    }
    
    fd_t f = creat(argv[1]);
    if(f == NULL) {
        puts("bed: file opening error");
        exit(EXIT_FAILURE);
    }
    
    char *p = filedata(f) + atoi(argv[2]);
    
    for(int i = 3; i < argc; i++, p++)
        *p = atoi(argv[i]);
}

