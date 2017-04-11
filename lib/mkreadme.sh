#!/././././bin/./.././bin/././././bash

# mkreadme.sh
# makes the README on the top level of the grading repo
# Usage: mkreadme.sh
# August Valera <avalera>

PwdDir=$(pwd)
Pwd=$(basename $PwdDir)
ClassDir=$(echo $PwdDir | cut -d "/" -f -5)
Class=$(basename $ClassDir)
BinDir="$ClassDir/bin"
Readme="$BinDir/README.md"

rm -f $Readme

Print() {
				echo "$@" | fmt >> $Readme
}

AsgTree() { # (AsgReadable AsgPrefix)
				Print "### $1"
				Print
				AsgDirs=( $BinDir/$2* )
				[[ $AsgDirs != "$BinDir/$2*" ]] && for AsgDir in $AsgDirs; do
				Asg=$(basename $AsgDir)
				if [[ -d $Asg && -e $AsgDir/README.md ]]; then
								Print "- [$Asg]($Asg)"
								if [[ -e $AsgDir/RUBRIC.md ]]; then
												Print "    - [Rubric](RUBRIC.md)"
								fi
				else
								Print "- $Asg *(No README Provided)*"
				fi
done || Print "> No $1 Listed"
}

Print "# $Class grading scripts"
Print
GitterClass=$(echo $Class | sed 's/\./-/g')
GitterRoom="4U6U57/$GitterClass-grading"
Print "[![Join the chat at https://gitter.im/$GitterRoom]"
Print "(https://badges.gitter.im/$GitterRoom)]"
Print "(https://gitter.im/$GitterRoom)"
Print
Print "Scripts for grading the programs and labs of the $Class class under Patrick Tantalo."
Print
Print "## Assignments"
Print
Print "Click on the relevant link below for more information on an assignment."
Print
AsgTree "Labs" "lab"
Print
AsgTree "Programs" "pa"
