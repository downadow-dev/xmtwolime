#ifndef __FLOATS__
#define __FLOATS__   1

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void __fstrip(float *x) {
    int n, lw;
    _call("funzip", *x, &n, &lw);
    while(lw > 0 && n % 10 == 0) {
        n /= 10;
        lw--;
    }
    *x = _call("fzip", n, lw);
}

void __fnormalize(float *x, float *y) {
    int x_n, x_lw;
    int y_n, y_lw;
    
    __fstrip(x);
    __fstrip(y);
    
    _call("funzip", *x, &x_n, &x_lw);
    _call("funzip", *y, &y_n, &y_lw);
    
    if(x_lw < y_lw) {
        for(int i = x_lw; i < y_lw; i++)
            x_n *= 10;
        x_lw = y_lw;
    } else if(x_lw > y_lw) {
        for(int i = y_lw; i < x_lw; i++)
            y_n *= 10;
        y_lw = x_lw;
    }
    
    *x = _call("fzip", x_n, x_lw);
    *y = _call("fzip", y_n, y_lw);
}

float __fadd(float y, float x) {
    int x_n, x_lw;
    int y_n, y_lw;
    __fnormalize(&x, &y);
    _call("funzip", x, &x_n, &x_lw);
    _call("funzip", y, &y_n, &y_lw);
    
    x_n += y_n;
    
    return _call("fzip", x_n, x_lw);
}

float __fsub(float y, float x) {
    int x_n, x_lw;
    int y_n, y_lw;
    __fnormalize(&x, &y);
    _call("funzip", x, &x_n, &x_lw);
    _call("funzip", y, &y_n, &y_lw);
    
    x_n -= y_n;
    
    return _call("fzip", x_n, x_lw);
}

float __fmul(float y, float x) {
    int x_n, x_lw;
    int y_n, y_lw;
    __fstrip(&x);
    __fstrip(&y);
    _call("funzip", x, &x_n, &x_lw);
    _call("funzip", y, &y_n, &y_lw);
    
    while(x_lw + y_lw > 4) {
        if(x_lw > y_lw) {
            x_n /= 10;
            x_lw--;
        } else {
            y_n /= 10;
            y_lw--;
        }
    }
    
    x_n  *= y_n;
    x_lw += y_lw;
    
    return _call("fzip", x_n, x_lw);
}

float __fdiv(float y, float x) {
    int x_n, x_lw;
    int y_n, y_lw;
    __fstrip(&y);
    _call("funzip", x, &x_n, &x_lw);
    _call("funzip", y, &y_n, &y_lw);
    
    if(x_n >= 0) {
        while(x_n < 100000) {
            x_n *= 10;
            x_lw++;
        }
    } else {
        while(x_n > -100000) {
            x_n *= 10;
            x_lw++;
        }
    }
    
    x_n  /= y_n;
    x_lw -= y_lw;
    
    return _call("fzip", x_n, x_lw);
}

int __f2i(float x) {
    int n, lw;
    _call("funzip", x, &n, &lw);
    
    while(lw--)
        n /= 10;
    
    return n;
}

int __feq(float y, float x) {
    int x_n, x_lw;
    int y_n, y_lw;
    __fnormalize(&x, &y);
    _call("funzip", x, &x_n, &x_lw);
    _call("funzip", y, &y_n, &y_lw);
    
    return x_n == y_n;
}

int __fne(float y, float x) {
    int x_n, x_lw;
    int y_n, y_lw;
    __fnormalize(&x, &y);
    _call("funzip", x, &x_n, &x_lw);
    _call("funzip", y, &y_n, &y_lw);
    
    return x_n != y_n;
}

int __flt(float y, float x) {
    int x_n, x_lw;
    int y_n, y_lw;
    __fnormalize(&x, &y);
    _call("funzip", x, &x_n, &x_lw);
    _call("funzip", y, &y_n, &y_lw);
    
    return x_n < y_n;
}

int __fgt(float y, float x) {
    int x_n, x_lw;
    int y_n, y_lw;
    __fnormalize(&x, &y);
    _call("funzip", x, &x_n, &x_lw);
    _call("funzip", y, &y_n, &y_lw);
    
    return x_n > y_n;
}

int __fle(float y, float x) {
    int x_n, x_lw;
    int y_n, y_lw;
    __fnormalize(&x, &y);
    _call("funzip", x, &x_n, &x_lw);
    _call("funzip", y, &y_n, &y_lw);
    
    return x_n <= y_n;
}

int __fge(float y, float x) {
    int x_n, x_lw;
    int y_n, y_lw;
    __fnormalize(&x, &y);
    _call("funzip", x, &x_n, &x_lw);
    _call("funzip", y, &y_n, &y_lw);
    
    return x_n >= y_n;
}

float atof(char *s) {
    int n = 0, lw = 0;
    char *p;
    n = atoi(s);
    
    if((p = strchr(s, '.'))) {
        p++;
        for(char *ptr = p; *ptr && *ptr != 'e' && *ptr != 'E'; ptr++) {
            n *= 10;
            lw++;
        }
        n += (n < 0 ? -atoi(p) : atoi(p));
    }
    
    if((p = strchr(s, 'e')) || (p = strchr(s, 'E'))) {
        p++;
        int i = atoi(p);
        if(i < 0) {
            lw += -i;
        } else if(i > 0) {
            while(i-- > 0) {
                if(lw > 0)
                    lw--;
                else
                    n *= 10;
            }
        }
    }
    
    return _call("fzip", n, lw);
}

#endif
