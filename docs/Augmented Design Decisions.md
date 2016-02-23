### Module 2 
**Error Handling**
Because of the disjointed nature of our system messager (as a result of the implementation of the fork process), there is cause for concern that failures found in the parent process would not affect the child process - when, in reality, this is the preferred approach. We have since designed our systems to ensure that we can properly handle all errors that arise.

We also ensure that user inputs to the program are properly sanitised - as a result, we properly handle all errors that arise from bad input data.

**Robustness**
Ultimately, we came to the following conclusion for our implementation: if there is an external segmentation fault, then our system should stop entirely. When looking at user requirements, most users would want a system that works to expectations. If the system falls prey to other issues - absolutely, we can handle those and preserve the initial function. However, our full system should not break by itself - but must also know when to stop. Regardless, our original missive remains - we will preserve our applicaiton to mitigate segmentation dumps.

**Security**
We have decided to use contracts in lieu of exceptions in order to properly illustrate either bad inputs or bad commands. That way, we can properly handle improper inputs through 'requirements design', instead of using the exception hierarchy. However, if errors exist outside of this scope (most notably within C, where contracts have no reach), then the exception hierarchy within C is implemented.