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

using namespace std;

void foo();
int  add(int a, int b);
int  sub(int a, int b);
void help();
void ls();
void cd(char * arg);
void filewatch(char * fn, char * name, int dur);
void sysmgr(char * arg1, int arg2);