#ifndef __file_h
#define __file_h    1

#include <xmtwolime.h>
#include <gets.h>

typedef char * fd_t;

#define MAX_PATH     63
#define FILE_SIZE    10000
#define FILESIZE     9937
#define MAX_FILES    129

char *__files = USERSPACE_START;

#define filedata(fd)  (fd+MAX_PATH)

/* получение адреса файла */
fd_t file(char *name) {
    if(*name == '.' && getuid() != UID_ROOT)
        return -1;
    
    for(int i = 0; i < MAX_FILES; i++)
        if(strcmp(&__files[i * FILE_SIZE], name))
            return &__files[i * FILE_SIZE];
    
    return -1;
}

/* создание файла */
fd_t creat(char *name) {
    fd_t fd;
    
    if(*name == '.' && getuid() != UID_ROOT)
        return -1;
    
    if((fd = file(name)) != -1)
        return fd;
    
    for(int i = 0; i < MAX_FILES; i++) {
        if(__files[i * FILE_SIZE] == '\0') {
            memcpy(&__files[i * FILE_SIZE], name, strlen(name) + 1);
            memset(&__files[i * FILE_SIZE] + MAX_PATH, '\0', FILESIZE);
            return &__files[i * FILE_SIZE];
        }
    }
    
    return -1;
}

/* удаление файла */
int unlink(char *name) {
    fd_t fd;
    
    if(*name == '.' && getuid() != UID_ROOT)
        return -1;
    
    if((fd = file(name)) != -1) {
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
    
    if((fd = file(oldname)) != -1) {
        memcpy(fd, newname, strlen(newname) + 1);
        return 0;
    } else {
        return -1;
    }
}

char *list_files(char *buf, size_t n) {
    char *p = buf;
    
    for(int i = 0; i < MAX_FILES && (p - buf) < n; i++) {
        if(__files[i * FILE_SIZE] != '\0') {
            /* файлы root'а не показываются */
            if(__files[i * FILE_SIZE] == '.' && getuid() != UID_ROOT)
                continue;
            
            memcpy(p, &__files[i * FILE_SIZE], strlen(&__files[i * FILE_SIZE]));
            p += strlen(&__files[i * FILE_SIZE]);
            *p++ = ' ';
        }
    }
    *(p-1) = '\0';
    
    return buf;
}


#endif
