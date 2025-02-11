#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <certificate_file>"
  exit 1
fi

# Check if CRL file exists
if [ ! -f demoCA/crl/crl.pem ]; then
  echo "CRL file (demoCA/crl/crl.pem) not found. Generating CRL..."
  openssl ca -config openssl.cnf -gencrl -out demoCA/crl/crl.pem
fi

# Verify certificate against CA and CRL
openssl verify -CAfile demoCA/ca.crt -CRLfile demoCA/crl/crl.pem -crl_check $1

openssl x509 -in $1 -noout -dates

