#!/bin/bash

##
# @file pa2-stable.sh
# @brief Grading script for all pa2's, compatible with autotable format
# @author August Valera (avalera)
# @version cmps011-pt/pa2-stable
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

  # File name (#6)
  # 5 points charity
  UserSourceFileDefault="Guess.java"
  UserSourceFile=$UserSourceFileDefault
  if [[ ! -e $UserSourceFile ]]; then
    JavaFiles=( *.java )
    if [[ ! -e ${JavaFiles[0]} ]]; then
      UserSourceFile=""
      settable grade 6 C
      settable notes 6 "$UserSourceFileDefault not submitted, cannot grade name"
    else
      UserSourceFile="${JavaFiles[0]}"
      settable grade 6 3
      settable notes 6 "$UserSourceFileDefault named incorrectly: $UserSourceFile"
    fi
  else
    settable grade 6 P
    settable notes 6 "$UserSourceFile named correctly"
  fi

  # Comment block (#5)
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
      fi
      if ! grep -i "$STUDENT" <(echo "$CommentBlock") >/dev/null; then
        Note+=", missing CruzID ($STUDENT)"
        Score=$((Score - 1))
      fi
      if ! grep -i "$ASG" <(echo "$CommentBlock") >/dev/null; then
        Note+=", missing assignment name ($ASG)"
        Score=$((Score - 1))
      fi
      [[ $Score -eq 5 ]] && Score=P
      settable grade 5 $Score
      settable notes 5 "$Note"
    else
      settable grade 5 C
      settable notes 5 "$UserSourceFile did not contain a comment block"
    fi
  else
    settable grade 5 P
    settable notes 5 "$UserSourceFileDefault not submitted, cannot grade comment block"
  fi

  # Class name (#7)
  # 5 points
  UserClassNameDefault=$(basename $UserSourceFileDefault .java)
  if [[ ! -z $UserSourceFile ]]; then
    UserClassName="$(grep -P '^\s*(public\s+)?class\s+' $UserSourceFile | head -n 1 | sed 's#public##g;s#class##g;s#{##g;s#^\s*##g;s#\s.*$##g')"
    if [[ $UserClassName == $UserClassNameDefault ]]; then
      settable grade 7 P
      settable notes 7 "Class $UserClassNameDefault named correctly"
    else
      settable grade 7 C
      settable notes 7 "Class $UserClassNameDefault named incorrectly: $UserClassName"
    fi
  else
    settable grade 7 C
    settable notes 7 "$UserSourceFileDefault not submitted, cannot grade class name"
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

  # Compilation issues (#8)
  # 25 points, 5 points charity
  # This section goes under the assumption that all compilation errors have already been fixed
  # Specifically, it works by comparing faulty files file.java.orig with fixed file.java
  # Point value for deduction based on the diff output, or how many changes needed to compile
  if [[ ! -z $UserSourceFile ]]; then
    if [[ ! -e $UserClassFile ]]; then
      settable grade 8 C
      settable notes 8 "Could not compile"
    elif [[ -e $UserSourceFile.orig ]]; then
      CompileDiff="$(diff -ub $UserSourceFile.orig $UserSourceFile)"
      CompileCount=$(echo "$CompileDiff" | tail -n +4 | grep "^[+-]" | wc -l)
      CompileCountWeigh=$((CompileCount / 2)) # Since each - is usually accompanied by a -
      CompileScore=$((25 - CompileCountWeigh))
      [[ $CompileScore -le 5 ]] && CompileScore=C
      settable grade 8 $CompileScore
      settable notes 8 "Errors in compilation: $CompileCount lines of diff output"
    else
      settable grade 8 P
      settable notes 8 "No compilation issues"
    fi
    rm -f $UserClassFile
  else
    settable grade 8 C
    settable notes 8 "$UserSourceFileDefault not submitted, could not check compilation"
  fi

  # Ending condition
  if [[ -z $(gettable grade 1) ]]; then
    if [[ ! -z $UserSourceFile ]]; then
      more $UserSourceFile
      select Rank in "perfect" "some term" "no term" "some cond" "prints" "bad" "skip"; do
        case $Rank in
          ("perfect")
            settable grade 1 P
            settable notes 1 "Program terminates on win correctly"
            ;;
          ("some term")
            settable grade 1 8
            settable notes 1 "Program checks winning conditions, but doesn't always terminate"
            ;;
          ("no term")
            settable grade 1 6
            settable notes 1 "Program checks winning conditions, but never terminates "
            ;;
          ("some cond")
            settable grade 1 4
            settable notes 1 "Program checks some winning conditions, but not all"
            ;;
          ("prints")
            settable grade 1 2
            settable notes 1 "Program at least prints 'win' at some point"
            ;;
          ("bad")
            settable grade 1 C
            settable notes 1 "Program win not implemented at all"
            ;;
          ("skip")
            echo "Skipping $STUDENT for now"
            break
            ;;
        esac
        break
      done
    else
      settable grade 1 5
      settable notes 1 "$UserSourceFileDefault not submitted, could not check program win"
    fi
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
  cleartable
}
forall main
