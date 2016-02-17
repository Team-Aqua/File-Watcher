%module mylib
%{
#include "mylib.h"
%}
void   foo();
int    add(int a, int b);
int    sub(int a, int b);
void   ls();
void   help();
void   cd();
void   filewatch();