#!/bin/bash

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
    #echo "$SEPARATE"
    #pwd
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

  # File name (#8)
  # 10 points, 5 points charity
  UserSourceFile="Lawn.java"
  if [[ ! -e $UserSourceFile ]]; then
    JavaFiles=( *.java )
    if [[ ! -e ${JavaFiles[0]} ]]; then
      UserSourceFile=""
      settable grade 8 C
      settable notes 8 "Lawn.java not submitted, cannot grade name"
    else
      UserSourceFile="${JavaFiles[0]}"
      settable grade 8 3
      settable notes 8 "Lawn.java named incorrectly: $UserSourceFile"
    fi
  else
    settable grade 8 P
    settable notes 8 "Lawn.java named correctly"
  fi

  # Comment block (#7)
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
      if ! grep "$StudentFirstName" <(echo "$CommentBlock") >/dev/null; then
        Note+=", missing your name ($StudentFirstName)"
        Score=$((Score - 1))
      fi
      if ! grep -i "$STUDENT" <(echo "$CommentBlock") >/dev/null; then
        Note+=", missing CruzID ($STUDENT)"
        Score=$((Score - 1))
      fi
      if ! grep -i "pa\s*1" <(echo "$CommentBlock") >/dev/null; then
        Note+=", missing assignment name (pa1)"
        Score=$((Score - 1))
      fi
      [[ $Score -eq 5 ]] && Score=P
      settable grade 7 $Score
      settable notes 7 "$Note"
    else
      settable grade 7 C
      settable notes 7 "$UserSourceFile did not contain a comment block"
    fi
  else
    settable grade 7 P
    settable notes 7 "Lawn.java not submitted, cannot grade comment block"
  fi

  # Class name (#6)
  # 5 points, 0 points charity
  if [[ ! -z $UserSourceFile ]]; then
    UserClassName="$(grep -P '^\s*(public\s+)?class\s+' $UserSourceFile | head -n 1 | sed 's#public##g;s#class##g;s#{##g;s#^\s*##g;s#\s.*$##g')"
    if [[ $UserClassName == "Lawn" ]]; then
      settable grade 6 P
      settable notes 6 "Class Lawn named correctly"
    else
      settable grade 6 P
      settable notes 6 "Class Lawn named incorrectly: $UserClassName"
    fi
  fi

  # Compilation step, if no compile, opens a bash shell to fix issues
  # Copy original file into *.java.orig, if cannot compile, just leave it without a .class file
  # Make sure to copy all changes (*.java, *.java.orig) into .backup to prevent auto revert
  UserClassFile=Lawn.class
  if [[ ! -z $UserSourceFile ]]; then
    javac $UserSourceFile
    UserClassFile="$UserClassName.class"
    if [[ ! -e $UserClassFile ]]; then
      bash
    fi
  fi

  # Compilation issues (#9)
  # 25 points, 5 points charity
  # This section goes under the assumption that all compilation errors have already been fixed
  # Specifically, it works by comparing faulty files file.java.orig with fixed file.java
  # Point value for deduction based on the diff output, or how many changes needed to compile
  if [[ ! -z $UserSourceFile ]]; then
    if [[ ! -e $UserClassFile ]]; then
      settable grade 9 C
      settable notes 9 "Could not compile"
    elif [[ -e $UserSourceFile.orig ]]; then
      CompileDiff="$(diff -ub $UserSourceFile.orig $UserSourceFile)"
      CompileCount=$(echo "$CompileDiff" | grep "^[+-]" | wc -l)
      CompileCountWeigh=$((CompileCount / 2)) # Since each - is usually accompanied by a -
      CompileScore=$((25 - CompileCountWeigh))
      [[ $CompileScore -le 5 ]] && CompileScore=C
      settable grade 9 $CompileScore
      settable notes 9 "Errors in compilation: $CompileCount lines of diff output"
    else
      settable grade 9 P
      settable notes 9 "No compilation issues"
    fi
  else
    settable grade 9 C
    settable notes 9 "Lawn.java not submitted, could not check compilation"
  fi

  # Performance tests (#1)
  # 15 points
  if [[ -e $UserClassFile ]]; then
    PerfScore=15
    PerfNotes=""
    for I in $(seq 1 3); do
      InFile="$ASGBIN/in$I.txt"
      OutFile="out$I.txt"
      ModelOutFile="$ASGBIN/model-out$I.txt"
      DiffFile="diff$I.txt"
      java $UserClassName <$InFile >$OutFile 2>&1
      diff -u $OutFile $ModelOutFile >$DiffFile
      if [[ -e $DiffFile ]]; then
        DiffCount=$(cat $DiffFile | grep "^[+-]" | wc -l)
        DiffCountWeigh=$((DiffCount / 2))
        [[ $DiffCountWeigh -gt 5 ]] && DiffCountWeigh=5
        PerfScore=$((PerfScore - DiffCountWeigh))
        PerfNotes+=", failed in$1.txt with $DiffCount lines of diff output"
        cp $DiffFile $BACKUP
      fi
      cp $OutFile $BACKUP
    done
    if [[ $PerfScore -eq 15 ]]; then
      settable grade 1 P
      settable notes 1 "Performance tests all passed"
    else
      settable grade 1 $PerfScore
      settable notes 1 "Performance issues$PerfNotes"
    fi
    rm -f $UserClassFile
  else
    settable grade 1 C
    settable notes 1 "Lawn.java not submitted, could not check performance"
  fi

  }

  main() {
    BACKUP=".backup"
    pwd
    backup $BACKUP
    readtable $ASGTABLE/student_$STUDENT.autotable
    grade
    restore $BACKUP
    writetable $ASGTABLE/student_$STUDENT.autotable # Comment this one out
    # writetable $ASGTABLE/student_$STUDENT.autotable # Uncomment to deploy
    cleartable
  }
  forall main
