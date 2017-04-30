#!/././././bin/./.././bin/././././bash

# forall.sh
# Runs input $CMD forall submissions in $ASG directory
# Usage: forall.sh [-d] [$ASG] $CMD
# Or, if running from within directory named $ASG (such as $CLASS/$ASG or $CLASS/bin/$ASG)
#        forall.sh $CMD
# August Valera <avalera>

PwdDir=$(pwd)
Pwd=$(basename $PwdDir)
ClassDir=$(echo $PwdDir | cut -d "/" -f -5)
Class=$(basename $ClassDir)
Asg=""

ShowName=false
if [[ $1 == "-d" ]]; then
  echo "Displaying usernames"
  ShowName=true
  shift
fi
echo $ClassDir/$1
if [[ -d "$ClassDir/$Pwd" && "$Pwd" != "bin" ]]; then
  Asg=$Pwd
  echo "Asg $Asg taken from basename of current directory"
elif [[ ! -z "$1" && -d "$ClassDir/$1" ]]; then
  Asg=$1
  echo "Asg $Asg taken from first argument of script"
  shift
else
  echo "No asg provided"
  exit
fi
AsgDir=$ClassDir/$Asg
if [[ ! -d "$AsgDir" ]]; then
  echo "ERROR: Invalid asg $Asg"
  exit 1
fi

cd $AsgDir
for Student in $(ls -d */); do
  StudentDir=$AsgDir/$Student
  cd $StudentDir
  if $ShowName; then
    echo $Student
  fi
  $@
done
