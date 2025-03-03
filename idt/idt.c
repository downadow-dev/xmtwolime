/*
 * Файл ``../boot.s`` содержит код программы downloadMode.
 * Эта программа позволяет записывать/читать устройство,
 * пока оно находится в режиме downloadMode.
 * 
 * --downadow
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

FILE *xfopen(char *path, char *mode) {
    FILE *f;
    if((f = fopen(path, mode)) == NULL) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }
    return f;
}

int main(int argc, char **argv) {
    if(argc < 8) {
        fprintf(stderr, "usage: %s .comm_file .comm2_file {flash|read} image_file start end speed_ms\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    
    FILE *fcomm;
    FILE *fcomm2;
    char command[32];
    char *p;
    int total = 0;
    int end = strtol(argv[6], NULL, 0);
    struct timespec slp = {.tv_sec = 0, .tv_nsec = strtol(argv[7], NULL, 0) * 1000000};
    
    if(strcmp(argv[3], "flash") == 0) {
        FILE *fbin = xfopen(argv[4], "rb");
        for(int i = strtol(argv[5], NULL, 0); i < end; i += 10) {
            sprintf(command, "f%07d", i);
            p = command + strlen(command);
            memset(p, '\0', 10);
            for(int j = 0; j < 10; j++, total++) {
                if((*p++ = fgetc(fbin)) == EOF) {
                    *--p = '\0';
                    i = end - 1;
                    break;
                }
            }
            
            fcomm = xfopen(argv[1], "wb");
            for(int j = 0; j < 18; j++)
                fputc(command[j], fcomm);
            fclose(fcomm);
            
            nanosleep(&slp, NULL);
            
            fcomm = xfopen(argv[1], "wb");
            fputc(0, fcomm);
            fclose(fcomm);
            
            printf("\rprogress: %07d", total);
            fflush(stdout);
            
            nanosleep(&slp, NULL);
        }
        fcomm = xfopen(argv[1], "wb");
        fputc(0, fcomm);
        fclose(fcomm);
        
        printf("\n");
        fclose(fbin);
    } else if(strcmp(argv[3], "read") == 0) {
        FILE *fdest = xfopen(argv[4], "wb");
        
        for(int i = strtol(argv[5], NULL, 0); i < end; i += 8) {
            fcomm = xfopen(argv[1], "wb");
            fprintf(fcomm, "g%07d", i);
            fclose(fcomm);
            
            nanosleep(&slp, NULL);
            
            fcomm = xfopen(argv[1], "wb");
            fputc(0, fcomm);
            fclose(fcomm);
            
            nanosleep(&slp, NULL);
            
            fcomm2 = xfopen(argv[2], "rb");
            
            for(int j = 0; j < 5; j++)
                fgetc(fcomm2);
            
            for(int j = 0; j < 8; j++, total++)
                fputc(fgetc(fcomm2), fdest);
            fclose(fcomm2);
            
            printf("\rprogress: %07d", total);
            fflush(stdout);
        }
        fcomm = xfopen(argv[1], "wb");
        fputc(0, fcomm);
        fclose(fcomm);
        
        printf("\n");
        fclose(fdest);
    } else {
        fprintf(stderr, "%s: unknown command\n", argv[3]);
        exit(EXIT_FAILURE);
    }
}

