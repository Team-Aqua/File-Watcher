# Todo

#### Due: Wednesday Feb 10th 

  * Aaron: Answer Questions Module 1 []
  * Anson: Answer Questions Module 2 []
  * Quentin: Answer Questions Module 3 []

  * Aaron: Look over contribute/critique ALL Questions []
  * Anson: Look over contribute/critique ALL Questions []
  * Quentin: Look over contribute/critique ALL Questions []

#### Due: Friday Feb 12th
  * Specs
    * Questions Answered []
    * Find Examples of Shells / Which CMD's Need to be implemented []
    * Write a Few User Stories []
    * Use Cases []

#### Due: Late Saturday Feb 13th 
  * Design []
    * Expand Off Diagram (One Made in Meeting) []
    * Skeletal []
    * UML Class Diagram []

    * Aaron: Look over contribute/critique Skeletal and Architecture Design Decisions []
    * Anson: Look over contribute/critique Skeletal and Architecture Design Decisions []
    * Quentin: Look over contribute/critique Skeletal and Architecture Design Decisions []

#### Due: Tuesday Feb 16th
  * Contracts

#### Due: Thursday Feb 18th
  * Module 1 Basics

#### Due: Friday Feb 19th
  * Module 2

#### Due: Thursday Feb 20th
  * Module 3 / Module 1 Complete




# Meeting Notes

Email TA's a Q: Do we have to write all the shell commands ourselves in C?

What is exception hierarchy 
What is Module Errno? 

What is a tainted object?


## Part 1
#### Overall Program 
  * Full on Shell Creation
  * Threaded Parent: Receives input and Child: Does work

  * Parent: Input / Output / Interfacing with child (HOW IS THIS DONE POLLING? INTERRUPT?)
  * Child: Does Process Work. 

  * Design Design to be document as to HOW THE PARENTS WAITS FOR THE CHILD. 

  * ANSWER THIS: What is the deference between class or module?



####

## Part 2
#### Overall Program 

  What is a "driver" program?

  1. Send msg.
  2. Child sleeps
  3. 
  4.

Research alternate shells for ideas (Methods required)


## Part 3
#### Overall Program 

If a file is deleted do we stop monitoring?
If a file is modified once do we stop monitoring?

How does ruby accept/output the filewatcher response from Batch Children 

```
  -----------------------
  | Ruby User Interface | 
  -----------------------
            |     ^
            V     |
        ---------------------
        | Sleeping C Parent |
        |--------------------
        | Queue of cmd's    | - CMD's have Types 
        |                   |     - Batch (Spawns New Child | Killed After return) e.g. Filewatcher CMD
        |-------------------|     - Sequential (Uses Main Child Worker) e.g. ls or cd
          1       1
          |       |
          |       |
          |       |
          |       V
          |       1
          |   -----------------
          |   | Main Worker   |  
          |   -----------------
          |
          |
          |
          V
        0..*
    ----------------
    |  Batch Spawn |
    ----------------

```























