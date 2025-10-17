#include <stdio.h>

void main(int argc, char **argv) {
    printf("%d\n", *__extern_label("lastReturnCode"));
}

