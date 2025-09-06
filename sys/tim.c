/* таймер */

#include <stdlib.h>
#include <stdio.h>
#include <xmtwolime.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl tim MIN SEC");
        exit(EXIT_FAILURE);
    }
    
    int time = clock() + (atoi(argv[2]) + atoi(argv[1]) * 60) * 100;
    while(clock() < time) {
        clear_output();
        printf("%dm %ds", (time - clock() + 100) / 100 / 60, ((time - clock() + 100) / 100) % 60);
        time--;
        ssleep(10);
    }
    clear_output();
    setbg(WHITE);
    setcolor(BLACK);
    puts("END");
    getchar();
}

