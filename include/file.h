#ifndef __file_h
#define __file_h    1

#include <xmtwolime.h>
#include <string.h>

typedef char * fd_t;

#define MAX_PATH     63
#define FILE_SIZE    10000
#define FILESIZE     9937
#define MAX_FILES    128

char *__files = USERSPACE_START;

#define filedata(fd)  ((fd)+MAX_PATH)

/* получение адреса файла */
fd_t file(char *name) {
    if(*name == '\0' || (*name == '.' && getuid() != UID_ROOT))
        return NULL;
    
    for(int i = 0; i < MAX_FILES; i++) {
        if(strcmp(&__files[i * FILE_SIZE], name) == 0)
            return &__files[i * FILE_SIZE];
        
        if(strlen(&__files[i * FILE_SIZE]) > 2 && __files[i * FILE_SIZE + strlen(&__files[i * FILE_SIZE]) - 2] == '@') {
            i += __files[i * FILE_SIZE + strlen(&__files[i * FILE_SIZE]) - 1] - '0';
            continue;
        }
    }
    
    return NULL;
}

/* создание файла */
fd_t creat(char *name) {
    fd_t fd;
    
    int n = 0;
    if(strlen(name) > 2 && name[strlen(name) - 2] == '@')
        n = name[strlen(name) - 1] - '0';
    
    if(*name == '.' && getuid() != UID_ROOT)
        return NULL;
    
    if(fd = file(name))
        return fd;
    
    for(int i = 0; i < MAX_FILES; i++) {
        if(__files[i * FILE_SIZE] == '\0') {
            if(n > 0) {
                for(int j = i + 1; j < i + 1 + n; j++)
                    if(__files[j * FILE_SIZE] != '\0')
                        goto next;
            }
            memcpy(&__files[i * FILE_SIZE], name, strlen(name) + 1);
            memset(&__files[i * FILE_SIZE] + MAX_PATH, '\0', FILESIZE);
            return &__files[i * FILE_SIZE];
        } else if(strlen(&__files[i * FILE_SIZE]) > 2 && __files[i * FILE_SIZE + strlen(&__files[i * FILE_SIZE]) - 2] == '@') {
            i += __files[i * FILE_SIZE + strlen(&__files[i * FILE_SIZE]) - 1] - '0';
            continue;
        }
        
        next: ;
    }
    
    return NULL;
}

/* удаление файла */
int unlink(char *name) {
    fd_t fd;
    
    if(*name == '.' && getuid() != UID_ROOT)
        return -1;
    
    if(fd = file(name)) {
        if(strlen(name) > 2 && name[strlen(name) - 2] == '@') {
            for(int i = 1; i < name[strlen(name) - 1] - '0' + 1; i++)
                memset(fd + FILE_SIZE * i, '\0', FILE_SIZE);
        }
        
        *fd = '\0';
        return 0;
    } else {
        return -1;
    }
}

/* переименование файла */
int rename(char *oldname, char *newname) {
    fd_t fd;
    
    if((*oldname == '.' || *newname == '.') && getuid() != UID_ROOT)
        return -1;
    
    if((fd = file(oldname)) && file(newname) == NULL) {
        memcpy(fd, newname, strlen(newname) + 1);
        return 0;
    } else {
        return -1;
    }
}

int __nextfile_count = 0;

char *fnext(void) {
    if(__nextfile_count > 0 && strlen(&__files[(__nextfile_count - 1) * FILE_SIZE]) > 2 && __files[(__nextfile_count - 1) * FILE_SIZE + strlen(&__files[(__nextfile_count - 1) * FILE_SIZE]) - 2] == '@')
        __nextfile_count += __files[(__nextfile_count - 1) * FILE_SIZE + strlen(&__files[(__nextfile_count - 1) * FILE_SIZE]) - 1] - '0';
    
    while((__files[__nextfile_count * FILE_SIZE] == '\0' || ((__files[__nextfile_count * FILE_SIZE] == '.' || __files[__nextfile_count * FILE_SIZE] == '~') && getuid() != UID_ROOT)) && __nextfile_count < MAX_FILES)
        __nextfile_count++;
    
    if(__nextfile_count >= MAX_FILES)
        return NULL;
    
    return &__files[(__nextfile_count++) * FILE_SIZE];
}

void freset(void) {
    __nextfile_count = 0;
}

#endif

