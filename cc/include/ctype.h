/* --Menshikov S. */

#ifndef _CTYPE_H
#define _CTYPE_H   1

int islower(int c)  { return (c >= 'a' && c <= 'z');      }
int isupper(int c)  { return (c >= 'A' && c <= 'Z');      }
int isdigit(int c)  { return (c >= '0' && c <= '9');      }
int isalpha(int c)  { return (islower(c) || isupper(c));  }
int isalnum(int c)  { return (isalpha(c) || isdigit(c));  }
int isxdigit(int c) { return (isdigit(c) || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F')); }
int iscntrl(int c)  { return (c < 32 || c == 127);        }
int isblank(int c)  { return (c == ' ' || c == '\t');     }
int isprint(int c)  { return (c > 32 && c < 127);         }
int isgraph(int c)  { return (c >= 32 && c < 127);        }
int isspace(int c)  { return (c == ' ' || (c >= '\t' && c <= '\r')); }
int isascii(int c)  { return (c >= 0 && c <= 127);        }
int ispunct(int c)  { return (isprint(c) && !isalnum(c)); }

int tolower(int c)  { return (isupper(c) ? c + 32 : c);   }
int toupper(int c)  { return (islower(c) ? c - 32 : c);   }

#endif
