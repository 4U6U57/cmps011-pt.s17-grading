#!/bin/bash

# checksubmit.sh
# checks the submissions for the given USER for this class
# Usage: mailer.sh $USER
#        USER: Student to search
# August Valera <avalera>

PwdDir=$(pwd)
Pwd=$(basename $PwdDir)
ClassDir=$(echo $PwdDir | cut -d "/" -f -5)
Class=$(basename $ClassDir)

cd $ClassDir && find -maxdepth 2 -name $1 -type d | cut -d '/' -f 2 | sort
