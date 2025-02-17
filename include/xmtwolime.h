#ifndef __xmtwolime_h
#ifdef __XCC_C__

#define __xmtwolime_h     1

#include <string.h>
#include <time.h>

/* USERSPACE_START, USERSPACE_END, MEM_START */
#define USERSPACE_START   8700000
#define USERSPACE_END     9999999
#define MEM_START         6900000

/* известные пользователи */
#define UID_USER          1
#define UID_ROOT          0

/* коды цветов */
#define BLACK             0
#define WHITE             1
#define GREEN             2
#define BLUE              3
#define GREEN2            4
#define GREY              5
#define RED               6
#define YELLOW            7

/* ioctl */
#define DEV_PRINTER       1
#define IO_PRINTER_INFO   1
#define IO_PRINTER_WRITE  2
#define IO_PRINTER_OFF    3

int ioctl(char device, char request, char *argp, int argn, char *outp, int outn) {
    memset((char *)9999000, 0, 100);
    *((char *)9999001) = request;
    if(argp) memcpy((char *)9999002, argp, argn);
    *((char *)9999000) = device;
    
    int start = clock();
    while(*((char *)9999872) == 0) {
        if(clock() > start + 5 * CLOCKS_PER_SEC) {
            *((char *)9999000) = 0;
            return -130;
        }
    }
    
    char status = *((char *)9999872) - 1;
    if(outp) memcpy(outp, (char *)9999873, outn);
    *((char *)9999000) = 0;
    while(*((char *)9999872) != 0) {
        if(clock() > start + 5 * CLOCKS_PER_SEC) {
            return -130;
        }
    }
    return status;
}

#endif
#endif
