#!/bin/bash
# cmps011-pt.s17 grading
# usage: pa3.sh
# (run within your pa3 directory to test your code)

SRCDIR=https://raw.githubusercontent.com/4u6u57/cmps011-pt.s17.grading/master/pa3

curl $SRCDIR/.pa3.sh > .pa3.sh
chmod +x .pa3.sh
./.pa3.sh
rm .pa3.sh
