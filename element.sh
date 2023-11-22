#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"



if [[ -z $1 ]]
then
echo "Please provide an element as an argument."

elif [[ $1 ]]
then 

  #if arg is atomic number
  if [[ $1 =~ [0-9]+ ]]
   then 
    #Create atomic number VARIABLE
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number= $1")

    if [[ $ATOMIC_NUMBER ]]
    then
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."

    elif [[ -z $ATOMIC_NUMBER ]]
    then
    echo "I could not find that element in the database."
    fi

  #if arg is 2 letters so a symbol 
  elif [[ $1 =~ ^[[:alpha:]]{,2}$ ]]
  then
    #create SYMBOL VARIABLE 
    ARGSYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
    if [[ $ARGSYMBOL ]]
    then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol LIKE '$ARGSYMBOL'")
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    elif [[ -z $ARGSYMBOL ]]
    then
    echo "I could not find that element in the database."
    fi

  #if arg is 3 letters or more so it's a name
  elif [[ $1 =~ ^[[:alpha:]]{3,}$ ]]
  then
    #CREATE NAME variable
    ARGNAME=$($PSQL "SELECT name FROM elements WHERE name= '$1'")
    if [[ $ARGNAME ]]
    then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name LIKE '$ARGNAME'")
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    elif [[ -z $ARGNAME ]]
    then
    echo "I could not find that element in the database."
    fi
  fi
fi

