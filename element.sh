#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

# get elements and properties
ELEMENTS=$($PSQL "select * from elements right join properties using(atomic_number);")
#ELEMENTS=$($PSQL "select * from elements;")


DISPLAY_PROPERTIES(){
  # display properties of the element
  #if [[ -z $ELEMENT_CHECKER ]]
      #then
      #echo "Argument is invalid or element is not yet in database."
      #else
      echo "$ELEMENTS" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID
      do
        if [[ $USER_INPUT == $ATOMIC_NUMBER || $USER_INPUT == $SYMBOL || $USER_INPUT == $NAME ]]
          then
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
          break
        fi
      done
  #fi
}

ELEMENT_CHECKER(){
  if [[ $USER_INPUT =~ ^[0-9]+$ ]]
    then
    ELEMENT_CHECK=$($PSQL "select atomic_number from elements where atomic_number = $USER_INPUT;")
    if [[ -z $ELEMENT_CHECK ]]
      then
      echo "I could not find that element in the database."
    fi
    else
    ELEMENT_CHECK=$($PSQL "select atomic_number from elements where symbol = '$USER_INPUT' or name = '$USER_INPUT';")
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
  
  # check if argument is in database
  #ELEMENT_CHECKER=$($PSQL "select atomic_number from elements where atomic_number = $USER_INPUT or symbol = '$USER_INPUT' or name = '$USER_INPUT';")
  ELEMENT_CHECKER
  DISPLAY_PROPERTIES
fi

