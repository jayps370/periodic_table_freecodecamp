#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"


DISPLAY_PROPERTIES(){

  echo "$ELEMENT_CHECK" | while read TYPE_IC BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
    do
      if [[ $USER_INPUT == $ATOMIC_NUMBER || $USER_INPUT == $SYMBOL || $USER_INPUT == $NAME ]]
        then
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        break
      fi
    done

}

ELEMENT_CHECKER(){
  # check if argument is a number
  if [[ $USER_INPUT =~ ^[0-9]+$ ]]
    then
    ELEMENT_CHECK=$($PSQL "select * from elements right join properties using(atomic_number) full join types using(type_id) where atomic_number=$USER_INPUT;")
    if [[ -z $ELEMENT_CHECK ]]
      then
      echo "I could not find that element in the database."
    fi
  #if argument is not a number
    else
    ELEMENT_CHECK=$($PSQL "select * from elements right join properties using(atomic_number) full join types using(type_id) where symbol = '$USER_INPUT' or name = '$USER_INPUT';")
    if [[ -z $ELEMENT_CHECK ]]
      then
      echo "I could not find that element in the database."
    fi
  fi
}

if [[ -z $1 ]]
  then
  echo "Please provide an element as an argument."
  else
  
  # set argument into USER_INPUT
  USER_INPUT=$1
  ELEMENT_CHECKER
  DISPLAY_PROPERTIES
fi

