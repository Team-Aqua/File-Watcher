#include "mylib.h"
#include <string>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <iostream>
#include <fstream>
#include <cstdio>
#include <sys/time.h>
#include <time.h>

void foo()
{
    help();
}

void help () {
  cout << "+----------------------------------------------------------+" << endl;
  cout << " FileWatcher Ruby Shell                     .. by Team AQuA   " << endl;
  cout << "+----------------------------------------------------------+" << endl;
  cout << " Standard Functions:                                          " << endl;
  cout << " ===================                                          " << endl;
  cout << " help                          :: list available functions  " << endl;
  cout << " ls                            :: find files in directory   " << endl;
  cout << " cd {dir}                      :: change directories        " << endl;
  cout << " getdir                        :: get current directory     " << endl;
  cout << " quit                          :: exit console              " << endl;
  cout << "+----------------------------------------------------------+" << endl;
  cout << " Advanced Functions:                                          " << endl;
  cout << " ===================                                          " << endl;
  cout << " filewatch -m {create, alter, destroy}                        " << endl;     
  cout << "           -f '{filename list}'                               " << endl;  
  cout << "           -t {time}           :: monitors file changes     " << endl;  
  cout << " sysmgr -m \"{msg}\" -t {time}   :: repeat system message   " << endl; // shifter by \" movement
  cout << "+----------------------------------------------------------+" << endl;
  cout << " Other Functions:                                             " << endl;
  cout << " ===================                                          " << endl;
  cout << " histfn {num = 0}              :: prints function history   " << endl;
  cout << " newfile -f '{filename list}'  :: creates blank files       " << endl;
  cout << " delfile -f '{filename}'       :: deletes files in dir.     " << endl;
  cout << "+----------------------------------------------------------+" << endl;
}

int add (int a, int b) {
    return a+b;
}

int sub (int a, int b) {
    return a-b;
}

time_t get_mtime(char *path) {
    // ref: http://stackoverflow.com/questions/4021479/getting-file-modification-time-on-unix-using-utime-in-c
    struct stat statbuf;
    if (stat(path, &statbuf) == -1) {
        perror(path);
        exit(1);
    }
    return statbuf.st_mtime;
}

void newfile (char * filename) {
  // ref: http://en.cppreference.com/w/cpp/io/c/remove
  bool created = static_cast<bool>(std::ofstream(filename));
  if (!created) {
    cout << "+------------------------------+" << endl;
    cout << " File " << filename << " cannot be created!" << endl;
    cout << "+------------------------------+" << endl;
  } else {
    cout << "+------------------------------+" << endl;
    cout << " File " << filename << " created." << endl;
    cout << "+------------------------------+" << endl;
  }
  return;
}

void delfile (char * filename) {
  // ref: http://en.cppreference.com/w/cpp/io/c/remove
  // removes a file or empty directory
  DIR           *dp;
  struct dirent *dirp;
  struct stat    buf;

  int duritr = 0;
  
  dp = opendir(".");

  if(dp == NULL)
    {
        perror("Cannot open directory ");
        exit(2);
    }

  while ((dirp = readdir(dp)) != NULL) {
    if (strncmp (dirp->d_name,".xxx",1) != 0){
      if (strncmp (dirp->d_name, filename, strlen(filename)) == 0) {
          std::remove(filename);
          cout << "+------------------------------+" << endl;
          cout << " File " << filename << " deleted." << endl;
          cout << "+------------------------------+" << endl;
          return;
      } 
    }
  }
  cout << "+------------------------------+" << endl;
  cout << " File " << filename << " could not be found." << endl;
  cout << "+------------------------------+" << endl;
  return;
}

void getdir () {
  // ref: http://stackoverflow.com/questions/2203159/is-there-a-c-equivalent-to-getcwd
  char buff[PATH_MAX];
  getcwd( buff, PATH_MAX );
  std::string cwd( buff );
  cout << "+------------------------+" << endl;
  cout << " Current Directory: " << endl;
  cout << "+------------------------+" << endl;
  cout << buff << endl;
  return;
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
  cout << " Duration: " << dur << "s" << endl;
  cout << "+-------------------+\n" << endl;

  int pid = fork();
  if ( pid == 0 ){
    /* child */
    // FIXME: need to have an array of names, not just one name - maybe iterate @ this level?
    if (strncmp (fn, "create", strlen(fn)) == 0 ) {
      fwcreate(name, dur);
    } else if (strncmp (fn, "alter", strlen(fn)) == 0) {
      fwalter(name, dur);
    } else if (strncmp (fn, "destroy", strlen(fn)) == 0) {
      fwdestroy(name, dur);
    } else {
      cout << "No recognised function call presented." << endl;
    }
    exit(0);
  } else {
    /* parent */
  }
}

