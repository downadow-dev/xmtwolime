
/* порт ассемблера mxm2c-as */


#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <file.h>

char __ALLOC_mem[200000];
char *__ALLOC_ptr;
#define ALLOC(n)   (__ALLOC_ptr -= (n))

struct as_entry {
    char name[100];
    char value[100];
    struct as_entry *next;
};

struct as_entry *labels;
struct as_entry *refs;

void preprocess(char *);

void main(int argc, char **argv) {
    if(argc < 3) {
        printf("usage: xtl asm IN_FILE OUT_FILE\n");
        exit(EXIT_FAILURE);
    }
    
    __ALLOC_ptr = __ALLOC_mem + sizeof(__ALLOC_mem);
    
    fd_t f;
    if(!(f = creat(argv[2]))) {
        printf("file creating/opening error\n");
        exit(EXIT_FAILURE);
    }
    char *app = filedata(f);
    memset(app, '\0', FILESIZE);
    
    labels = ALLOC(sizeof(struct as_entry));
    labels->next = NULL;
    refs = ALLOC(sizeof(struct as_entry));
    refs->next = NULL;
    
    if(!(f = file(argv[1]))) {
        printf("file opening error\n");
        exit(EXIT_FAILURE);
    }
    char data[FILESIZE];
    strcpy(data, filedata(f));
    
    char buf[256];
    char *fp = data;
    // работа для создания меток и ссылок
    for(int i = 0; ;) {
        char *tmpp = strsep(&fp, "\n");
        if(!tmpp) break;
        strcpy(buf, tmpp);
        
        char *s = buf;
        
        preprocess(s);
        
        if(*s == '\0')
            continue;
        
        char *instr = s;
        
        s = strchr(s, ' ');
        if(s) *s++ = '\0';
        
        /* заполнения для соответствия двоичному коду */
        if(strcmp(instr, "nop") == 0  || strcmp(instr, "off") == 0  ||
           strcmp(instr, "updd") == 0 || strcmp(instr, "end") == 0  ||
           strcmp(instr, "vrst") == 0 || strcmp(instr, "trst") == 0 ||
           strcmp(instr, ".byte") == 0) i++;
        else if(strcmp(instr, "if") == 0 && strstr(s, "&&")) i += 6;
        else if(strcmp(instr, "add") == 0 ||
                strcmp(instr, "lshift") == 0 ||
                strcmp(instr, "rshift") == 0 ||
                strcmp(instr, "xor") == 0 ||
                strcmp(instr, "or") == 0 ||
                strcmp(instr, "and") == 0 ||
                strcmp(instr, "sub") == 0 ||
                strcmp(instr, "exp") == 0 ||
                strcmp(instr, "mod") == 0 ||
                strcmp(instr, "mul") == 0 ||
                strcmp(instr, "div") == 0 ||
                strcmp(instr, "if") == 0) i += 4;
        else if(strcmp(instr, "mov") == 0 ||
                strcmp(instr, "ld") == 0 ||
                strcmp(instr, "sel") == 0) i += 3;
        else if(strcmp(instr, "slp") == 0 ||
                strcmp(instr, "lslp") == 0 ||
                strcmp(instr, "inc") == 0 ||
                strcmp(instr, "dec") == 0 ||
                strcmp(instr, "tnp") == 0 ||
                strcmp(instr, "th1") == 0 ||
                strcmp(instr, "th2") == 0 ||
                strcmp(instr, "th3") == 0 ||
                strcmp(instr, "time") == 0 ||
                strcmp(instr, "jmp") == 0) i += 2;
        else if(strcmp(instr, "vld") == 0) {
            *strchr(s, ' ') = '\0';
            i += (strlen(s) < 3) ? 14 : 6;
        }
        else if(strcmp(instr, "ild") == 0) {
            *strchr(s, ' ') = '\0';
            i += (strlen(s) < 3) ? 16 : 8;
        }
        else if(strcmp(instr, "vsv") == 0 || strcmp(instr, "vsvan") == 0) i += (strlen(strchr(s, ' ') + 1) < 3) ? 14 : 6;
        else if(strcmp(instr, "isv") == 0) i += (strlen(strchr(s, ' ') + 1) < 3) ? 16 : 8;
        else if(strcmp(instr, "vstr") == 0) i += 6 + ((s + strlen(s) - 1) - strchr(s, '"') - 1);
        else if(strcmp(instr, "mov2") == 0 || strcmp(instr, "mov3") == 0) i += 8;
        else if(strcmp(instr, ".goto") == 0) i += strtol(s, NULL, 0);
        else if(strcmp(instr, ".orig") == 0) i = strtol(s, NULL, 0);
        // создание метки
        else if(instr[strlen(instr) - 1] == ':') {
            instr[strlen(instr) - 1] = '\0';
            struct as_entry *ent = labels;
            for(;;) {
                if(ent->next) {
                    ent = ent->next;
                    continue;
                }
                ent->next = ALLOC(sizeof(struct as_entry));
                strcpy(ent->next->name, instr);
                char tmpbuf[8];
                sprintf(ent->next->value, "0000000");
                sprintf(tmpbuf, "%d", app + i);
                sprintf(ent->next->value + (7 - strlen(tmpbuf)), "%s", tmpbuf);
                ent->next->next = NULL;
                
                printf("%s:%d\n", instr, i);
                
                break;
            }
        }
        // создание именованной константы
        else if(strcmp(instr, ".def") == 0) {
            char *name = s + 1;
            *strchr(name, '%') = '\0';
            char *value = name + strlen(name) + 3;
            *strchr(value, '"') = '\0';
            struct as_entry *ent = refs;
            for(;;) {
                if(ent->next) {
                    ent = ent->next;
                    continue;
                }
                ent->next = ALLOC(sizeof(struct as_entry));
                strcpy(ent->next->name, name);
                strcpy(ent->next->value, value);
                ent->next->next = NULL;
                break;
            }
        }
    }
    
    if(!(f = file(argv[1]))) {
        printf("file opening error\n");
        exit(EXIT_FAILURE);
    }
    strcpy(data, filedata(f));
    
    fp = data;
    // перевод программы в машинный код
    for(int i = 0; ;) {
        char *tmpp = strsep(&fp, "\n");
        if(!tmpp) break;
        strcpy(buf, tmpp);
        
        char *s = buf;
        
        preprocess(s);
        
        if(*s == '\0')
            continue;
        
        char *instr = s;
        
        s = strchr(s, ' ');
        if(s) *s++ = '\0';
        
        if(strcmp(instr, "nop") == 0) app[i++] = -1;
        else if(strcmp(instr, "add") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -2;
        }
        else if(strcmp(instr, "lshift") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -38;
        }
        else if(strcmp(instr, "rshift") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -39;
        }
        else if(strcmp(instr, "xor") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -40;
        }
        else if(strcmp(instr, "or") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -41;
        }
        else if(strcmp(instr, "and") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -42;
        }
        else if(strcmp(instr, "sub") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -3;
        }
        else if(strcmp(instr, "mov") == 0) {
            int rdst = atoi(strsep(&s, " "));
            int src = atoi(strsep(&s, " "));
            
            app[i++] = src;
            app[i++] = rdst;
            app[i++] = -4;
        }
        else if(strcmp(instr, "ild") == 0) {
            *strchr(s, ' ') = '\0';
            if(strlen(s) > 3) {
                for(int j = 6; j > 1; j--)
                    app[i++] = s[j] - '0';
                app[i++] = (s[0] - '0') * 10 + (s[1] - '0');
                app[i++] = atoi(s + strlen(s) + 1);
                app[i++] = -5;
            } else {
                char tmp[8];
                app[i++] = atoi(s);
                char tmpbuf[8];
                sprintf(tmp, "0000000");
                sprintf(tmpbuf, "%d", i + 7);
                sprintf(tmp + (7 - strlen(tmpbuf)), "%s", tmpbuf);
                for(int j = 6; j > 1; j--) {
                    app[i++] = tmp[j] - '0';
                }
                app[i++] = (tmp[0] - '0') * 10 + (tmp[1] - '0');
                app[i++] = -8;
                for(int j = 0; j < 6; j++)
                    app[i++] = 0;
                app[i++] = atoi(s + strlen(s) + 1);
                app[i++] = -5;
            }
        }
        else if(strcmp(instr, "vld") == 0) {
            *strchr(s, ' ') = '\0';
            if(strlen(s) > 3) {
                for(int j = 3; j >= 0; j--)
                    app[i++] = s[j] - '0';
                app[i++] = atoi(s + strlen(s) + 1);
                app[i++] = -6;
            } else {
                char tmp[8];
                app[i++] = atoi(s);
                char tmpbuf[8];
                sprintf(tmp, "0000000");
                sprintf(tmpbuf, "%d", i + 7);
                sprintf(tmp + (7 - strlen(tmpbuf)), "%s", tmpbuf);
                for(int j = 6; j > 1; j--) {
                    app[i++] = tmp[j] - '0';
                }
                app[i++] = (tmp[0] - '0') * 10 + (tmp[1] - '0');
                app[i++] = -8;
                for(int j = 0; j < 4; j++)
                    app[i++] = 0;
                app[i++] = atoi(s + strlen(s) + 1);
                app[i++] = -6;
            }
        }
        else if(strcmp(instr, "isv") == 0) {
            char *last = strchr(s, ' ') + 1;
            *(last - 1) = '\0';
            if(strlen(last) > 3) {
                app[i++] = atoi(s);
                for(int j = 6; j > 1; j--)
                    app[i++] = last[j] - '0';
                app[i++] = (last[0] - '0') * 10 + (last[1] - '0');
                app[i++] = -8;
            } else {
                char tmp[8];
                app[i++] = atoi(last);
                char tmpbuf[8];
                sprintf(tmp, "0000000");
                sprintf(tmpbuf, "%d", i + 8);
                sprintf(tmp + (7 - strlen(tmpbuf)), "%s", tmpbuf);
                for(int j = 6; j > 1; j--) {
                    app[i++] = tmp[j] - '0';
                }
                app[i++] = (tmp[0] - '0') * 10 + (tmp[1] - '0');
                app[i++] = -8;
                app[i++] = atoi(s);
                for(int j = 0; j < 6; j++)
                    app[i++] = 0;
                app[i++] = -8;
            }
        }
        else if(strcmp(instr, "vsv") == 0) {
            char *last = strchr(s, ' ') + 1;
            *(last - 1) = '\0';
            if(strlen(last) > 3) {
                app[i++] = atoi(s);
                for(int j = 3; j >= 0; j--)
                    app[i++] = last[j] - '0';
                app[i++] = -9;
            } else {
                char tmp[8];
                app[i++] = atoi(last);
                char tmpbuf[8];
                sprintf(tmp, "0000000");
                sprintf(tmpbuf, "%d", i + 8);
                sprintf(tmp + (7 - strlen(tmpbuf)), "%s", tmpbuf);
                for(int j = 6; j > 1; j--) {
                    app[i++] = tmp[j] - '0';
                }
                app[i++] = (tmp[0] - '0') * 10 + (tmp[1] - '0');
                app[i++] = -8;
                app[i++] = atoi(s);
                for(int j = 0; j < 4; j++)
                    app[i++] = 0;
                app[i++] = -9;
            }
        }
        else if(strcmp(instr, "vsvan") == 0) {
            char *last = strchr(s, ' ') + 1;
            *(last - 1) = '\0';
            if(strlen(last) > 3) {
                app[i++] = atoi(s);
                for(int j = 3; j >= 0; j--)
                    app[i++] = last[j] - '0';
                app[i++] = -36;
            } else {
                char tmp[8];
                app[i++] = atoi(last);
                char tmpbuf[8];
                sprintf(tmp, "0000000");
                sprintf(tmpbuf, "%d", i + 8);
                sprintf(tmp + (7 - strlen(tmpbuf)), "%s", tmpbuf);
                for(int j = 6; j > 1; j--) {
                    app[i++] = tmp[j] - '0';
                }
                app[i++] = (tmp[0] - '0') * 10 + (tmp[1] - '0');
                app[i++] = -8;
                app[i++] = atoi(s);
                for(int j = 0; j < 4; j++)
                    app[i++] = 0;
                app[i++] = -36;
            }
        }
        else if(strcmp(instr, "ld") == 0) {
            app[i++] = atoi(strsep(&s, " "));
            app[i++] = atoi(strsep(&s, " "));
            app[i++] = -7;
        }
        else if(strcmp(instr, "slp") == 0) {
            app[i++] = atoi(s);
            app[i++] = -10;
        }
        else if(strcmp(instr, "if") == 0) {
            if(strstr(s, "&&")) {
                int op1 = atoi(strsep(&s, " "));
                strsep(&s, " ");
                int op2 = atoi(strsep(&s, " "));
                strsep(&s, " ");
                int op3 = atoi(strsep(&s, " "));
                strsep(&s, " ");
                int op4 = atoi(strsep(&s, " "));
                int rdst = atoi(strsep(&s, " "));
                
                app[i++] = rdst;
                app[i++] = op4;
                app[i++] = op3;
                app[i++] = op2;
                app[i++] = op1;
                app[i++] = -37;
            } else {
                int op1 = atoi(strsep(&s, " "));
                char type = *strsep(&s, " ");
                int op2 = atoi(strsep(&s, " "));
                int rdst = atoi(strsep(&s, " "));
                
                app[i++] = rdst;
                app[i++] = op2;
                app[i++] = op1;
                
                switch(type) {
                    case '=': app[i++] = -11; break;
                    case '!': app[i++] = -12; break;
                    case '>': app[i++] = -13; break;
                    case '<': app[i++] = -14; break;
                    default : app[i++] = 0;   break;
                }
            }
        }
        else if(strcmp(instr, "updd") == 0) app[i++] = -15;
        else if(strcmp(instr, "off") == 0)  app[i++] = -16;
        else if(strcmp(instr, "vrst") == 0) app[i++] = -17;
        else if(strcmp(instr, "trst") == 0) app[i++] = -44;
        else if(strcmp(instr, "jmp") == 0) {
            app[i++] = atoi(s);
            app[i++] = -18;
        }
        else if(strcmp(instr, "end") == 0)  app[i++] = -19;
        else if(strcmp(instr, "sel") == 0) {
            app[i++] = atoi(strsep(&s, " "));
            app[i++] = atoi(strsep(&s, " "));
            app[i++] = -20;
        }
        else if(strcmp(instr, "mul") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -21;
        }
        else if(strcmp(instr, "div") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -22;
        }
        else if(strcmp(instr, "lslp") == 0) {
            app[i++] = atoi(s);
            app[i++] = -23;
        }
        else if(strcmp(instr, "vstr") == 0) {
            char *string = strchr(s, ' ');
            *string++ = '\0';
            *string++ = '\0';
            *strchr(string, '"') = '\0';
            for(int j = strlen(string) - 1; j >= 0; j--)
                app[i++] = string[j];
            app[i++] = strlen(string);
            for(int j = 3; j >= 0; j--)
                app[i++] = s[j] - '0';
            app[i++] = -25;
        }
        else if(strcmp(instr, "inc") == 0) {
            app[i++] = atoi(s);
            app[i++] = -26;
        }
        else if(strcmp(instr, "dec") == 0) {
            app[i++] = atoi(s);
            app[i++] = -27;
        }
        else if(strcmp(instr, "tnp") == 0) {
            app[i++] = atoi(s);
            app[i++] = -28;
        }
        else if(strcmp(instr, "mod") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -29;
        }
        else if(strcmp(instr, "exp") == 0) {
            int r1 = atoi(strsep(&s, " "));
            int r2 = atoi(strsep(&s, " "));
            int rdst = atoi(strsep(&s, " "));
            
            app[i++] = r2;
            app[i++] = r1;
            app[i++] = rdst;
            app[i++] = -30;
        }
        else if(strcmp(instr, "th1") == 0) {
            app[i++] = atoi(s);
            app[i++] = -32;
        }
        else if(strcmp(instr, "th2") == 0) {
            app[i++] = atoi(s);
            app[i++] = -33;
        }
        else if(strcmp(instr, "th3") == 0) {
            app[i++] = atoi(s);
            app[i++] = -34;
        }
        else if(strcmp(instr, "time") == 0) {
            app[i++] = atoi(s);
            app[i++] = -43;
        }
        else if(strcmp(instr, "mov2") == 0) {
            char *last = strchr(s, ' ') + 1;
            *(last - 1) = '\0';
            for(int j = 6; j > 1; j--)
                app[i++] = last[j] - '0';
            app[i++] = (last[0] - '0') * 10 + (last[1] - '0');
            app[i++] = atoi(s);
            app[i++] = -31;
        }
        else if(strcmp(instr, "mov3") == 0) {
            int rdst = atoi(strsep(&s, " "));
            int op1 = atoi(strsep(&s, " "));
            int op2 = atoi(strsep(&s, " "));
            int op3 = atoi(strsep(&s, " "));
            int op4 = atoi(strsep(&s, " "));
            int op5 = atoi(strsep(&s, " "));
            int op6 = atoi(strsep(&s, " "));
            
            app[i++] = op6;
            app[i++] = op5;
            app[i++] = op4;
            app[i++] = op3;
            app[i++] = op2;
            app[i++] = op1;
            app[i++] = rdst;
            app[i++] = -35;
        }
        
        
        else if(strcmp(instr, ".ascii") == 0) {
            char *p = strchr(s, ' ');
            *p++ = '\0';
            *p++ = '\0';
            *strchr(p, '"') = '\0';
            int j = atoi(s);
            while(*p) app[j++] = *p++;
            app[j] = '\0';
        }
        else if(strcmp(instr, ".goto") == 0) i += atoi(s);
        else if(strcmp(instr, ".orig") == 0) {
            int new = atoi(s);
            if(i > new) printf(".orig: warning: possible overflow\n");
            i = new;
        }
        else if(strcmp(instr, ".byte") == 0) app[i++] = atoi(s);
    }
}

