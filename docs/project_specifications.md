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
              |         T                               +----------+ ; stores data at the path
              |         +------------------------------ | dir_data | <--------------------------+
              V                                         +----------+                            |
    +-------------------------------------------------------------------------+                 |
    |                   RShell                                                |                 |
    |-------------------------------------------------------------------------|                 |
    | + rPath                                                                 |                 |
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
    | + filewatch(fn : String, name : String, dur : Int) :: result : String   |                 |
    | + filewatch_new(name : String, dur : Int) :: result : String            |                 |
    | + filewatch_edit(name : String, dur : Int) :: result : String           |                 |
    | + filewatch_del(name : String, dur : Int) :: result : String            |                 |
    +-------------------------------------------------------------------------+                 |
            V                                                                                   |
            |                                                                                   |
            | ;; handles the processing of each command in RShell                               |
            | ;; require revision to roles                                                      |
    +-------------------------------------------------------------------------+                 |
    |                   CShell                                                |                 |
    +-------------------------------------------------------------------------+                 |
    | + childProc : childProcess[]                                            |                 |
    | + childFW : childFileWatch                                              |                 |
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
    | + filewatch(fn : String, name : String, dur : Int) :: result : string   |                 |
    | + filewatch_new(name : String, dur : Int) :: result : string            |                 |
    | + filewatch_edit(name : String, dur : Int) :: result : string           |          +---------------------+
    | + filewatch_del(name : String, dur : Int) :: result : string            | >------> |  childFileWatch     |
    +-------------------------------------------------------------------------+          +---------------------+
            V                                                                            +---------------------+
            |                                                                            | + monitorNew()      |
            |                                                                            | + monitorEdit()     |
            |                                                                            | + monitorDel()      |
            | ;; handles the processing of child command structure                       +---------------------+
    +------------------------+
    | childProcess           | ---+-> [  directory  ]
    +------------------------+    |
    |                        |    +-> [  dir_data   ]
    +------------------------+
    |                        |
    +------------------------+

### User Stories
*As a user*, I would like to 

*As a developer*, I would like to

*As a software company*, we would like to

### Use Cases

### References
