### Shells
[Ruby Shell](http://ruby-doc.org/stdlib-2.0.0/libdoc/shell/rdoc/Shell.html)

### Commands
Generic functions for shells:

    mkdir (directory_name)      :: make the directory / make the folder
    cd (directory_name)         :: enter a directory
    ls ()                       :: returns list of files in folder
    getdir ()                   :: returns directory_name
    sys_path ()                 :: returns system path ( == echo $PATH )
    echo (resp)                 :: prints system response (string, path, etc.)       

Job-specific funcitonality:

    get_jobs ()                 :: returns list of jobs currently run by system (incl. filewatcher)
    kill (signal, job)          :: kills job, returns confirmation by boolean / string

### User Stories
*As a user*, I would like to 

*As a developer*, I would like to

*As a software company*, we would like to

### Use Cases

### References
