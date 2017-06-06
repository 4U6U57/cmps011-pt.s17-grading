#!/bin/bash

##
# @file pa4-stable.sh
# @brief Grading script for all pa4's, compatible with autotable format
# @author August Valera (avalera)
# @version cmps011-pt/pa4-stable
# @date 2017-05-05


GRADEFILE="grade.txt"
PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLASSDIR="$(echo $PWD | cut -d '/' -f 1-5)"
CLASS="$(basename $CLASSDIR)"
ASG="$(basename $PWD)"
ASGBIN="$CLASSDIR/bin/$ASG"
ASGDIR="$CLASSDIR/$ASG"
ASGTABLE="$ASGBIN/student"
[ ! -e $ASGTABLE ] && mkdir --parents $ASGTABLE
SEPARATE="=================================================="

forall() {
  CLASSNUM=$(echo $CLASS | cut -d '0' -f 2 | cut -d '-' -f 1)
  cd $ASGDIR
  for STUDENT in $(ls -d */); do
    STUDENTDIR=$ASGDIR/$STUDENT
    STUDENT=$(basename $STUDENT /)
    STUDENTNAME=$(getent passwd $STUDENT | cut -d ":" -f 5)
    cd $STUDENTDIR
    $@
  done
}

declare -A STUDENTTABLE
readtable() {
  cleartable
  if [[ -e $1 ]]; then
    while read LINE; do
      STUDENTTABLE["$(echo $LINE | cut -d ':' -f 1)"]="$(echo $LINE | cut -d ':' -f 2-)"
    done < $1
  else
    echo "TABLE: $STUDENT does not have a table"
  fi
}
writetable() {
  rm -f $1
  touch $1
  for KEY in ${!STUDENTTABLE[@]}; do
    echo $KEY: ${STUDENTTABLE["$KEY"]} >> $1
  done
  cat $1 | sort > $1.swp
  mv $1.swp $1
}
cleartable() {
  for KEY in ${!STUDENTTABLE[@]}; do
    unset STUDENTTABLE["$KEY"]
  done
}
settable() {
  STUDENTTABLE["$1.$2"]="$3"
}
gettable() {
  echo "${STUDENTTABLE[$1.$2]}"
}

