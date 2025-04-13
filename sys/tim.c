/* таймер */

#include <stdlib.h>
#include <stdio.h>
#include <xmtwolime.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl tim MIN SEC");
        exit(EXIT_FAILURE);
    }
    
    int time = clock() + (atoi(argv[2]) + atoi(argv[1]) * 60) * 1000;
    while(clock() < time) {
        clear_output();
        printf("%dm %ds", (time - clock() + 1000) / 1000 / 60, ((time - clock() + 1000) / 1000) % 60);
        time--;
        msleep(100);
    }
    clear_output();
    setbg(WHITE);
    setcolor(BLACK);
    puts("END");
    getchar();
}

