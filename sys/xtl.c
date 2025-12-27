#include <stdio.h>
#include <xmtwolime.h>

void main(int argc, char **argv) {
    clear_output();
    
    setcolor(GREEN);
    printf("\n\n\n\n\n\n");
    printf("  .  .  .  .  ...  .          .   ..   .     ...  .  .  ...\n"
           "   \\/   |\\/|   |    \\   /\\   /   /  \\  |      |   |\\/|  |..\n"
           "   /\\   |  |   |     \\ /  \\ /    \\  /  |      |   |  |  |\n"
           "  '  '  '  '   '      '    '      ''   ''''  '''  '  '  '''\n");
    setcolor(YELLOW);
    printf("\n");
    
    char stars[] = "   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *";
    int length = strlen(stars);
    char tmp;
    
    for(int i = 0; i < 300; i++, ssleep(5)) {
        tmp = stars[0];
        for(int j = 1; j < length; j++)
            stars[j - 1] = stars[j];
        stars[length - 1] = tmp;
        
        printf("\r %s", stars);
    }
    
    setcolor(WHITE);
    
    printf("\n\n\n");
    printf("Build date: %s", __DATE__);
}

