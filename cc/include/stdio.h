#ifndef _STDIO_H
#define _STDIO_H    1

#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

#define EOF          (-1)

int getchar(void) {
    char c;
    for(;;) {
        c = _call("getc");
        if(c != 0 && c != 65535)
            break;
    }
    
    return (c != 4 /* Ctrl+D */) ? c : EOF;
}

int putchar(int c) {
    switch(c) {
    case '\n':
        _call("newline");
        break;
    case '\b':
        _call("backspace");
        break;
    case '\r':
        _call("cr");
        break;
    default:
        _call("putc", c);
    }
    return c;
}

/* put number to string */

char *_sprinti(int v, char *start) {
    if(v < 0) {
        v = -v;
        *start++ = '-';
    }
    
    if(v / 10) start = _sprinti(v / 10, start);
    *start++ = (v % 10) + '0';
    return start;
}

char *_sprintu(unsigned int v, char *start, int base, int upper) {
    if(v / base) start = _sprintu(v / base, start, base, upper);
    *start++ = (v % base) < 10 ? ((v % base) + '0') : ((v % base) - 10 + (upper ? 'A' : 'a'));
    return start;
}

/* vsprintf */
int vsprintf(char *s, char *fmt, va_list ap) {
    char *p;
    char *orig = s;
    int zfill, alt;
    int i, n, l, lw;
    
    while(*fmt) {
        zfill = 0;
        alt = 0;
        
        if(*fmt == '%') {
            fmt++;
            
            if(*fmt == '#') {
                alt = 1;
                fmt++;
            }
            
            if(*fmt == '0') {
                zfill = atoi(++fmt);
                while(isdigit(*fmt)) fmt++;
            }
            
            while(*fmt == 'l' || *fmt == 'h' || *fmt == 't' || *fmt == 'z' || *fmt == 'j' || *fmt == ' ')
                fmt++;
            
            switch(*fmt) {
            case '%':
                *s++ = '%';
                break;
            case 'i': case 'd':
                if(zfill) {
                    *_sprinti(va_arg(ap, int), s) = '\0';
                    if((zfill -= strlen(s)) > 0) {
                        memmove(s + zfill, s, strlen(s) + 1);
                        memset(s, '0', zfill);
                    }
                    s += strlen(s);
                } else {
                    s = _sprinti(va_arg(ap, int), s);
                }
                break;
            case 'u':
                if(zfill) {
                    *_sprintu(va_arg(ap, unsigned int), s, 10, 0) = '\0';
                    if((zfill -= strlen(s)) > 0) {
                        memmove(s + zfill, s, strlen(s) + 1);
                        memset(s, '0', zfill);
                    }
                    s += strlen(s);
                } else {
                    s = _sprintu(va_arg(ap, unsigned int), s, 10, 0);
                }
                break;
            case 'p':
                p = va_arg(ap, void *);
                if(p) {
                    *s++ = '0';
                    *s++ = 'x';
                    s = _sprintu(p, s, 16, 0);
                } else {
                    s = stpcpy(s, "(nil)");
                }
                break;
            case 'x':
                if(alt) {
                    *s++ = '0';
                    *s++ = 'x';
                }
                
                if(zfill) {
                    *_sprintu(va_arg(ap, int), s, 16, 0) = '\0';
                    if((zfill -= strlen(s)) > 0) {
                        memmove(s + zfill, s, strlen(s) + 1);
                        memset(s, '0', zfill);
                    }
                    s += strlen(s);
                } else {
                    s = _sprintu(va_arg(ap, int), s, 16, 0);
                }
                break;
            case 'X':
                if(alt) {
                    *s++ = '0';
                    *s++ = 'X';
                }
                
                if(zfill) {
                    *_sprintu(va_arg(ap, int), s, 16, 1) = '\0';
                    if((zfill -= strlen(s)) > 0) {
                        memmove(s + zfill, s, strlen(s) + 1);
                        memset(s, '0', zfill);
                    }
                    s += strlen(s);
                } else {
                    s = _sprintu(va_arg(ap, int), s, 16, 1);
                }
                break;
            case 'o':
                if(alt) *s++ = '0';
                
                if(zfill) {
                    *_sprintu(va_arg(ap, int), s, 8, 0) = '\0';
                    if((zfill -= strlen(s)) > 0) {
                        memmove(s + zfill, s, strlen(s) + 1);
                        memset(s, '0', zfill);
                    }
                    s += strlen(s);
                } else {
                    s = _sprintu(va_arg(ap, int), s, 8, 0);
                }
                break;
#ifdef __FLOATS__
            case 'f': case 'F':
                _call("funzip", (float)va_arg(ap, double), &n, &lw);
                if(n < 0) {
                    n = -n;
                    *s++ = '-';
                }
                
                i = n, l = 0;
                for(int j = 0; j < lw; j++)
                    i /= 10;
                l = i;
                for(int j = 0; j < lw; j++)
                    l *= 10;
                l = n - l;
                
                s = _sprinti(i, s);
                if(lw > 0) {
                    *s++ = '.';
                    p = _sprinti(l, s);
                    memmove(s + (lw - (p - s)), s, p - s + 1);
                    memset(s, '0', lw - (p - s));
                    s = _sprinti(l, s + (lw - (p - s)));
                }
                
                break;
#endif
            case 'c':
                *s = (char)va_arg(ap, int);
                if(*s) s++;
                break;
            case 's':
                p = va_arg(ap, char *);
                s = stpcpy(s, p ? p : "(null)");
                break;
            default:
                return -1;
            }
        } else *s++ = *fmt;
        
        fmt++;
        
        if(s - orig > 2000)
            break;
    }
    
    *s = '\0';
    
    return s - orig;
}


/* vprintf */
int vprintf(char *fmt, va_list ap) {
    int n;
    static char buf[2048];
    
    n = vsprintf(buf, fmt, ap);
    if(n != -1) {
        for(char *p = buf; *p; p++) {
            putchar(*p);
        }
    }
    
    return n;
}

/* sprintf */
int sprintf(char *s, char *fmt, ...) {
    int n;
    va_list ap;
    
    va_start(ap, fmt);
    n = vsprintf(s, fmt, ap);
    va_end(ap);
    
    return n;
}

int printf(char *fmt, ...) {
    int n;
    va_list ap;
    
    va_start(ap, fmt);
    n = vprintf(fmt, ap);
    va_end(ap);
    
    return n;
}

#define puts(s)  printf("%s\n", (s))

char *gets(char *buf, int size) {
    int i = 0, c = 0;
    printf("█\b");
    while(i < (size - 1) && (c = getchar()) != '\n') {
        if(c == EOF) {
            buf[i] = '\0';
            return NULL;
        } else if(c != '\b') {
            printf("%c█\b", (buf[i++] = c));
        } else if(i > 0) {
            i--;
            printf(" \b\b█\b");
        }
    }
    printf(" \n");
    buf[i] = '\0';
    
    return buf;
}

#endif
