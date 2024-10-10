/* сравнение двух файлов */


#include <useful.h>
#include <gets.h>
#include <xmtwolime.h>
#include <file.h>

int main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl cmp <file1> <file2>");
        exit(EXIT_FAILURE);
    }
    
    fd_t f1 = file(argv[1]);
    fd_t f2 = file(argv[2]);
    if(f1 == NULL || f2 == NULL) {
        puts("cmp: file opening error");
        exit(EXIT_FAILURE);
    }
    
    char *addr1 = filedata(f1);
    char *addr2 = filedata(f2);
    
    size_t length = strlen(addr1);
    
    if(strlen(addr2) != length)
        exit(2);
    
    bool eq = true;
    for(int i = 0; i < length; i++) {
        if(addr1[i] != addr2[i]) {
            printf("%d: %c/%c\n", i, addr1[i], addr2[i]);
            eq = false;
        }
    }
    
    if(!eq) exit(2);
}

