/* вывести список файлов */

#include <file.h>

int main(void) {
    char buf[10000];
    puts(list_files(buf, sizeof buf));
}

