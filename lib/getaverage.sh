#!/./bin/./.././bin/./bash

# csvify.sh
# generates export csv file for a specific assignment to import to eCommons
# Usage: csvify.sh [$ASG] [$GRADEFILE] [$OUTFILE]
#        ASG: Assignment to mail, defaults to current directory name if valid
#        GRADEFILE: Grade file to read from
#        OUTFILE: csv file to output to
# Expects a line in $GRADEFILE of format "SCORE: $POINTS / $TOTAL"
# August Valera <avalera>

Exe="mailer"
MailWait=3
PwdDir=$(pwd)
Pwd=$(basename $PwdDir)
ClassDir=$(echo $PwdDir | cut -d "/" -f -5)
Class=$(basename $ClassDir)
Asg=""
GradeFile=""
BinDir="$ClassDir/bin"

[[ ! -d $BinDir ]] && mkdir $BinDir

if [[ -d "$ClassDir/$Pwd" && "$Pwd" != "bin" ]]; then
  Asg=$Pwd
  echo "Asg $Asg taken from basename of current directory"
elif [[ "$1" != "" && -d "$ClassDir/$1" ]]; then
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
  exit
fi

AsgBinDir="$BinDir/$Asg"
[[ ! -d $AsgBinDir ]] && mkdir $AsgBinDir

MailDir="$AsgBinDir/$Exe"
[[ ! -d $MailDir ]] && mkdir $MailDir

GradeFile="GRADE.txt"
[[ ! -z "$1" ]] && GradeFile="$1" && shift

cd $AsgDir
TotalScore=0
TotalStudents=0
TotalGraded=0
MaxScore=0
for Student in $(ls -d */); do
  TotalStudents=$((TotalStudents + 1))
  Student="$(basename $Student)"
  StudentDir="$AsgDir/$Student"
  StudentGrade="$StudentDir/$GradeFile"
  if [[ -e $StudentGrade ]]; then
  [[ $MaxScore -eq 0 ]] && MaxScore=$(grep "SCORE:" $StudentGrade | cut -d "/" -f 2 | cut -d "(" -f 1 | sed 's/\s//g')
    TotalGraded=$((TotalGraded + 1))
    StudentScore=$(grep "SCORE:" $StudentGrade | cut -d ':' -f 2 | cut -d "/" -f 1 | sed 's/\s//g')
    TotalScore=$((TotalScore + StudentScore))
  fi
done
[[ $TotalGraded -gt 0 ]] && AverageScore=$((TotalScore / TotalGraded)) || AverageScore=0
[[ $MaxScore -ne 0 ]] && ScoreAverage=$((AverageScore * 100 / MaxScore)) || ScoreAverage=0
echo "Average for $Asg is $AverageScore / $MaxScore ($ScoreAverage%), taking into account $TotalGraded / $TotalStudents students"
