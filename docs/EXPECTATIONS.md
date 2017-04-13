Below are some of the expectations that we graders will have for future
assignments.

## Comment Blocks
>... note that everything after // on a line constitutes a comment and is
ignored by the compiler. Every program you write in this class must begin with a
comment block of the following form.
```
// filename
// your Name
// your CruzID
// the assignment name (like lab1 or pa1)
// a very short description of what the program does
```

*Taken from the [lab1
PDF](https://classes.soe.ucsc.edu/cmps011/Spring17/lab1.pdf).*

Please note the underlined
portion of that quote. Future programs will not tell you to write a comment
block at the top of your code, but it is implied and expected that you continue
to adhere to this. There may be exceptions to this rule, such as lab2, where you
are instructed to "Submit result with no further changes to the assignment name
lab2", the no furthur changes meaning you should not edit the file to add a
comment block or otherwise. In these cases, the PDF instructions override these
instructions. If you are unsure, please check Piazza, and if there is no post
on the subject, ask for clarification.

The most important parts of the comment block (important in the sense that we
might automatically scan for them and deduct points if not found) are the
following:
- Filename, exactly how it appears on the Unix command line (so, the file
Lawn.java should have the string "Lawn.java" in it's comment block)
- Your CruzID, which is the prefix of your UCSC email and also part of the
command you use to SSH into the timeshare. It is not the numerical code found on
your student ID, that is your SID or student ID number (you can also run `echo
$USER` on the timeshare if you don't know what this is)
- The name of the assignment, exactly as it is used in the submit command (so,
"lab1" and "pa1" but not "Lab1", "lab 1", "lab one", or "programming assignment
1")

## Filenames

> Your source code file for this project will be called Lawn.java. Note that in
all projects source file names are not optional, and points may be deducted for
misspellings. Thus “lawn.java”, “LAWN.java” and “prog1.java” are all incorrect.

*Taken from the [pa1
PDF](https://classes.soe.ucsc.edu/cmps011/Spring17/pa1.pdf).*

This is pretty self explanatory, but still important. Capitalization matters.
Spelling matters. Severe point deductions may occur otherwise.

This issue is made more complicated by the fact that, although you can always
overwrite files on the Unix Timeshare, it is difficult to delete files you have
already submitted. If you find you have submitted a file that was named
incorrectly, we recommend you submit again with the correct filename, and then
submit an *empty file* to the incorrect filename.
