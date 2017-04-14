Some notes on workflow and how to edit your code on the timeshare

There are 3 general phases in writing code for this class: (1) editing the code,
(2) running the code, and (3) submitting the assignment. Step (3) must be done
on the Unix Timeshare, but aside from that, it is up to you to choose how you
want to accomplish these 3 tasks. Below we will go over a few different ways
this can be accomplished, starting with the "standard" (read: recommended) way
and then deviating from that to discuss alternatives.

## Doing Everything on the Unix Timeshare

The simplest way to accomplish these 3 things is to do them all in the Unix
timeshare. When your assignments are graded, we will perform the compilation and
testing on the timeshare, so it is safest to run (2) on the timeshare to make
sure that it will work correctly on our end. (There have been problems in the
past with code compiling on native Mac but not working on Unix.)

If you go this route, then you will need to use a terminal editor to write your
code (1). There are several available, but here are a few common ones:

- `nano`: Basic editor, has all the keyboard shortcuts you need to use it listed
    on the bottom. No advanced features (syntax highlighting, auto formatting,
    etc).
    - Save with `Ctrl+X` to Exit, then `Y` (yes) to save changes, then Enter to
        accept the current filename
- `vim`: More advanced editor, steep learning curve and weird keyboard
    shortcuts. Editor of choice of many at UCSC (including myself) because it is
    taught by Wesley Mackey in upper division courses.
    - After opening the file, press `i` to enter insert (editing mode). You
        start off in a view only mode
    - Save with `Esc` to get back into that normal (view only) mode, and then
        type `:wq` followed by `Enter`.
    - More Vim tips can be found on the [VIM](VIM.md) page.
- `emacs`: Another more advanced editor, equivalently powerful to `vim`.
    Completely different set of keyboard shortcuts. They both have [their own
    fanbases](https://xkcd.com/378/). `emacs` has the advantage of also having
    a GUI (regular pointy clicky program) version.

All of these editors are ran on the timeshare like so: `nano HelloWorld.java`,
`vim Lawn.java`, etc.

Once you have figured out editing, steps (2) and (3) are done in the usual way,
with the commands `javac Lawn.java` to compile and `java Lawn` to run.

## Using Your Own Editor

It is completely fine to use your own editor (Sublime Text, Notepad++, [etc]
(https://xkcd.com/1823/)) for step (1), and then copy over the files to the Unix
timeshare for step (2). Note that in order for you to compile the latest
version, you *must copy over your code every time you make an edit*.

There are a few ways to do this, but the one that Pat recommends is FileZilla,
which is a GUI program where you can drag and drop files to copy them over. You
can find instructions on how to install it on the
[class website](https://classes.soe.ucsc.edu/cmps005p/Spring17/prog.html).

There is also a way to do this through the command line, although it differs by
operating system. If you have a Unix based terminal (macOS terminal, Linux
terminal, or Windows Subsystem for Linux), you can use the `scp` command to copy
over files as an alternative to FileZilla. It works similar to the `cp` command,
except it includes the `ssh` server url, like so:

```bash
# File paths on both sides
scp whatever/folder/Lawn.java avalera@unix.ucsc.edu:folder/another/Lawn.java

# No file path on local computer, no filename on server means keep same filename
scp Lawn.java avalera@unix.ucsc.edu:cmps011/lab4/

# No file path on server means it's put in the home directory, do not forget :
scp Lawn.java avalera@unix.ucsc.edu:
```

If you are on Windows without a Unix command line, and you have Putty to `ssh`
into the timeshare, you can get around this by using Putty's version of `scp`,
aptly named `pscp`, along with the Windows Command Prompt (`cmd`) or Windows
Powershell. It works almost identically to `scp`, although Windows has a
different set of commands to navigate through the filesystem (for instance, `ls`
is replaced by `dir`) and the files will be addressed with backslashes on the
Windows side, like so.

```bash
pscp windows\folder\Lawn.java avalera@unix.ucsc.edu:linux/folder/Lawn.java
```

Even though you edit on your own local computer, it is still recommended that
you compile (2) on the Unix timeshare. This ensures that your program runs
correctly for the graders.

## Using an IDE

Using an IDE, or an Integrated Development Environment, is very similar to using
your own editor, except IDE's generally also come with tools to help you compile
and run your code within the program on your local folder. In this case, you
would do the same thing as the previous section in copying over your files to
the timeshare, but only in between steps (2) and (3).

There is one caveat to this, and it was mentioned earlier. *Your code must run
correctly on the timeshare for it to be correct.*. What this means is that,
although your program may work on your IDE's version of Java, if it does not
work properly on the timeshare, you will not receive credit for it. To make sure
that this is the case, you should run your program manually on the timeshare at
least once before submission, to verify that the behavior is consistent with
what you expect.
