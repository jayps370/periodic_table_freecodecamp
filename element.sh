#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

# get elements and properties
ELEMENTS=$($PSQL "select * from elements right join properties using(atomic_number);")
#ELEMENTS=$($PSQL "select * from elements;")


# if no argument
if [[ -z $1 ]]
 then
  echo "Please provide an element as an argument."
 else
  #number_symbol_name=$1
  echo "$ELEMENTS" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID
  do
   if [[ $1 == $ATOMIC_NUMBER || $1 == $SYMBOL || $1 == $NAME ]]
    then
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      break
    else
      echo "Argument is invalid or element is not yet in database."
      break
   fi
  done

fi


