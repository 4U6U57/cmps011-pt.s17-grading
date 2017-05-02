## Rubric for cmps011-pt.s17/pa1

Sorry about the delay, **pa1** was released on **DAY, DATE**. It was out of 80
points, and the average was a **AVERAGE**%. You should have received a grade
report email with a breakdown of your score, which should also be reflected on
eCommons. Below is a description of each section of the grade breakdown.

## Grade Breakdown

### Performance Tests
> 15 points, 5 points for test

For a single test (test inputs were the same used for the [pa1.sh
script](../README.md)):

Full credit for matching model output exactly.

If there was difference in output (found by running `diff -u`), then we counted
the number of lines of difference generated, divided that by 2 (because each
error consists of a deletion **-** and an addition **+** to the file), and set
that number to be the number of errors.

The score was then set to *max(5 - errors, 0)* to enforce a minimum of 0 for
this section.

The number of lines of difference is included in your grade report for each
test.

### Plurals and Singulars
> 5 points

If your code was designed to print an 's' when a corresponding value
(for H, M, or S) was not 1, then you get full credit. Otherwise, you get
no credit

### Area Calculation
> 5 points

Your code correctly calculates area (you don't have to print it to get
full credit here)

### Time Calculation
> 5 points

Your code correctly calculates time in all instances. It should be:
```
Math.round(lawnArea/mowRate);
```
### Calculating Hours, Minutes, Seconds
> 5 points

Your code correctly calculates a breakdown of Hours, Minutes, and
Seconds.

### Class named Lawn
> 5 points

Full credit for naming the class `Lawn` (the code is wrapped in a `class Lawn
{ ... }` block, and the program is run with `java Lawn`).

No credit for not doing this.

### Comment Block
> 5 points

Full credit for a comment block following the standards listed in the
[lab1 PDF](https://classes.soe.ucsc.edu/cmps011/Spring17/lab1.pdf) and on the
[grader expectations document](../docs/EXPECTATIONS.md).

1 point deducted for omitting each of the following:
- filename (exactly as it appears in `ls`)
- your name (specifically, your first name, as seen in `getent passwd $USER`)
- your CruzID (as seen in `echo $USER`)
- assignment name (`pa1` exactly as used in the submit command)

No credit for not having a comment block (detected by checking the first 10
lines of the file for lines prefixed with a `/` or `*`).

### Naming (Lawn.java)
> 10 points, 5 minimum

Full credit for submitting a file named exactly `Lawn.java`

5 points for submitting some other `.java` file

5 points for not submitting any Java file (charity, due to major deductions
  elsewhere).

### Compilation Issues
> 25 points, 5 minimum

Full credit if file compiles (running `javac Lawn.java` produces a `Lawn.class`,
names may vary due to other errors, but this was not taken into account).

If your file had compilation errors, we manually went into it and modified it
(without changing any of the underlying program structure) to compile. This
consisted of mostly fixing syntax errors, typos, and bad variable scope.

We then took the difference between the original and the modified versions (with
`diff -ub`). The amount of lines of difference generated, divided by 2 (because
each change consists of a deletion **-** and an addition **+** to the file) was
taken to be the general number of changes needed to be made to make the program
compile.
original 
Your score was then set to *max(25 - number of changes, 5)*, to enforce a 5 point
minimum on this section for charity.

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
