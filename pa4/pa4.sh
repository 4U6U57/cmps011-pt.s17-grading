#!/bin/bash
# cmps011-pt.s17 grading
# usage: pa4.sh
# (run within your pa4 directory to test your code)

SRCDIR=https://raw.githubusercontent.com/4u6u57/cmps011-pt.s17.grading/master/pa4
# Get all necessary extras

for TYPE in in model-out; do
  for NUM in $(seq 1 10); do
    curl $SRCDIR/$TYPE$NUM.txt > $TYPE$NUM.txt
  done
done

curl $SRCDIR/RootsClient1.java > RootsClient1.java
curl $SRCDIR/RootsClient2.java > RootsClient2.java
curl $SRCDIR/RootsClient3.java > RootsClient3.java

if [ ! -d .backup ]; then
   mkdir .backup
fi

cp *.java Makefile .backup

make

if [ ! -e Roots ] || [ ! -x Roots ]; then # exist and executable
   echo ""
   echo "Makefile doesn't correctly create Roots!!!"
   echo ""
   rm -f *.class
   javac Roots.java
   echo "Main-class: Roots" > Manifest
   jar cvfm Roots Manifest *.class
   rm Manifest
   chmod +x Roots
fi

# Run tests
echo "If nothing between '=' signs, then test is passed::"
for NUM in $(seq 1 10); do
  echo "Test $NUM:"
  echo "=========="
  timeout 0.5 Roots < in$NUM.txt > out$NUM.txt
  diff -bBwu out$NUM.txt model-out$NUM.txt > diff$NUM.txt
  cat diff$NUM.txt
  echo "=========="
done

make clean

echo ""

if [ -e Roots ] || [ -e *.class ]; then
   echo "WARNING: Makefile didn't successfully clean all files"
fi

echo ""

# Compile unit tests
echo "compiling unit tests:"
javac Roots.java
javac RootsClient1.java
javac RootsClient2.java
javac RootsClient3.java


echo ""
echo "Unit Tests:"
timeout 0.5 java RootsClient1
timeout 0.5 java RootsClient2
timeout 0.5 java RootsClient3

rm -f *.class RootsClient1 RootsClient2 RootsClient3 Roots
