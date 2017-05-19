#!/././././bin/./.././bin/././././bash

##
# @file mosser.sh
# @brief overwrites GRADE.txt files with the standard MOSS plagarism message to select students
# @author August Valera (avalera)
# @version
# @date 2017-04-19
#
# Usage: mosser.sh [$ASG] [$FILE]
#        ASG: Assignment to moss, defaults to current directory name if valid
#        FILE: Grade file to overwrite, defaults to GRADE.txt if not specified
#              The original file is renamed to FILE.moss in each individual student directory
#
# Prerequesites:
# - File bin/moss/$ASG.moss contains students to be mossed
# - File bin/moss/$ASG.txt contains the message to send the students, in lieu of their GRADE file


Exe="mosser"
PwdDir=$(pwd)
Pwd=$(basename $PwdDir)
ClassDir=$(echo $PwdDir | cut -d "/" -f -5)
Class=$(basename $ClassDir)
Asg=""
GradeFile=""
BinDir="$ClassDir/bin"
MossDir="$BinDir/moss"

[[ ! -d $BinDir ]] && mkdir $BinDir
[[ ! -d $MossDir ]] && mkdir $MossDir

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

StudentFile="$MossDir/$Asg.moss"
[[ ! -e $StudentFile ]] && echo "$Exe: Assignment student list does not exist, creating: $StudentFile" && touch $StudentFile

MossFile="$MossDir/$Asg.txt"
if [[ ! -e $MossFile ]]; then
  echo "$Exe: Assignment moss message does not exist, creating default: $MossFile"
  echo -e "Dear \$StudentName (\$Student),\n\nYou are receiving a zero on this assignment (\$Asg) because strong similarities were detected between the files you submitted and the work of other students. Please carefully read the section of the course syllabus pertaining to Academic Honesty, and adhere to the policies described there in future projects. No charge of academic dishonesty will be filed for this infraction, but if further violations of the policy are detected, you may face such charges.\n\nIf you believe that you have not violated the Academic Honesty policy for this course, and that you have been wrongly accused in this case, then please meet with the instructor, Patrick Tantalo, during his office hours to discuss the matter (Monday and Wednesday 5:00-8:30pm, E2 building room 257). If you are unable to attend those hours, please contact Professor Tantalo to make an appointment. In any case, please do not respond directly to this email since the graders and TAs have no authority in this matter.\n\nSCORE: 0 / X" | fmt >$MossFile
fi

cd $AsgDir
MossCount=0
for Student in $(cat $StudentFile); do
  MossCount=$((MossCount + 1))
done
[[ $MossCount -eq 0 ]] && echo "$Exe: No students to moss, quitting" && exit
Input=""
echo -n "$Exe: There are $MossCount students to moss, proceed (y/n)? "
read Input
case $Input in
  ([Yy][Ee][Ss]|[Yy])
    for Student in $(cat $StudentFile); do
      StudentDir=$AsgDir/$Student
      if [[ -d $StudentDir ]]; then
        StudentName=$(getent passwd $Student | cut -d ":" -f 5)
        cp -v $StudentDir/$GradeFile $StudentDir/$GradeFile.moss
        cp -v $MossFile $StudentDir/$GradeFile
        sed -i "s#\\\$Asg#$Asg#g;s#\\\$StudentName#$StudentName#g;s#\\\$Student#$Student#g" $StudentDir/$GradeFile
      else
        echo "$Exe: Error processing $Student"
      fi
    done
    ;;
  (*)
    ;;
esac
