#include "mylib.h"

void foo()
{
    cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl;
    cout << "FileWatcher Ruby Shell                 .. by Team AQuA " << endl;
    cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl;
    cout << "Available Functions:                                   " << endl;
    cout << "help :: list available functions                       " << endl;
    cout << "ls :: find files in current directory                  " << endl;
    cout << "cd :: change directories                               " << endl;
    cout << "filewatch :: watch files                               " << endl;
    cout << "sysmgr :: repeat system message                        " << endl;
    cout << "quit :: exit console                                   " << endl;
    cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl;
}

void help () {
  cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl;
  cout << "FileWatcher Ruby Shell                 .. by Team AQuA " << endl;
  cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl;
  cout << "Available Functions:                                   " << endl;
  cout << "help :: list available functions                       " << endl;
  cout << "ls :: find files in current directory                  " << endl;
  cout << "cd :: change directories                               " << endl;
  cout << "filewatch :: watch files                               " << endl;
  cout << "sysmgr :: repeat system message                        " << endl;
  cout << "quit :: exit console                                   " << endl;
  cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl;
}

int add (int a, int b) {
    return a+b;
}

int sub (int a, int b) {
    return a-b;
}

void ls () {
  cout << "~~~~~~~~~~~~" << endl;
  cout << "EXECUTING LS" << endl;
  cout << "~~~~~~~~~~~~\n" << endl;

  DIR           *dp;
  struct dirent *dirp;
  struct stat    buf;
  
  dp = opendir(".");

  if(dp == NULL)
    {
        perror("Cannot open directory ");
        exit(2);
    }

  while ((dirp = readdir(dp)) != NULL)
  {
    if (strncmp (dirp->d_name,".xxx",1) != 0){
      printf("%s\n", dirp->d_name);
    }
  }
}

void cd () {
  cout << "~~~~~~~~~~~~" << endl;
  cout << "EXECUTING CD" << endl;
  cout << "~~~~~~~~~~~~\n" << endl;

}

void filewatch() {
  cout << "EXECUTING FileWatcher!!!!" << endl;

  int pid = fork();
  if ( pid == 0 ){
    /* child */
    exit(0);
  } else {
    /* parent */
  }
}

void sysmgr() {

}

int main() {
  ls();
}
