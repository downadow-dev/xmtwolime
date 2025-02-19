#include <xmtwolime.h>
#include <stdlib.h>
#include <stdio.h>

void main(int argc, char *argv[]) {
    if(argc < 2) {
        puts("usage: xtl prt FILE");
        exit(EXIT_FAILURE);
    }
    
    int status;
    char info[90];
    
    if((status = ioctl(DEV_PRINTER, IO_PRINTER_INFO, NULL, 0, info, 90)) != 0) {
        printf("error (%d)", status);
        exit(EXIT_FAILURE);
    }
    
    puts(info);
    
    /* печать содержимого текстового файла */
    fd_t f;
    if(!(f = file(argv[1]))) {
        puts("file opening error");
        exit(EXIT_FAILURE);
    }
    
    char *p = filedata(f);
    for(;;) {
        if((status = ioctl(DEV_PRINTER, IO_PRINTER_WRITE, p, (strlen(p) < 90) ? strlen(p) : 90, NULL, 0)) != 0) {
            printf("error (%d)", status);
            exit(EXIT_FAILURE);
        }
        
        if(strlen(p) < 90) break;
        
        p += 90;
    }
}