void fwdestroy(char * name, int dur) {

  DIR           *dp;
  struct dirent *dirp;
  struct stat    buf;

  int duritr = 0;
  int durms = dur * 1000; // expression in ms
  
  struct timespec timeeval;
  timeeval.tv_sec = 0;
  timeeval.tv_nsec = 250000000; /* 250 milliseconds */

  bool found = false;
  dp = opendir(".");

  if(dp == NULL)
    {
        perror("Cannot open directory ");
        exit(2);
    }
  // things need to be fixed:
  // iterate over a group
  // check that the file is present before checking if it's destroyed
  while ((dirp = readdir(dp)) != NULL) {
    if (strncmp (dirp->d_name,".xxx",1) != 0){
      if (strncmp (dirp->d_name, name, strlen(name)) == 0) {
        found = true;
      } 
    }
  }
  if (found == false) {
    cout << "+---------------------------------------+" << endl;
    cout << " " << name << " isn't found ;; filewatch has ended" << endl;
    cout << "+---------------------------------------+" << endl;
    return;
  }

  while (duritr < durms) {
    dp = opendir(".");
    found = false;
    while ((dirp = readdir(dp)) != NULL)
    {
      if (strncmp (dirp->d_name,".xxx",1) != 0){
        if (strncmp (dirp->d_name, name, strlen(name)) == 0) {
          found = true;
        } 
      }
    }
    if (found == false) {
      cout << "+----------------------------------------+" << endl;
      cout << " File " << name << " destroyed after " << duritr + 25 << " milliseconds" << endl;
      cout << "+----------------------------------------+" << endl;
      return;
    }
    duritr = duritr + 250;
    nanosleep(&timeeval, NULL);
    // cout << duritr << endl;
  }
  cout << "+-----------------------------------+" << endl;
  cout << "File monitoring for "<< name << " complete after " << dur << " seconds." << endl;
  cout << "+-----------------------------------+" << endl;
  return;
}

void fwalter(char * name, int dur) {
  DIR           *dp;
  struct dirent *dirp;
  struct stat    buf;
  char* filepath;
  time_t oldModifiedTime;
  time_t newModifiedTime;
  char buff[20];
  
  int durms = dur * 1000; // time expression in microseconds
  int duritr = 0;

  struct timespec timeeval;
  timeeval.tv_sec = 0;
  timeeval.tv_nsec = 250000000; /* 25 milliseconds */

  bool found = false;
  dp = opendir(".");
 
  if(dp == NULL) {
    perror("Cannot open directory ");
    exit(2);
  }

	// check that the file is present before checking if it's altered
  while ((dirp = readdir(dp)) != NULL) {
    if (strncmp (dirp->d_name,".xxx",1) != 0){
      if (strncmp (dirp->d_name, name, strlen(name)) == 0) {
        found = true;
        strcpy(filepath, "./");
        strcat(filepath, dirp->d_name);
        oldModifiedTime = get_mtime(filepath);
      }
    }
  }
  if (found == false) {
    cout << "+---------------------------------------+" << endl;
    cout << " " << name << " isn't found ;; filewatch has ended" << endl;
    cout << "+---------------------------------------+" << endl;
    return;
  }

  while (duritr < durms) {
    while ((dirp = readdir(dp)) != NULL)
    {
      if (strncmp (dirp->d_name,".xxx",1) != 0){
        if (strncmp (dirp->d_name, name, strlen(name)) == 0) {
          found = true;
          oldModifiedTime = get_mtime(filepath);
          if (difftime(newModifiedTime, oldModifiedTime) != 0) {
            cout << "+-----------------------------------+" << endl;
            cout << " File " << name << " has been changed after " << duritr + 25 << " milliseconds - altered" <<     endl;
            cout << "+-----------------------------------+" << endl;
            return;
          }
        } 
      }
    }

    if (found == false) {
      cout << "+-----------------------------------+" << endl;
      cout << " File " << name << " not found after " << duritr + 1 << " seconds - destroyed" << endl;
      cout << "+-----------------------------------+" << endl;
      return;
    }
    duritr = duritr + 250;
    nanosleep(&timeeval, NULL);
  }
  cout << "+-----------------------------------+" << endl;
  cout << "File monitoring for "<< name << " complete after " << dur << " seconds." << endl;
  cout << "+-----------------------------------+" << endl;
  return;
}

void fwcreate(char * name, int dur) {

  DIR           *dp;
  struct dirent *dirp;
  struct stat    buf;

  int duritr = 0;
  int durms = dur * 1000;

  struct timespec timeeval;
  timeeval.tv_sec = 0;
  timeeval.tv_nsec = 250000000; /* 250 milliseconds */

  
  dp = opendir(".");

  if(dp == NULL)
    {
        perror("Cannot open directory ");
        exit(2);
    }

  while ((dirp = readdir(dp)) != NULL) {
    if (strncmp (dirp->d_name,".xxx",1) != 0){
      if (strncmp (dirp->d_name, name, strlen(name)) == 0) {
        // if file is found, then return 'true'.
        // can test by running, then making a file @ location
        cout << "+----------------------------------------------+" << endl;
        cout << " " << name << " is already created ;; filewatch has ended" << endl;
        cout << "+----------------------------------------------+" << endl;
        return;
      } 
    }
  }

  while (duritr < durms) {
    while ((dirp = readdir(dp)) != NULL)
    {
      if (strncmp (dirp->d_name,".xxx",1) != 0){
        if (strncmp (dirp->d_name, name, strlen(name)) == 0) {
          // if file is found, then return 'true'.
          // can test by running, then making a file @ location
          cout << "+----------------------------------------+" << endl;
          cout << " File " << name << " created after " << duritr + 25 << " milliseconds" << endl;
          cout << "+----------------------------------------+" << endl;
          return;
        } 
      }
    }
    duritr = duritr + 250;
    nanosleep(&timeeval, NULL);
  }
  cout << "+----------------------------------------------+" << endl;
  cout << "File monitoring for "<< name << " complete after " << dur << " seconds." << endl;
  cout << "+----------------------------------------------+" << endl;
  return;
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
