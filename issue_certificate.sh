#!/bin/bash

# Check if all required arguments are provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ] || [ -z "$6" ]; then
  echo "Usage: $0 <country_code_2_letters> <state_name> <city_name> <organization_name> <server_name> <validity_days>"
  exit 1
fi

# Assign arguments to variables
COUNTRY=$1
STATE=$2
CITY=$3
ORG=$4
SERVER_NAME=$5
VALIDITY_DAYS=$6

# Generate Private Key
openssl genrsa -out $SERVER_NAME.key 2048

# Generate CSR with dynamic subject fields
openssl req -new -key $SERVER_NAME.key -out $SERVER_NAME.csr \
  -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/CN=$SERVER_NAME"

# Sign CSR with Root CA
openssl ca -config openssl.cnf -in $SERVER_NAME.csr -out $SERVER_NAME.crt -days $VALIDITY_DAYS -batch

echo "Certificate issued: $SERVER_NAME.crt (Valid for $VALIDITY_DAYS days)"

