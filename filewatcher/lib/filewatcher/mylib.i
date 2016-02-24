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
void filewatch(char * fn, char * name, int dur, char * commandName, char * action);
void   sysmgr(char * arg1, int arg2);
void   getdir();
int   fwcreate(char * name, int dur);
int   fwalter(char * name, int dur);
int   fwdestroy(char * name, int dur);
void   newfile (char * filename);
void   delfile (char * filename);
void   strprint(char * statement);

