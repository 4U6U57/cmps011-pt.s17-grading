#!/././././bin/./.././bin/././././bash

##
# @file pairer.sh
# @brief links GRADE.txt files for students under pair programming
# @author August Valera (avalera)
# @version
# @date 2017-04-19
#
# Usage: pairer.sh [$ASG] [$FILE]
#        ASG: Assignment to pair, defaults to current directory name if valid
#        FILE: Grade file to link, defaults to GRADE.txt if not specified
#
# Prerequesites:
# - File bin/$ASG/PAIR contains students to be paired, two per line
#   The first student should be the one who submitted the source code
#   The second's GRADE file will be overwritten


Exe="pairer"
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
  echo "$Exe: Asg $Asg taken from basename of current directory"
elif [[ "$1" != "" && -d "$ClassDir/$1" ]]; then
  Asg=$1
  echo "$Exe: Asg $Asg taken from first argument of script"
  shift
else
  echo "$Exe: ERROR - No asg provided"
  exit
fi
AsgDir=$ClassDir/$Asg
if [[ ! -d "$AsgDir" ]]; then
  echo "$Exe: ERROR - Invalid asg $Asg"
  exit
fi

GradeFile="GRADE.txt"
[[ "$1" != "" ]] && GradeFile="$1"

AsgBinDir="$BinDir/$Asg"
[[ ! -d $AsgBinDir ]] && mkdir $AsgBinDir

StudentFile="$AsgBinDir/PAIR"
[[ ! -e $StudentFile ]] && echo "$Exe: Assignment student list does not exist, creating: $StudentFile" && touch $StudentFile

cd $AsgDir
PairCount=0
for Student in $(cat $StudentFile); do
  PairCount=$((PairCount + 1))
done
[[ $PairCount -eq 0 ]] && echo "$Exe: No students to pair, quitting" && exit
Input=""
echo -n "$Exe: There are $PairCount students to pair ($((PairCount / 2)) pairs), proceed (y/n)? "
read Input
case $Input in
  ([Yy][Ee][Ss]|[Yy])
    while read Pair; do
      FirstStudent=$(echo $Pair | cut -d " " -f 1)
      SecondStudent=$(echo $Pair | cut -d " " -f 2)
      FirstDir=$AsgDir/$FirstStudent
      SecondDir=$AsgDir/$SecondStudent
      FirstGrade=$FirstDir/$GradeFile
      SecondGrade=$SecondDir/$GradeFile
      FirstName=$(getent passwd $FirstStudent | cut -d ":" -f 5)
      SecondName=$(getent passwd $SecondStudent | cut -d ":" -f 5)

      if [[ -z $FirstStudent ]] || [[ -z $SecondStudent ]]; then
        echo "$Exe: ERROR - Incomplete line: $Pair"
      elif [[ ! -d $FirstDir ]] || [[ ! -d $SecondDir ]]; then
        echo "$Exe: ERROR - Missing student in pair: $Pair"
      elif [[ ! -e $FirstGrade ]]; then
        echo "$Exe: ERROR - Missing grade file to copy: $FirstGrade"
      else
       cp -v $FirstGrade $SecondGrade
       echo "" >>$SecondGrade
       echo "Pair programming was applied to this assignment ($FirstStudent -> $SecondStudent). This grade report is for $SecondName ($SecondStudent). Please disrgard your partner's name ($FirstName) at the top of this report." | fmt >>$SecondGrade
      fi
    done <$StudentFile
    ;;
  (*)
    ;;
esac
