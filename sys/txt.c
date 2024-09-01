/* редактирование текста */


#include <xmtwolime.h>
#include <___get_args.h>
#include <useful.h>
#include <gets.h>

int main(int argc, char *argv[]) {
    int addr, uid;
    
    if(argc < 2) {
        puts("usage: xtl txt <address>");
        exit(EXIT_FAILURE);
    }
    
    check_addr(addr = atoi(argv[1]));
    
    char buf[63];
    for(;;) {
        for(char *p = &mem[addr]; *p && *p != '\n'; p++)
            putchar(*p);
        printf("\r");
        
        /************************************/
        
        gets(buf, sizeof(buf));
        
        if(buf[0] == EOT)
            break;
        
        memset(&buf[strlen(buf)], ' ', sizeof(buf) - 1);
        buf[sizeof(buf) - 1] = '\0';
        
        addr = memcpy(&mem[addr], buf, strlen(buf)) + strlen(buf);
        mem[addr++] = '\n';
    }
}

