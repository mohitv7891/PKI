#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <certificate_file>"
  exit 1
fi

# Revoke Certificate
openssl ca -config openssl.cnf -revoke $1

# Generate/Update CRL
openssl ca -config openssl.cnf -gencrl -out demoCA/crl/crl.pem

echo "Revoked certificate and updated CRL: demoCA/crl/crl.pem"


