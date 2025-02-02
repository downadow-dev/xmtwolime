/* таймер */

#include <stdlib.h>
#include <stdio.h>
#include <___get_args.h>
#include <xmtwolime.h>

void main(int argc, char *argv[]) {
    if(argc < 3) {
        puts("usage: xtl tim <minutes> <seconds>");
        exit(EXIT_FAILURE);
    }
    
    int time = atoi(argv[2]) + atoi(argv[1]) * 60;
    while(time) {
        clear_output();
        printf("%dm %ds", time / 60, time % 60);
        sleep(1);
        time--;
    }
    clear_output();
    setbg(WHITE);
    setcolor(BLACK);
    puts("END");
    getchar();
}

