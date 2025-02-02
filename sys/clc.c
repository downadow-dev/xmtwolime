#include <stdio.h>
#include <stdlib.h>
#include <___get_args.h>

int stack[100];
int stackptr = 0;

void main(int argc, char *argv[]) {
    int base = 10;
    
    if(argc > 1 && argv[1][0] == '-' && argv[1][1] == 'x') {
        base = 16;
        argv++;
        argc--;
    } else if(argc > 1 && argv[1][0] == '-' && argv[1][1] == 'o') {
        base = 8;
        argv++;
        argc--;
    }
    
    memset(stack, '\0', sizeof(stack));
    
    for(int i = 1; i < argc; i++) {
        /* защита от переполнения */
        if(stackptr < 0 || stackptr >= sizeof(stack))
            exit(EXIT_FAILURE);
        
        switch(argv[i][0]) {
            /* операции */
            case '+':
                stackptr -= 2;
                stack[stackptr] = stack[stackptr] + stack[stackptr + 1];
                stackptr++;
                break;
            case '-':
                stackptr -= 2;
                stack[stackptr] = stack[stackptr] - stack[stackptr + 1];
                stackptr++;
                break;
            case '*':
                stackptr -= 2;
                stack[stackptr] = stack[stackptr] * stack[stackptr + 1];
                stackptr++;
                break;
            case '/':
                stackptr -= 2;
                stack[stackptr] = stack[stackptr] / stack[stackptr + 1];
                stackptr++;
                break;
            case '%':
                stackptr -= 2;
                stack[stackptr] = stack[stackptr] % stack[stackptr + 1];
                stackptr++;
                break;
            
            case '?':
                stack[stackptr++] = sel(10);
                break;
            
            /* число */
            default:
                stack[stackptr++] = atoi(argv[i]);
        }
    }
    
    if(stackptr > 0) {
        printf(base == 10 ? "%d\n" : (base == 16 ? "%X\n" : "%o\n"), stack[--stackptr]);
        exit(EXIT_SUCCESS);
    } else {
        puts("usage: xtl clc [-{x|o}] <code>  (e.g. '2 4 +')");
        exit(EXIT_FAILURE);
    }
}
