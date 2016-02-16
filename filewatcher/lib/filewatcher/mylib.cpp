#include "mylib.h"

void foo()
{
    cout << "FileWatcher Ruby Shell                 .. by Team AQuA \n" << endl;
}

int add(int a, int b)
{
    return a+b;
}

int sub(int a, int b)
{
    return a-b;
}

void ls(){
  cout << "EXECUTING LS" << endl;
  cout << "############" << endl;

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

void cd(){
  cout << "EXECUTING CD" << endl;
}

void filewatch(){
  cout << "EXECUTING FileWatcher!!!!" << endl;

  int pid = fork();
  if ( pid == 0 ){
    /* child */
  } else {
    /* parent */
  }
}

int main(){
  ls();
}
