#!/bin/bash
# cmps011-pt.s17 grading
# usage: pa6.sh
# (run within your pa6 directory to test your code)

if [ ! -d .backup ]; then
   mkdir .backup
fi

cp *.java Makefile .backup

SRCDIR=https://raw.githubusercontent.com/4u6u57/cmps011-pt.s17.grading/master/pa6
# Get all necessary extras

curl $SRCDIR/ComplexExceptionTest.java > ComplexExceptionTest.java
curl $SRCDIR/ComplexTest.java > ComplexTest.java

for num in 1 2 3 4
do
   curl $SRCDIR/in$num.txt > in$num.txt
   curl $SRCDIR/model-out$num.txt > model-out$num.txt
   curl $SRCDIR/model-out${num}_1.txt > model-out${num}_1.txt
done

make

if [ ! -e ComplexTest ] || [ ! -x ComplexTest ]; then # exist and executable
   echo ""
   echo "Makefile doesn't correctly create ComplexTest!!!"
   echo ""
   rm -f *.class
   javac Complex.java ComplexTest.java
   echo "Main-class: ComplexTest" > Manifest
   jar cvfm ComplexTest Manifest *.class
   rm Manifest
   chmod +x ComplexTest
fi

echo ""

# Run tests
echo "If nothing between '=' signs, then test is passed::"
for num in 1 2 3 4
do
   echo "Test $num:"
   echo "=========="
   timeout 0.5 ComplexTest in$num.txt out$num.txt
   diff -bBwu out$num.txt model-out$num.txt > diff$num.txt
   diff -bBwu out$num.txt model-out${num}_1.txt > diff${num}_1.txt
   if [ -s diff$num.txt ] && [ -s diff${num}_1.txt ]; then # cat diff if
                                                           # both don't
                                                           # pass
      cat diff$num.txt
   fi
   echo "=========="
done

echo ""

make spotless

echo ""

if [ -e ComplexTest ] || [ -e *.class ]; then
   echo "WARNING: Makefile didn't successfully clean all files"
fi

echo ""

# Compile unit tests
javac Complex.java > junkfile
javac ComplexExceptionTest.java > junkfile
echo "Main-class: ComplexExceptionTest" > Manifest
jar cvfm ComplexExceptionTest Manifest *.class > junkfile
rm Manifest > junkfile
chmod +x ComplexExceptionTest > junkfile
rm junkfile

echo "Unit Tests:"
timeout 0.5 ComplexExceptionTest
echo ""

rm -f *.class ComplexTest ComplexExceptionTest
