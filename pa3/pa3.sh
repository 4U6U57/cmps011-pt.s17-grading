#!/bin/bash
# cmps012a-pt.w17 grading
# usage: pa3.sh
# (run within your pa3 directory to test your code)

SRCDIR=https://raw.githubusercontent.com/4u6u57/cmps011-pt.s17.grading/master/pa3

# Get all necessary extras
for TYPE in in model-out; do
  for NUM in $(seq 1 6); do
    curl $SRCDIR/$TYPE$NUM.txt > $TYPE$NUM.txt
  done
done

# Compile code
javac GCD.java

# Run tests
echo "If nothing between '=' signs, then test is passed::"
for NUM in $(seq 1 6); do
  echo "Test $NUM:"
  echo "=========="
  timeout 1 java GCD < in$NUM.txt > out$NUM.txt
  diff -bBwu out$NUM.txt model-out$NUM.txt > diff$NUM.txt
  cat diff$NUM.txt
  echo "=========="
done

rm -f *.class

