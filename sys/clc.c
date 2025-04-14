#include <stdio.h>
#include <stdlib.h>

void main(int argc, char *argv[]) {
    float stack[100];
    int stackptr = 0;
    
    for(int i = 1; i < argc; i++) {
        switch(argv[i][0]) {
        /* операции */
        case '+':
            if(stackptr < 2) exit(EXIT_FAILURE);
            stackptr -= 2;
            stack[stackptr] = stack[stackptr] + stack[stackptr + 1];
            stackptr++;
            break;
        case '-':
            if(stackptr < 2) exit(EXIT_FAILURE);
            stackptr -= 2;
            stack[stackptr] = stack[stackptr] - stack[stackptr + 1];
            stackptr++;
            break;
        case '*':
            if(stackptr < 2) exit(EXIT_FAILURE);
            stackptr -= 2;
            stack[stackptr] = stack[stackptr] * stack[stackptr + 1];
            stackptr++;
            break;
        case '/':
            if(stackptr < 2) exit(EXIT_FAILURE);
            stackptr -= 2;
            stack[stackptr] = stack[stackptr] / stack[stackptr + 1];
            stackptr++;
            break;
        
        /* число */
        default:
            if(stackptr >= sizeof(stack) / sizeof(stack[0])) exit(EXIT_FAILURE);
            stack[stackptr++] = atof(argv[i]);
            break;
        }
    }
    
    if(stackptr > 0) {
        printf("%f", stack[--stackptr]);
        exit(EXIT_SUCCESS);
    } else {
        puts("usage: xtl clc CODE  (e.g. '2.0 4.0 +')");
        exit(EXIT_FAILURE);
    }
}