// преобразовать в s_buf имена меток и именованных констант в их значения и др.
void preprocess(char *s_buf) {
    while(isspace(*s_buf))
        memmove(s_buf, s_buf + 1, strlen(s_buf + 1) + 1);
    
    for(int i = strlen(s_buf) - 1; i > 0; i--) {
        if(isspace(s_buf[i]))
            s_buf[i] = '\0';
        else
            break;
    }
    
    if(*s_buf && s_buf[strlen(s_buf) - 1] == ':')
        return;
    
    int lrblock = 0;
    
    for(char *p = s_buf; *p; p++) {
        if((*p == '<' || *p == '%') && !isspace(p[1]) && !lrblock)
            lrblock = 1;
        else if((*p == '>' || *p == '%') && !isspace(p[-1]) && lrblock)
            lrblock = 0;
        
        if(!lrblock) {
            if(isupper(*p))
                *p = tolower(*p);
            else if(*p == ',')
                *p = ' ';
            else if(p[0] == '\'' && p[1] && p[2] == '\'') {
                char tmp[4];
                sprintf(tmp, "%d", (int)p[1]);
                memmove(p + strlen(tmp), p + 3, strlen(p + 3) + 1);
                memcpy(p, tmp, strlen(tmp));
            }
            else if(*p == '"')
                break;
        }
    }
    
    lrblock = 0;
    
    for(char *p = s_buf; *p;) {
        if((*p == '<' || *p == '%') && !isspace(p[1]) && !lrblock)
            lrblock = 1;
        else if((*p == '>' || *p == '%') && !isspace(p[-1]) && lrblock)
            lrblock = 0;
        
        if(!lrblock) {
            if(isspace(p[0]) && isspace(p[1]))
                memmove(p, p + 1, strlen(p + 1) + 1);
            else if(p[0] == 'u' && p[1] == 'r')
                memmove(p, p + 2, strlen(p + 2) + 1);
            else if(*p == '"')
                break;
            else p++;
        } else p++;
    }
    
    for(char *p = s_buf; *p; p++) {
        if(*p == '<') {
            char *endp;
            for(endp = p + 1; *endp; endp++) {
                if(*endp == '>') {
                    char buf[100];
                    memset(buf, '\0', sizeof(buf));
                    memcpy(buf, p + 1, (endp - 1) - p);
                    
                    struct as_entry *ent = labels;
                    while(ent = ent->next) {
                        if(strcmp(ent->name, buf) == 0) {
                            memmove(p + strlen(ent->value), endp + 1, strlen(endp) + 1);
                            memcpy(p, ent->value, strlen(ent->value));
                            break;
                        }
                    }
                    
                    break;
                }
            }
        } else if(*p == '%' && !(s_buf[0] == '.' && s_buf[1] == 'd' && s_buf[2] == 'e' && s_buf[3] == 'f')) {
            char *endp;
            for(endp = p + 1; *endp; endp++) {
                if(*endp == '%') {
                    char buf[100];
                    memset(buf, '\0', sizeof(buf));
                    memcpy(buf, p + 1, (endp - 1) - p);
                    
                    struct as_entry *ent = refs;
                    while(ent = ent->next) {
                        if(strcmp(ent->name, buf) == 0) {
                            memmove(p + strlen(ent->value), endp + 1, strlen(endp) + 1);
                            memcpy(p, ent->value, strlen(ent->value));
                            preprocess(s_buf);
                            break;
                        }
                    }
                    
                    break;
                }
            }
        }
    }
}
