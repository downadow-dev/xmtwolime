/* таймер */

#include <stdlib.h>
#include <stdio.h>
#include <xmtwolime.h>
#include <time.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl tim MIN SEC");
        exit(EXIT_FAILURE);
    }
    
    clock_t time = clock() + (atoi(argv[2]) + atoi(argv[1]) * 60) * CLOCKS_PER_SEC;
    while(clock() < time) {
        clear_output();
        printf("%dm %ds",
            (time - clock() + CLOCKS_PER_SEC) / CLOCKS_PER_SEC / 60,
            (time - clock() + CLOCKS_PER_SEC) / CLOCKS_PER_SEC % 60);
        time--;
        ssleep(10);
    }
    clear_output();
    setbg(WHITE);
    setcolor(BLACK);
    puts("END");
    getchar();
}

