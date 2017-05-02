## Rubric for cmps011-pt.s17/pa1

## Grade Breakdown

### Performance Tests
> 15 points, 5 points for test

For a single test (test inputs were the same used for the [pa1.sh
script](../README.md)):

Full credit for matching model output exactly.

If there was difference in output (found by running `diff -u`), then we counted
the number of lines of difference generated, divided that by 2 (because each
change consists of a deletion **-** and an addition **+** to the file), and then
subtracted that number from 5 to get your score.

The number of lines of difference is included in your grade report for each
test.

### Plurals and Singulars
> 5 points

2.desc.1: Plurals and Singulars not completely implemented
2.maxpts: 5

### Area Calculation
> 5 points

3.desc.1: Incorrect Area
3.maxpts: 5

### Time Calculation
> 5 points

4.desc.1: Incorrect Time
4.maxpts: 5

### Calculating Hours, Minutes, Seconds
> 5 points

5.desc.1: Incorrect Hours, Minutes, or Seconds
5.maxpts: 5

### Class named Lawn
> 5 points

Full credit for naming your class `Lawn` (your code is wrapped in a `class Lawn
{ ... }` block, and you run your program with `java Lawn`).

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

Full credit if you submitted a file named exactly `Lawn.java`

5 points if you submitted some other `.java` file

5 points if you did not submit any Java file (charity, due to major deductions
  elsewhere).

### Compilation Issues
> 25 points

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

Your score was then set to *max(25 - number of changes, 5)*, to enforce a 5 point
minimum on this section for charity.
