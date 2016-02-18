#include "mylib.h"
#include <string>
#include <unistd.h>

void foo()
{
    help();
}

void help () {
  cout << "+----------------------------------------------------------+" << endl;
  cout << " FileWatcher Ruby Shell                     .. by Team AQuA " << endl;
  cout << "+----------------------------------------------------------+" << endl;
  cout << " Standard Functions:                                        " << endl;
  cout << " help :: list available functions                           " << endl;
  cout << " ls :: find files in current directory                      " << endl;
  cout << " cd {dir} :: change directories                             " << endl;
  cout << " quit :: exit console                                       " << endl;
  cout << "+----------------------------------------------------------+" << endl;
  cout << " Advanced Functions:                                        " << endl;
  cout << " filewatch -f {function} -n {name} -t {time} ::             " << endl;
  cout << " sysmgr -m {msg} -t {time} :: repeat system message         " << endl;
  cout << "+----------------------------------------------------------+" << endl;
}

int add (int a, int b) {
    return a+b;
}

int sub (int a, int b) {
    return a-b;
}

void ls () {
  cout << "+------------+" << endl;
  cout << " EXECUTING LS" << endl;
  cout << "+------------+\n" << endl;

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

void cd (char * arg) {
  cout << "+------------+" << endl;
  cout << " EXECUTING CD" << endl;
  cout << " Input: " << arg << endl;
  cout << "+------------+" << endl;
  if ( chdir(arg) >= 0) { // good chdir
    cout << "Entered successfully.\n" << endl;
    return;
  }
  cout << "Unable to enter.\n" << endl;
}

void filewatch(char * fn, char * name, int dur) {
  cout << "+-------------------+" << endl;
  cout << " EXECUTING FILEWATCH" << endl;
  cout << " Function: " << fn << endl;
  cout << " Filename: " << name << endl;
  cout << " Duration: " << dur << endl;
  cout << "+-------------------+\n" << endl;

  int pid = fork();
  if ( pid == 0 ){
    /* child */
    exit(0);
  } else {
    /* parent */
  }
}

void sysmgr(char * arg1, int arg2) {
  cout << "+-----------------+" << endl;
  cout << " EXECUTING SYSMGR" << endl;
  cout << " Phrase: " << arg1 << endl;
  cout << " Duration: " << arg2 << endl;
  cout << "+-----------------+\n" << endl;
  int pid = fork();
  if ( pid == 0 ){
    sleep(arg2); // currently doesn't send to another child proc.
    cout << "\n+-----------------+" << endl;
    cout << " RETURNING SYSMGR" << endl;
    cout << " " << arg1 << endl;
    cout << "+-----------------+\n" << endl;
    exit(0);
  } else {
    return;
  }
}

int main() {
  ls();
}
