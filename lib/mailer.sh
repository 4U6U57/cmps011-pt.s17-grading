#!/././././bin/./.././bin/././././bash

# mailer.sh
# sends grade files to all students for a specific assignment
# Usage: mailer.sh [$ASG] [$FILE]
#        ASG: Assignment to mail, defaults to current directory name if valid
#        FILE: Grade file to send, defaults to GRADE.txt if not specified
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
[[ "$1" != "" ]] && GradeFile="$1"

MailMissing=""
CountMissing=0
MailNew=""
CountNew=0
MailUpdate=""
CountUpdate=0
MailIgnore=""
CountIgnore=0

cd $AsgDir
for Student in $(ls -d */); do
  Student="$(basename $Student)"
  StudentDir="$AsgDir/$Student"
  StudentGrade="$StudentDir/$GradeFile"
  BackupGrade="$MailDir/$Student.$GradeFile"
  cd $StudentDir
  if [[ ! -e $StudentDir/$GradeFile ]]; then
    MailMissing+="$Student "
    echo $((CountMissing++)) >/dev/null
  elif [[ ! -e $BackupGrade ]]; then
    MailNew+="$Student "
    echo $((CountNew++)) >/dev/null
  elif ! diff $StudentGrade $BackupGrade >/dev/null; then
    MailUpdate+="$Student "
    echo $((CountUpdate++)) >/dev/null
  else
    MailIgnore+="$Student "
    echo $((CountIgnore++)) >/dev/null
  fi
done

echo "Need to send mail to $((CountNew + CountUpdate)) student(s)."
echo
echo "$CountNew student(s) would be mailed for the first time:"
echo "$MailNew" | fmt
echo
echo "$CountUpdate student(s) would be sent an update to their grade:"
echo "$MailUpdate" | fmt
echo
echo "There are also $((CountMissing + CountIgnore)) student(s) who don't need mailing."
echo
echo "$CountMissing student(s) do not have a gradefile:"
echo "$MailMissing" | fmt
echo
echo "$CountIgnore students do not require an update:"
echo "$MailIgnore" | fmt

MailSend=$(echo "$MailNew $MailUpdate" | sort)

echo
echo -n "Send (n)ew grades, (u)pdates, (a)ll, or (c)ancel: "
read MailInput

echo
MailSend=""
CountSend=0
StringSend=""
case $MailInput in
  (n|N):
    MailSend="$MailNew"
    CountSend=$CountNew
    StringSend="new grades"
    ;;
  (u|U):
    MailSend="$MailUpdate"
    CountSend=$CountUpdate
    StringSend="updated grades"
    ;;
  (a|A):
    MailSend=$(echo "$MailNew $MailUpdate" | sort)
    CountSend=$((CountNew + CountUpdate))
    StringSend="new and updated grades"
    ;;
esac
[[ $CountSend == 1 ]] && StringSend=$(echo $StringSend | head -c -2)

if [[ $CountSend == 0 ]]; then
  echo "Okay, not sending any mails."
else
  echo "Sending $CountSend $StringSend (ETA: $((CountSend * MailWait)))"
  for Student in $MailSend; do
    Student="$(basename $Student)"
    StudentDir="$AsgDir/$Student"
    StudentGrade="$StudentDir/$GradeFile"
    BackupGrade="$MailDir/$Student.$GradeFile"
    sed -i 's/\r//g' $StudentGrade
    StudentEmail="$Student@ucsc.edu"
    echo "Sending mail to $Student"
    mailx -s "[$Class] $Asg grade for $Student" $StudentEmail <$StudentGrade
    cp $StudentGrade $BackupGrade
    sleep $MailWait
  done
fi
