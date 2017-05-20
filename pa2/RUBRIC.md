## Rubric for cmps011-pt.s17/pa2

Sorry about the delay, **pa2** was released on **Friday, May 19**. It was out of
80 points, and the average was a **73 (90%)**. You should have received a grade
report email with a breakdown of your score, which should also be reflected on
eCommons. Below is a description of each section of the grade breakdown.

## Grade Breakdown

This assignment was graded by:
- Isaak Cherdak (icherdak)
- August Valera (avalera)


### Termination on Win
> 10 points, AV

Full credit for terminating on win in all guesses, with correct exit code (0)

8 points for not terminating in all winning situations, or terminating with
  wrong error codes (for example, running `System.exit(n)`, where `n` is your random number)

6 points for checking winning condition, but not actually terminating where
  required (program continues to ask for guesses even after winning)

4 points for checking winning condition in some situations, but not all required

2 points for not checking winning condition correctly, but at the very least it is possible for your program to print "You win." in some situation

5 points if java file not submitted, charity

No credit for not doing anything in regard to program win

### Displays Correct Answer on Lose
> 5 points, IC

Full credit for displaying correct answer on lose

### Incorrect Guesses Indicate High/Low
> 5 points, IC

Full credit for all incorrect guesses indicating high/low

### Number Range
> 20 points, IC

Full credit of uniformly distributed random number generation from 1-10.

### Class named Guess
> 5 points, AV, same as pa1

Full credit for naming the class `Guess` (the code is wrapped in a `class Guess
{ ... }` block, and the program is run with `java Guess`).

No credit for not doing this.

### Comment Block
> 5 points, AV, same as pa1

Full credit for a comment block following the standards listed in the
[lab1 PDF](https://classes.soe.ucsc.edu/cmps011/Spring17/lab1.pdf) and on the
[grader expectations document](../docs/EXPECTATIONS.md).

1 point deducted for omitting each of the following:
- filename (exactly as it appears in `ls`)
- your CruzID (as seen in `echo $USER`)
- assignment name (`pa1` exactly as used in the submit command)

Note that the notes will indicate if you have not included your name as listed
on the course roster (run `getent passwd $USER` to check this). However, there
is no deduction corresponding to this message

No credit for not having a comment block (detected by checking the first 10
lines of the file for lines prefixed with a `/` or `*`).

Full credit for not submitting any Java file (charity, due to major deductions
elsewhere).

### Naming (Lawn.java)
> 10 points, 5 minimum, AV

Full credit for submitting a file named exactly `Lawn.java`

5 points for submitting some other `.java` file

5 points for not submitting any Java file (charity, same as prev).

### Compilation Issues
> 25 points, 5 minimum, AV

Full credit if file compiles (running `javac Guess.java` produces a
`Guess.class`, names may vary due to other errors, but this was not taken into
account).

If your file had compilation errors, we manually went into it and modified it
(without changing any of the underlying program structure) to compile. This
consisted of mostly fixing syntax errors, typos, and bad variable scope.

We then took the difference between the original and the modified versions (with
`diff -ub`). The amount of lines of difference generated, divided by 2 (because
each change consists of a deletion **-** and an addition **+** to the file) was
taken to be the general number of changes needed to be made to make the program
compile.

Your score was then set to *max(25 - number of changes, 5)*, to enforce a 5
point minimum on this section for charity.

## Questions

Any questions about the rubric or the assignment should be posted on the Piazza
followup discussion pertaining to the rubric. More personal questions pertaining
to your specific submission should be sent as a reply to your grade report
email, to give us context on your submission. We will not accept any other
emails, the only exception being if you did not receive a grade report email and
think you should have.

## Grade Review

A grade review is a request for the graders to review work you believe *has been
graded in error, inconsistent with the rubric outlined above*. By submitting a
grade review, you are allowing us to go through your submission and modify your
score. Note that this applies for the whole submission, meaning that although in
most cases your score may stay the same or increase if we find errors in our
grading, there is the possibility that we may find additional problems in your
submission that would cause your score to decrease.

Note that a review is simply that, a reviewing of your original submission. You
may not submit new files for grading (because you submitted the wrong version,
or had trouble submitting in the first place, etc.). Concerns of this nature
must be brought up with the instructor.

You may request a grade review by sending a reply to your grade report email,
with the word **REVIEW** in all caps within the body of the email. Any email
that does not contain **REVIEW** shall be treated as a general question, and
will not affect your grade.
