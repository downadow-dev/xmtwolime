#ifndef __time_h
#define __time_h   1

typedef long clock_t;
#define CLOCKS_PER_SEC   1000

void clock_sleep(int ms) {
    int end = _call("clock") + ms;
    while(_call("clock") < end);
}

#endif
