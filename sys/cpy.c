#include <xmtwolime.h>
#include <file.h>
#include <___get_args.h>
#include <stdlib.h>
#include <stdio.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl cpy <file_src> <file_dst>");
        exit(EXIT_FAILURE);
    }
    
    fd_t fsrc = file (argv[1]);
    fd_t fdst = creat(argv[2]);
    if(fsrc == NULL || fdst == NULL) {
        puts("cpy: file opening error");
        exit(EXIT_FAILURE);
    }
    
    memcpy(filedata(fdst), filedata(fsrc), FILESIZE);
}

