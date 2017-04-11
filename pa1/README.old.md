# cmps011-pt.s17/pa1

The following is a set of performance tests to run on your Lawn program. It takes three example input files and compares your results to our correct model outputs. We have made this available to you to check your work before making your final submission.

## Installation

Run the following in your working directory (the directory you wrote your code in) to get the test script and example input files:

```bash
curl https://raw.githubusercontent.com/4u6u57/cmps011-pt.s17.grading/master/pa1/pa1.sh > pa1.sh
chmod +x pa1.sh
```

## Usage

After installation, you can run the script with this line:

```bash
./pa1.sh
```

It will print out the difference between your output and the correct output, using the `diff` command. Lack of any output between the set of "==========" means that your program is running correctly.

## Removal

The following command will remove all text files and shell scripts in your directory. Since you should not have any files that end in `.txt` or `.sh` anyway, this should serve to delete all the files we gave you.

```bash
rm -f *.txt *.sh
```
