# Domain Knowledge
* [Shell](https://en.wikipedia.org/wiki/Shell_\(computing\))

# Design Questions
### Module 1:
##### Is your problem a class or a module? What is the difference?
##### What shell(s) are you using to provide a specification? What features do they support?
##### In your opinion, which features are essential (should include in your design) and which are “window dressing” (should not include in your design)?
##### Economics: Which, if any, essential features will be omitted from your design due to unmanageable effort requirements?
##### Error handling? What percentage of code handles functional against potential pitfalls: In the average commercial program? In your shell program? If they are radically different, please provide a rationale.
##### Robustness? How do we make the system bullet-proof? Is Avoiding Core dumps of system shells important? Especially from a Security viewpoint, remember this dump will give access to underlying C system code and potentially Linux daemons?
##### Describe the Ruby exception hierarchy, which classes of exceptions are applicable to this problem?
##### What is Module Errno? Is it applicable to the problem? Explain your answer! Remember Ruby often wraps C code.
##### Security? How will we protect the system from tainted objects? Can we trust the user?
##### Is sand boxing applicable to this problem? Is it feasible to write security contracts?
##### Should we be using class GetoptLong? Or Regexp? Or shell? Or ...
##### What environment does a shell run within? Current Directory? Or ...
##### What features should be user controllable? Prompts? Input and Output channels? Or ...

### Module 2:
##### A class or a module?
##### Error handling? Robustness? Security? Are any of these required?
##### What components of the Ruby exception hierarchy are applicable to this problem? Illustrate your answer.
##### Is Module Errno useful in this problem? Illustrate your answer.
##### Describe the article at: [http://today.java.net/pub/a/today/2006/04/06/exception-handlingantipatterns.html](http://today.java.net/pub/a/today/2006/04/06/exception-handlingantipatterns.html). 
##### Convince the marker that these Anti-patterns don’t exist in your solution. 
##### Do they exist in your Shell solution?
##### How can I make the timing accurate? What time resolution should I be looking at, remember real-time systems? Time formats?
##### Does ‘C’ have better facilities for this problem than Ruby? (Big hint!)
##### What should be user controllable? Can we trust the user?

### Module 3:
##### Which interface protocol is presented?
##### A class or a module?
##### Error handling? Robustness? Security? Are any of these required?
##### What components of the Ruby exception hierarchy are applicable to this problem? Illustrate your answer.
##### Does this problem require an iterator?
##### Describe Java’s anonymous inner classes.
##### Compare and Contrast Java’s anonymous inner classes and Ruby Proc objects; which do you think is better?
##### From a cohesion viewpoint, which interface protocol is superior? Explain your decision!
##### Is Module Errno useful in this problem? Illustrate your answer.
##### Do any of the Anti-patterns described at: [http://today.java.net/pub/a/today/2006/04/06/exception-handlingantipatterns.html](http://today.java.net/pub/a/today/2006/04/06/exception-handlingantipatterns.html) exist in your solution?
##### Describe the content of the library at: [http://c2.com/cgi/wiki?ExceptionPatterns](http://c2.com/cgi/wiki?ExceptionPatterns). Which are applicable to this problem? Illustrate your answer. Which are applicable to the previous two problems? Illustrate your answer.
##### Is a directory, a file? Is a pipe, a file? Is a ….., a file? Tell us your thoughts on the definition of a file in a LINUX context.
##### Define what is meant (in a LINUX environment) by file change? Does it mean only contents? Or does it include meta-information? What is meta-information for a file?