/* вывести список файлов */

#include <file.h>

int main(void) {
    char *name;
    freset();
    while(name = fnext()) {
        printf("%s ", name);
    }
}

