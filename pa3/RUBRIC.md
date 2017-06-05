# Rubric for cmps011-pt.s17/pa3

**pa3** was released on **Monday, June 5**. It was out of 80 points, and the
average was a **64 (80%)**. You should have received a grade report email with a
breakdown of your score, which should also be reflected on eCommons. Below is a
description of each section of the grade breakdown.

# Grade Breakdown

This assignment was graded by:
- Isaak Cherdak (icherdak)
- August Valera (avalera)

Each category is labeled with the respective grader's initials. Sending your
questions/review requests to the appropriate grader expedites it's processing.

## Correctness

**20 points, IC**

## Error Checking

**10 points, IC**

## Passing Tests

**10 points, 2 points each, AV**

For each test, full credit given if test output exactly matches output.

Tests were the same distributed in the assignment check script.

## Design

**10 points, IC**

Full credit given for using the Euclidian algorithm given in the lab manual.

## Formatting

**10 points, IC**

Full credit for decent formatting, indentation where expected

## Class named GCD

**5 points, AV, same as pa3**

Full credit for naming the class `GCD` (the code is wrapped in a `class GCD {
... }` block, and the program is run with `java GCD`).

No credit for not doing this.

## Comment Block

** 5 points, AV, same as pa2**

Full credit for a comment block following the standards listed in the
[lab1 PDF](https://classes.soe.ucsc.edu/cmps011/Spring17/lab1.pdf) and on the
[grader expectations document](../docs/EXPECTATIONS.md).

1 point deducted for omitting each of the following:
- filename (exactly as it appears in `ls`)
- your CruzID (as seen in `echo $USER`)
- assignment name (`pa3` exactly as used in the submit command)

Note that the notes will indicate if you have not included your name as listed
on the course roster (run `getent passwd $USER` to check this). However, there
is no deduction corresponding to this message

No credit for not having a comment block (detected by checking the first 10
lines of the file for lines prefixed with a `/` or `*`).

Full credit for not submitting any Java file (charity, due to major deductions
elsewhere).

## Naming (GCD.java)

**5 points, AV**

Full credit for submitting a file named exactly `GCD.java`.

5 points for submitting some other `.java` file.

No credit for not doing this.

## Compilation Issues

**10 points, AV**

Full credit if file compiles (running `javac GCD.java` produces a `GCD.class`,
names may vary due to other errors, but this was not taken into account).

If your file had compilation errors, we manually went into it and modified it
(without changing any of the underlying program structure) to compile. This
consisted of mostly fixing syntax errors, typos, and bad variable scope.

We then took the difference between the original and the modified versions (with
`diff -ub`). The amount of lines of difference generated, divided by 2 (because
each change consists of a deletion **-** and an addition **+** to the file) was
taken to be the general number of changes needed to be made to make the program
compile.

Your score was then set to *max(10 - number of changes, 5)*, to enforce a 5
point minimum on this section for charity.

## Questions

Any questions about the rubric or the assignment should be posted on the Piazza
followup discussion pertaining to the rubric. More personal questions pertaining
to your specific submission should be sent as a reply to your grade report
email, to give us context on your submission. We will not accept any other
emails, the only exception being if you did not receive a grade report email and
think you should have.

## Academic Honesty Policy

Effective pa2, all submissions are analyzed to detect plagiarism. These results
are screened by one of the teaching staff, and then submitted to us graders to
notify the individuals (and give them a 0 on the assignment). If your submission
has been flagged as such, you **must** address all issues pertaining to this
with the instructor directly during their office hours, not the graders or
teaching staff during scheduled sections. Once flagged, only the instructor may
modify a submission. Note that, although you may have received a 0 on this
assignment, this is not a formal charge of Academic Dishonesty (which results in
letters to your provost, campus judicial proceedings, etc).

If you have discussed your case with the professor and he has decided to clear
the flag on your submission, you should receive a grade report with your
updated/actual grade either when the regular assignment grades are released, or
within 48 hours of the professor notifying the grades to clear your submission,
if the grades have already been released. Clearance must come directly from the
professor, so if this does not occur within 48 hours, please email the
instructor directly. Any updated grade report sent to your UCSC email overrides
all previously issued grade reports.

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
