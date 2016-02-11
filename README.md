
# File Watcher
A Linux monitoring system.

#### Description

##### Module the 1st
A shell program can be regarded as the normal interface between the application programmer and the operating system or real-time kernel. The shell's task is to accept command lines and execute the appropriate command returning error messages as required. This task is repeated
indefinitely.

**Write your own basic shell utility** – as a reusable component or components.
Hint: a 'rough' algorithm:
    
    loop
    get_command
    create child/worker process
    Parent : wait for worker (child) to finish
    Child: change job
    Parent: report results
    end_loop

Please note: In our current set-up, your shell program will sit above the current Linux shell. However, you are to assume, okay pretend, that Linux shell does not exist! That is make decisions, and deploy coding strategies appropriate for your shell being the only shell program!

**Modules to Add** 

  * ls
  * cd 
  * change permissions of a file
  * add / edit / delete file
  * find file in folder?
  * call linux shell

**Questions (for pondering and answering)**

##### Is your problem a class or a module? What is the difference?

Our problem is a module. Modules do not neet to be instantiated and are about functions while classes need to be instantiated and are about providing objects. [Reference](http://stackoverflow.com/questions/151505/difference-between-a-class-and-a-module)
  
##### What shell(s) are you using to provide a specification? What features do they support?
  
We are using the C Shell to provide a specification. Some features include history and editing, aliases, directory stacks, tilde notation, cdpath, job control and path hashing.
  
##### In your opinion, which features are essential (should include in your design) and which are “window dressing” (should not include in your design)?

We believe that directory functions like ls and cd will be required functions for navigating and selecting files to monitor using the File Watcher. Tilde notation, aliases , history and editing are not needed for the completion of the shell.
  
##### Economics: Which, if any, essential features will be omitted from your design due to unmanageable effort requirements?

Most likely the directory stack, job control and path hashing wil be omitted from the shell. Despite how useful they will be for a file watcher, they are not essential for its completion.
  
##### Error handling? What percentage of code handles functional against potential pitfalls:

    **In the average commercial program? In your shell program?**: 20% of code in the average commercial program handles error handling and about 10% of our code will handle error handling.
    
    **If they are radically different, please provide a rationale**: Most likely our shell will not be performing a lot of error handling. Most testing will be completed on the front end to test for correct inputs using ruby's contracts.
  
##### Robustness? How do we make the system bullet-proof? Is Avoiding Core dumps of system shells important? Especially from a Security viewpoint, remember this dump will give access to underlying C system code and potentially Linux daemons?

We can make the system robust by validating unputs and commands. We can stop core dumps by ensuring that there are correct inputs and files, and that links to the files have been closed.
  
##### Describe the Ruby exception hierarchy, which classes of exceptions are applicable to this problem?
  
[Reference](http://makandracards.com/makandra/4851-ruby-exception-class-hierarchy) Ruby's exception heirarchy is as follows: 

    1) NoMemoryError
    2) ScrpitError
    3) SignalException
    4) StandardError
    5) SystemExit
    6) fatal

Standard error will be applicatble in order to handle IO exceptions. NoMemoryError will be needed due to the theoreticaly low amount of memory that our system will be having. SignalException will be used to ensure that interupts from the child processes are handled correctly. SystemExit will be taken into consideration in order to clean up processes if the shell is closed unexpectedly. 
  
##### What is Module Errno? Is it applicable to the problem? Explain your answer! Remember Ruby often wraps C code.

