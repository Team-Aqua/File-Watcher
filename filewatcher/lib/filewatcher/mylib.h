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

using namespace std;

void foo();
int  add(int a, int b);
int  sub(int a, int b);
void ls();
void cd();
void filewatch();