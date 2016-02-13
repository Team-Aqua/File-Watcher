### Shells
[Ruby Shell](http://ruby-doc.org/stdlib-2.0.0/libdoc/shell/rdoc/Shell.html)

### Commands
Generic functions for shells:
  
    mkdir (directory_name)                :: make the directory / make the folder
    cd (directory_name)                   :: enter a directory // .. returns to the upper folder
    ls ()                                 :: returns list of files in folder
    getdir ()                             :: returns directory_name
    syspath ()                            :: returns system path ( == echo $PATH )
    echo (resp)                           :: prints system response (string, path, etc.)
    history (number = 5)                  :: returns list of file history locations, default last 5
    histfn (number = 5)                   :: returns list of functions called for directory, default last 5   

Job-specific functionality:

    get_jobs ()                           :: returns list of jobs currently run by system (incl. filewatcher)
    kill (signal, job)                    :: kills job, returns confirmation by boolean / string

System messager functionality:
  
    sysmgr (string, duration)             :: returns string after a certain duration

File watcher functionality:

    filewatch (function, name, dur)      :: monitors for operation completed on file system for duration
    filewatch_new (filename, dur)         :: monitors if any file with that filename is created for set duration
    filewatch_edit (filename, dur)        :: monitors if any file with that filename is edited for set duration (must exist)
    filewatch_del (filename, dur)         :: monitors if any file with that filename is deleted for set duration (must exist)

### UML Class Diagram 

                                           +--------------------+
                                           |     directory      | ; stores path-relevant information
              +------------+               +--------------------+
              |   rPath    | |------------ | +dir_name : String | 
              +------------+               +--------------------+
              | +directory | ;; goal: this object holds directory metadata, 
              | +dir_data  | ;; as well as holds the files and information listed
              +------------+     
              |         T                               +----------+ ; stores data at the path - incl. files, metadata
              |         +------------------------------ | dir_data | <--------------------------+
              V                                         +----------+                            |
    +-------------------------------------------------------------------------+                 |
    |                   RShell                                                |                 |
    |-------------------------------------------------------------------------|                 |
    | - rPath                                                                 |                 |
    +-------------------------------------------------------------------------+                 |
    | + mkdir(dir_name : String) :: rPath                                     |                 |
    | + cd(dir_name : String) :: rPath                                        |                 |
    | + ls() :: rPath                                                         |                 |
    | + getdir() :: dir_name : String                                         |                 |
    | + syspath() :: directory : directory                                    |                 |
    | + echo(cmd : String) :: response : String                               |                 |
    | + history(num) :: dir_hist : String[]                                   |                 |
    | + histfn(num) :: fn_hist : String[]                                     |                 |
    | + get_jobs() :: arr_jobs : String[]                                     |                 |
    | + kill(signal : Int, job : String) :: result : Int                      |                 |
    | + sysmgr(text : String, dur : Int) :: result : String                   |                 |
    | + filewatch(fn : String, name : String, dur : Int) :: result : String   |                 |
    | + filewatch_new(name : String, dur : Int) :: result : String            |                 |
    | + filewatch_edit(name : String, dur : Int) :: result : String           |                 |
    | + filewatch_del(name : String, dur : Int) :: result : String            |                 |
    +-------------------------------------------------------------------------+                 |
            V                                                                                   |
            |                                                                                   |
            | ;; handles the processing of each command in RShell                               |
            | ;; require revision to functional roles                                           |
    +-------------------------------------------------------------------------+                 |
    |                   CShell                                                |                 |
    +-------------------------------------------------------------------------+                 |
    | - childProc : childProcess                                              |                 |
    | - childFW : childFileWatch[]                                            |                 |
    | - cmdQueue : cmdQueue                                                   |                 |
    +-------------------------------------------------------------------------+                 |
    | + mkdir(dir_name : String) :: rPath                                     |                 |
    | + cd(dir_name : String) :: rPath                                        |                 |
    | + ls() :: rPath                                                         |                 |
    | + getdir() :: dir_name : String                                         |                 |
    | + syspath() :: directory : directory                                    |                 |
    | + echo(cmd : String) :: response : String                               |                 |
    | + history(num : Integer) :: dir_hist : String[]                         |                 |
    | + histfn(num : Integer) :: fn_hist : String[]                           |                 |
    | + get_jobs() :: arr_jobs : String[]                                     |                 |
    | + kill(signal : Int, job : String) :: result : Int                      |                 |
    | + sysmgr(text : String, dur : Int) :: result : String                   |                 |
    | + filewatch(fn : String, name : String, dur : Int) :: result : string   |                 |
    | + filewatch_new(name : String, dur : Int) :: result : string            |                 |
    | + filewatch_edit(name : String, dur : Int) :: result : string           |     0..* +---------------------+
    | + filewatch_del(name : String, dur : Int) :: result : string            | >------> |  childFileWatch     |
    +-------------------------------------------------------------------------+          +---------------------+
            V                                                             V              +---------------------+
            |                                                             |              | + monitorNew()      |
            |                                                             |              | + monitorEdit()     |
            |                                                             |              | + monitorDel()      |
            | ;; handles the processing of child command structure        |              +---------------------+
            1                                                             | ;; queues all commands; prioritizes FW/Msgr
    +------------------------+                                        +-------------------------------+ 
    | childProcess           | ---+-> [  directory  ]                 |  cmdQueue                     |
    +------------------------+    |                                   +-------------------------------+
    |                        |    +-> [  dir_data   ]                 | + LPqueue : String[]          |
    +------------------------+                                        | + HPqueue : String[]          |
    |                        |                                        +-------------------------------+
    +------------------------+                                        | + clear()                     | 
                                                                      | + push(Queue, cmd : String)   |
                                                                      | + pop(Queue) :: cmd : String  |
                                                                      +-------------------------------+


### User Stories
*As a user*, 

    I would like to be able to enter and leave any file in my file directory.
    I would like to see what files are in what directory.
    I would like to look at the history of my file access - both the my function history and my filepath history.
    I would like to see if a file in a location is created, edited, or deleted.
    I would like to send a message, to be returned to me at a given time.

*As a developer*, 
    
    I would like to run multiple filewatches at the same time, across multiple locations.
    I would like to be alerted of changes in files when I'm working on other programs.
    I would like to see what filewatches, or other jobs, are running at that time.
    I would like to preemptively kill jobs that are running.

*As a software company*, 

    We would like to use a quick program that can efficiently with a multitude of filewatchers at once.
    We would like to use a secure, safe application that protects itself from users, in both input and data.

### Use Cases
##### Running a generic shell operation:
1. User sends request to RShell.
2. RShell communicates to CShell identifying task.
3. CShell places task into LPQueue (low-priority queue).
4. CShell pops task off of LBQueue, once childProcess is empty.
5. CShell passes task to childProcess.
6. childProcess processes task.
7. childProcess returns result to CShell.
8. CShell gets result from childProcess, returns to RShell.
9. RShell returns result to user.

**Errors and Mitigations:**

* 1.1 Bad data is sent to RShell
  * RShell returns error notification

##### Running a FileWatch or SysMgr task:
1. User sends request to RShell.
2. RShell communicates to CShell identifying task.
3. CShell places task into HPQueue (high-priority queue).
4. CShell pops task off of HPQueue.
5. CShell creates a childFileWatch to handle task.
6. childFileWatch waits until time assigned had passed.
7. childFileWatch returns result to CShell, terminates.
8. CShell returns result to RShell.
9. RShell returns result to user.

**Errors and Mitigations:**

* 1.1 Bad data is sent to RShell
  * RShell returns error notification
* 6.1 For FileWatcher, childFileWatch finds change in file before alloted time had passed
  * RShell returns exception found, and data collected - childFileWatch is terminated

### Other References
* [Class vs Module](http://stackoverflow.com/questions/151505/difference-between-a-class-and-a-module)
* [Ruby Exception Hierarchy](http://makandracards.com/makandra/4851-ruby-exception-class-hierarchy) 
* [Errno Documentation](http://ruby-doc.org/core-1.9.3/Errno.html)
* [GetoptLong](http://ruby-doc.org/stdlib-1.9.3/libdoc/getoptlong/rdoc/GetoptLong.html)
* [Regexp](http://ruby-doc.org/core-2.1.1/Regexp.html)
* [Anti-patterns](http://today.java.net/pub/a/today/2006/04/06/exception-handlingantipatterns.html)

