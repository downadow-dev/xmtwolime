/*
 * Файл ``../boot.s`` содержит код программы downloadMode.
 * IDT позволяет записывать/читать устройство,
 * пока оно находится в режиме downloadMode.
 * 
 * --downadow
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <limits.h>

FILE *xfopen(char *path, char *mode) {
    FILE *f;
    if((f = fopen(path, mode)) == NULL) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }
    return f;
}

int read_int(FILE *f) {
    static char buf[16];
    return (fgets(buf, sizeof(buf), f) != NULL) ? atoi(buf) : INT_MIN;
}

void write_int(int val, FILE *f) {
    fprintf(f, "%d\n", val);
}

int main(int argc, char **argv) {
    if(argc < 8) {
        fprintf(stderr, "usage: %s comm_file fcomm_file {flash|read} image_file start end speed_ms\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    
    FILE *fcomm;
    FILE *fcomm2;
    int command[32];
    int total = 0;
    int end = strtol(argv[6], NULL, 0);
    struct timespec slp = {.tv_sec = 0, .tv_nsec = strtol(argv[7], NULL, 0) * 1000000};
    
    if(strcmp(argv[3], "flash") == 0) {
        FILE *fimg = xfopen(argv[4], "r");
        for(int i = strtol(argv[5], NULL, 0); i < end; i += 10) {
            memset(command, 0, sizeof(command));
            command[0] = 'f';
            command[1] = i;
            for(int j = 0; j < 10; j++, total++) {
                if((command[2 + j] = read_int(fimg)) == INT_MIN) {
                    command[2 + j] = '\0';
                    i = end - 1;
                    break;
                }
            }
            
            fcomm = xfopen(argv[1], "w");
            write_int(0, fcomm);
            for(int j = 0; j < 12; j++)
                write_int(command[j], fcomm);
            fclose(fcomm);
            
            nanosleep(&slp, NULL);
            
            fcomm = xfopen(argv[1], "w");
            write_int(0, fcomm);
            write_int(0, fcomm);
            fclose(fcomm);
            
            printf("\rprogress: %07d", total);
            fflush(stdout);
            
            nanosleep(&slp, NULL);
        }
        fcomm = xfopen(argv[1], "w");
        write_int(0, fcomm);
        write_int(0, fcomm);
        fclose(fcomm);
        
        printf("\n");
        fclose(fimg);
    } else if(strcmp(argv[3], "read") == 0) {
        FILE *fdest = xfopen(argv[4], "w");
        
        for(int i = strtol(argv[5], NULL, 0); i < end; i += 8) {
            fcomm = xfopen(argv[1], "w");
            write_int(0, fcomm);
            write_int('g', fcomm);
            write_int(i, fcomm);
            fclose(fcomm);
            
            nanosleep(&slp, NULL);
            
            fcomm = xfopen(argv[1], "w");
            write_int(0, fcomm);
            write_int(0, fcomm);
            fclose(fcomm);
            
            nanosleep(&slp, NULL);
            
            fcomm2 = xfopen(argv[2], "r");
            
            for(int j = 0; j < 1000; j++)
                read_int(fcomm2);
            
            for(int j = 0; j < 8; j++, total++)
                write_int(read_int(fcomm2), fdest);
            fclose(fcomm2);
            
            printf("\rprogress: %07d", total);
            fflush(stdout);
        }
        fcomm = xfopen(argv[1], "w");
        write_int(0, fcomm);
        write_int(0, fcomm);
        fclose(fcomm);
        
        printf("\n");
        fclose(fdest);
    } else {
        fprintf(stderr, "%s: unknown command\n", argv[3]);
        exit(EXIT_FAILURE);
    }
}

