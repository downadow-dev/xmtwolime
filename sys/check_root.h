#ifndef __check_root_h
#define __check_root_h    1

#include <xmtwolime.h>
#include <misc.h>

void check_root(void) {
    if(getuid() != UID_ROOT) {
        puts("root required");
        exit(EXIT_FAILURE);
    }
}

void check_addr(int addr) {
    if(addr < USERSPACE_START) check_root();
}

#endif

