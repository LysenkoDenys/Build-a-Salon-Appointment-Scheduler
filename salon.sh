#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon  --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"

# Trim function to clean psql output
trim() {
  echo "$1" | sed -E 's/^ *| *$//g'
}

MAIN_MENU(){
  # Optional message if passed

  if [[ $1 ]]; then
    echo -e "\n$1"
  else
    echo -e "Welcome to My Salon, how can I help you?\n"
  fi

  # Fetch services from DB dynamically
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  # Display each service as "1) cut"
  echo "$SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME
  do
    SERVICE_ID=$(trim "$SERVICE_ID")
    SERVICE_NAME=$(trim "$SERVICE_NAME")
    echo "$SERVICE_ID) $SERVICE_NAME"
  done

  read SERVICE_ID_SELECTED

  SERVICE_NAME=$(trim "$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")")
  	
  if [[ -z $SERVICE_NAME ]]; then 
    # Invalid service: show menu again
    MAIN_MENU "I could not find that service. What would you like today?"
    return
  fi

  # get customer info
	echo -e "\nWhat's your phone number?"
	read CUSTOMER_PHONE
	CUSTOMER_ID=$(trim "$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")")

  if [[ -z $CUSTOMER_ID ]]; then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    $PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')" > /dev/null
    CUSTOMER_ID=$(trim "$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")")
  else
    CUSTOMER_NAME=$(trim "$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")")
  fi

  # Ask for service time and insert appointment
  echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  $PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')" > /dev/null
  # Confirmation
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}
MAIN_MENU