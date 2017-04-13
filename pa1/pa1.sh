#!/bin/bash

SRCDIR=https://raw.githubusercontent.com/4u6u57/cmps011-pt.s17.grading/master/pa1
for TYPE in in model-out; do
    for NUM in $(seq 1 3); do
        curl $SRCDIR/$TYPE$NUM.txt > $TYPE$NUM.txt
    done
done

javac Lawn.java
echo "If nothing between '=' signs, then test is passed:"
echo "Test 1:"
echo "=========="
java Lawn < in1.txt > out1.txt
diff -bBwu out1.txt model-out1.txt > diff1.txt
cat diff1.txt
echo "=========="
echo "Test 2:"
echo "=========="
java Lawn < in2.txt > out2.txt
diff -bBwu out2.txt model-out2.txt > diff2.txt
cat diff2.txt
echo "=========="
echo "Test 3:"
echo "=========="
java Lawn < in3.txt > out3.txt
diff -bBwu out3.txt model-out3.txt > diff3.txt
cat diff3.txt
echo "=========="
rm *.class