backup() {
  if [[ ! -e $1 ]]; then
    mkdir $1
  fi
  for FILE in *; do
    [[ $FILE != "*" ]] && cp -n $FILE $1/$FILE
  done
}
restore() {
  for FILE in *; do
    if [[ $FILE != "*" && ! -e $1/$FILE ]]; then
      echo "RESTORE: $FILE created during grading, deleting"
      rm -f ./$FILE
    fi
  done
  for FILE in $1/*; do
    FILE=$(basename $FILE)
    if [[ $FILE != "*" ]]; then
      if [[ ! -e $FILE ]]; then
        echo "RESTORE: $FILE deleted during grading, restoring"
        cp $1/$FILE $FILE
      elif ! diff -q $FILE $1/$FILE > /dev/null; then
        echo "RESTORE: $FILE modified during grading, restoring"
        cp $1/$FILE $FILE
      fi
    fi
  done
}

grade() {
  # Actual grading code here

  # File name (#9)
  # 5 points charity
  UserSourceFileDefault="Roots.java"
  UserSourceFile=$UserSourceFileDefault
  if [[ ! -e $UserSourceFile ]]; then
    JavaFiles=( *.java )
    if [[ ! -e ${JavaFiles[0]} ]]; then
      UserSourceFile=""
      settable grade 9 C
      settable notes 9 "$UserSourceFileDefault not submitted, cannot grade name"
    else
      UserSourceFile="${JavaFiles[0]}"
      settable grade 9 3
      settable notes 9 "$UserSourceFileDefault named incorrectly: $UserSourceFile"
    fi
  else
    settable grade 9 P
    settable notes 9 "$UserSourceFile named correctly"
  fi

  # Comment block (#8)
  # 5 points, 0 points charity
  if [[ ! -z $UserSourceFile ]]; then
    CommentBlock="$(head -n 10 $UserSourceFile | grep "^\s*[/#*]")"
    if [[ ! -z $CommentBlock ]]; then
      Score=5
      Note="$UserSourceFile contained comment block"
      StudentFirstName=$(echo $STUDENTNAME | cut -d " " -f 1)
      if ! grep "$UserSourceFile" <(echo "$CommentBlock") >/dev/null; then
        Note+=", missing filename ($UserSourceFile)"
        Score=$((Score - 1))
      fi
      if ! grep -i "$STUDENT" <(echo "$CommentBlock") >/dev/null; then
        Note+=", missing CruzID ($STUDENT)"
        Score=$((Score - 1))
      fi
      if ! grep -i "$ASG" <(echo "$CommentBlock") >/dev/null; then
        Note+=", missing assignment name ($ASG)"
        Score=$((Score - 1))
      fi
      if ! grep "$StudentFirstName" <(echo "$CommentBlock") >/dev/null; then
        Note+=", doesn't contain your legal name ($StudentFirstName) (only an informational warning, not a deduction)"
      fi
      [[ $Score -eq 5 ]] && Score=P
      settable grade 8 $Score
      settable notes 8 "$Note"
    else
      settable grade 8 C
      settable notes 8 "$UserSourceFile did not contain a comment block"
    fi
  else
    settable grade 8 P
    settable notes 8 "$UserSourceFileDefault not submitted, cannot grade comment block"
  fi

  # Class name (not graded)
  UserClassNameDefault=$(basename $UserSourceFileDefault .java)
  if [[ ! -z $UserSourceFile ]]; then
    UserClassName="$(grep -P '^\s*(public\s+)?class\s+' $UserSourceFile | head -n 1 | sed 's#public##g;s#class##g;s#{.*##g;s#^\s*##g;s#\s.*$##g')"
    #if [[ $UserClassName == $UserClassNameDefault ]]; then
    #  settable grade 7 P
    #  settable notes 7 "Class $UserClassNameDefault named correctly"
    #else
    #  settable grade 7 C
    #  settable notes 7 "Class $UserClassNameDefault named incorrectly: $UserClassName"
    #fi
    #else
    #  settable grade 7 C
    #  settable notes 7 "$UserSourceFileDefault not submitted, cannot grade class name"
  fi

  # Compilation step, if no compile, opens a bash shell to fix issues
  # Copy original file into *.java.orig, if cannot compile, just leave it without a .class file
  # Make sure to copy all changes (*.java, *.java.orig) into .backup to prevent auto revert
  UserClassFile=$UserClassNameDefault.class
  if [[ ! -z $UserSourceFile ]]; then
    javac $UserSourceFile
    UserClassFile="$UserClassName.class"
    if [[ ! -e $UserClassFile ]]; then
      bash
    fi
  fi

  # Compilation issues (#10)
  # 25 points, no charity
  # This section goes under the assumption that all compilation errors have already been fixed
  # Specifically, it works by comparing faulty files file.java.orig with fixed file.java
  # Point value for deduction based on the diff output, or how many changes needed to compile
  if [[ ! -z $UserSourceFile ]]; then
    if [[ ! -e $UserClassFile ]]; then
      settable grade 10 C
      settable notes 10 "Could not compile"
    elif [[ -e $UserSourceFile.orig ]]; then
      CompileMax=25
      CompileDiff="$(diff -ub $UserSourceFile.orig $UserSourceFile)"
      CompileCount=$(echo "$CompileDiff" | tail -n +4 | grep -c "^[+-]")
      CompileCountWeigh=$((CompileCount / 2)) # Since each - is usually accompanied by a -
      CompileScore=$((CompileMax - CompileCountWeigh))
      [[ $CompileScore -le 0 ]] && CompileScore=C
      settable grade 10 $CompileScore
      settable notes 10 "Errors in compilation: $CompileCount lines of diff output"
    else
      settable grade 10 P
      settable notes 10 "No compilation issues"
    fi
  else
    settable grade 10 C
    settable notes 10 "$UserSourceFileDefault not submitted, could not check compilation"
  fi

  # Makefile making executable (#6)
  # 5 points
  UserExecFile="$(basename $UserSourceFileDefault .java)"
  if [[ ! -e "Makefile" ]] && [[ ! -e "makefile" ]]; then
    settable grade 6 C
    settable notes 6 "Makefile not submitted, could not check make"
  elif [[ -e $UserClassFile ]]; then
    make
    if [[ ! -e $UserExecFile ]]; then
      settable grade 6 C
      settable notes 6 "Makefile does not compile executable: $UserExecFile"
      rm -f *.class
      javac $UserSourceFile
      echo "Main-class: $UserClassName" > Manifest
      jar cvfm $UserExecFile Manifest *.class
      rm Manifest
      chmod +x $UserExecFile
    elif [[ ! -x $UserExecFile ]]; then
      settable grade 6 3
      settable notes 6 "Makefile creates executable but not runnable: $UserExecFile"
      chmod +x $UserExecFile
    else
      settable grade 6 P
      settable notes 6 "Makefile creates executable: $UserExecFile"
    fi
  else
    settable grade 6 C
    settable notes 6 "$UserSourceFileDefault could not be compiled, could not check make"
  fi

  # General tests (#2)
  # 15 points, 3 points each, no charity
  if [[ -e $UserClassFile ]]; then
    PerfScore=10
    PerfNotes=""
    for I in $(seq 1 6); do
      InFile="$ASGBIN/in$I.txt"
      OutFile="out$I.txt"
      ModelOutFile="$ASGBIN/model-out$I.txt"
      DiffFile="diff$I.txt"
      rm -f $OutFile $DiffFile $BACKUP/$OutFile
      touch $InFile
      timeout 3 java $UserClassName <$InFile >$OutFile 2>&1
      diff -Bbwu $OutFile $ModelOutFile >$DiffFile
      if [[ ! -e $OutFile ]]; then
        PerfScore=$((PerfScore - 3))
        Notes+=", failed $(basename $InFile) by infinte loop"
      elif [[ -s $DiffFile ]]; then
        DiffCount=$(cat $DiffFile | tail -n +4 | grep -c "^[+-]")
        DiffCountWeigh=$((DiffCount / 2))
        [[ $DiffCountWeigh -gt 3 ]] && DiffCountWeigh=3
        PerfScore=$((PerfScore - DiffCountWeigh))
        PerfNotes+=", failed $(basename $InFile) with $DiffCount lines of diff output"
        cp $DiffFile $BACKUP
      fi
      cp $OutFile $BACKUP
    done
    if [[ $PerfScore -eq 10 ]]; then
      settable grade 2 P
      settable notes 2 "General tests all passed"
    else
      [[ $PerfScore -le 0 ]] && PerfScore=C
      settable grade 2 $PerfScore
      settable notes 2 "General test issues$PerfNotes"
    fi
    rm -f $UserClassFile
  else
    settable grade 2 C
    settable notes 2 "$UserSourceFileDefault could not be compiled, could not check general tests"
  fi

  # Unit tests (#3-5)
  # 5 points each
  # poly(), diff(), findRoot()

}

main() {
  BACKUP=".backup"
  pwd
  backup $BACKUP
  readtable $ASGTABLE/student_$STUDENT.autotable
  grade
  restore $BACKUP
  writetable $ASGTABLE/student_$STUDENT.autotable # Comment this one out
  cleartable
}
forall main
