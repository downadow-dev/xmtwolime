#include <useful.h>
#include <xmtwolime.h>
#include <file.h>
#include <___get_args.h>

int main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl cpy <file_src> <file_dst>");
        exit(EXIT_FAILURE);
    }
    
    fd_t fsrc = file (argv[1]);
    fd_t fdst = creat(argv[2]);
    if(fsrc == -1 || fdst == -1) {
        puts("cpy: file opening error");
        exit(EXIT_FAILURE);
    }
    
    memcpy(filedata(fdst), filedata(fsrc), FILESIZE);
}

