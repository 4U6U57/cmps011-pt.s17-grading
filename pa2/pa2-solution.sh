#!/././././bin/./.././bin/././././bash

##
# @file pa2-solution.sh
# @brief Simulates run of correct Guess program
# @author August Valera (avalera)
# @version cmps011/pa2
# @date 2017-04-16
#
# Simulates a correct Guess program

echo "I'm thinking of an integer in the range 1 to 10. You have three guesses."
echo

Number=$(((RANDOM % 10) + 1))

for Guess in "first" "second" "third"; do
  echo -n "Enter your $Guess guess: "
  Input=""
  while [[ ! $Input =~ ^[0-9]+$ ]]; do
    read Input;
  done
  if [[ $Input -gt $Number ]]; then
    Offset="high"
  elif [[ $Input -lt $Number ]]; then
    Offset="low"
  else
    echo "You win!"
    exit
  fi
  echo "Your guess is too $Offset."
  echo
done
echo "You lose. The number was $Number."
