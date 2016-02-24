#include <iostream>

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <fcntl.h>
#include <errno.h>
#include <poll.h>
#include <string>
#include <ruby.h>
#include <iostream>
#include <fstream>
#include <cstdio>

using namespace std;

void foo();
int  add(int a, int b);
int  sub(int a, int b);
void help();
void ls();
void cd(char * arg);
void filewatch(char * fn, char * name, int dur, char * commandName, char * action);
void sysmgr(char * arg1, int arg2);
void getdir();
int fwcreate(char * name, int dur);
int fwalter(char * name, int dur);
int fwdestroy(char * name, int dur);
void newfile (char * filename);
void delfile (char * filename);
void strprint(char * statement);
