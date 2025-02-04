/* напечатать информацию о системе */

#include <file.h>
#include <limits.h>

void main(int argc, char *argv[]) {
    printf("\
CHAR_BIT     %d\n\
MAX_PATH     %d\n\
FILESIZE     %d\n\
MAX_FILES    %d\n\
\n\
Current UID  %d\n\
", CHAR_BIT, MAX_PATH, FILESIZE, MAX_FILES, getuid());
}

