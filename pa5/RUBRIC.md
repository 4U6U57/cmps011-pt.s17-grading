# Rubric for cmps011-pt.s17/pa5

**pa5** was released on **Mon, June 19**. It was out of 100 points, and the
average was a **77 (77%)**. You should have received a grade report email with a
breakdown of your score, which should also be reflected on eCommons. Below is a
description of each section of the grade breakdown.

# Grade Breakdown

This assignment was graded by:
- Isaak Cherdak (icherdak)
- August Valera (avalera)

Each category is labeled with the respective grader's initials. Sending your
questions/review requests to the appropriate grader expedites its processing.

## Error Checking

**10 points, IC**

-

## Verbose Output

**5 points, IC**

-

## General Tests

**10 points, 1 point each, AV**

- For each test, full credit given if test output exactly matches model output,
taken directly from the assignment check script.

- No credit given if program did not compile.

## Unit tests: isSolution(), nextPermutation()

**20 points total, 10 points per function, 5 points each test, 3 points charity
each, AV**

- Full credit for passing the unit test, taken directly from the assignment
  check script.

- 3 points for failing the unit test (function exists but does not work as
  expected).

- No credit given if the unit test did not compile (the function/class was not
given the right name, or took in different arguments than what was specified, or
did not exist outright).

## Makefile

**5 points, AV**

- Full credit for creating an executable called exactly `Queens` that runs
correctly

- 3 points for creating a file `Queens` that is not executable (needs `chmod
  +x`)

- No credit for invalid/incorrectly named/not submitted Makefile. Makefiles ran
with `make` by default must be called either `Makefile` or `makefile`.

## Formatting

**10 points, IC**

Full credit for decent formatting, indentation where expected:

 - subtract 5 points for clearly inconsistent formatting.
 - subtract 10 points for absolutely unacceptable formatting.

## Comment Block

**5 points, AV, same as pa2**

-Full credit for a comment block following the standards listed in the
[lab1 PDF](https://classes.soe.ucsc.edu/cmps011/Spring17/lab1.pdf) and on the
[grader expectations document](../docs/EXPECTATIONS.md).

- 1 point deducted for omitting each of the following:
    - filename (exactly as it appears in `ls`)
    - your CruzID (as seen in `echo $USER`)
    - assignment name (`pa5` exactly as used in the submit command)

- Note that the notes will indicate if you have not included your name as listed
on the course roster (run `getent passwd $USER` to check this). However, there
is no deduction corresponding to this message

- No credit for not having a comment block (detected by checking the first 10
lines of the file for lines prefixed with a `/` or `*`).

- Full credit for not submitting any Java file (charity, due to major deductions
elsewhere).

## Naming (Queens.java)

**5 points, AV**

- Full credit for submitting a file named exactly `Queens.java`.

- 3 points for submitting some other `.java` file.

- No credit for not doing this.

## Compilation Issues

**30 points, 5 points charity, AV**

- Full credit if file compiles (running `javac Queens.java` produces a
  `Queens.class`, names may vary due to other errors, but this was not taken
  into account).

- If your file had compilation errors, we manually went into it and modified it
(without changing any of the underlying program structure) to compile. This
consisted of mostly fixing syntax errors, typos, and bad variable scope.

- We then took the difference between the original and the modified versions
  (with `diff -ub`). The amount of lines of difference generated, divided by 2
  (because each change consists of a deletion **-** and an addition **+** to the
  file) was taken to be the general number of changes needed to be made to make
  the program compile.

- Your score was then set to *max(30 - number of changes, 5)*, to enforce a 5
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
within 48 hours of the professor notifying the graders to clear your submission,
if the grades have already been released. Clearance must come directly from the
professor, so if this does not occur within 48 hours, please email the
instructor directly. *Any updated grade report sent to your UCSC email overrides
all previously issued grade reports.*

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

## Final Deadlines

As the quarter is coming to a close, we are mandating that all issues with
grading (questions, review requests) be sent by email no later than **Monday,
June 19, 2017 at 20:00**. This is to give us time to process the requests by the 
official grade deadline, Tuesday.
