#!/././././bin/./.././bin/././././bash

##
# @file forall.sh
# @brief Runs a given command for all submissions in an assignment
# @author August Valera (avalera)
# @version cmps011
# @date 2017-05-05
#
# Usage: forall.sh [-d] [$ASG] $CMD
#        -d     Print out directory (student) paths before running command
#        ASG    Assignment to apply, if not provided, taken from name of current directory
#        CMD    Command to run in each student directory
#
# Limitations:
#   - Cannot use and, or, pipes (&&, ||, |) as they will be taken to apply to the whole command, not for each student
#   - Bash variables/commands will be evaluated before running ($Variable, $(command))
#
# Examples:
#   - forall.sh ls -m: Print out all files in each directory, comma separated
#   - forall.sh ls -m | grep -v "Lawn.java": Same as the above, but finds only those missing a file (or incorrectly named)
#   - forall.sh cp $(pwd)/GRADE.txt .: Copies a file GRADE.txt in the current directory to all student directories

PwdDir=$(pwd)
Pwd=$(basename $PwdDir)
ClassDir=$(echo $PwdDir | cut -d "/" -f -5)
Class=$(basename $ClassDir)
Asg=""

ShowName=false
if [[ $1 == "-d" ]]; then
  echo "Displaying student directory paths"
  ShowName=true
  shift
fi
if [[ -d "$ClassDir/$Pwd" && "$Pwd" != "bin" ]]; then
  Asg=$Pwd
  echo "Asg $Asg taken from basename of current directory"
elif [[ ! -z "$1" && -d "$ClassDir/$1" ]]; then
  Asg=$1
  echo "Asg $Asg taken from first argument of script"
  shift
else
  echo "ERROR: No asg provided"
  exit
fi
AsgDir=$ClassDir/$Asg
if [[ ! -d "$AsgDir" ]]; then
  echo "ERROR: Invalid asg $Asg"
  exit 1
fi

echo $ClassDir/$1

cd $AsgDir
for Student in $(ls -d */); do
  StudentDir=$AsgDir/$Student
  cd $StudentDir
  Output="$($@)"
  $ShowName && [[ ! -z "$Output" ]] && pwd
  [[ ! -z "$Output" ]] && echo $Output
done