[Errno Documentation](http://ruby-doc.org/core-1.9.3/Errno.html)

The OS reports errors using pain integers. Module Errno is created dynamically to map operating system errors to Ruby classe, with each error number generating its own subclass of SystemCallError. This module is applicatble to our project since there needs to be a way to trace errors generated from C code and bring it to the ruby's front end to be displayed to the user. 
  
##### Security? How will we protect the system from tainted objects? Can we trust the user?

We can use ruby to detect and sanitize tainted objects to prevent the user from attacking the host system. We can never trust the user. 
  
##### Is sand boxing applicable to this problem? Is it feasible to write security contracts?
  
Sandboxing should not be needed to run untrusted code because it has either been used thoroughly or we will write it ourselves. It is feasable to write security contracts to test for tainted inputs.
  
##### Should we be using class GetoptLong? Or Regexp? Or shell? Or ...
  
    [GetoptLong](http://ruby-doc.org/stdlib-1.9.3/libdoc/getoptlong/rdoc/GetoptLong.html): parse conmmand line option. It is a pure ruby implementation.
    [Regexp](http://ruby-doc.org/core-2.1.1/Regexp.html): Used to match patterns against a string.
    [Shell](http://ruby-doc.org/stdlib-2.0.0/libdoc/shell/rdoc/Shell.html): Implements an idiomatic interface for common UNIX shell commands.

Use Regexp since some of the command line options will be custom made.

##### What environment does a shell run within? Current Directory? Or ...

The shell will run within the current directory so the user can use cd or ls to start navigation from the current directory.
  
##### What features should be user controllable? Prompts? Input and Output channels? Or ...

Inputs into the shell will be widely used, especially with file watcher. An output channel can be used if the user would want the data sent to a logfile instead of the shell.

##### Module the 2nd
The control of time in many real-time systems is very important. Further, many real-time systems run on processors with limited capabilities and capacity. Processes must know how to wait, not only for an event, but also for a certain time period.

**Write a reusable component(s) plus a “driver” program**, which has two parameters accepted from the command line at the start of execution:

    a) An amount of time
    b) A message

Your program should wait for the specified amount of time and then print out the specified message. Meanwhile control of the shell should be returned to the user, i.e. the program must be non-blocking. Finally, your program should minimize the number of processes it creates, if any, as the memory capacity on the target system is expected to be very low.

**Questions (for pondering and answering)**
##### A class or a module?
Likely, the implementation of this design would be completed through a series of modules, each holding the specific functions required. More specifically, the 2nd module would be housed within a module, and would be called by the main script by the child process.

##### Error handling? Robustness? Security? Are any of these required?
The inputs would be sanitised beforehand by the Ruby script before being processed. This removes the possibility of 'tarnished' inputs prior to processing. Once the system is in module 2's exclusive code, the system follows the following parameters:

**Error Handling**: the system would protect against external interrupts/kill signals, which would terminate the program, as well as the child. Additionally, if the second module encounters an issue on its own (for example, if the system encounters a segmentation fault before the process is complete) the module must appropriately handle the situation.

**Robustness**: the system has to be robust enough to work despite adverse conditions. This means that the program would continue to work despite a segmentation fault raised outside of the process.

**Security**: the system needs to be isolated, strictly within the child process. As a result, the system can protect the child process from external control, and thus would result in a secure system.

These aspects are required, especially for a command line interface application. As users expect a level of quality with the innermost processes (aspects obtained by having a secure, robust system), developers need to build applications with respect to these key qualities at all times.

##### What components of the Ruby exception hierarchy are applicable to this problem? Illustrate your answer.
Reference: 

* http://blog.nicksieger.com/articles/2006/09/06/rubys-exception-hierarchy/
* http://ruby-doc.org/core-2.1.1/Exception.html

The following components are applicable to this problem:

1. http://ruby-doc.org/core-2.1.1/ArgumentError.html
  * ArgumentErrors occur if an incorrect argument is passed. We can use to clean inputs.
2. http://ruby-doc.org/core-2.1.1/RuntimeError.html
  * Generic class used if the system encounters a runtime error.
3. http://ruby-doc.org/core-2.1.1/TypeError.html
  * TypeError when the system is passed a bad input (eg. RelayMessage "Two" "Hello World", where proper input is RelayMessage 2 "Hello World")

##### Is Module Errno useful in this problem? Illustrate your answer.
Reference:

* http://ruby-doc.org/core-2.1.1/Errno.html
* http://blog.honeybadger.io/understanding-rubys-strange-errno-exceptions/ 

Errno could potentially be useful to identify system errors - but more so for other modules. Important errno to take account of are:

1. EACCES  Permission denied; the file permissions do not allow the attempted operation.
  * Didn't have permission to call the function.
2. EINVAL Invalid argument. This is used to indicate various kinds of problems with passing the wrong argument to a library function.
  * Invalid argument passed; likely caught by ruby function before processing.

##### Describe the article at: 
[http://today.java.net/pub/a/today/2006/04/06/exception-handlingantipatterns.html](http://today.java.net/pub/a/today/2006/04/06/exception-handlingantipatterns.html). 
Reference: 

* https://community.oracle.com/docs/DOC-983543https://community.oracle.com/docs/DOC-983543

Used to identify exception handling, as well as custom exceptions. More specifically, the article focuses on antipatterns, which discuss 'bad' patterns for exceptions to have.

##### Convince the marker that these Anti-patterns don’t exist in your solution. 
>> to be completed in finalised copy.

##### Do they exist in your Shell solution?
>> to be completed in finalised copy

##### How can I make the timing accurate? What time resolution should I be looking at, remember real-time systems? Time formats?
Generally, system time is considered accurate enough. For example, sleep(x) is considered accurate.

Reference:

* http://pubs.opengroup.org/onlinepubs/009695399/functions/sleep.html

##### Does ‘C’ have better facilities for this problem than Ruby? (Big hint!)
Yes, C has better facilities for this problem. We plan on using one of those key facilities (sleep) to accurately time our processes.

##### What should be user controllable? Can we trust the user?
The values that should be user controllable are: evoking the function, setting the message, and setting the time duration. Because we properly sanitize the input, we can trust the user with manipulating the message, as well as setting the time duration. Of course, various gates are used in order to ensure that the user cannot 'break' the system - this includes adding a limit to both message size and duration, as well as preventing any 'bad' input from going through. However, because this module is naturally unintrusive, most functionality can be trusted to the user.

##### Module the 3rd 
An important task in any system is to keep track of all files in existence at any point in time. In addition, many security systems monitor change information in the file system to help detect erroneous alteration.

To help with this and other related tasks; **write a reusable component(s) plus a “driver” program**, which monitors files or potential files. The list of all names to be monitored is fully specified at execution time. If the file is altered, created or destroyed, the component should undertake a user-specified action after an optional, but highly accurate, time delay. Note that while these components are 'watching' the user must still be able to enter commands normally to the shell; that is, the system must be non-blocking. Think of this system as a typical batch-processing job that
runs indefinitely.

The user-defined actions, and any time delay, must be specific to the type of alteration. That is the user must be able to specify different behaviour for each type of change (altered, created or destroyed). The user must also by able to define which type of alternation to which (potential) file(name) they are interested in watching. Specifically, this component must provide a facility, which supports one of the following interface protocols – you are required to decide which one:

    FileWatch( type of alteration, duration, list of filenames) {action}

Or

    FileWatchCreation(duration, list of filenames) { action}
    FileWatchAlter(duration, list of filenames) { action}
    FileWatchDestroy(duration, list of filenames) { action}

Or give us a better idea – but you will need to be convincing.

**Questions (for pondering and answering)**

  * A class or a module?
  * Error handling? Robustness? Security? Are any of these required?
  * What components of the Ruby exception hierarchy are applicable to this problem? Illustrate your answer.
  * Does this problem require an iterator?
  * Describe Java’s anonymous inner classes.
  * Compare and Contrast Java’s anonymous inner classes and Ruby Proc objects; which do you think is better?
  * From a cohesion viewpoint, which interface protocol is superior? Explain your decision!
  * Is Module Errno useful in this problem? Illustrate your answer.
  * Do any of the Anti-patterns described at: [http://today.java.net/pub/a/today/2006/04/06/exception-handlingantipatterns.html](http://today.java.net/pub/a/today/2006/04/06/exception-handlingantipatterns.html) exist in your solution?
  * Describe the content of the library at: [http://c2.com/cgi/wiki?ExceptionPatterns](http://c2.com/cgi/wiki?ExceptionPatterns). 
    * Which are applicable to this problem? Illustrate your answer. 
    * Which are applicable to the previous two problems? Illustrate your answer.
  * Is a directory, a file? Is a pipe, a file? Is a ….., a file? Tell us your thoughts on the definition of a file in a LINUX context.
  * Define what is meant (in a LINUX environment) by file change? Does it mean only contents? Or does it include meta-information? What is meta-information for a file?

#### Context

Fortunately, systems programming in Ruby is similar to systems programming on any Linux box; hence this assignment we will rely on the knowledge that has been accrued from the operating systems class (CMPUT 379). Below are three short exercises to get everyone back up to speed while exercising some new concepts and ideas.

For example, systems programs are real security nightmares. Designing and implementing a truly secure program is actually a difficult task on Unix−like systems such as Linux and Unix. The difficulty is that a truly secure program must respond appropriately to all possible inputs and environments controlled by a potentially hostile user. Developers of secure programs must deeply understand their platform, seek and use guidelines (such as these), and then use assurance processes (such as inspections and other peer review techniques) to reduce their programs' vulnerabilities.

Following standard practice, here are some of the key guidelines that ‘C’ programmers follow:

  * Validate all your inputs, including command line inputs, environment variables, CGI inputs, and so on. Don't just reject "bad" input; define what is an "acceptable" input and reject anything that doesn't match.
  * Avoid buffer overflow. Make sure that long inputs (and long intermediate data values) can't be used to take over your program. This is the primary programmatic error at this time.
  * Structure program internals. Secure the interface, minimize privileges, make the initial configuration and defaults safe, and fail safe. Avoid race conditions (e.g., by safely opening any files in a shared directory like /tmp). Trust only trustworthy channels (e.g., most servers must not trust their clients for security checks or other sensitive data such as an item's price in a purchase).
  * Carefully call out to other resources. Limit their values to valid values (in particular be concerned about meta-characters), and check all system call return values.
  * Reply information judiciously. In particular, minimize feedback, and handle full or unresponsive output to an un-trusted user.
  * Avoid Core dumps, especially in situations where the core dump may have the SETUID bit set! Um – now which of these are likely to apply to Ruby programs? Remember Ruby programs are often only Ruby wrappers around components written in other languages, especially C.
  
#### Requirements

  1. You must provide complete design rationale and system research – i.e. the written answers to the design questions; this must be handed in by Tuesday February 23rd @ midnight;
  2. You must provide complete design by contract test cases for the three problems; this must be handed in by Tuesday February 23rd @ midnight; please note: since these problems are systems programming problems you can expect your contracts to be more abstract than in the previous assignment; and
  3. Your system must be completed by: Tuesday February 23rd @ midnight and must be ready for demonstration in the following practical session.

In addition to the practical demonstration, you are required to hand-in:

  1. A detailed rational for any augmented decisions (from Part 1) with regard to the below design questions.
  2. A list of deviations in the contracts implemented form the contracts specified in Part 2.
  3. A copy of the code
  4. A description of any additional testing beyond that described by your contracts.
  5. A list of known errors, faults, defects, missing functionality, etc ... telling us about your system’s limitations will score better than letting us find them!

Please hand in all components by emailing them to {jimm, zuhori}@ualberta.ca and hence all subcomponents by definition must be machine readable. In addition,

  * The Subject Line should be in a specific format - Assignment 2: Group 1 [, Part 1...]
  * File types should be only of .doc or .pdf
  * File names for code should be in ruby format (all lower cases, with words concatenated with a dash)
  * For each assignment with a code section, there must be a primary executable file that is the main entry for other codes. This has to have the format: assignment2_main.rb (where 2 corresponds to the appropriate number in the assignment sequence). This main file should also contain a comment section with a list of the group members if necessary and some description of the runtime requirement of the code (e.g. commandline activation format)

