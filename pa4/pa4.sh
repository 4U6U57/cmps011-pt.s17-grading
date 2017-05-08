#!/bin/bash
# cmps011-pt.s17 grading
# usage: pa4.sh
# (run within your pa4 directory to test your code)

SRCDIR=https://raw.githubusercontent.com/4u6u57/cmps011-pt.s17.grading/master/pa4
EXE="pa4-check.sh"
SCRIPT=$(mktemp)

curl $SRCDIR/$EXE > $SCRIPT
chmod +x $SCRIPT
$SCRIPT
rm -f $SCRIPT
