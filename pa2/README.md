# cmps011-pt.s17/pa2

Because this assignment requires your program to generate a random number for
the user to guess, we are not able to distribute a testing script (because the
behavior of your program will depend on the random number, which we do not know
ahead of time).

Instead, we will be distributing a solution script, which is essentially a
program, written in Bash, which runs exactly as your program should, written
correctly. Use this script to better understand the assignment specifications.
Of course, due to the behavior mentioned above, running our script and your own
program at the same time with the exact same inputs will produce different
outputs 9 out of 10 times, due to the fact that the number you are guessing are
generated randomly on either side.

## Installation

The following two lines downloads the script to your current directory:

```bash
curl
https://raw.githubusercontent.com/4U6U57/cmps011-pt.s17.grading/master/pa2/pa2-solution.sh > pa2-solution.sh
chmod +x pa2-solution.sh
```

## Usage

Then, run the following line to execute the script:

```bash
./pa2-solution.sh
```

This should produce results similar to your program, which you would run with
the following:

```bash
javac Guess.java
java Guess
```

## Removal

Removal is done in the normal way. This script does not generate or download any 
extra files.

```bash
rm pa2-solution.sh
```
