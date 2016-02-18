%module mylib
%{
#include "mylib.h"
%}
void   foo();
int    add(int a, int b);
int    sub(int a, int b);
void   ls();
void   help();
void   cd(char * arg);
void   filewatch(char * fn, char * name, int dur);
void   sysmgr(char * arg1, int arg2);