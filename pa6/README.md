# cmps011-pt.s17/pa6

The following is a set of performance tests to run on your Complex program.
We have made this available to you to check your work before making your final
submission.

The tests used are from the examples on the website as well
An additional test is used to check that exceptions are being thrown
correctly

## Warning

This script should confirm all components of your performance based grade but
doesn't confirm every component of your grade for things like comment blocks,
but it'll definitely get you the majority points.

## Installation

Run the following in your working directory (the directory you wrote your code
in) to download the test script.

```bash
curl https://raw.githubusercontent.com/4u6u57/cmps011-pt.s17.grading/master/pa6/pa6.sh > pa6.sh
chmod +x pa6.sh
```

# Usage

After downloading the script, run it with the following command:

```bash
./pa6.sh
```

It will print out the difference between your output and the correct output,
using the `diff` command. Lack of any output between the set of "=========="
means that your program is running correctly.

> WARNING: There are few cases that are acceptable to be different in
> output (errors on the 14th digit or something in one line of two
> different files). When in doubt consult Isaak Cherdak or August Valera.

## Removal

You can delete the test and all other downloaded/generated files with:
`rm -f pa6.sh in* diff*.txt out*.txt model-out*.txt ComplexExceptionTest*`
